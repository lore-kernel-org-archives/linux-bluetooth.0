Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Nov 2008 13:39:52 +0800
Subject: RE: Can we change org.openobex.Client's dbus node path?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
 <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org>
 <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com>
 <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org>
In-Reply-To: <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>
>this is a bug in gdbus then. The exactly same code is used in
>bluetoothd and connmand so it seems weird. Did you try to debug it
>where it actually fails to get this wrong? Are we missing some
>"invalidate parent" calls?
>
>Regards
>
>Marcel

Hi Marcel

	I found the reason. During interface register object_path_unref did call i=
nvalidate_parent_data. But for our case: we have path "/" at first, and we =
register interface at "/org/openobex/Session0", there are no data for "/org=
/openobex", so no any parent introspect data is invalidated. But the whole =
/org/openobex path is created for the first time. So actually the "/"'s int=
rospect data need to be invalidated.

I modify the code as below to invalidate the parent data up to "/", so that=
 it will fix this problem.

-------------------------------------------------------------------
diff --git a/gdbus/object.c b/gdbus/object.c
old mode 100644
new mode 100755
index a417ab9..074f40b
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -299,25 +299,28 @@ static void invalidate_parent_data(DBusConnection *co=
nn, const char *child_path)
        char *parent_path, *slash;

        parent_path =3D g_strdup(child_path);
-       slash =3D strrchr(parent_path, '/');
-       if (!slash)
-               goto done;
-
-       *slash =3D '\0';
-       if (!strlen(parent_path))
-               goto done;
+       do{
+               slash =3D strrchr(parent_path, '/');
+               if (!slash)
+                       break;

-       if (!dbus_connection_get_object_path_data(conn, parent_path,
-                                                       (void *) &data))
-               goto done;
+               if (slash =3D=3D parent_path) {
+                       *(slash+1) =3D '\0';
+               } else {
+                       *slash =3D '\0';
+               }

-       if (!data)
-               goto done;
+               if (!dbus_connection_get_object_path_data(conn, parent_path=
,
+                                                               (void *) &d=
ata))
+                       continue;

-       g_free(data->introspect);
-       data->introspect =3D NULL;
+               if (!data)
+                       continue;

-done:
+               g_free(data->introspect);
+               data->introspect =3D NULL;
+       }while(slash !=3D parent_path);
+
        g_free(parent_path);
 }

-------------------------------------------------------------------------

However, It got some drawback here: if part of the parent path did exist be=
fore, and the parent's parents data do not need to change. This fix will do=
 much more thing then it should. I guess to found out all the change up to =
the necessay level will need more code. So I just make it simple here.

Raymond
