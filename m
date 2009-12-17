Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 17 Dec 2009 12:21:19 -0500
Message-ID: <cf4ddc810912170921g7b774371u4843dac6f1725ec8@mail.gmail.com>
Subject: sixpair.c compile comments patch
From: Nathan Fearnley <nfearnley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here's a small patch that updates the instructions on how to compile
the sixpair.c program. They were out of date since the common folder
was merged with src.
--Nathan Fearnley


--- sixpair.c   2009-12-17 12:01:59.202237665 -0500
+++ sixpair.new.c       2009-12-17 12:03:37.130237071 -0500
@@ -1,5 +1,5 @@
 /* To compile
- * gcc -g -Wall -I../src -I../lib/ -I../include
-DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c
../src/storage.c ../common/libhelper.a -I../common `pkg-config --libs
--cflags glib-2.0 libusb-1.0` -lbluetooth
+ * gcc -g -Wall -I../src -I../lib/ -I../include
-DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c
../src/storage.c ../src/textfile.c ../src/glib-helper.c -I../common
`pkg-config --libs --cflags glib-2.0 libusb-1.0` -lbluetooth
  */

 #include <unistd.h>
