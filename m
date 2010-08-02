Return-Path: <cyrus@holtmann.org>
Message-Id: <201008022209.o72M94DV017676@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Tue, 3 Aug 2010 00:08:15 +0200
Subject: [PATCH] obexd: ebook backend: return all TEL attribs from vcard in string
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

evcard_to_string() only took one TEL attrib from a vcard. But
multiple TEL attribs are supported. This patch will convert
all TEL attribs to strings.
---
 plugins/phonebook-ebook.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 089b956..e80f797 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -97,6 +97,7 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 							uint64_t filter)
 {
 	EVCard *evcard2;
+	GList *l;
 	char *vcard;
 	unsigned int i;
 
@@ -109,18 +110,23 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 	 */
 	filter = format == EVC_FORMAT_VCARD_30 ? filter | 0x87: filter | 0x85;
 
+	l = e_vcard_get_attributes(evcard);
 	evcard2 = e_vcard_new();
-	for (i = 0; i < 29; i++) {
-		EVCardAttribute *attrib;
-
-		if (!(filter & (1 << i)))
-			continue;
+	for (; l; l = g_list_next(l)) {
+		EVCardAttribute *attrib = l->data;
+		const char *name;
 
-		attrib = e_vcard_get_attribute(evcard, attribute_mask[i]);
 		if (!attrib)
 			continue;
-
-		e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));
+		name = e_vcard_attribute_get_name(attrib);
+		for (i = 0; attribute_mask[i] != NULL; i++) {
+			if (!(filter & (1 << i)))
+				continue;
+			if (g_strcmp0(name, attribute_mask[i]) != 0)
+				continue;
+			e_vcard_add_attribute(evcard2,
+						e_vcard_attribute_copy(attrib));
+		}
 	}
 
 	vcard = e_vcard_to_string(evcard2, format);
-- 
1.7.2

