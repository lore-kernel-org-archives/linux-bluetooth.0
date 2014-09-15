Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v2 2/3] tools/btsnoop : Fix variable reassigning issue
Date: Mon, 15 Sep 2014 11:40:04 +0530
Message-id: <1410761405-4525-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Variable 'written' is reassigned a value before the old one has been used.
---
 tools/btsnoop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 6ca62d2..1fdd391 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -211,8 +211,9 @@ next_packet:
 		goto next_packet;
 	}
 
-	written = input_pkt[select_input].size = htobe32(toread - 1);
-	written = input_pkt[select_input].len = htobe32(toread - 1);
+	written = htobe32(toread-1);
+	input_pkt[select_input].size = written;
+	input_pkt[select_input].len = written;
 
 	switch (buf[0]) {
 	case 0x01:
-- 
1.9.1

