Return-Path: <cyrus@holtmann.org>
Subject: Re: Input pairing broken again
From: David Woodhouse <dwmw2@infradead.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: <1221265310.10249.10.camel@macbook.infradead.org>
References: <1221265310.10249.10.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 19:17:25 -0700
Message-Id: <1221272245.10249.18.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-09-12 at 17:21 -0700, David Woodhouse wrote:
> Using the wizard to pair with my Anycom BTM-100 mouse is broken by
> commit 58d8ea3c (Make discovery service routine to search for driver
> uuids.)
> 
> I think the pairing actually works OK, but it takes so long that the
> wizard times out, and doesn't bother to connect the new input device.
> Looking at the dump at http://david.woodhou.se/btmouse-fail.dump it
> seems to be taking about 30 seconds.

diff --git a/src/device.c b/src/device.c
index b90861b..0e615be 100644
--- a/src/device.c
+++ b/src/device.c
@@ -975,8 +975,9 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	bdaddr_t src;
 	uuid_t uuid;
 
-	/* Public browsing successful or Single record requested */
-	if (err < 0 || (!req->search_uuid && recs))
+	/* If we have a valid response and req->search_uuid == 1, then
+	   public browsing was successful -- we don't need any more */
+	if (err < 0 || (req->search_uuid == 1 && recs))
 		goto done;
 
 	update_services(req, recs);
@@ -984,8 +985,8 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	adapter_get_address(adapter, &src);
 
 	/* Search for mandatory uuids */
-	if (uuid_list[++req->search_uuid]) {
-		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid]);
+	if (uuid_list[req->search_uuid]) {
+		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 		bt_search_service(&src, &device->bdaddr, &uuid, browse_cb, user_data, NULL);
 		return;
 	}
@@ -1057,7 +1061,7 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 		memcpy(&uuid, search, sizeof(uuid_t));
 		cb = search_cb;
 	} else {
-		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid]);
+		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 		init_browse(req);
 		cb = browse_cb;
 	}
@@ -1072,7 +1076,7 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 						device, NULL);
 
 	return bt_search_service(&src, &device->bdaddr,
-					&uuid, browse_cb, req, NULL);
+					&uuid, cb, req, NULL);
 }
 
 struct btd_adapter *device_get_adapter(struct btd_device *device)


-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

