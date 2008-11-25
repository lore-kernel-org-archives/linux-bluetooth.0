Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Nov 2008 14:14:54 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/5] drivers/bluetooth: change simple_strtol to simple_strtoul
Message-ID: <Pine.LNX.4.64.0811251414330.11897@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

Since size, addr, fcs, and tmp are unsigned, it would seem better to use
simple_strtoul that simple_strtol.

A simplified version of the semantic patch that makes this change is as
follows: (http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r2@
long e;
position p;
@@

e = simple_strtol@p(...)

@@
position p != r2.p;
type T;
T e;
@@

e = 
- simple_strtol@p
+ simple_strtoul
  (...)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

 drivers/bluetooth/bt3c_cs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -u -p a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -502,15 +502,15 @@ static int bt3c_load_firmware(bt3c_info_
 
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + 2, 2);
-		size = simple_strtol(b, NULL, 16);
+		size = simple_strtoul(b, NULL, 16);
 
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + 4, 8);
-		addr = simple_strtol(b, NULL, 16);
+		addr = simple_strtoul(b, NULL, 16);
 
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + (size * 2) + 2, 2);
-		fcs = simple_strtol(b, NULL, 16);
+		fcs = simple_strtoul(b, NULL, 16);
 
 		memset(b, 0, sizeof(b));
 		for (tmp = 0, i = 0; i < size; i++) {
@@ -530,7 +530,7 @@ static int bt3c_load_firmware(bt3c_info_
 			memset(b, 0, sizeof(b));
 			for (i = 0; i < (size - 4) / 2; i++) {
 				memcpy(b, ptr + (i * 4) + 12, 4);
-				tmp = simple_strtol(b, NULL, 16);
+				tmp = simple_strtoul(b, NULL, 16);
 				bt3c_put(iobase, tmp);
 			}
 		}
