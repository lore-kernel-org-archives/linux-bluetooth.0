Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix for handling addresses in pull call history queries
Date: Wed,  5 Jan 2011 11:48:15 +0200
Message-Id: <1294220895-2037-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously only addresses of one type (by example only
HOME addresses) were listed. Now every address will for
contact will be included in call history results.
---
 plugins/phonebook-tracker.c |   84 +++++++++++++++++++++++++++++-------------
 1 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index c052b43..3dcf818 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -109,7 +109,9 @@
 "tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
 "tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"		\
+"tracker:coalesce(nco:country(?aff_addr), \"\"), "			\
+"\"\31\", rdfs:label(?_role) ), "					\
+"\"\30\") "								\
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
@@ -192,9 +194,12 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
+	"\"\31\", rdfs:label(?c_role) ), "				\
+	"\"\30\") "							\
 	"WHERE {"							\
-	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
@@ -337,9 +342,12 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
+	"\"\31\", rdfs:label(?c_role) ), "				\
+	"\"\30\") "							\
 	"WHERE {"							\
-	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
@@ -481,9 +489,12 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
+	"\"\31\", rdfs:label(?c_role) ), "				\
+	"\"\30\") "							\
 	"WHERE {"							\
-	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
@@ -619,9 +630,12 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
+	"\"\31\", rdfs:label(?c_role) ), "				\
+	"\"\30\") "							\
 	"WHERE {"							\
-	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
@@ -807,7 +821,9 @@
 "tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
 "tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"		\
+"tracker:coalesce(nco:country(?aff_addr), \"\"), "			\
+"\"\31\", rdfs:label(?_role) ), "					\
+"\"\30\") "								\
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
@@ -1562,14 +1578,42 @@ static enum phonebook_address_type get_addr_type(const char *affilation)
 	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
 		return ADDR_TYPE_WORK;
 
-	return ADDR_TYPE_HOME;
+	return ADDR_TYPE_OTHER;
+}
+
+static void add_aff_address(struct phonebook_contact *contact, char *aff_addr)
+{
+	char **addr_parts;
+	char *type, *address;
+
+	/* Addresses from affilation data, are represented as real address
+	 * string and affilation type - those strings are separated by
+	 * SUB_DELIM string */
+	addr_parts = g_strsplit(aff_addr, SUB_DELIM, 2);
+
+	if (!addr_parts)
+		return;
+
+	if (addr_parts[0])
+		address = addr_parts[0];
+	else
+		goto failed;
+
+	if (addr_parts[1])
+		type = addr_parts[1];
+	else
+		goto failed;
+
+	add_address(contact, address, get_addr_type(type));
+
+failed:
+	g_strfreev(addr_parts);
 }
 
 static void contact_add_addresses(struct phonebook_contact *contact,
 								char **reply)
 {
-
-	char **aff_addr, **con_addr;
+	char **aff_addr;
 	int i;
 
 	/* Addresses from affilation */
@@ -1578,21 +1622,9 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 
 	if (aff_addr)
 		for(i = 0; aff_addr[i] != NULL; ++i)
-			add_address(contact, aff_addr[i],
-					get_addr_type(reply[COL_AFF_TYPE]));
+			add_aff_address(contact, aff_addr[i]);
 
 	g_strfreev(aff_addr);
-
-	/* Addresses from contact struct */
-	con_addr = g_strsplit(reply[COL_ADDR_CONTACT], MAIN_DELIM,
-								MAX_FIELDS);
-
-	if (con_addr)
-		for(i = 0; con_addr[i] != NULL; ++i)
-			add_address(contact, con_addr[i], ADDR_TYPE_OTHER);
-
-	g_strfreev(con_addr);
-
 }
 
 static void contact_add_organization(struct phonebook_contact *contact,
-- 
1.7.0.4

