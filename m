Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <001001c3248f$838dfdf0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] SO_ERROR, LM_RELIABLE
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 27 May 2003 13:35:29 -0700

Max,

I'm working on LM_RELIABLE support in l2test. I'm using aclsession to send
both valid and invalid l2cap packets.

I'm sending an invalid (wrong length) packet followed by a valid packet. I
get the ECOMM error and clear it with getsockopt(SO_ERROR), and then I can
receive the next packet. That works fine for both long and short packets.
But when I disconnect, I get the following in syslog (for either the too
long or the too short case):

l2test[583]: Disconnect. Communication error on send

Normally that would say "Disconnect. Success".

But I'm not sending. (At least not that I know of) Any ideas about what
would cause that?

The same code will print "Disconnect. Success" if aclsession is used to sen=
d
two valid packets.

-Daryl.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
