Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <451D5EDB.2010303@brainhub.org>
Date: Fri, 29 Sep 2006 10:58:51 -0700
From: Andrey Jivsov <bluetooth@brainhub.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <451A1A54.3020903@brainhub.org>	<1159343538.22162.11.camel@localhost>
	<451A35A1.6020309@brainhub.org>
	<1159530755.6131.34.camel@localhost>
In-Reply-To: <1159530755.6131.34.camel@localhost>
Content-Type: multipart/mixed; boundary="------------090508010508050803050608"
Subject: Re: [Bluez-users] Microsoft IntelliMouse with kernel 2.6.1 and
 patch-2.6.18-mh1 is broken (fix provided)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090508010508050803050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Andrey,
> 
>> here is the patch against linux-2.6.18-mh1 to fix 
>> IntelliMouse. That's the best range of changes I have time to provide: 
>> somewhere in these changes IntelliMouse was broken. I believe this 
>> happened between patch-2.6.15-mh2 and linux-2.6.18-mh1. While there are 
>> a lot of changes in these 17 files, but most of them are variable 
>> renames. I hope this helps you to narrow down the issue.
> 
> I only care about changes in net/bluetooth/hidp/. All others are not
> relevant. Can't you show me your changes from that directory.
> 

Marcel, there is only one file changed in this directory: 
net/bluetooth/hidp/core.c. The changes are rollback of hidp_get_device call.

Thank you.




--------------090508010508050803050608
Content-Type: text/plain;
 name="patch-2.6.18-hidp-only-mh1aj"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.18-hidp-only-mh1aj"

diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hidp/core.c linux-2.6.18-my-bt/net/bluetooth/hidp/core.c
--- linux-2.6.18-mh1/net/bluetooth/hidp/core.c	2006-09-23 19:56:07.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hidp/core.c	2006-09-23 23:00:22.000000000 -0700
@@ -41,7 +41,6 @@
 #include "hid.h"
 
 #include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
 #include "hidp.h"
@@ -573,26 +572,6 @@
 	return 0;
 }
 
-static struct device *hidp_get_device(struct hidp_session *session)
-{
-	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
-	bdaddr_t *dst = &bt_sk(session->ctrl_sock->sk)->dst;
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(dst, src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (!conn)
-		return NULL;
-
-	hci_dev_put(hdev);
-
-	return &conn->dev;
-}
-
 static inline void hidp_setup_input(struct hidp_session *session, struct hidp_connadd_req *req)
 {
 	struct input_dev *input = session->input;
@@ -631,8 +610,6 @@
 		input->relbit[0] |= BIT(REL_WHEEL);
 	}
 
-	input->cdev.dev = hidp_get_device(session);
-
 	input->event = hidp_input_event;
 
 	input_register_device(input);
@@ -660,8 +637,6 @@
 	strncpy(hid->phys, batostr(&src), 64);
 	strncpy(hid->uniq, batostr(&dst), 64);
 
-	hid->dev = hidp_get_device(session);
-
 	hid->send = hid_send_report;
 
 	hid_register_device(hid);


--------------090508010508050803050608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090508010508050803050608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------090508010508050803050608--
