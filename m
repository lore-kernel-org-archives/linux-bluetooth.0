Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Deprecate the ListAdapters() method on Manager
Date: Fri, 12 Feb 2010 16:16:32 -0200
Message-Id: <1265998592-7249-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265998592-7249-1-git-send-email-padovan@profusion.mobi>
References: <1265998592-7249-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/manager-api.txt |    6 ++++--
 src/manager.c       |    3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 256a782..d2c1caf 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -37,9 +37,11 @@ Methods		dict GetProperties()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
 
-		array{object} ListAdapters()
+		array{object} ListAdapters() {deprecated}
 
-			Returns list of adapter object paths under /org/bluez
+			Returns list of adapter object paths under /org/bluez.
+			This method is deprecated, instead use the Adapters
+			Property to get the list of adapter object paths.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
diff --git a/src/manager.c b/src/manager.c
index 3331dcb..da7b91f 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -229,7 +229,8 @@ static GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
 	{ "FindAdapter",	"s",	"o",	find_adapter	},
-	{ "ListAdapters",	"",	"ao",	list_adapters	},
+	{ "ListAdapters",	"",	"ao",	list_adapters,
+						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ }
 };
 
-- 
1.6.4.4

