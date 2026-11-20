Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795137222;
	b=Uih681F5BEpHUqgddPtnUI6ipfGfYhvWkvlE5SUjsLgD/Udn85ZQAy5/14qhe2chYhIm
	 pWUNyTmPbiDv99mEdnGtx5bHoXIlCK2gdnQII7FeLpPfg3x6GTX+OGrjX9RkAcgXDUntW
	 H4Wptw1KzSqp9H2b7qvJWAHVML2wxYK6htTlL88FMpo4HaBQUMnm0FTENdjhVhUteox18
	 jx58rQV1Tpi6rwW8o/WjmEC+YUkzx9BgRyrX6GzeTkiByd97jb1KFff6lrvHW/OBMvIbn
	 bsLshhqvDFxIfq0xFvPItlqKjh8cDWMeuyAfIOBc1HexKu3ijV11fWiRxJtYAp7NBQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZZ/wZxb5FVQ258VnNPOOYek4ipDLrwtdDou9zYB1QIc=;
	b=yj4ddLH0BLCV0UM3NqOy8foZOXoaBF8xPwOoiYhAETcnV4WrN291ekaW5WTlOdaxP+NX
	 6cxOuo5Y78dIKIBY7+N7GTWjSN8G3hsOUdkYTdDd61DJWbsjh6aIPzZXkNfQ4bKt0Z0Zf
	 YEO60BJEZc/WttHft0Zaa6jaj2cd093HUkkW4psyUmnPjqNRhRsm5AnowAufUPZaP/CYS
	 XuRPRIdmchQMQZF6B+jhoYVrg5Yxbt7QHe+q7NnqmfeeBNoPe2F/j6Q7ldBCJLm3gaOPg
	 2c/9L1aa1W8RY4KrcnMKt0LOLpi9oFkIn9hm55MvesgS5zC0AQPUFv5xNHpvWBXPe+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCnWTjDy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D8606A331;
	Fri, 20 Nov 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCnWTjDy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795137222;
	b=rtCNLIzN8eva13DmQqgKQcY6dwMF/3HzsFb66OZRSnDh4cF8mGQ9nqaFGI0o88Bho2sH
	 FyuPgFrVSrolgIirQ2lhxFaelSbzWQUSA3gbi4kLED4xdnzD/AfnnNBShwg9/2fETRuOn
	 1ZPhUtNixbR5K7IE0ibdX+8ije3U5TkC1U/co5225uK2lf3mAPUAh7XUyAXO+9TJUrDAl
	 dldHJ1RBlvg8SQnyrMhzKnh/8zhBleCZacfHkxgFwJN7o3PfNNNgvWFWNgzg+XjLSTADf
	 w3Lq+Gga/tGrFPn1WNDCgsbCEpfm4msLPk+QOGGJNVLfwyGYYVRsXKgIwA5bvo5PwZw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795137222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZZ/wZxb5FVQ258VnNPOOYek4ipDLrwtdDou9zYB1QIc=;
	b=zU2lPCtuC+Wc+sS3nMOZcn8nB3e2z0ytIP1ErSlAjrlbkgNtzocqywi+RwY3GqB/Hc4b
	 F37+d6DnH52mxT3sCFRSk0JBddPW5b9rkn1fbI9Uji0t7KzcijAIZu9qrkao7pl/BWnje
	 cmu2CCFse8yLAdWhA8a485Kq8Bx6mlknXhqXtUalDYtRFfuFAVFGA4SeuE6EgybuTo9xD
	 3HYZLUVWULWdkUJfP6UJaLMza3lg5Bzm3IC3ACnJP9mUGGIpYQ0kia5dXT8Ee6iQ+J8mk
	 fPqdmD5bvd36l4TXz6pRGGahS+B/IDgegm1MWBWuntwdFfEmyYFu5+ayAnc0A65zdGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C89CC1F000CA;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795137222;
	bh=ZZ/wZxb5FVQ258VnNPOOYek4ipDLrwtdDou9zYB1QIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PCnWTjDy4cgwyIz293TjAi/JU1bcL+qtgBPl6cac9FwLG8JF2wIUNAkAzedYq2vt6
	 nldxhitkSpYuGwLyEAlIqxIF35uKAz4ZRkKFPMV+qr1AuQTaVFQi55a0+MYeXiy4Vt
	 bmjTQWLJaWrg8arkJ/0byCt8tH2GXYZNKSl59xu7CjA2Uz6brQXTZDHM9ujdc6FrhM
	 fpSar/SFsL99mfFxwCVyUMEZJtMfMTnj57KN2riwcdcqZjiZ2MslPJ/D3AX6xg3/xp
	 WR5O3FDUdcdoJOQkirxdtdkoqKN4/bNYWBkeUXWJDGJkFBurPiLzel5bzhgWKOdMZJ
	 IfHgipmjvwxmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 55E7C42614;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
From: Thomas de Gruijter via B4 Relay <devnull+thomasdegruijter.pm.me@kernel.org>
Date: Fri, 20 Nov 2026 02:13:36 +0100
Subject: [PATCH 2/2] Bluetooth: MSFT: Only enable the advertisement filter
 with monitors
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-msft-filter-monitors-v1-2-8192f0c0791a@pm.me>
References: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
In-Reply-To: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Brian Gix <brian.gix@intel.com>, Yun-Hao Chung <howardchung@google.com>, 
 Miao-chen Chou <mcchou@chromium.org>, Archie Pusaka <apusaka@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas de Gruijter <thomasdegruijter@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795137220; l=5018;
 i=thomasdegruijter@pm.me; s=20261120; h=from:subject:message-id;
 bh=oT34K5Pir/uDlTpBt575+nbbGyIR7ZHnel9uDdmYiDw=;
 b=fsi+gUP+ht/139YcgqzEyVLogw8p4nnwczBQby4sAl8ujOmP77MtN21lncNbh0//pUWXNb45j
 SHpRBT+6vAgAAFjBIMZzTcKLfzU0zT4T2L58Y6Ul02dvtDNYftR49hm
