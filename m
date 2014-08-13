Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4] monitor: Handle default switch case
Date: Wed, 13 Aug 2014 14:32:07 +0300
Message-Id: <1407929527-12120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20140813091913.GA19215@t440s.lan>
References: <20140813091913.GA19215@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes issues with junk packets.
---
 monitor/analyze.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b027b3c..eea3c9e 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -309,6 +309,9 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_SCO_RX_PKT:
 			sco_pkt(&tv, index, buf, pktlen);
 			break;
+		default:
+			fprintf(stderr, "Wrong opcode %u\n", opcode);
+			goto done;
 		}
 
 		num_packets++;
-- 
1.9.1

