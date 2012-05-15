Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] client: Fix not checking if GoepL2capPsm contains a valid PSM
Date: Tue, 15 May 2012 19:16:46 +0300
Message-Id: <1337098606-5710-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337098606-5710-1-git-send-email-luiz.dentz@gmail.com>
References: <1337098606-5710-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the PSM is not valid ignore it so we are still able to connect
to RFCOMM.
---
 client/bluetooth.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/client/bluetooth.c b/client/bluetooth.c
index b49a82e..56f80fe 100644
--- a/client/bluetooth.c
+++ b/client/bluetooth.c
@@ -261,7 +261,8 @@ static void search_callback(uint8_t type, uint16_t status,
 		}
 
 		data = sdp_data_get(rec, 0x0200);
-		if (data != NULL)
+		/* PSM must be odd and lsb of upper byte must be 0 */
+		if (data != NULL && (data->val.uint16 & 0x0101) == 0x0001)
 			ch = data->val.uint16;
 
 		sdp_record_free(rec);
-- 
1.7.7.6

