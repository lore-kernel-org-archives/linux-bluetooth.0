Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 14 Apr 2018 00:28:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC PATCH] Bluetooth: __hci_req_remove_ext_adv_set() can be static
Message-ID: <20180413162854.GA9996@lkp-snb01>
References: <1523531987-17140-16-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523531987-17140-16-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Fixes: 8369ebfd29c2 ("Bluetooth: Implement disable and removal of adv instance")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hci_request.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 0e470f7..341b5bd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1443,7 +1443,7 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-void __hci_req_remove_ext_adv_set(struct hci_request *req, u8 instance)
+static void __hci_req_remove_ext_adv_set(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_remove_adv_set cp;
 
