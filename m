Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jun 2015 20:28:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: stop sabotaging list poisoning
Message-ID: <20150610172832.GA8898@p183.telecom.by>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

list_del() poisons pointers with special values, no need to overwrite them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 net/bluetooth/l2cap_core.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1601,7 +1601,7 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 
 	hci_dev_lock(hdev);
 
-	if (user->list.next || user->list.prev) {
+	if (!list_empty(&user->list)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1631,12 +1631,10 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 
 	hci_dev_lock(hdev);
 
-	if (!user->list.next || !user->list.prev)
+	if (list_empty(&user->list))
 		goto out_unlock;
 
 	list_del(&user->list);
-	user->list.next = NULL;
-	user->list.prev = NULL;
 	user->remove(conn, user);
 
 out_unlock:
@@ -1651,8 +1649,6 @@ static void l2cap_unregister_all_users(struct l2cap_conn *conn)
 	while (!list_empty(&conn->users)) {
 		user = list_first_entry(&conn->users, struct l2cap_user, list);
 		list_del(&user->list);
-		user->list.next = NULL;
-		user->list.prev = NULL;
 		user->remove(conn, user);
 	}
 }
