Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd] Fix white space related coding style issues
Date: Mon, 27 Jun 2011 01:10:40 +0530
Message-Id: <1309117240-25201-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Corrected the whitespace related coding style issues
a. no space before '{'
b. no space after 'sizeof'
c. no space during array initilization
d. no space after 'for'
e. no space between function arguments.
---
 gdbus/object.c              |    2 +-
 gwobex/obex-priv.h          |    2 +-
 gwobex/utils.c              |    4 ++--
 plugins/filesystem.c        |    2 +-
 plugins/ftp.c               |    2 +-
 plugins/pcsuite.c           |    4 ++--
 plugins/phonebook-tracker.c |   10 +++++-----
 plugins/vcard.c             |   14 +++++++-------
 src/manager.c               |    2 +-
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index d17a101..8bc12f5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -76,7 +76,7 @@ static void print_arguments(GString *gstr, const char *sig,
 
 		/* Gather enough data to have a single complete type */
 		for (len = 0; len < (sizeof(type) - 1) && sig[i]; len++, i++) {
-			switch (sig[i]){
+			switch (sig[i]) {
 			case '(':
 				struct_level++;
 				break;
diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index f4e3e5b..c7e4997 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -37,7 +37,7 @@
 #include "gw-obex.h"
 #include "obex-xfer.h"
 
-#define CHECK_DISCONNECT(ret,err,ctx) do { \
+#define CHECK_DISCONNECT(ret, err, ctx) do { \
                                           if ((ctx)->conn_fd < 0) { \
                                               if (err) \
                                                   *(err) = GW_OBEX_ERROR_DISCONNECT; \
diff --git a/gwobex/utils.c b/gwobex/utils.c
index 02afa2e..f47b68a 100644
--- a/gwobex/utils.c
+++ b/gwobex/utils.c
@@ -50,7 +50,7 @@ char *bytestr(const uint8_t *uuid, int len) {
 gboolean fd_raw_mode(int fd) {
     struct termios mode;
 
-    memset(&mode, 0, sizeof (mode));
+    memset(&mode, 0, sizeof(mode));
     if (tcgetattr(fd, &mode) < 0) {
         debug("tcgetattr(%d, &mode): %s", fd, strerror(errno));
         return FALSE;
@@ -134,7 +134,7 @@ time_t parse_iso8601(const gchar *str, int len) {
     time_t    time;
     time_t    tz_offset = 0;
 
-    memset (&tm, 0, sizeof (struct tm));
+    memset (&tm, 0, sizeof(struct tm));
 
     /* According to spec the time doesn't have to be null terminated */
     if (str[len - 1] != '\0') {
diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index b4ff556..22e883f 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -84,7 +84,7 @@ static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 #define PCSUITE_WHO_SIZE 8
 
 static const uint8_t PCSUITE_WHO[PCSUITE_WHO_SIZE] = {
-			'P','C',' ','S','u','i','t','e' };
+			'P', 'C', ' ', 'S', 'u', 'i', 't', 'e' };
 
 
 static char *file_stat_line(char *filename, struct stat *fstat,
diff --git a/plugins/ftp.c b/plugins/ftp.c
index 4cf0135..15cc7fb 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -144,7 +144,7 @@ static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 			0x98, 0x4E, 0x52, 0x54, 0x00, 0xDC, 0x9E, 0x09 };
 
 static const uint8_t PCSUITE_WHO[PCSUITE_WHO_SIZE] = {
-			'P','C',' ','S','u','i','t','e' };
+			'P', 'C', ' ', 'S', 'u', 'i', 't', 'e' };
 
 struct ftp_session {
 	struct obex_session *os;
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 125f25a..d43842f 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -109,7 +109,7 @@ static const uint8_t FTP_TARGET[TARGET_SIZE] = {
 			0x98, 0x4E, 0x52, 0x54, 0x00, 0xDC, 0x9E, 0x09 };
 
 static const uint8_t PCSUITE_WHO[PCSUITE_WHO_SIZE] = {
-			'P','C',' ','S','u','i','t','e' };
+			'P', 'C', ' ', 'S', 'u', 'i', 't', 'e' };
 
 struct pcsuite_session {
 	struct ftp_session *ftp;
@@ -267,7 +267,7 @@ static struct obex_service_driver pcsuite = {
 	.disconnect = pcsuite_disconnect
 };
 
-struct backup_object{
+struct backup_object {
 	gchar *cmd;
 	int fd;
 	int oflag;
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d396203..52c4746 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1020,7 +1020,7 @@ static void contact_add_numbers(struct phonebook_contact *contact,
 	aff_numbers = g_strsplit(reply[COL_PHONE_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_numbers)
-		for(i = 0;aff_numbers[i]; ++i)
+		for (i = 0; aff_numbers[i]; ++i)
 			add_aff_number(contact, aff_numbers[i],
 							reply[COL_AFF_TYPE]);
 
@@ -1077,7 +1077,7 @@ static void contact_add_emails(struct phonebook_contact *contact,
 	aff_emails = g_strsplit(reply[COL_EMAIL_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_emails)
-		for(i = 0; aff_emails[i] != NULL; ++i)
+		for (i = 0; aff_emails[i] != NULL; ++i)
 			add_aff_field(contact, aff_emails[i], add_email);
 
 	g_strfreev(aff_emails);
@@ -1094,7 +1094,7 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 								MAX_FIELDS);
 
 	if (aff_addr)
-		for(i = 0; aff_addr[i] != NULL; ++i)
+		for (i = 0; aff_addr[i] != NULL; ++i)
 			add_aff_field(contact, aff_addr[i], add_address);
 
 	g_strfreev(aff_addr);
@@ -1110,7 +1110,7 @@ static void contact_add_urls(struct phonebook_contact *contact,
 	aff_url = g_strsplit(reply[COL_URL], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_url)
-		for(i = 0; aff_url[i] != NULL; ++i)
+		for (i = 0; aff_url[i] != NULL; ++i)
 			add_aff_field(contact, aff_url[i], add_url);
 
 	g_strfreev(aff_url);
@@ -1553,7 +1553,7 @@ int phonebook_pull_read(void *request)
 
 	data->newmissedcalls = 0;
 
-	if (g_strcmp0(data->req_name,"/telecom/mch.vcf") == 0 &&
+	if (g_strcmp0(data->req_name, "/telecom/mch.vcf") == 0 &&
 						data->tracker_index == 0) {
 		/* new missed calls amount should be counted only once - it
 		 * will be done during generating first part of results of
diff --git a/plugins/vcard.c b/plugins/vcard.c
index efeba17..d6df360 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -265,7 +265,7 @@ static void vcard_printf_tag(GString *vcards, uint8_t format, const char *tag,
 	if (tag == NULL || strlen(tag) == 0)
 		return;
 
-	if (fld == NULL || strlen(fld) == 0){
+	if (fld == NULL || strlen(fld) == 0) {
 		vcard_printf(vcards, "%s:", tag);
 		return;
 	}
@@ -294,7 +294,7 @@ static void vcard_printf_slash_tag(GString *vcards, uint8_t format,
 	if (tag == NULL || strlen(tag) == 0)
 		return;
 
-	if (fld == NULL || (len = strlen(fld)) == 0){
+	if (fld == NULL || (len = strlen(fld)) == 0) {
 		vcard_printf(vcards, "%s:", tag);
 		return;
 	}
@@ -321,11 +321,11 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 	char field[LEN_MAX];
 	int len = 0;
 
-	if (!address || !(len = strlen(address))){
+	if (!address || !(len = strlen(address))) {
 		vcard_printf(vcards, "EMAIL:");
 		return;
 	}
-	switch (category){
+	switch (category) {
 	case FIELD_TYPE_HOME:
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET;HOME";
@@ -346,7 +346,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 	}
 
 	add_slash(field, address, LEN_MAX, len);
-	vcard_printf(vcards,"EMAIL;%s:%s", category_string, field);
+	vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
 }
 
 static void vcard_printf_url(GString *vcards, uint8_t format,
@@ -398,7 +398,7 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 static void vcard_printf_org(GString *vcards,
 					struct phonebook_contact *contact)
 {
-	if (org_fields_present(contact) == FALSE){
+	if (org_fields_present(contact) == FALSE) {
 		vcard_printf(vcards, "ORG:");
 		return;
 	}
@@ -536,7 +536,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 			vcard_printf_email(vcards, format, NULL,
 							FIELD_TYPE_OTHER);
 
-		for (; l; l = l->next){
+		for (; l; l = l->next) {
 			struct phonebook_field *email = l->data;
 			vcard_printf_email(vcards, format, email->text,
 								email->type);
diff --git a/src/manager.c b/src/manager.c
index 80140b6..241c9af 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -252,7 +252,7 @@ static char *target2str(const uint8_t *t)
 
 	return g_strdup_printf("%02X%02X%02X%02X-%02X%02X-%02X%02X-"
 				"%02X%02X-%02X%02X%02X%02X%02X%02X",
-				t[0], t[1], t[2], t[3], t[4], t[5], t[6],t[7],
+				t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7],
 				t[8], t[9], t[10], t[11], t[12], t[13], t[14], t[15]);
 }
 
-- 
1.7.4.1

