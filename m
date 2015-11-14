Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 2/2] monitor/rfcomm: Fix frame names formatting
Date: Sat, 14 Nov 2015 13:28:58 +0100
Message-Id: <1447504138-3575-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447504138-3575-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447504138-3575-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/rfcomm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index bdf4000..91f0c39 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -422,10 +422,10 @@ struct rfcomm_data {
 
 static const struct rfcomm_data rfcomm_table[] = {
 	{ 0x2f, "Set Async Balance Mode (SABM) " },
-	{ 0x63, "Unnumbered Ack (UA)" },
-	{ 0x0f, "Disconnect Mode (DM)" },
-	{ 0x43, "Disconnect (DISC)" },
-	{ 0xef, "Unnumbered Info with Header Check (UIH)" },
+	{ 0x63, "Unnumbered Ack (UA) " },
+	{ 0x0f, "Disconnect Mode (DM) " },
+	{ 0x43, "Disconnect (DISC) " },
+	{ 0xef, "Unnumbered Info with Header Check (UIH) " },
 	{ }
 };
 
-- 
2.6.2

