Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 3/7] tools/btsnoop : Fix variable reassigning issue
Date: Thu, 11 Sep 2014 18:50:03 +0530
Message-id: <1410441607-9687-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Variable 'written' is reassigned a value before the old one has been used.
The below on fix the same.
---
 tools/btsnoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 6ca62d2..86f4691 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -211,7 +211,7 @@ next_packet:
 		goto next_packet;
 	}
 
-	written = input_pkt[select_input].size = htobe32(toread - 1);
+	input_pkt[select_input].size = htobe32(toread - 1);
 	written = input_pkt[select_input].len = htobe32(toread - 1);
 
 	switch (buf[0]) {
-- 
1.9.1

