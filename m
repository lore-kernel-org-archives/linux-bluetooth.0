Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <001d01c324ae$8e0d6da0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] Qualification testing - rfcomm
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
Date: Tue, 27 May 2003 17:17:41 -0700

Marcel,

Looks like there were two problems related to xon/xoff (and maybe other
parameters) in the rfcomm_recv_rpn() function.

Here's what's happening: (Please excuse me if I'm slightly off on the
terminology)
 1.  The tester sends a parameter negotiation packet with valid settings an=
d
all bits in the mask set.
 2.  We send back a response with the XON bit in the mask still set
(indicating that we liked it), but the XON_CHAR field is set to 0. We're
supposed to reply with the valid XON character.

I just took a quick look at the code and it appears that if we like the
value then xon_char is left as the default value of 0, and then sent as suc=
h
at the bottom of the function.

And, yes, we have hcidump -w logs (just not yet at my fingertips to send
you). I'll forward them as soon as I get them.

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
