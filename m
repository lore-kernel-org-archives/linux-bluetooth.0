Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ] core/adapter: Fix local oob data reading fail when SC is
 disabled
Date: Wed, 05 Aug 2015 13:20:50 +0900
Message-id: <1438748450-20284-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

If SC is not enabled, MGMT_OP_READ_LOCAL_OOB_DATA command does not
get the local oob extended data. And the length is smaller than
rp size. This patch removes the size checking logic, so will not
return the error for the normal case. We can handle the exception
case when the status is not MGMT_STATUS_SUCCESS.

< HCI Command: Read Local OOB Data (0x03|0x0057) plen 0         [hci0] 7.628820
> HCI Event: Command Complete (0x0e) plen 36                    [hci0] 7.632616
      Read Local OOB Data (0x03|0x0057) ncmd 1
        Status: Success (0x00)
        Hash C from P-192: 150780594affab7c117efa6cb64918f3
        Randomizer R with P-192: c75821e0b60e070ba5f4534606ebcb01

bluetoothd[3348]: src/adapter.c:btd_adapter_read_local_oob_data() hci0
bluetoothd[3348]: Too small read local OOB data response
---
 src/adapter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 59c90d2..07bf7b4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7199,9 +7199,6 @@ static void read_local_oob_data_complete(uint8_t status, uint16_t length,
 						mgmt_errstr(status), status);
 		hash = NULL;
 		randomizer = NULL;
-	} else if (length < sizeof(*rp)) {
-		error("Too small read local OOB data response");
-		return;
 	} else {
 		hash = rp->hash192;
 		randomizer = rp->rand192;
-- 
1.8.1.2

