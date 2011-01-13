Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add support for multiple URL in PBAP
Date: Thu, 13 Jan 2011 13:53:12 +0200
Message-Id: <1294919592-2978-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Application which stores contact data changed way that
URL data is stored. Now it is possible for contact to
have more than one url defined with different types.
Place where these url are stored has also changed in db.
This fix changes handling for url in PBAP to make urls
visible in pull results again.
---
 plugins/phonebook-tracker.c |   89 +++++++++++++++++++++++++++++++++++++++----
 plugins/vcard.c             |   54 ++++++++++++++++++++++++--
 plugins/vcard.h             |    2 +-
 3 files changed, 132 insertions(+), 13 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 67e4d40..f51503b 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -109,7 +109,12 @@
 "}) "									\
 "nco:birthDate(?_contact) "						\
 "nco:nickname(?_contact) "						\
-"nco:url(?_contact) "							\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_val, \"\31\", rdfs:label(?_role) "			\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_role nco:url ?url_val . "				\
+"})"									\
 "nie:url(nco:photo(?_contact)) "					\
 "nco:role(?_role) "							\
 "nco:contactUID(?_contact) "						\
@@ -181,7 +186,14 @@
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
-	"nco:url(?_contact) "						\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_value, \"\31\", ?aff_type "				\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_contact nco:hasAffiliation ?c_role . "		\
+		"?c_role nco:url ?url_value . "				\
+		"?c_role rdfs:label ?aff_type . "			\
+"})"									\
 	"nie:url(nco:photo(?_contact)) "				\
 	"nco:role(?_role) "						\
 	"nco:contactUID(?_contact) "					\
@@ -311,7 +323,14 @@
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
-	"nco:url(?_contact) "						\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_value, \"\31\", ?aff_type "				\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_contact nco:hasAffiliation ?c_role . "		\
+		"?c_role nco:url ?url_value . "				\
+		"?c_role rdfs:label ?aff_type . "			\
+"})"									\
 	"nie:url(nco:photo(?_contact)) "				\
 	"nco:role(?_role) "						\
 	"nco:contactUID(?_contact) "					\
@@ -440,7 +459,14 @@
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
-	"nco:url(?_contact) "						\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_value, \"\31\", ?aff_type "				\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_contact nco:hasAffiliation ?c_role . "		\
+		"?c_role nco:url ?url_value . "				\
+		"?c_role rdfs:label ?aff_type . "			\
+"})"									\
 	"nie:url(nco:photo(?_contact)) "				\
 	"nco:role(?_role) "						\
 	"nco:contactUID(?_contact) "					\
@@ -563,7 +589,14 @@
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
-	"nco:url(?_contact) "						\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_value, \"\31\", ?aff_type "				\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_contact nco:hasAffiliation ?c_role . "		\
+		"?c_role nco:url ?url_value . "				\
+		"?c_role rdfs:label ?aff_type . "			\
+"})"									\
 	"nie:url(nco:photo(?_contact)) "				\
 	"nco:role(?_role) "						\
 	"nco:contactUID(?_contact) "					\
@@ -732,7 +765,12 @@
 "}) "									\
 "nco:birthDate(<%s>) "							\
 "nco:nickname(<%s>) "							\
-"nco:url(<%s>) "							\
+"(SELECT GROUP_CONCAT(fn:concat( "					\
+	"?url_val, \"\31\", rdfs:label(?_role) "			\
+	"), \"\30\") "							\
+	"WHERE {"							\
+		"?_role nco:url ?url_val . "				\
+"})"									\
 "nie:url(nco:photo(<%s>)) "						\
 "nco:role(?_role) "							\
 "nco:contactUID(<%s>) "							\
@@ -1255,6 +1293,26 @@ static void add_address(struct phonebook_contact *contact,
 	contact->addresses = g_slist_append(contact->addresses, addr);
 }
 
+static void add_url(struct phonebook_contact *contact, const char *url_val,
+								int type)
+{
+	struct phonebook_field *url;
+
+	if (url_val == NULL || strlen(url_val) == 0)
+		return;
+
+	/* Not adding url if there is already added with the same value */
+	if (find_field(contact->urls, url_val, type))
+		return;
+
+	url = g_new0(struct phonebook_field, 1);
+
+	url->text = g_strdup(url_val);
+	url->type = type;
+
+	contact->urls = g_slist_append(contact->urls, url);
+}
+
 static GString *gen_vcards(GSList *contacts,
 					const struct apparam_field *params)
 {
@@ -1320,7 +1378,6 @@ static void contact_init(struct phonebook_contact *contact, char **reply)
 	contact->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
 	contact->birthday = g_strdup(reply[COL_BIRTH_DATE]);
 	contact->nickname = g_strdup(reply[COL_NICKNAME]);
-	contact->website = g_strdup(reply[COL_URL]);
 	contact->photo = g_strdup(reply[COL_PHOTO]);
 	contact->company = g_strdup(reply[COL_ORG_NAME]);
 	contact->department = g_strdup(reply[COL_ORG_DEPARTMENT]);
@@ -1469,6 +1526,21 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 	g_strfreev(aff_addr);
 }
 
