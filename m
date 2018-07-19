Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ] monitor: Allow Ellisys injection when reading from TTY
Date: Thu, 19 Jul 2018 20:34:30 +0200
Message-Id: <20180719183430.9334-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/control.c b/monitor/control.c
index 150bdcc44..1b62001fa 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1307,6 +1307,8 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
 
 		btsnoop_write_hci(btsnoop_file, tv, 0, opcode, drops,
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
+		ellisys_inject_hci(tv, 0, opcode, hdr->ext_hdr + hdr->hdr_len,
+					pktlen);
 		packet_monitor(tv, NULL, 0, opcode,
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
 
-- 
2.18.0

