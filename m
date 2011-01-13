Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/3] Refactoring of vcard content structures
Date: Thu, 13 Jan 2011 09:38:59 +0200
Message-Id: <1294904341-16047-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Structures for holding data about phone numbers, emails and
addressess were practically identical and there was no sense
to handle them differently. Now for saving informations about
field content and type struct "phonebook_field" is used.
---
 plugins/phonebook-tracker.c |   59 ++++++++++++++++++------------------------
 plugins/vcard.c             |   57 +++++++++++++++--------------------------
 plugins/vcard.h             |   28 ++++----------------
 3 files changed, 52 insertions(+), 92 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 237fb33..9354a47 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1178,16 +1178,16 @@ static struct phonebook_contact *find_contact(GSList *contacts, const char *id)
 	return NULL;
 }
 
-static struct phonebook_number *find_phone(GSList *numbers, const char *phone,
+static struct phonebook_field *find_phone(GSList *numbers, const char *phone,
 								int type)
 {
 	GSList *l;
 
 	for (l = numbers; l; l = l->next) {
-		struct phonebook_number *pb_num = l->data;
+		struct phonebook_field *pb_num = l->data;
 		/* Returning phonebook number if phone values and type values
 		 * are equal */
-		if (g_strcmp0(pb_num->tel, phone) == 0 && pb_num->type == type)
+		if (g_strcmp0(pb_num->text, phone) == 0 && pb_num->type == type)
 			return pb_num;
 	}
 
@@ -1197,7 +1197,7 @@ static struct phonebook_number *find_phone(GSList *numbers, const char *phone,
 static void add_phone_number(struct phonebook_contact *contact,
 						const char *phone, int type)
 {
-	struct phonebook_number *number;
+	struct phonebook_field *number;
 
 	if (phone == NULL || strlen(phone) == 0)
 		return;
@@ -1206,21 +1206,21 @@ static void add_phone_number(struct phonebook_contact *contact,
 	if (find_phone(contact->numbers, phone, type))
 		return;
 
-	number = g_new0(struct phonebook_number, 1);
-	number->tel = g_strdup(phone);
+	number = g_new0(struct phonebook_field, 1);
+	number->text = g_strdup(phone);
 	number->type = type;
 
 	contact->numbers = g_slist_append(contact->numbers, number);
 }
 
-static struct phonebook_email *find_email(GSList *emails, const char *address,
+static struct phonebook_field *find_email(GSList *emails, const char *address,
 								int type)
 {
 	GSList *l;
 
 	for (l = emails; l; l = l->next) {
-		struct phonebook_email *email = l->data;
-		if (g_strcmp0(email->address, address) == 0 &&
+		struct phonebook_field *email = l->data;
+		if (g_strcmp0(email->text, address) == 0 &&
 						email->type == type)
 			return email;
 	}
@@ -1231,7 +1231,7 @@ static struct phonebook_email *find_email(GSList *emails, const char *address,
 static void add_email(struct phonebook_contact *contact, const char *address,
 								int type)
 {
-	struct phonebook_email *email;
+	struct phonebook_field *email;
 
 	if (address == NULL || strlen(address) == 0)
 		return;
@@ -1240,21 +1240,21 @@ static void add_email(struct phonebook_contact *contact, const char *address,
 	if (find_email(contact->emails, address, type))
 		return;
 
-	email = g_new0(struct phonebook_email, 1);
-	email->address = g_strdup(address);
+	email = g_new0(struct phonebook_field, 1);
+	email->text = g_strdup(address);
 	email->type = type;
 
 	contact->emails = g_slist_append(contact->emails, email);
 }
 
-static struct phonebook_address *find_address(GSList *addresses,
+static struct phonebook_field *find_address(GSList *addresses,
 					const char *address, int type)
 {
 	GSList *l;
 
 	for (l = addresses; l; l = l->next) {
-		struct phonebook_address *addr = l->data;
-		if (g_strcmp0(addr->addr, address) == 0 &&
+		struct phonebook_field *addr = l->data;
+		if (g_strcmp0(addr->text, address) == 0 &&
 						addr->type == type)
 			return addr;
 	}
@@ -1265,7 +1265,7 @@ static struct phonebook_address *find_address(GSList *addresses,
 static void add_address(struct phonebook_contact *contact,
 					const char *address, int type)
 {
-	struct phonebook_address *addr;
+	struct phonebook_field *addr;
 
 	if (address == NULL || address_fields_present(address) == FALSE)
 		return;
@@ -1274,9 +1274,9 @@ static void add_address(struct phonebook_contact *contact,
 	if (find_address(contact->addresses, address, type))
 		return;
 
-	addr = g_new0(struct phonebook_address, 1);
+	addr = g_new0(struct phonebook_field, 1);
 
-	addr->addr = g_strdup(address);
+	addr->text = g_strdup(address);
 	addr->type = type;
 
 	contact->addresses = g_slist_append(contact->addresses, addr);
@@ -1423,14 +1423,14 @@ static void contact_add_numbers(struct phonebook_contact *contact,
 	g_strfreev(aff_numbers);
 }
 
-static enum phonebook_email_type get_email_type(const char *affilation)
+static enum phonebook_field_type get_field_type(const char *affilation)
 {
 	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
-		return EMAIL_TYPE_HOME;
+		return FIELD_TYPE_HOME;
 	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
-		return EMAIL_TYPE_WORK;
+		return FIELD_TYPE_WORK;
 
-	return EMAIL_TYPE_OTHER;
+	return FIELD_TYPE_OTHER;
 }
 
 static void add_aff_email(struct phonebook_contact *contact, char *aff_email)
@@ -1456,7 +1456,7 @@ static void add_aff_email(struct phonebook_contact *contact, char *aff_email)
 	else
 		goto failed;
 
-	add_email(contact, email, get_email_type(type));
+	add_email(contact, email, get_field_type(type));
 
 failed:
 	g_strfreev(email_parts);
@@ -1478,16 +1478,6 @@ static void contact_add_emails(struct phonebook_contact *contact,
 	g_strfreev(aff_emails);
 }
 
-static enum phonebook_address_type get_addr_type(const char *affilation)
-{
-	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
-		return ADDR_TYPE_HOME;
-	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
-		return ADDR_TYPE_WORK;
-
-	return ADDR_TYPE_OTHER;
-}
-
 static void add_aff_address(struct phonebook_contact *contact, char *aff_addr)
 {
 	char **addr_parts;
@@ -1511,7 +1501,7 @@ static void add_aff_address(struct phonebook_contact *contact, char *aff_addr)
 	else
 		goto failed;
 
-	add_address(contact, address, get_addr_type(type));
+	add_address(contact, address, get_field_type(type));
 
 failed:
 	g_strfreev(addr_parts);
@@ -1534,6 +1524,7 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 	g_strfreev(aff_addr);
 }
 
+
 static void contact_add_organization(struct phonebook_contact *contact,
 								char **reply)
 {
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 3f69189..261e264 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -315,7 +315,7 @@ static void vcard_printf_slash_tag(GString *vcards, uint8_t format,
 
 static void vcard_printf_email(GString *vcards, uint8_t format,
 					const char *address,
-					enum phonebook_email_type category)
+					enum phonebook_field_type category)
 {
 	const char *category_string = "";
 	char field[LEN_MAX];
@@ -326,13 +326,13 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 		return;
 	}
 	switch (category){
-	case EMAIL_TYPE_HOME:
+	case FIELD_TYPE_HOME:
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET;HOME";
 		else if (format == FORMAT_VCARD30)
 			category_string = "TYPE=INTERNET;TYPE=HOME";
 		break;
-	case EMAIL_TYPE_WORK:
+	case FIELD_TYPE_WORK:
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET;WORK";
 		else if (format == FORMAT_VCARD30)
@@ -374,7 +374,7 @@ static void vcard_printf_org(GString *vcards,
 
 static void vcard_printf_address(GString *vcards, uint8_t format,
 					const char *address,
-					enum phonebook_address_type category)
+					enum phonebook_field_type category)
 {
 	char buf[LEN_MAX];
 	char field[ADDR_FIELD_AMOUNT][LEN_MAX];
@@ -388,13 +388,13 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	}
 
 	switch (category) {
-	case ADDR_TYPE_HOME:
+	case FIELD_TYPE_HOME:
 		if (format == FORMAT_VCARD21)
 			category_string = "HOME";
 		else if (format == FORMAT_VCARD30)
 			category_string = "TYPE=HOME";
 		break;
-	case ADDR_TYPE_WORK:
+	case FIELD_TYPE_WORK:
 		if (format == FORMAT_VCARD21)
 			category_string = "WORK";
 		else if (format == FORMAT_VCARD30)
@@ -487,9 +487,9 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 							TEL_TYPE_OTHER);
 
 		for (; l; l = l->next) {
-			struct phonebook_number *number = l->data;
+			struct phonebook_field *number = l->data;
 
-			vcard_printf_number(vcards, format, number->tel, 1,
+			vcard_printf_number(vcards, format, number->text, 1,
 								number->type);
 		}
 	}
@@ -499,11 +499,11 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 
 		if (g_slist_length(l) == 0)
 			vcard_printf_email(vcards, format, NULL,
-							EMAIL_TYPE_OTHER);
+							FIELD_TYPE_OTHER);
 
 		for (; l; l = l->next){
-			struct phonebook_email *email = l->data;
-			vcard_printf_email(vcards, format, email->address,
+			struct phonebook_field *email = l->data;
+			vcard_printf_email(vcards, format, email->text,
 								email->type);
 		}
 	}
@@ -513,11 +513,11 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 
 		if (g_slist_length(l) == 0)
 			vcard_printf_address(vcards, format, NULL,
-							ADDR_TYPE_OTHER);
+							FIELD_TYPE_OTHER);
 
 		for (; l; l = l->next) {
-			struct phonebook_address *addr = l->data;
-			vcard_printf_address(vcards, format, addr->addr,
+			struct phonebook_field *addr = l->data;
+			vcard_printf_address(vcards, format, addr->text,
 								addr->type);
 		}
 	}
@@ -553,28 +553,13 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	vcard_printf_end(vcards);
 }
 
-static void number_free(gpointer data, gpointer user_data)
-{
-	struct phonebook_number *number = data;
-
-	g_free(number->tel);
-	g_free(number);
-}
-
-static void email_free(gpointer data, gpointer user_data)
-{
-	struct phonebook_email *email = data;
-
-	g_free(email->address);
-	g_free(email);
-}
 
-static void address_free(gpointer data, gpointer user_data)
+static void field_free(gpointer data, gpointer user_data)
 {
-	struct phonebook_address *addr = data;
+	struct phonebook_field *field = data;
 
-	g_free(addr->addr);
-	g_free(addr);
+	g_free(field->text);
+	g_free(field);
 }
 
 void phonebook_contact_free(struct phonebook_contact *contact)
@@ -582,13 +567,13 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	if (contact == NULL)
 		return;
 
-	g_slist_foreach(contact->numbers, number_free, NULL);
+	g_slist_foreach(contact->numbers, field_free, NULL);
 	g_slist_free(contact->numbers);
 
-	g_slist_foreach(contact->emails, email_free, NULL);
+	g_slist_foreach(contact->emails, field_free, NULL);
 	g_slist_free(contact->emails);
 
-	g_slist_foreach(contact->addresses, address_free, NULL);
+	g_slist_foreach(contact->addresses, field_free, NULL);
 	g_slist_free(contact->addresses);
 
 	g_free(contact->uid);
diff --git a/plugins/vcard.h b/plugins/vcard.h
index d1c225e..379f92c 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -27,10 +27,10 @@ enum phonebook_number_type {
 	TEL_TYPE_OTHER,
 };
 
-enum phonebook_email_type {
-	EMAIL_TYPE_HOME,
-	EMAIL_TYPE_WORK,
-	EMAIL_TYPE_OTHER,
+enum phonebook_field_type {
+	FIELD_TYPE_HOME,
+	FIELD_TYPE_WORK,
+	FIELD_TYPE_OTHER,
 };
 
 enum phonebook_call_type {
@@ -40,24 +40,8 @@ enum phonebook_call_type {
 	CALL_TYPE_OUTGOING,
 };
 
-enum phonebook_address_type {
-	ADDR_TYPE_HOME,
-	ADDR_TYPE_WORK,
-	ADDR_TYPE_OTHER,
-};
-
-struct phonebook_number {
-	char *tel;
-	int type;
-};
-
-struct phonebook_email {
-	char *address;
-	int  type;
-};
-
-struct phonebook_address {
-	char *addr;
+struct phonebook_field {
+	char *text;
 	int type;
 };
 
-- 
1.7.0.4

