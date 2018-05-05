Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 6 May 2018 04:11:54 +0800
From: kbuild test robot <lkp@intel.com>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [RFC PATCH] Bluetooth: hci_qca: btqca_disable_regulators() can be
 static
Message-ID: <20180505201154.GA97475@lkp-hsx03>
References: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Fixes: 1bab29c5dbe1 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990.")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hci_qca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 075fab7..ff9fbe0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1291,7 +1291,7 @@ static const struct btqca_vreg_data cherokee_data = {
 	.num_vregs = 5,
 };
 
-void btqca_disable_regulators(int reg_nu, struct btqca_vreg *vregs)
+static void btqca_disable_regulators(int reg_nu, struct btqca_vreg *vregs)
 {
 	/* disable the regulator if requested by user
 	 * or when fault in any regulator.
