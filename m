Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990F2D3A9D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533012; cv=none; b=lLhUe4OtefZPSI5+1DpmKKraxXSbvjaJ7r0Ct9FepHv6gD7kSGeanTK7voc9WcHV3ijcQzplZuREk7N0KwcnJsw1mp/1HpjdnUcjfrpEJZYWdPHMXQloALUTwHPaOL1hCxeWBbVcS+Bpjiv5ZmEttBVgEBNEWOozpCr4IwPMsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533012; c=relaxed/simple;
	bh=/onDnsdO1+FI0Oe4dEkX9jy0kfYBOSlGDKHH9UY+fVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub71XL/OBSOMpk4C3MgJmHJ/j6pFjUoEFw92Epb8oTXPQQOJNhRC1cp7LUECo/LjH8xoDTz81MHQMoFXJdeAENQVCCdyWAqxv7pFu9BtPZCEU2jX013DUcZ0g4bzWcAEGCcOaOqXdCfTRiJDFX6HO5I9cZoz0OXeIoIIEL8tO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D46C643186;
	Thu,  3 Jul 2025 08:56:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 11/19] obexd: Fix typos
Date: Thu,  3 Jul 2025 10:53:19 +0200
Message-ID: <20250703085630.935452-12-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevteejtdffffevudevueetudehgeeuhfefffeutedvjeeggeffteffiedvhfetjeenucffohhmrghinhepshgvmhgrnhhtihgtuggvshhkthhophdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 obexd/client/session.c            |  2 +-
 obexd/plugins/irmc.c              |  4 ++--
 obexd/plugins/mas.c               |  2 +-
 obexd/plugins/messages.h          |  4 ++--
 obexd/plugins/pcsuite.c           |  2 +-
 obexd/plugins/phonebook-dummy.c   |  2 +-
 obexd/plugins/phonebook-tracker.c | 34 +++++++++++++++----------------
 obexd/src/manager.c               |  2 +-
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 2770b926124c..fa9bd7d17b16 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -845,7 +845,7 @@ static int session_process_transfer(struct pending_request *p, GError **err)
 	if (!obc_transfer_start(p->transfer, p->session->obex, err))
 		return -1;
 
-	DBG("Tranfer(%p) started", p->transfer);
+	DBG("Transfer(%p) started", p->transfer);
 	p->session->p = p;
 	return 0;
 }
diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index cab97b620ac2..cfd8a45d4029 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -294,7 +294,7 @@ static int irmc_open_cc(struct irmc_session *irmc)
 
 static int irmc_open_cal(struct irmc_session *irmc)
 {
-	/* no suport yet. Just return an empty buffer. cal.vcs */
+	/* no support yet. Just return an empty buffer. cal.vcs */
 	DBG("unsupported, returning empty buffer");
 
 	if (!irmc->buffer)
@@ -305,7 +305,7 @@ static int irmc_open_cal(struct irmc_session *irmc)
 
 static int irmc_open_nt(struct irmc_session *irmc)
 {
-	/* no suport yet. Just return an empty buffer. nt.vnt */
+	/* no support yet. Just return an empty buffer. nt.vnt */
 	DBG("unsupported, returning empty buffer");
 
 	if (!irmc->buffer)
diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 35974650114c..b9feeb395529 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -805,7 +805,7 @@ static void *message_notification_filter_open(const char *name, int oflag,
 
 	DBG("");
 
-	/* TODO notifcation filter add */
+	/* TODO notification filter add */
 	mas->finished = TRUE;
 	*err = 0;
 
diff --git a/obexd/plugins/messages.h b/obexd/plugins/messages.h
index 535ec303cbdc..fe7d07fee098 100644
--- a/obexd/plugins/messages.h
+++ b/obexd/plugins/messages.h
@@ -271,7 +271,7 @@ int messages_update_inbox(void *session, messages_status_cb callback,
  * handle: Unique identifier to the message.
  * value: Indicates the new value of the read status for a given message.
  * Callback shall be called for every read status update request
- *	recieved from MCE.
+ *	received from MCE.
  * user_data: User data if any to be sent.
  */
 int messages_set_read(void *session, const char *handle, uint8_t value,
@@ -283,7 +283,7 @@ int messages_set_read(void *session, const char *handle, uint8_t value,
  * handle: Unique identifier to the message.
  * value: Indicates the new value of the delete status for a given message.
  * Callback shall be called for every delete status update request
- *	recieved from MCE.
+ *	received from MCE.
  * user_data: User data if any to be sent.
  */
 int messages_set_delete(void *session, const char *handle, uint8_t value,
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 1755ffbbbd59..0e83a1133320 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -447,7 +447,7 @@ static ssize_t backup_write(void *object, const void *buf, size_t count)
 	if (obj->fd != -1) {
 		ret = write(obj->fd, buf, count);
 
-		DBG("cmd = %s, WRITTING", obj->cmd);
+		DBG("cmd = %s, WRITING", obj->cmd);
 
 		if (ret < 0) {
 			error("backup: cmd = %s", obj->cmd);
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 4d0b705049ce..0dce13f66b52 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -452,7 +452,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	char *filename, *folder;
 
 	/*
-	 * Main phonebook objects will be created dinamically based on the
+	 * Main phonebook objects will be created dynamically based on the
 	 * folder content. All vcards inside the given folder will be appended
 	 * in the "virtual" main phonebook object.
 	 */
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 71a91c1ea1ab..61a660561f72 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -32,8 +32,8 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define AFFILATION_HOME "Home"
-#define AFFILATION_WORK "Work"
+#define AFFILIATION_HOME "Home"
+#define AFFILIATION_WORK "Work"
 #define ADDR_FIELD_AMOUNT 7
 #define PULL_QUERY_COL_AMOUNT 23
 #define COUNT_QUERY_COL_AMOUNT 1
@@ -45,7 +45,7 @@
 #define COL_ADDITIONAL_NAME 4
 #define COL_NAME_PREFIX 5
 #define COL_NAME_SUFFIX 6
-#define COL_ADDR_AFF 7 /* addresses from affilation */
+#define COL_ADDR_AFF 7 /* addresses from affiliation */
 #define COL_BIRTH_DATE 8
 #define COL_NICKNAME 9
 #define COL_URL 10
@@ -56,7 +56,7 @@
 #define COL_AFF_TYPE 15
 #define COL_ORG_NAME 16
 #define COL_ORG_DEPARTMENT 17
-#define COL_EMAIL_AFF 18 /* email's from affilation (work/home) */
+#define COL_EMAIL_AFF 18 /* email's from affiliation (work/home) */
 #define COL_DATE 19
 #define COL_SENT 20
 #define COL_ANSWERED 21
@@ -1046,11 +1046,11 @@ static void contact_init(struct phonebook_contact *contact,
 							reply[COL_ANSWERED]);
 }
 
-static enum phonebook_number_type get_phone_type(const char *affilation)
+static enum phonebook_number_type get_phone_type(const char *affiliation)
 {
-	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
+	if (g_strcmp0(AFFILIATION_HOME, affiliation) == 0)
 		return TEL_TYPE_HOME;
-	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
+	else if (g_strcmp0(AFFILIATION_WORK, affiliation) == 0)
 		return TEL_TYPE_WORK;
 
 	return TEL_TYPE_OTHER;
@@ -1086,7 +1086,7 @@ static void add_aff_number(struct phonebook_contact *contact,
 		add_phone_number(contact, number, TEL_TYPE_MOBILE);
 	else
 		/* if this is no fax/mobile phone, then adding phone number
-		 * type based on type of the affilation field */
+		 * type based on type of the affiliation field */
 		add_phone_number(contact, number, get_phone_type(aff_type));
 
 failed:
@@ -1099,7 +1099,7 @@ static void contact_add_numbers(struct phonebook_contact *contact,
 	char **aff_numbers;
 	int i;
 
-	/* Filling phone numbers from contact's affilation */
+	/* Filling phone numbers from contact's affiliation */
 	aff_numbers = g_strsplit(reply[COL_PHONE_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_numbers)
@@ -1110,11 +1110,11 @@ static void contact_add_numbers(struct phonebook_contact *contact,
 	g_strfreev(aff_numbers);
 }
 
-static enum phonebook_field_type get_field_type(const char *affilation)
+static enum phonebook_field_type get_field_type(const char *affiliation)
 {
-	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
+	if (g_strcmp0(AFFILIATION_HOME, affiliation) == 0)
 		return FIELD_TYPE_HOME;
-	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
+	else if (g_strcmp0(AFFILIATION_WORK, affiliation) == 0)
 		return FIELD_TYPE_WORK;
 
 	return FIELD_TYPE_OTHER;
@@ -1126,8 +1126,8 @@ static void add_aff_field(struct phonebook_contact *contact,
 	char **email_parts;
 	char *type, *email;
 
-	/* Emails from affilation data, are represented as real email
-	 * string and affilation type - those strings are separated by
+	/* Emails from affiliation data, are represented as real email
+	 * string and affiliation type - those strings are separated by
 	 * SUB_DELIM string */
 	email_parts = g_strsplit(aff_email, SUB_DELIM, 2);
 
@@ -1156,7 +1156,7 @@ static void contact_add_emails(struct phonebook_contact *contact,
 	char **aff_emails;
 	int i;
 
-	/* Emails from affilation */
+	/* Emails from affiliation */
 	aff_emails = g_strsplit(reply[COL_EMAIL_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_emails)
@@ -1172,7 +1172,7 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 	char **aff_addr;
 	int i;
 
-	/* Addresses from affilation */
+	/* Addresses from affiliation */
 	aff_addr = g_strsplit(reply[COL_ADDR_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_addr)
@@ -1188,7 +1188,7 @@ static void contact_add_urls(struct phonebook_contact *contact,
 	char **aff_url;
 	int i;
 
-	/* Addresses from affilation */
+	/* Addresses from affiliation */
 	aff_url = g_strsplit(reply[COL_URL], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_url)
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 5a6fd9b4b94e..683dd4ca079d 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -40,7 +40,7 @@
 #define AGENT_INTERFACE OBEXD_SERVICE ".Agent1"
 #define OBEX_ERROR_REJECT      "org.bluez.obex.Error.Rejected"
 
-#define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
+#define TIMEOUT 60*1000 /* Timeout for user response (milliseconds) */
 
 struct agent {
 	char *bus_name;
-- 
2.50.0

