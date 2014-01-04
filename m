Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 09/12] android/client: Remove duplicate "const" specifier
Date: Fri,  3 Jan 2014 21:55:25 -0400
Message-Id: <1388800528-10699-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes clang errors like:

android/client/if-hh.c:181:39: error: duplicate 'const' declaration
specifier [-Werror,-Wduplicate-decl-specifier]
---
 android/client/if-hh.c  | 16 ++++++++--------
 android/client/if-pan.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index b8ebc8e..56eb698 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -178,7 +178,7 @@ static void init_p(int argc, const char **argv)
 
 /* connect */
 
-static void connect_c(int argc, const const char **argv, enum_func *enum_func,
+static void connect_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
 	if (argc == 3) {
@@ -243,8 +243,8 @@ static void set_info_p(int argc, const char **argv)
 
 /* get_protocol */
 
-static void get_protocol_c(int argc, const const char **argv,
-					enum_func *enum_func, void **user)
+static void get_protocol_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
 {
 	if (argc == 3) {
 		*user = connected_device_addr;
@@ -296,8 +296,8 @@ static void set_protocol_p(int argc, const char **argv)
 
 /* get_report */
 
-static void get_report_c(int argc, const const char **argv,
-					enum_func *enum_func, void **user)
+static void get_report_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
 {
 	if (argc == 3) {
 		*user = connected_device_addr;
@@ -341,8 +341,8 @@ static void get_report_p(int argc, const char **argv)
 
 /* set_report */
 
-static void set_report_c(int argc, const const char **argv,
-					enum_func *enum_func, void **user)
+static void set_report_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
 {
 	if (argc == 3) {
 		*user = connected_device_addr;
@@ -377,7 +377,7 @@ static void set_report_p(int argc, const char **argv)
 
 /* send_data */
 
-static void send_data_c(int argc, const const char **argv, enum_func *enum_func,
+static void send_data_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
 	if (argc == 3) {
diff --git a/android/client/if-pan.c b/android/client/if-pan.c
index a11f2a3..bdb36cc 100644
--- a/android/client/if-pan.c
+++ b/android/client/if-pan.c
@@ -80,7 +80,7 @@ static void init_p(int argc, const char **argv)
 
 /* enable */
 
-static void enable_c(int argc, const const char **argv, enum_func *enum_func,
+static void enable_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
 	if (argc == 3) {
@@ -121,7 +121,7 @@ static void get_local_role_p(int argc, const char **argv)
 
 /* connect */
 
-static void connect_c(int argc, const const char **argv, enum_func *enum_func,
+static void connect_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
 	if (argc == 3) {
@@ -165,8 +165,8 @@ static void connect_p(int argc, const char **argv)
 
 /* disconnect */
 
-static void disconnect_c(int argc, const const char **argv,
-					enum_func *enum_func, void **user)
+static void disconnect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
 {
 	if (argc == 3) {
 		*user = last_used_addr;
-- 
1.8.3.2

