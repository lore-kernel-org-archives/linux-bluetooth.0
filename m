Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] Fix fetching contact photo file name
Date: Mon, 15 Nov 2010 14:33:37 +0100
Message-Id: <1289828017-13412-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously photo id was fetched. File name may be further converted to
binary data (actual image) if such behavior would be desired in the future.
---
 plugins/phonebook-tracker.c |   60 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 672d59f..962cc4d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -69,7 +69,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
@@ -80,6 +80,10 @@
 	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
+		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
 		"OPTIONAL {"						\
 		"?h a nco:FaxNumber ; "					\
@@ -135,7 +139,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
@@ -156,6 +160,10 @@
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasPhoneNumber ?t . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?t a nco:CellPhoneNumber ; "			\
 				"nco:phoneNumber ?vc . "		\
 		"} "							\
@@ -186,6 +194,10 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?a rdfs:label \"Work\" . "			\
 			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
@@ -274,7 +286,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
@@ -295,6 +307,10 @@
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasPhoneNumber ?t . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?t a nco:CellPhoneNumber ; "			\
 				"nco:phoneNumber ?vc . "		\
 		"} "							\
@@ -325,6 +341,10 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?a rdfs:label \"Work\" . "			\
 			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
@@ -412,7 +432,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
@@ -432,6 +452,10 @@
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasPhoneNumber ?t . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?t a nco:CellPhoneNumber ; "			\
 				"nco:phoneNumber ?vc . "		\
 		"} "							\
@@ -461,6 +485,10 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?a rdfs:label \"Work\" . "			\
 			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
@@ -544,7 +572,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
@@ -564,6 +592,10 @@
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasPhoneNumber ?t . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?t a nco:CellPhoneNumber ; "			\
 				"nco:phoneNumber ?vc . "		\
 		"} "							\
@@ -593,6 +625,10 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?a rdfs:label \"Work\" . "			\
 			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
@@ -641,6 +677,10 @@
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasPhoneNumber ?t . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?t a nco:CellPhoneNumber ; "			\
 				"nco:phoneNumber ?vc . "		\
 		"} "							\
@@ -670,6 +710,10 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
+			"?c a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
+		"OPTIONAL { "						\
 			"?a rdfs:label \"Work\" . "			\
 			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
@@ -775,7 +819,7 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:url(<%s>) "		\
-	"nco:photo(<%s>) nco:fullname(?o) nco:department(?a) "		\
+	"?file nco:fullname(?o) nco:department(?a) "			\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(<%s>) "	\
@@ -786,6 +830,10 @@
 	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:PersonContact . "				\
+		"OPTIONAL { "						\
+			"<%s> a nco:PersonContact ; nco:photo ?pht . "	\
+			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
+		"} "							\
 	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . "			\
 		"OPTIONAL {"						\
 		"?h a nco:FaxNumber ; "					\
-- 
1.7.0.4

