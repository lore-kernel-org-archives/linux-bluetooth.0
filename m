Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/13] doc/coding-style: Update 'enum as switch variable' section
Date: Tue,  2 Dec 2014 18:28:26 +0100
Message-Id: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since GCC has option (-Wswitch-enum) that ensure all enum values are
handled inside switch it is no longer necessary to forbit default in
such case.
---
 doc/coding-style.txt | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 59df64a..b3fbd2e 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -175,10 +175,11 @@ enum animal_type {
 M10: Enum as switch variable
 ============================
 
-If the variable of a switch is an enum, you must not include a default in
-switch body. The reason for this is: If later on you modify the enum by adding
-a new type, and forget to change the switch accordingly, the compiler will
-complain the new added type hasn't been handled.
+If the variable of a switch is an enum, you must include all values in
+switch body even if providing default. This is enforced by compiler option
+enabling extra warning in such case. The reason for this is to ensure that if
+later on enum is modified and one forget to change the switch accordingly, the
+compiler will complain the new added type hasn't been handled.
 
 Example:
 
@@ -190,7 +191,7 @@ enum animal_type {
 
 enum animal_type t;
 
-switch (t) {
+switch (t) { // OK
 case ANIMAL_TYPE_FOUR_LEGS:
 	...
 	break;
@@ -200,7 +201,18 @@ case ANIMAL_TYPE_EIGHT_LEGS:
 case ANIMAL_TYPE_TWO_LEGS:
 	...
 	break;
-default:  // wrong
+default:
+	break;
+}
+
+switch (t) { // Wrong
+case ANIMAL_TYPE_FOUR_LEGS:
+	...
+	break;
+case ANIMAL_TYPE_TWO_LEGS:
+	...
+	break;
+default:
 	break;
 }
 
-- 
1.9.1

