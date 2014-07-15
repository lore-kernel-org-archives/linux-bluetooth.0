Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Write btsnoop before processing packet
Date: Tue, 15 Jul 2014 14:18:18 +0200
Message-Id: <1405426698-27365-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of parser crash packet should still be present in
btsnoop file. This allows to reproduce crash and provide fix.
---
 monitor/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 879e195..451eabe 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -811,11 +811,11 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 			packet_control(tv, index, opcode, data->buf, pktlen);
 			break;
 		case HCI_CHANNEL_MONITOR:
-			packet_monitor(tv, index, opcode, data->buf, pktlen);
 			btsnoop_write_hci(btsnoop_file, tv, index, opcode,
 							data->buf, pktlen);
 			ellisys_inject_hci(tv, index, opcode,
 							data->buf, pktlen);
+			packet_monitor(tv, index, opcode, data->buf, pktlen);
 			break;
 		}
 	}
-- 
1.9.1

