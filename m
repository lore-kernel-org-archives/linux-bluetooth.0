Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2015 11:43:40 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Johan Hedberg
 <johan.hedberg@gmail.com>, =?UTF-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>,
 tedd.an@intel.com
Subject: [PATCH] Bluetooth: Reinitialize the list after deletion for session
 user list
Message-ID: <20150630114340.260dca22@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

If the user->list is deleted with list_del(), it doesn't initialize the
entry which can cause the issue with list_empty(). According to the
comment from the list.h, list_empty() returns false even if the list is
empty and put the entry in an undefined state.

/**
 * list_del - deletes entry from list.
 * @entry: the element to delete from the list.
 * Note: list_empty() on entry does not return true after this, the entry is
 * in an undefined state.
 */

Because of this behavior, list_empty() returns false even if list is empty
when the device is reconnected.

So, user->list needs to be re-initialized after list_del(). list.h already
have a macro list_del_init() which deletes the entry and initailze it again.

Tested-by: J=C3=B6rg Otte <jrg.otte@gmail.com>
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 51594fb..45fffa4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1634,7 +1634,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, s=
truct l2cap_user *user)
 	if (list_empty(&user->list))
 		goto out_unlock;
=20
-	list_del(&user->list);
+	list_del_init(&user->list);
 	user->remove(conn, user);
=20
 out_unlock:
@@ -1648,7 +1648,7 @@ static void l2cap_unregister_all_users(struct l2cap_c=
onn *conn)
=20
 	while (!list_empty(&conn->users)) {
 		user =3D list_first_entry(&conn->users, struct l2cap_user, list);
-		list_del(&user->list);
+		list_del_init(&user->list);
 		user->remove(conn, user);
 	}
 }
--=20
2.1.0
