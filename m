Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ37+GoQx66+xD+K9_Lbi4yQZq_TWt_qDMiObdmwUg0AA@mail.gmail.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
	<1345653354-23720-2-git-send-email-s.syam@samsung.com>
	<CABBYNZLr1iENopeSbqqiQuryC0T99KkG=Go-K0j9zNca_ijpVQ@mail.gmail.com>
	<CABBYNZJ37+GoQx66+xD+K9_Lbi4yQZq_TWt_qDMiObdmwUg0AA@mail.gmail.com>
Date: Fri, 24 Aug 2012 12:45:37 +0300
Message-ID: <CABBYNZLyT80dZHzuZA=F=KvqrQsK9sZqgyq211Uoysk0Gap7UA@mail.gmail.com>
Subject: Re: [PATCH obexd v1 2/4] build: Require GLib 2.32 or later
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Aug 23, 2012 at 1:36 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Syam,
>
> On Thu, Aug 23, 2012 at 1:27 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Syam,
>>
>> On Wed, Aug 22, 2012 at 7:35 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
>>> If we use GLib version less than 2.32 (more precisely < 2.31.2) then
>>> the following build error may occure in a 32 bit.
>>
>> We had the issue with BlueZ but we did not bump the glib version,
>> which makes me wonder if you are able to compile bluetoothd?
>
> It looks like we fix it with use of a variable:
>
>  commit e34836262ba6a46491b6a760520158d70e8b51b5
> Author: Johan Hedberg <johan.hedberg@intel.com>
> Date:   Wed Oct 12 00:48:59 2011 +0300
>
>     Fix compilation error on 32-bit systems
>
>     This fixes the following compilation error with GLib on 32-bit sytems:
>
>     audio/media.c: In function 'get_setting':
>     audio/media.c:1109:44: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>     audio/media.c: In function 'set_setting':
>     audio/media.c:1132:41: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]

How about the following patch:

diff --git a/gobex/gobex-apparam.c b/gobex/gobex-apparam.c
index 8f72aa7..d29dfc1 100644
--- a/gobex/gobex-apparam.c
+++ b/gobex/gobex-apparam.c
@@ -112,12 +112,14 @@ GObexApparam *g_obex_apparam_decode(const void
*data, gsize size)
 	while (count < size) {
 		struct apparam_tag *tag;
 		gsize parsed;
+		guint id;

 		tag = apparam_tag_decode(data + count, size - count, &parsed);
 		if (tag == NULL)
 			break;

-		g_hash_table_insert(tags, GUINT_TO_POINTER(tag->id), tag);
+		id = tag->id;
+		g_hash_table_insert(tags, GUINT_TO_POINTER(id), tag);

 		count += parsed;
 	}
@@ -167,12 +169,14 @@ GObexApparam
*g_obex_apparam_set_bytes(GObexApparam *apparam, guint8 id,
 						const void *value, gsize len)
 {
 	struct apparam_tag *tag;
+	guint uid;

 	if (apparam == NULL)
 		apparam = g_obex_apparam_new();

 	tag = tag_new(id, len, value);
-	g_hash_table_replace(apparam->tags, GUINT_TO_POINTER(id), tag);
+	uid = id;
+	g_hash_table_replace(apparam->tags, GUINT_TO_POINTER(uid), tag);

 	return apparam;
 }
@@ -232,6 +236,12 @@ GObexApparam
*g_obex_apparam_set_string(GObexApparam *apparam, guint8 id,
 	return g_obex_apparam_set_bytes(apparam, id, value, len);
 }

+static struct apparam_tag *g_obex_apparam_find_tag(GObexApparam *apparam,
+								guint id)
+{
+	return g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+}
+
 gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, guint8 id,
 							guint8 *dest)
 {
@@ -239,7 +249,7 @@ gboolean g_obex_apparam_get_uint8(GObexApparam
*apparam, guint8 id,

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return FALSE;

@@ -257,7 +267,7 @@ gboolean g_obex_apparam_get_uint16(GObexApparam
*apparam, guint8 id,

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return FALSE;

@@ -278,7 +288,7 @@ gboolean g_obex_apparam_get_uint32(GObexApparam
*apparam, guint8 id,

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return FALSE;

@@ -299,7 +309,7 @@ gboolean g_obex_apparam_get_uint64(GObexApparam
*apparam, guint8 id,

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return FALSE;

@@ -320,7 +330,7 @@ char *g_obex_apparam_get_string(GObexApparam
*apparam, guint8 id)

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return NULL;

@@ -338,7 +348,7 @@ gboolean g_obex_apparam_get_bytes(GObexApparam
*apparam, guint8 id,

 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);

-	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
+	tag = g_obex_apparam_find_tag(apparam, id);
 	if (tag == NULL)
 		return FALSE;

-- 
1.7.11.4



-- 
Luiz Augusto von Dentz
