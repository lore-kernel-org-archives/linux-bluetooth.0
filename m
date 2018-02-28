Return-Path: <bjorn.andersson@linaro.org>
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
Date: Tue, 27 Feb 2018 16:17:38 -0800
Message-Id: <20180228001738.11131-1-bjorn.andersson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

rpmsg_create_ept() returns NULL on error and as such
qcom_wcnss_open_channel() does the same. Clarify this in the
kernel-doc and correct the error checks in btqcomsmd.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/btqcomsmd.c | 8 ++++----
 drivers/soc/qcom/wcnss_ctrl.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 2c9a5fc9137d..24f702927875 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -151,13 +151,13 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 
 	btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
 						   btqcomsmd_acl_callback, btq);
-	if (IS_ERR(btq->acl_channel))
-		return PTR_ERR(btq->acl_channel);
+	if (!btq->acl_channel)
+		return -ENOENT;
 
 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
 						   btqcomsmd_cmd_callback, btq);
-	if (IS_ERR(btq->cmd_channel))
-		return PTR_ERR(btq->cmd_channel);
+	if (!btq->cmd_channel)
+		return -ENOENT;
 
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index d008e5b82db4..e968559b0fc4 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -275,6 +275,8 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
  * @wcnss:	wcnss handle, retrieved from drvdata
  * @name:	SMD channel name
  * @cb:		callback to handle incoming data on the channel
+ *
+ * Return: rpmsg_endpoint object on success, NULL on error
  */
 struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rpmsg_rx_cb_t cb, void *priv)
 {
-- 
2.16.2
