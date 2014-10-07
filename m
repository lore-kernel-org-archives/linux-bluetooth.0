Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/6] doc/obex-api: Add description about MASInstance request
Date: Tue, 07 Oct 2014 09:36:51 +0530
Message-id: <1412654816-14971-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/obex-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index a39abc0..d432da1 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -715,6 +715,12 @@ Methods		void SetFolder(string name)
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
 
+		string GetMASInstanceInfo(void)
+
+			Request remote for MAS Instance Information
+
+			Possible errors: org.bluez.obex.Error.InvalidArguments
+					 org.bluez.obex.Error.Failed
 
 Filter:		uint16 Offset:
 
-- 
1.9.1

