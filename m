Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix incorrect uninitialized assignment
Date: Wed,  7 Mar 2012 14:51:45 +0200
Message-Id: <1331124705-11023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Revert part of commit 8035ded4 which has introduced bug by
assigning uninitialized value.

...
+ src/net/bluetooth/rfcomm/tty.c: warning: 'p' is used uninitialized in this
	function:  => 218
+ src/net/bluetooth/rfcomm/tty.c: warning: 'p' may be used uninitialized in
	this function:  => 218
...

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/rfcomm/tty.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a2d4f51..ca6c8a6 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -210,8 +210,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (req->dev_id < 0) {
 		dev->id = 0;
 
-		list_for_each_entry(entry, &rfcomm_dev_list, list) {
-			if (entry->id != dev->id)
+		list_for_each(p, &rfcomm_dev_list) {
+			if (list_entry(p, struct rfcomm_dev, list)->id != dev->id)
 				break;
 
 			dev->id++;
@@ -220,7 +220,9 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	} else {
 		dev->id = req->dev_id;
 
-		list_for_each_entry(entry, &rfcomm_dev_list, list) {
+		list_for_each(p, &rfcomm_dev_list) {
+			struct rfcomm_dev *entry = list_entry(p, struct rfcomm_dev, list);
+
 			if (entry->id == dev->id) {
 				err = -EADDRINUSE;
 				goto out;
-- 
1.7.9

