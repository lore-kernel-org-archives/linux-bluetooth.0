Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] emulator: Fix AMP emulation build error
Date: Thu, 10 Oct 2013 10:15:34 +0200
Message-ID: <1381392934-12197-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix build with GCC 4.6.3.

  CC     emulator/amp.o
emulator/amp.c: In function ‘send_packet’:
emulator/amp.c:172:7: error: ignoring return value of ‘write’,
    declared with attribute warn_unused_result [-Werror=unused-result]
cc1: all warnings being treated as errors
make[1]: *** [emulator/amp.o] Error
---
 emulator/amp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/emulator/amp.c b/emulator/amp.c
index e80d9a8..714854b 100644
--- a/emulator/amp.c
+++ b/emulator/amp.c
@@ -169,7 +169,8 @@ static void reset_defaults(struct bt_amp *amp)
 
 static void send_packet(struct bt_amp *amp, const void *data, uint16_t len)
 {
-	write(amp->vhci_fd, data, len);
+	if (write(amp->vhci_fd, data, len) < 0)
+		fprintf(stderr, "Write to /dev/vhci failed\n");
 }
 
 static void send_event(struct bt_amp *amp, uint8_t event,
-- 
1.8.4

