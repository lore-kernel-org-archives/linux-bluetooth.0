Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dick <dm@chello.nl>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411061328.04823.dm@chello.nl>
Subject: [Bluez-devel] inline problem gcc 3.4.2 and 2.6.9-mh3
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 6 Nov 2004 13:28:04 +0100

Hi,

GCC 3.4.2 doesn't seem like the prototypes:

static inline u8 l2cap_get_ident(struct l2cap_conn *conn);
static inline int l2cap_send_req(struct l2cap_conn *conn, u8 ident, u8 code, 
u16 len, void *data);

output:
# make
<snip>
net/bluetooth/l2cap.c: In function `__l2cap_sock_close':
net/bluetooth/l2cap.c:77: sorry, unimplemented: inlining failed in call to 
'l2cap_get_ident': function body not available
net/bluetooth/l2cap.c:284: sorry, unimplemented: called from here
net/bluetooth/l2cap.c:78: sorry, unimplemented: inlining failed in call to 
'l2cap_send_req': function body not available
net/bluetooth/l2cap.c:291: sorry, unimplemented: called from here

When I remove inline it seems to compile:
net/bluetooth/l2cap.c:77: warning: 'l2cap_get_ident' declared inline after 
being called
net/bluetooth/l2cap.c:77: warning: previous declaration of 'l2cap_get_ident' 
was here
net/bluetooth/l2cap.c:78: warning: 'l2cap_send_req' declared inline after 
beingcalled
net/bluetooth/l2cap.c:78: warning: previous declaration of 'l2cap_send_req' 
washere

Could someone please take a look at this?
Thanks in advance,
Dick


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
