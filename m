Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 3/3] tools/hcidump: Print LDAC vendor codec name
Date: Fri, 13 Nov 2015 11:59:41 +0100
Message-Id: <1447412381-6208-3-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447412381-6208-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447412381-6208-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/parser/avdtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index f05f329..4f53553 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -154,6 +154,8 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
 {
 	if (vendor == 0x0000004f && vndcodec == 0x0001)
 		return "aptX";
+	else if (vendor == 0x0000012d && vndcodec == 0x00aa)
+		return "LDAC";
 	return "Unknown";
 }
 
-- 
2.6.2

