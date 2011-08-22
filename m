Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 2/2] Fix semicolon delimiter issue in address fields
Date: Mon, 22 Aug 2011 12:32:57 +0200
Message-Id: <1314009177-19178-2-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
References: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously semicolon was used as delimiter when address vCard fields
are concatenated (at the moment of fetching from database via query).
It was introducing confusion at the moment of splitting address string
into seperate fields, since these fields may contain semicolons as well.
In this case it leads to treating some semicolons - characters in address
fields - as real delimiters (no escaped but it should) and other
semicolons - real delimiters - as characters in address field
(escaped but it shouldn't).
This patch fixes problem described above, since semicolon delimiter
is replaced by character called Unit Separator (equal to '\37') which
shouldn't be present in address fields.
---
 plugins/phonebook-tracker.c |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 56291d0..cecaf2d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -83,6 +83,7 @@
 
 #define MAIN_DELIM "\30" /* Main delimiter between phones, addresses, emails*/
 #define SUB_DELIM "\31" /* Delimiter used in telephone number strings*/
+#define ADDR_DELIM "\37" /* Delimiter used for address data fields */
 #define MAX_FIELDS 100 /* Max amount of fields to be concatenated at once*/
 #define VCARDS_PART_COUNT 50 /* amount of vcards sent at once to PBAP core */
 #define QUERY_OFFSET_FORMAT "%s OFFSET %d"
@@ -101,12 +102,12 @@
 "nco:nameHonorificPrefix(?_contact) "					\
 "nco:nameHonorificSuffix(?_contact) "					\
 "(SELECT GROUP_CONCAT(fn:concat("					\
-"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
-"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \"\37\","	\
+"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \"\37\","	\
+"tracker:coalesce(nco:locality(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:region(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \"\37\","		\
 "tracker:coalesce(nco:country(?aff_addr), \"\"), "			\
 "\"\31\", rdfs:label(?_role) ), "					\
 "\"\30\") "								\
@@ -210,12 +211,12 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
 "(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \"\37\","	\
+	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \"\37\","\
+	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \"\37\","\
+	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \"\37\","	\
+	"tracker:coalesce(nco:region(?aff_addr), \"\"), \"\37\","	\
+	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \"\37\","	\
 	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
 	"\"\31\", rdfs:label(?c_role) ), "				\
 	"\"\30\") "							\
@@ -306,12 +307,12 @@ COMBINED_CONSTRAINT		\
 "nco:nameHonorificPrefix(<%s>) "					\
 "nco:nameHonorificSuffix(<%s>) "					\
 "(SELECT GROUP_CONCAT(fn:concat("					\
-"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
-"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \"\37\","	\
+"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \"\37\","	\
+"tracker:coalesce(nco:locality(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:region(?aff_addr), \"\"), \"\37\","		\
+"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \"\37\","		\
 "tracker:coalesce(nco:country(?aff_addr), \"\"), "			\
 "\"\31\", rdfs:label(?_role) ), "					\
 "\"\30\") "								\
@@ -886,7 +887,7 @@ static struct phonebook_addr *gen_addr(const char *address, int type)
 	if (address == NULL || strlen(address) < ADDR_FIELD_AMOUNT)
 		return NULL;
 
-	addr_parts = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
+	addr_parts = g_strsplit(address, ADDR_DELIM, ADDR_FIELD_AMOUNT);
 
 	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i)
 		fields = g_slist_append(fields, g_strdup(addr_parts[i]));
-- 
1.6.3.3

