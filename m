Return-Path: <cyrus@holtmann.org>
Subject: Re: Input pairing broken again
From: David Woodhouse <dwmw2@infradead.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: <1221272245.10249.18.camel@macbook.infradead.org>
References: <1221265310.10249.10.camel@macbook.infradead.org>
	 <1221272245.10249.18.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 19:38:27 -0700
Message-Id: <1221273507.10249.20.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While we're at it, let's fix init_browse() not to abort completely when
it finds one driver asking for a UUID that another driver already
wanted, and to eliminate duplicates of the UUIDs in uuid_list[] too...

diff --git a/src/device.c b/src/device.c
index b90861b..cae29f8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1022,11 +1023,29 @@ static void init_browse(struct browse_req *req)
 
 		for (i = 0; driver->uuids[i]; i++) {
 			char *uuid;
-
+			int j;
+
+			/* Eliminate duplicates of UUIDs in uuid_list[]... */
+			if (strlen(driver->uuids[i]) == 36 && 
+			    !strncmp(driver->uuids[i], "0000", 4) &&
+			    !strcasecmp(driver->uuids[i] + 8, 
+					"-0000-1000-8000-00805F9B34FB")) {
+				uint16_t uuid16 = strtol(driver->uuids[i],
+							 NULL, 16);
+				for (j = 0; uuid_list[j]; j++) {
+					if (uuid16 == uuid_list[j])
+						continue;
+				}
+					
+			}
+			/* ... and of UUIDs another driver already asked for */
 			if (g_slist_find_custom(req->uuids, driver->uuids[i],
-					(GCompareFunc) strcasecmp))
-				return;
-
+						(GCompareFunc) strcasecmp)) {
+				printf("match on %s: return\n", driver->uuids[i]);
+				continue;
+			}
+			printf("Add uuid %s for driver %s\n",
+			       driver->uuids[i], driver->name);
 			uuid = g_strdup(driver->uuids[i]);
 			req->uuids = g_slist_append(req->uuids, uuid);
 		}

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

