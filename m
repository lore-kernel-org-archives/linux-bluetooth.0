Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 1/2] Add handling of single contact's fields handled in VCARD structure
Date: Thu, 19 Aug 2010 14:48:20 +0300
Message-Id: <1282218500-18458-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After pulling contacts these fields weren't present in downloaded
VCARD structure in spite of that these fields existed (not empty).

This patch adds handling of fields: BDAY, NICKNAME, URL, PHOTO
To solve this problem extending number of columns and queries of database
was needed especially. Displaying these fields is done by genaral
functions: vcard_printf_slash_tag, vcard_printf_slash_slash_tag.
Of course fields mentioned above were added to phonebook_contact structure
as char * type to save gained data.
---
 plugins/phonebook-tracker.c |   29 +++++++++++++++----
 plugins/vcard.c             |   66 +++++++++++++++++++++++++++++++++++++++++++
 plugins/vcard.h             |    4 ++
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 1109968..fd92125 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,16 +43,16 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 21
-#define PULL_QUERY_COL_AMOUNT 22
+#define CONTACTS_ID_COL 25
+#define PULL_QUERY_COL_AMOUNT 26
 #define COL_HOME_NUMBER 0
 #define COL_HOME_EMAIL 7
 #define COL_WORK_NUMBER 8
 #define COL_FAX_NUMBER 16
 #define COL_WORK_EMAIL 17
-#define COL_DATE 18
-#define COL_SENT 19
-#define COL_ANSWERED 20
+#define COL_DATE 22
+#define COL_SENT 23
+#define COL_ANSWERED 24
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -62,6 +62,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:photo(?c) "						\
 	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
@@ -106,6 +108,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:photo(?c) "						\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -151,6 +155,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:photo(?c) "						\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -196,6 +202,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew)"	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:photo(?c) "						\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -239,6 +247,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:photo(?c) "						\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -306,6 +316,8 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f  nco:emailAddress(?ew)"	\
+	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:websiteUrl(<%s>) "	\
+	"nco:photo(<%s>) "						\
 	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
@@ -774,6 +786,10 @@ add_entry:
 	contact->region = g_strdup(reply[13]);
 	contact->postal = g_strdup(reply[14]);
 	contact->country = g_strdup(reply[15]);
+	contact->birthday = g_strdup(reply[18]);
+	contact->nickname = g_strdup(reply[19]);
+	contact->website = g_strdup(reply[20]);
+	contact->photo = g_strdup(reply[21]);
 
 	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
 			reply[COL_ANSWERED]);
@@ -978,7 +994,8 @@ int phonebook_get_entry(const char *folder, const char *id,
 	data->vcardentry = TRUE;
 
 	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
-						id, id, id, id, id, id, id);
+						id, id, id, id, id, id, id,
+						id, id, id, id);
 
 	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 18b5952..c45bfcd 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -256,6 +256,54 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	vcard_printf(vcards, buf, number);
 }
 
+static void vcard_printf_tag(GString *vcards, const char *tag,
+					const char* category, const char *fld)
+{
+	if (tag == NULL || strlen(tag) == 0)
+		return;
+
+	if (fld == NULL || strlen(fld) == 0)
+		return;
+
+	char separator = '\0', *type = "";
+	char buf[LEN_MAX];
+
+	if (category && strlen(category)) {
+		separator = ';';
+		type = "TYPE=";
+	}
+
+	snprintf(buf, sizeof(buf), "%s%c%s%s", tag, separator, type, category);
+
+	vcard_printf(vcards, "%s:%s", buf, fld);
+}
+
+static void vcard_printf_slash_tag(GString *vcards, const char *tag,
+					const char* category, const char *fld)
+{
+	int len;
+
+	if (tag == NULL || strlen(tag) == 0)
+		return;
+
+	if (fld == NULL || (len = strlen(fld)) == 0)
+		return;
+
+	char separator = '\0', *type = "";
+	char buf[LEN_MAX];
+
+	if (category && strlen(category)) {
+		separator = ';';
+		type = "TYPE=";
+	}
+
+	snprintf(buf, sizeof(buf), "%s%c%s%s", tag, separator, type, category);
+
+	char field[LEN_MAX];
+	add_slash(field, fld, LEN_MAX, len);
+	vcard_printf(vcards, "%s:%s", buf, field);
+}
+
 static void vcard_printf_email(GString *vcards, const char *email)
 {
 	int len = 0;
@@ -354,6 +402,20 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_ADR)
 		vcard_printf_adr(vcards, contact);
 
+	if (filter & FILTER_BDAY)
+		vcard_printf_tag(vcards, "BDAY", NULL, contact->birthday);
+
+	if (filter & FILTER_NICKNAME)
+		vcard_printf_slash_tag(vcards, "NICKNAME", NULL,
+							contact->nickname);
+
+	if (filter & FILTER_URL)
+		vcard_printf_slash_tag(vcards, "URL", "INTERNET",
+							contact->website);
+
+	if (filter & FILTER_PHOTO)
+		vcard_printf_tag(vcards, "PHOTO", NULL, contact->photo);
+
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
 		vcard_printf_datetime(vcards, contact);
 
@@ -392,6 +454,10 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_free(contact->region);
 	g_free(contact->postal);
 	g_free(contact->country);
+	g_free(contact->birthday);
+	g_free(contact->nickname);
+	g_free(contact->website);
+	g_free(contact->photo);
 	g_free(contact->datetime);
 	g_free(contact);
 }
diff --git a/plugins/vcard.h b/plugins/vcard.h
index fa571e4..a9809ea 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -55,6 +55,10 @@ struct phonebook_contact {
 	char *region;
 	char *postal;
 	char *country;
+	char *birthday;
+	char *nickname;
+	char *website;
+	char *photo;
 	char *datetime;
 	int calltype;
 };
-- 
1.6.3.3

