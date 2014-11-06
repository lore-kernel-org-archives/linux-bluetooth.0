Return-Path: <cyrus@holtmann.org>
From: Alex Gal <a.gal@miip.ca>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Gal <a.gal@miip.ca>
Subject: [PATCH 2/2] profiles/input: Add Sony Navigation Controller
Date: Thu,  6 Nov 2014 10:29:14 -0500
Message-Id: <1415287754-868-2-git-send-email-a.gal@miip.ca>
In-Reply-To: <1415287754-868-1-git-send-email-a.gal@miip.ca>
References: <1415287754-868-1-git-send-email-a.gal@miip.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 307db96..50a9074 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -140,6 +140,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	if (vid == 0x054c && pid == 0x05c4)
 		return true;
 
+	/* Navigation Controller */
+	if (vid == 0x054c && pid == 0x042f)
+		return true;
+
 	return false;
 }
 
-- 
2.1.1

