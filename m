Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 4/7] tools/csr_usb : Fix Resource leak: file
Date: Thu, 11 Sep 2014 18:50:04 +0530
Message-id: <1410441607-9687-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handles resource leak.
---
 tools/csr_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index 5fb6bdc..a1d7324 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -80,9 +80,12 @@ static int read_value(const char *name, const char *attr, const char *format)
 		return -1;
 
 	n = fscanf(file, format, &value);
-	if (n != 1)
+	if (n != 1) {
+		fclose(file);
 		return -1;
+	}
 
+	fclose(file);
 	return value;
 }
 
-- 
1.9.1

