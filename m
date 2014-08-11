Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/10] monitor: Handle default switch case
Date: Mon, 11 Aug 2014 10:50:37 +0300
Message-Id: <1407743445-1329-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes issues with junk packets.
---
 monitor/analyze.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 7aa98b0..9ec6b06 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -339,6 +339,9 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_SCO_RX_PKT:
 			sco_pkt(&tv, index, true, buf, pktlen);
 			break;
+		default:
+			fprintf(stderr, "Wrong opcode %u", opcode);
+			goto done;
 		}
 
 		num_packets++;
-- 
1.9.1

