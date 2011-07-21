Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 21 Jul 2011 11:19:17 -0700
Message-ID: <CAE-CKuhSu6EdLSLio8HcorP+cwAo3-ByMwSxJEMc7BefhC_Sdw@mail.gmail.com>
Subject: [PATCH] Fix Read-Not-Permit in char discovery
From: mike tsai <mikeyhtsai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
     This patch reads the discovered characteristic's property to
determine if Read is permitted before sending read request. This
avoids the error response from server as "read not permitted".

 ---
 attrib/client.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 1ef2699..f345a9e 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -850,6 +850,8 @@ static void update_all_chars(gpointer data,
gpointer user_data)
 	struct primary *prim = user_data;
 	struct gatt_service *gatt = prim->gatt;

+	if (chr->perm & ATT_CHAR_PROPER_READ)
+	{
 	qdesc = g_new0(struct query_data, 1);
 	qdesc->prim = prim;
 	qdesc->chr = chr;
@@ -864,8 +866,8 @@ static void update_all_chars(gpointer data,
gpointer user_data)

 	gatt->attrib = g_attrib_ref(gatt->attrib);
 	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
+	}
 }
-
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
-- 
1.7.4.1
