Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] monitor: Fix checking boolean return value
Date: Thu, 19 Jun 2014 16:55:32 +0300
Message-Id: <1403186136-30041-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since btsnoop_read_hci() is used from src/shared.
---
 monitor/analyze.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a747938..a5ed5f4 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -286,8 +286,8 @@ void analyze_trace(const char *path)
 		struct timeval tv;
 		uint16_t index, opcode, pktlen;
 
-		if (btsnoop_read_hci(btsnoop_file, &tv, &index, &opcode,
-							buf, &pktlen) < 0)
+		if (!btsnoop_read_hci(btsnoop_file, &tv, &index, &opcode,
+								buf, &pktlen))
 			break;
 
 		switch (opcode) {
-- 
1.8.3.2

