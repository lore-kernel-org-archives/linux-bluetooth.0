Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 2/2] manager: add argument name
Date: Tue, 15 Nov 2011 03:43:53 -0200
Message-Id: <1321335833-16907-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1321335833-16907-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1321335833-16907-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 464b0ca..2ea0d51 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -199,7 +199,8 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter",	"s",	"o",	find_adapter	},
+	{ "FindAdapter",	"s",	"o",	find_adapter,
+					.arg_names = "pattern" },
 	{ "ListAdapters",	"",	"ao",	list_adapters,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ }
-- 
1.7.7.3

