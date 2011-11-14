Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] phonebook-tracker: Seek for contact name deeper
Date: Mon, 14 Nov 2011 14:30:54 +0100
Message-Id: <1321277454-25486-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some contacts in Tracker can have no name fields set nor nickname. This
patch enhances the way the contact name is obtained:

1) If there is no nco:nickname set for contact, use nco:imNickname from
its related IM data.
2) As the N field is mandatory in both vCard 2.1 and 3.0 and it's the
most useful field for PBAP clients, if its components are not present
in Tracker, use nco:fullname (thus promote FN to N) or if nco:fullname
is also not present, then use previously obtained nickname for N field.
---
 plugins/phonebook-tracker.c |   91 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a8b97c2..570ab37 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -113,7 +113,18 @@
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
 "nco:birthDate(?_contact) "						\
-"nco:nickname(?_contact) "						\
+"(SELECT "								\
+"	?nick "								\
+"	WHERE { "							\
+"		{ "							\
+"			?_contact nco:nickname ?nick "			\
+"		} UNION { "						\
+"			?_contact nco:hasAffiliation ?role . "		\
+"			?role nco:hasIMAddress ?im . "			\
+"			?im nco:imNickname ?nick "			\
+"		} "							\
+"	} "								\
+") "									\
 "(SELECT GROUP_CONCAT(fn:concat( "					\
 	"?url_val, \"\31\", tracker:coalesce(rdfs:label(?_role), \"\") "\
 	"), \"\30\") "							\
@@ -146,6 +157,18 @@
 	"SELECT ?c nco:nameFamily(?c) "					\
 	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
 	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
+	"(SELECT "							\
+		"?nick "						\
+		"WHERE { "						\
+			"{ "						\
+				"?c nco:nickname ?nick "		\
+			"} UNION { "					\
+				"?c nco:hasAffiliation ?role . "	\
+				"?role nco:hasIMAddress ?im . "		\
+				"?im nco:imNickname ?nick "		\
+			"} "						\
+		"} "							\
+	") "								\
 	"nco:phoneNumber(?h) "						\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
@@ -185,6 +208,18 @@ CONSTRAINT								\
 	"nco:nameGiven(?_contact) nco:nameAdditional(?_contact) "	\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
+	"(SELECT "							\
+		"?nick "						\
+		"WHERE { "						\
+			"{ "						\
+				"?_contact nco:nickname ?nick "		\
+			"} UNION { "					\
+				"?_contact nco:hasAffiliation ?role . "	\
+				"?role nco:hasIMAddress ?im . "		\
+				"?im nco:imNickname ?nick "		\
+			"} "						\
+		"} "							\
+	") "								\
 	"nco:phoneNumber(?_cpn) "					\
 CALLS_CONSTRAINTS(CONSTRAINT)						\
 "ORDER BY DESC(nmo:sentDate(?_call)) "
@@ -223,7 +258,18 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
-	"nco:nickname(?_contact) "					\
+"(SELECT "								\
+	"?nick "							\
+	"WHERE { "							\
+	"	{ "							\
+	"	?_contact nco:nickname ?nick "				\
+	"		} UNION { "					\
+	"			?_contact nco:hasAffiliation ?role . "	\
+	"			?role nco:hasIMAddress ?im . "		\
+	"			?im nco:imNickname ?nick "		\
+	"		} "						\
+	"	} "							\
+	") "								\
 "(SELECT GROUP_CONCAT(fn:concat(?url_value, \"\31\", "			\
 	"tracker:coalesce(rdfs:label(?c_role), \"\")), \"\30\") "	\
 	"WHERE {"							\
@@ -316,7 +362,19 @@ COMBINED_CONSTRAINT		\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
 "nco:birthDate(<%s>) "							\
-"nco:nickname(<%s>) "							\
+"(SELECT "								\
+"	?nick "								\
+"	WHERE { "							\
+"		{ "							\
+"			?_contact nco:nickname ?nick "			\
+"		} UNION { "						\
+"			?_contact nco:hasAffiliation ?role . "		\
+"			?role nco:hasIMAddress ?im . "			\
+"			?im nco:imNickname ?nick "			\
+"		} "							\
+"		FILTER (?_contact = <%s>)"				\
+"	} "								\
+") "									\
 "(SELECT GROUP_CONCAT(fn:concat( "					\
 	"?url_val, \"\31\", tracker:coalesce(rdfs:label(?_role), \"\") "\
 	"), \"\30\") "							\
@@ -972,12 +1030,23 @@ static void add_affiliation(char **field, const char *value)
 static void contact_init(struct phonebook_contact *contact,
 							const char **reply)
 {
+	if (reply[COL_FAMILY_NAME][0] == 0 &&
+			reply[COL_GIVEN_NAME][0] == 0 &&
+			reply[COL_ADDITIONAL_NAME][0] == 0 &&
+			reply[COL_NAME_PREFIX][0] == 0 &&
+			reply[COL_NAME_SUFFIX][0] == 0) {
+		if (reply[COL_FULL_NAME][0] != 0)
+			contact->family = g_strdup(reply[COL_FULL_NAME]);
+		else
+			contact->family = g_strdup(reply[COL_NICKNAME]);
+	} else {
+		contact->family = g_strdup(reply[COL_FAMILY_NAME]);
+		contact->given = g_strdup(reply[COL_GIVEN_NAME]);
+		contact->additional = g_strdup(reply[COL_ADDITIONAL_NAME]);
+		contact->prefix = g_strdup(reply[COL_NAME_PREFIX]);
+		contact->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
+	}
 	contact->fullname = g_strdup(reply[COL_FULL_NAME]);
-	contact->family = g_strdup(reply[COL_FAMILY_NAME]);
-	contact->given = g_strdup(reply[COL_GIVEN_NAME]);
-	contact->additional = g_strdup(reply[COL_ADDITIONAL_NAME]);
-	contact->prefix = g_strdup(reply[COL_NAME_PREFIX]);
-	contact->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
 	contact->birthday = g_strdup(reply[COL_BIRTH_DATE]);
 	contact->nickname = g_strdup(reply[COL_NICKNAME]);
 	contact->photo = g_strdup(reply[COL_PHOTO]);
@@ -1332,7 +1401,9 @@ static int add_to_cache(const char **reply, int num_fields, void *user_data)
 			!g_str_equal(reply[0], TRACKER_DEFAULT_CONTACT_ME))
 		return 0;
 
-	if (i == 6)
+	if (i == 7)
+		formatted = g_strdup(reply[7]);
+	else if (i == 6)
 		formatted = g_strdup(reply[6]);
 	else
 		formatted = g_strdup_printf("%s;%s;%s;%s;%s",
@@ -1640,7 +1711,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
 
-	ret = query_tracker(query, 7, add_to_cache, data);
+	ret = query_tracker(query, 8, add_to_cache, data);
 	if (err)
 		*err = ret;
 
-- 
1.7.4.1

