Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PBAP 2/2] obexd/client/pbap: Adds few attributes to property mask
Date: Thu, 25 Sep 2014 14:40:12 +0530
Message-id: <1411636212-5872-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1411636212-5872-1-git-send-email-gowtham.ab@samsung.com>
References: <1411636212-5872-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below attributes for property mask:
1) Speed-dial
2) Uniform Caller Identifier
3) Unique Identifier
---
 obexd/client/pbap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 614616c..fe0602e 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -103,6 +103,9 @@ static const char *filter_list[] = {
 	"CLASS",
 	"SORT-STRING",
 	"X-IRMC-CALL-DATETIME",
+	"X-BT-SPEEDDIALKEY",
+	"X-BT-UCI",
+	"X-BT-UID",
 	NULL
 };
 
-- 
1.9.1