+static void contact_add_urls(struct phonebook_contact *contact, char **reply)
+{
+	char **aff_url;
+	int i;
+
+	/* Addresses from affilation */
+	aff_url = g_strsplit(reply[COL_URL], MAIN_DELIM, MAX_FIELDS);
+
+	if (aff_url)
+		for(i = 0; aff_url[i] != NULL; ++i)
+			add_aff_field(contact, aff_url[i], add_url);
+
+	g_strfreev(aff_url);
+}
+
 static void contact_add_organization(struct phonebook_contact *contact,
 								char **reply)
 {
@@ -1546,6 +1618,7 @@ add_numbers:
 	contact_add_numbers(contact, reply);
 	contact_add_emails(contact, reply);
 	contact_add_addresses(contact, reply);
+	contact_add_urls(contact, reply);
 	contact_add_organization(contact, reply);
 
 	DBG("contact %p", contact);
@@ -1854,7 +1927,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 						id, id, id, id, id, id, id, id,
-						id, id, id);
+						id, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 261e264..efeba17 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -349,6 +349,41 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 	vcard_printf(vcards,"EMAIL;%s:%s", category_string, field);
 }
 
+static void vcard_printf_url(GString *vcards, uint8_t format,
+					const char *url,
+					enum phonebook_field_type category)
+{
+	const char *category_string = "";
+
+	if (!url || strlen(url) == 0) {
+		vcard_printf(vcards, "URL:");
+		return;
+	}
+
+	switch (category) {
+	case FIELD_TYPE_HOME:
+		if (format == FORMAT_VCARD21)
+			category_string = "INTERNET;HOME";
+		else if (format == FORMAT_VCARD30)
+			category_string = "TYPE=INTERNET;TYPE=HOME";
+		break;
+	case FIELD_TYPE_WORK:
+		if (format == FORMAT_VCARD21)
+			category_string = "INTERNET;WORK";
+		else if (format == FORMAT_VCARD30)
+			category_string = "TYPE=INTERNET;TYPE=WORK";
+		break;
+	default:
+		if (format == FORMAT_VCARD21)
+			category_string = "INTERNET";
+		else if (format == FORMAT_VCARD30)
+			category_string = "TYPE=INTERNET";
+		break;
+	}
+
+	vcard_printf(vcards,"URL;%s:%s", category_string, url);
+}
+
 static gboolean org_fields_present(struct phonebook_contact *contact)
 {
 	if (contact->company && strlen(contact->company))
@@ -530,9 +565,18 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		vcard_printf_slash_tag(vcards, format, "NICKNAME", NULL,
 							contact->nickname);
 
-	if (filter & FILTER_URL)
-		vcard_printf_slash_tag(vcards, format, "URL", "INTERNET",
-							contact->website);
+	if (filter & FILTER_URL) {
+		GSList *l = contact->urls;
+
+		if (g_slist_length(l) == 0)
+			vcard_printf_url(vcards, format, NULL,
+							FIELD_TYPE_OTHER);
+
+		for (; l; l = l->next) {
+			struct phonebook_field *url = l->data;
+			vcard_printf_url(vcards, format, url->text, url->type);
+		}
+	}
 
 	if (filter & FILTER_PHOTO)
 		vcard_printf_tag(vcards, format, "PHOTO", NULL,
@@ -576,6 +620,9 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_slist_foreach(contact->addresses, field_free, NULL);
 	g_slist_free(contact->addresses);
 
+	g_slist_foreach(contact->urls, field_free, NULL);
+	g_slist_free(contact->urls);
+
 	g_free(contact->uid);
 	g_free(contact->fullname);
 	g_free(contact->given);
@@ -585,7 +632,6 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_free(contact->suffix);
 	g_free(contact->birthday);
 	g_free(contact->nickname);
-	g_free(contact->website);
 	g_free(contact->photo);
 	g_free(contact->company);
 	g_free(contact->department);
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 379f92c..88cdbed 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -58,7 +58,7 @@ struct phonebook_contact {
 	GSList *addresses;
 	char *birthday;
 	char *nickname;
-	char *website;
+	GSList *urls;
 	char *photo;
 	char *company;
 	char *department;
-- 
1.7.0.4

