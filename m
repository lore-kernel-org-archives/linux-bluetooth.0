Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/5] monitor: Handle default switch case
Date: Tue, 12 Aug 2014 15:46:35 +0300
Message-Id: <1407847596-14781-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20140812090449.GA18519@t440s.ger.corp.intel.com>
 <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes issues with junk packets.
---
 monitor/analyze.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b027b3c..4c52d12 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -309,6 +309,9 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_SCO_RX_PKT:
 			sco_pkt(&tv, index, buf, pktlen);
 			break;
+		default:
+			fprintf(stderr, "Wrong opcode %u", opcode);
+			goto done;
 		}
 
 		num_packets++;
-- 
1.9.1

