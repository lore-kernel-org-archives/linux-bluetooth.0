Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 5/5] manager: set argument name for introspection
Date: Wed, 18 Apr 2012 13:48:02 -0300
Message-Id: <1334767682-27121-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now we have the following extra 'name=pattern' as response to
org.freedesktop.DBus.Introspectable.Introspect:

...
	<method name="FindAdapter">
		<arg name="pattern" type="s" direction="in"/>
		<arg type="o" direction="out"/>
	</method>
...
---
 src/manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/manager.c b/src/manager.c
index 6244516..5ee1054 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -199,7 +199,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter",	"s",	"o",	find_adapter	},
+	{ "FindAdapter",	"s[pattern]",	"o",	find_adapter	},
 	{ "ListAdapters",	"",	"ao",	list_adapters,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ }
-- 
1.7.10

