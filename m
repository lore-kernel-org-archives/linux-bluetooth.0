Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 13/23] client-api: Rename PhonebookAccess interface to org.bluez.obex.PhonebookAccess
Date: Tue,  5 Jun 2012 13:57:11 +0300
Message-Id: <1338893841-14234-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/pbap.c      |    2 +-
 doc/client-api.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index e296eec..9bd93b8 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -122,7 +122,7 @@ static const char *filter_list[] = {
 #define FILTER_BIT_MAX	63
 #define FILTER_ALL	0xFFFFFFFFFFFFFFFFULL
 
-#define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
+#define PBAP_INTERFACE "org.bluez.obex.PhonebookAccess"
 #define PBAP_UUID "0000112f-0000-1000-8000-00805f9b34fb"
 
 struct pbap_data {
diff --git a/doc/client-api.txt b/doc/client-api.txt
index fc58ee9..5a6189d 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -184,7 +184,7 @@ Phonebook Access hierarchy
 =======================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.PhonebookAccess
+Interface	org.bluez.obex.PhonebookAccess
 Object path	[variable prefix]/{session0,session1,...}
 
 Methods		void Select(string location, string phonebook)
-- 
1.7.10.2

