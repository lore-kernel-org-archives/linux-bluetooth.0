Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH 6/7] Fix proper type handling in contact_query_from_uri
Date: Wed, 10 Nov 2010 14:15:29 +0100
Message-Id: <1289394930-6694-6-git-send-email-bulislaw@linux.com>
In-Reply-To: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
References: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously all phone numbers, addresses and emails was considered to be "work".
Now there are three working types for emails and addresses: "work", "home",
"other" and four for phone numbers - these three as well as "cell".
---
 plugins/phonebook-tracker.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 616cc96..f195f3f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -767,41 +767,55 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define CONTACTS_QUERY_FROM_URI						\
-	"SELECT ?v nco:fullname(<%s>) "					\
+	"SELECT nco:phoneNumber(?v) nco:fullname(<%s>) "		\
 	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "			\
 	"nco:nameAdditional(<%s>) nco:nameHonorificPrefix(<%s>) "	\
 	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f  nco:emailAddress(?ew)"	\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:url(<%s>) "		\
 	"nco:photo(<%s>) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(<%s>) "	\
-	"nco:title(?a) nco:phoneNumber(?t) "				\
+	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+        "nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
+	"?vc "								\
 	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
-		"<%s> a nco:Contact . "					\
-	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . 			\
-		OPTIONAL {"						\
+		"<%s> a nco:PersonContact . "				\
+	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
 		"OPTIONAL {"						\
+		"?h a nco:CellPhoneNumber ; "				\
+		"nco:phoneNumber ?vc"					\
+		"}"							\
+		"OPTIONAL {"						\
 		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
+		"nco:phoneNumber ?t"					\
 		"}"							\
 	"}"								\
-	"OPTIONAL { <%s> nco:hasEmailAddress ?e . } "			\
-	"OPTIONAL { <%s> nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"<%s> nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a nco:hasPhoneNumber ?w . }" 		\
-		"OPTIONAL { ?a nco:hasEmailAddress ?ew . }"		\
-		"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "		\
+		"OPTIONAL { ?a rdfs:label \"Work\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
+		"}"							\
+		"OPTIONAL { ?a rdfs:label \"Home\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
+		"}"							\
 		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
+	"OPTIONAL { <%s> nco:hasPostalAddress ?po . } "			\
+	"OPTIONAL { <%s> nco:hasEmailAddress ?eo . } "			\
 	"}"
 
 #define CONTACTS_OTHER_QUERY_FROM_URI					\
-- 
1.7.0.4

