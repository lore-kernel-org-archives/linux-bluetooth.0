Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Change "websiteUrl" query field to more general
Date: Thu, 30 Sep 2010 15:41:53 +0200
Message-Id: <1285854113-13649-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"websiteUrl" query field is replaced by more general "url" because
previously web address wasn't downloaded in each case.
---
 plugins/phonebook-tracker.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 2d94bc6..c10491d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -64,7 +64,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
-	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
@@ -116,7 +116,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
-	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
@@ -188,7 +188,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
-	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
@@ -260,7 +260,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew)"	\
-	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
@@ -328,7 +328,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
-	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
+	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
@@ -443,7 +443,7 @@
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f  nco:emailAddress(?ew)"	\
-	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:websiteUrl(<%s>) "	\
+	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:url(<%s>) "		\
 	"nco:photo(<%s>) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-- 
1.6.3.3

