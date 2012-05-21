Return-Path: <cyrus@holtmann.org>
Message-ID: <1337612367.3349.2.camel@ufo>
Subject: [PATCH obexd] build: Remove left over glib-helper.h support
From: Paul Seidler <pl.seidler@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 21 May 2012 16:59:27 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 700e24a8fecf3c1376bde878470011e961a29da6 Mon Sep 17 00:00:00 2001
From: Paul Seidler <pl.seidler@googlemail.com>
Date: Mon, 21 May 2012 16:31:13 +0200
Subject: [PATCH] build: Remove left over glib-helper.h support

---
 plugins/phonebook-ebook.c   |    1 -
 plugins/phonebook-tracker.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index c2e8649..a1f06b5 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -37,7 +37,6 @@
 #include "obex.h"
 #include "service.h"
 #include "phonebook.h"
-#include "glib-helper.h"
 
 #define QUERY_FN "(contains \"family_name\" \"%s\")"
 #define QUERY_NAME "(contains \"given_name\" \"%s\")"
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index da82ff5..96635c4 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -35,7 +35,6 @@
 #include "mimetype.h"
 #include "phonebook.h"
 #include "vcard.h"
-#include "glib-helper.h"
 
 #define TRACKER_SERVICE "org.freedesktop.Tracker1"
 #define TRACKER_RESOURCES_PATH "/org/freedesktop/Tracker1/Resources"
-- 
1.7.10.2



