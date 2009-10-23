Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256253562-22532-1-git-send-email-jaikumar@google.com>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
Date: Fri, 23 Oct 2009 10:49:37 -0300
Message-ID: <2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 22, 2009 at 8:19 PM, Jaikumar Ganesh <jaikumar@google.com> wrote:
>        for (list = uuids; list; list = list->next)
>                device->uuids = g_slist_remove(device->uuids, list->data);

It looks like to me this would be the proper place to remove the
records from the storage, since we are updating the uuids list there
is no big deal to redo that in another function.

So it would look like this:

diff --git a/src/device.c b/src/device.c
index 6cb9641..708e069 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1134,8 +1134,6 @@ static void device_remove_drivers(struct
btd_device *device, GSList *uuids)
 		next = list->next;

 		for (uuid = driver->uuids; *uuid; uuid++) {
-			sdp_record_t *rec;
-
 			if (!g_slist_find_custom(uuids, *uuid,
 					(GCompareFunc) strcasecmp))
 				continue;
@@ -1148,15 +1146,6 @@ static void device_remove_drivers(struct
btd_device *device, GSList *uuids)
 								driver_data);
 			g_free(driver_data);

-			rec = find_record_in_list(records, *uuid);
-			if (!rec)
-				break;
-
-			delete_record(srcaddr, dstaddr, rec->handle);
-
-			records = sdp_list_remove(records, rec);
-			sdp_record_free(rec);
-
 			break;
 		}
 	}
@@ -1164,8 +1153,19 @@ static void device_remove_drivers(struct
btd_device *device, GSList *uuids)
 	if (records)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);

-	for (list = uuids; list; list = list->next)
+	for (list = uuids; list; list = list->next) {
+		sdp_record_t *rec;
+
 		device->uuids = g_slist_remove(device->uuids, list->data);
+		rec = find_record_in_list(records, list->data);
+		if (!rec)
+			break;
+
+		delete_record(srcaddr, dstaddr, rec->handle);
+
+		records = sdp_list_remove(records, rec);
+		sdp_record_free(rec);
+	}
 }

 static void services_changed(struct btd_device *device)


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
