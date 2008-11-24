Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Nov 2008 18:11:20 +0800
Subject: RE: Can we change org.openobex.Client's dbus node path?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E021C55AE@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
 <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org>
 <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com>
 <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org>
 <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
 <D964A4DB-60BA-4B95-A970-4D7E3E289670@holtmann.org>
In-Reply-To: <D964A4DB-60BA-4B95-A970-4D7E3E289670@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>
>so first, please fix the coding style here. I can tell from just the
>pure email that you are mixing up tabs and spaces and also that you
>are missing whitespaces here and there. Check that your mail client
>doesn't mangle it. If in doubt send it as attachment.
>
>Regards
>
>Marcel


Hi Marcel

Thanks for point out the tabs and spaces issue, I think this is might be re=
lated to my terminal setting when I do the copy/paste with the diff output.=
 And 3 whitespaces added. So here it is:

---------------------------------------------------------------------------

diff --git a/gdbus/object.c b/gdbus/object.c
index a417ab9..9cf6f09 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -299,25 +299,28 @@ static void invalidate_parent_data(DBusConnection *co=
nn, const char *child_path)
 	char *parent_path, *slash;
=20
 	parent_path =3D g_strdup(child_path);
-	slash =3D strrchr(parent_path, '/');
-	if (!slash)
-		goto done;
-
-	*slash =3D '\0';
-	if (!strlen(parent_path))
-		goto done;
+	do {
+		slash =3D strrchr(parent_path, '/');
+		if (!slash)
+			break;
=20
-	if (!dbus_connection_get_object_path_data(conn, parent_path,
-							(void *) &data))
-		goto done;
+		if (slash =3D=3D parent_path) {
+			*(slash + 1) =3D '\0';
+		} else {
+			*slash =3D '\0';
+		}
=20
-	if (!data)
-		goto done;
+		if (!dbus_connection_get_object_path_data(conn, parent_path,
+								(void *) &data))
+			continue;
=20
-	g_free(data->introspect);
-	data->introspect =3D NULL;
+		if (!data)
+			continue;
=20
-done:
+		g_free(data->introspect);
+		data->introspect =3D NULL;
+	} while (slash !=3D parent_path);
+=09
 	g_free(parent_path);
 }

---------------------------------------------

Raymond
