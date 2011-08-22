Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 1/2] Refactoring address fields handled in vcard module
Date: Mon, 22 Aug 2011 12:32:56 +0200
Message-Id: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces phonebook_addr struct for more intuitive
handling address fields from backend. Now address fields are managed
by linked list (wrapped by structure) and it is used for printing vCard
address fields, instead of buffers set (combined with g_strsplit
and snprintf functions).
---
 plugins/phonebook-tracker.c |   72 +++++++++++++++++++++++++++++++++++++-----
 plugins/vcard.c             |   70 +++++++++++++++++++----------------------
 plugins/vcard.h             |    7 +++-
 3 files changed, 101 insertions(+), 48 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 8bc070f..56291d0 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -852,22 +852,76 @@ static void add_email(struct phonebook_contact *contact, const char *address,
 	contact->emails = g_slist_append(contact->emails, email);
 }
 
+static gboolean addr_matches(struct phonebook_addr *a, struct phonebook_addr *b)
+{
+	GSList *la, *lb;
+
+	if (a->type != b->type)
+		return FALSE;
+
+	for (la = a->fields, lb = b->fields; la && lb;
+						la = la->next, lb = lb->next) {
+		char *field_a = la->data;
+		char *field_b = lb->data;
+
+		if (g_strcmp0(field_a, field_b) != 0)
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
+/* generates phonebook_addr struct from tracker address data string. */
+static struct phonebook_addr *gen_addr(const char *address, int type)
+{
+	struct phonebook_addr *addr;
+	GSList *fields = NULL;
+	char **addr_parts;
+	int i;
+
+	/* This test handles cases when address points to empty string
+	 * (or address is NULL pointer) or string containing only six
+	 * separators. It indicates that none of address fields is present
+	 * and there is no sense to create dummy phonebook_addr struct */
+	if (address == NULL || strlen(address) < ADDR_FIELD_AMOUNT)
+		return NULL;
+
+	addr_parts = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
+
+	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i)
+		fields = g_slist_append(fields, g_strdup(addr_parts[i]));
+
+	g_strfreev(addr_parts);
+
+	addr = g_new0(struct phonebook_addr, 1);
+	addr->fields = fields;
+	addr->type = type;
+
+	return addr;
+}
+
 static void add_address(struct phonebook_contact *contact,
 					const char *address, int type)
 {
-	struct phonebook_field *addr;
-
-	if (address == NULL || address_fields_present(address) == FALSE)
-		return;
+	struct phonebook_addr *addr;
+	GSList *l;
 
-	/* Not adding address if there is already added with the same value */
-	if (find_field(contact->addresses, address, type))
+	addr = gen_addr(address, type);
+	if (addr == NULL)
 		return;
 
-	addr = g_new0(struct phonebook_field, 1);
+	/* Not adding address if there is already added with the same value.
+	 * These type of checks have to be done because sometimes tracker
+	 * returns results for contact data in more than 1 row - then the same
+	 * address may be returned more than once in query results */
+	for (l = contact->addresses; l; l = l->next) {
+		struct phonebook_addr *tmp = l->data;
 
-	addr->text = g_strdup(address);
-	addr->type = type;
+		if (addr_matches(tmp, addr)) {
+			phonebook_addr_free(addr);
+			return;
+		}
+	}
 
 	contact->addresses = g_slist_append(contact->addresses, addr);
 }
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 5a5bcf4..a4a1921 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -201,24 +201,6 @@ static gboolean contact_fields_present(struct phonebook_contact * contact)
 	return FALSE;
 }
 
-gboolean address_fields_present(const char *address)
-{
-	gchar **fields = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
-	int i;
-
-	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i) {
-
-		if (strlen(fields[i]) != 0) {
-			g_strfreev(fields);
-			return TRUE;
-		}
-	}
-
-	g_strfreev(fields);
-
-	return FALSE;
-}
-
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
@@ -440,21 +422,19 @@ static void vcard_printf_org(GString *vcards,
 }
 
 static void vcard_printf_address(GString *vcards, uint8_t format,
-					const char *address,
-					enum phonebook_field_type category)
+					struct phonebook_addr *address)
 {
-	char buf[LEN_MAX];
-	char field[ADDR_FIELD_AMOUNT][LEN_MAX];
+	char *fields, field_esc[LEN_MAX];
 	const char *category_string = "";
-	int len, i;
-	gchar **address_fields;
+	size_t len;
+	GSList *l;
 
-	if (!address || address_fields_present(address) == FALSE) {
+	if (!address) {
 		vcard_printf(vcards, "ADR:");
 		return;
 	}
 
-	switch (category) {
+	switch (address->type) {
 	case FIELD_TYPE_HOME:
 		if (format == FORMAT_VCARD21)
 			category_string = "HOME";
@@ -475,18 +455,25 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 		break;
 	}
 
-	address_fields = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
+	/* allocate enough memory to insert address fields separated by ';'
+	 * and terminated by '\0' */
+	len = ADDR_FIELD_AMOUNT * LEN_MAX;
+	fields = g_malloc0(len);
+
+	for (l = address->fields; l; l = l->next) {
+		char *field = l->data;
+
+		add_slash(field_esc, field, LEN_MAX, strlen(field));
+		g_strlcat(fields, field_esc, len);
 
-	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i) {
-		len = strlen(address_fields[i]);
-		add_slash(field[i], address_fields[i], LEN_MAX, len);
+		if (l->next)
+			/* not addding ';' after last addr field */
+			g_strlcat(fields, ";", len);
 	}
 
-	snprintf(buf, LEN_MAX, "%s;%s;%s;%s;%s;%s;%s",
-	field[0], field[1], field[2], field[3], field[4], field[5], field[6]);
-	g_strfreev(address_fields);
+	vcard_printf(vcards,"ADR;%s:%s", category_string, fields);
 
-	vcard_printf(vcards,"ADR;%s:%s", category_string, buf);
+	g_free(fields);
 }
 
 static void vcard_printf_datetime(GString *vcards,
@@ -576,9 +563,8 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		GSList *l = contact->addresses;
 
 		for (; l; l = l->next) {
-			struct phonebook_field *addr = l->data;
-			vcard_printf_address(vcards, format, addr->text,
-								addr->type);
+			struct phonebook_addr *addr = l->data;
+			vcard_printf_address(vcards, format, addr);
 		}
 	}
 
@@ -627,6 +613,14 @@ static void field_free(gpointer data)
 	g_free(field);
 }
 
+void phonebook_addr_free(gpointer addr)
+{
+	struct phonebook_addr *address = addr;
+
+	g_slist_free_full(address->fields, g_free);
+	g_free(address);
+}
+
 void phonebook_contact_free(struct phonebook_contact *contact)
 {
 	if (contact == NULL)
@@ -634,7 +628,7 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 
 	g_slist_free_full(contact->numbers, field_free);
 	g_slist_free_full(contact->emails, field_free);
-	g_slist_free_full(contact->addresses, field_free);
+	g_slist_free_full(contact->addresses, phonebook_addr_free);
 	g_slist_free_full(contact->urls, field_free);
 
 	g_free(contact->uid);
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 88cdbed..22c3f68 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -45,6 +45,11 @@ struct phonebook_field {
 	int type;
 };
 
+struct phonebook_addr {
+	GSList *fields;
+	int type;
+};
+
 struct phonebook_contact {
 	char *uid;
 	char *fullname;
@@ -73,4 +78,4 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 
 void phonebook_contact_free(struct phonebook_contact *contact);
 
-gboolean address_fields_present(const char *address);
+void phonebook_addr_free(gpointer addr);
-- 
1.6.3.3

