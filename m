Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/4] tools/csr_usb : Fix Resource leak: file
Date: Wed, 15 Oct 2014 19:38:19 +0530
Message-id: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
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