X-Developer-Key: i=thomasdegruijter@pm.me; a=ed25519;
 pk=YtEZHHXdsASGVJkddpdFLAnfVg0G/gza+FXgPGUJZlg=
X-Endpoint-Received: by B4 Relay for thomasdegruijter@pm.me/20261120 with
 auth_id=1578
X-Original-From: Thomas de Gruijter <thomasdegruijter@pm.me>
Reply-To: thomasdegruijter@pm.me
Content-Transfer-Encoding: 7bit

From: Thomas de Gruijter <thomasdegruijter@pm.me>

msft_do_open() unconditionally enables the MSFT LE advertisement filter
on every power on, whether or not any advertisement monitor is
registered.

On MediaTek MT7922 (USB 0e8d:0616, firmware build 20260724) the
controller then drops every LE advertisement: LE Set Extended Scan
Enable succeeds, but no LE Extended Advertising Report is ever
delivered, so LE discovery and passive scanning find nothing. BR/EDR
inquiry is not affected. Sending LE Set Advertisement Filter Enable with
Enable set to 0x00 restores reporting immediately. The Microsoft HCI
extension specification defines the filter as disabled by default and
does not specify what a controller reports while the filter is enabled
without any monitor condition.

Only enable the filter while at least one monitor is offloaded to the
controller, and update it after a monitor is added or removed and after
the monitors are re-registered on power on and resume. Like the
monitors, the filter state does not survive a power off, so reset the
tracked state in msft_do_close() instead of sending a redundant disable
on power on. A command is only sent when the wanted state differs from
msft->filter_enabled, so this depends on the previous patch keeping
that state accurate when the controller reports the filter as already
being in the requested state.

Fixes: 394566bf1e37 ("Bluetooth: advmon offload MSFT handle filter enablement")
Signed-off-by: Thomas de Gruijter <thomasdegruijter@pm.me>
---
 net/bluetooth/msft.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index f372df9a9831..db7b40ab5fc1 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -468,6 +468,30 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 	return err;
 }
 
+/* Keep the advertisement filter enabled only while at least one monitor is
+ * offloaded to the controller. With the filter enabled and no monitors, some
+ * controllers (e.g. MediaTek MT7922) drop every advertisement, which breaks
+ * LE discovery and passive scanning entirely.
+ *
+ * This function requires the caller holds hci_req_sync_lock
+ */
+static void msft_update_filter_enable(struct hci_dev *hdev)
+{
+	struct msft_data *msft = hdev->msft_data;
+	bool enable, update;
+
+	if (!msft)
+		return;
+
+	hci_dev_lock(hdev);
+	enable = !list_empty(&msft->handle_map);
+	update = enable != msft->filter_enabled;
+	hci_dev_unlock(hdev);
+
+	if (update)
+		msft_set_filter_enable(hdev, enable);
+}
+
 /* This function requires the caller holds hci_req_sync_lock */
 int msft_suspend_sync(struct hci_dev *hdev)
 {
@@ -493,6 +517,8 @@ int msft_suspend_sync(struct hci_dev *hdev)
 	/* All monitors have been removed */
 	msft->suspending = false;
 
+	msft_update_filter_enable(hdev);
+
 	return 0;
 }
 
@@ -633,6 +659,7 @@ int msft_resume_sync(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	reregister_monitor(hdev);
+	msft_update_filter_enable(hdev);
 
 	return 0;
 }
@@ -670,11 +697,11 @@ void msft_do_open(struct hci_dev *hdev)
 
 	if (msft_monitor_supported(hdev)) {
 		msft->resuming = true;
-		msft_set_filter_enable(hdev, true);
 		/* Monitors get removed on power off, so we need to explicitly
 		 * tell the controller to re-monitor.
 		 */
 		reregister_monitor(hdev);
+		msft_update_filter_enable(hdev);
 	}
 }
 
@@ -706,6 +733,11 @@ void msft_do_close(struct hci_dev *hdev)
 		kfree(handle_data);
 	}
 
+	/* The advertisement filter is back to its default, disabled state
+	 * after power off as well.
+	 */
+	msft->filter_enabled = false;
+
 	hci_dev_unlock(hdev);
 
 	mutex_lock(&msft->filter_lock);
@@ -1173,6 +1205,7 @@ static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
 int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor)
 {
 	struct msft_data *msft = hdev->msft_data;
+	int err;
 
 	if (!msft)
 		return -EOPNOTSUPP;
@@ -1180,13 +1213,17 @@ int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor)
 	if (msft->resuming || msft->suspending)
 		return -EBUSY;
 
-	return msft_add_monitor_sync(hdev, monitor);
+	err = msft_add_monitor_sync(hdev, monitor);
+	msft_update_filter_enable(hdev);
+
+	return err;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
 int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 {
 	struct msft_data *msft = hdev->msft_data;
+	int err;
 
 	if (!msft)
 		return -EOPNOTSUPP;
@@ -1194,7 +1231,10 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	if (msft->resuming || msft->suspending)
 		return -EBUSY;
 
-	return msft_remove_monitor_sync(hdev, monitor);
+	err = msft_remove_monitor_sync(hdev, monitor);
+	msft_update_filter_enable(hdev);
+
+	return err;
 }
 
 int msft_set_filter_enable(struct hci_dev *hdev, bool enable)

-- 
2.56.0


