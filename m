Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040826141810.46943.qmail@web52608.mail.yahoo.com>
From: gonzalo briceno <gonzaloother@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Bluez setup and Bluetooth stack and 2.6 kernel
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 26 Aug 2004 07:18:10 -0700 (PDT)

Marcel responded to my posting by saying:
"the Bluetooth core layer for 2.6 is in the
bluetooth.ko kernel module and the config options
start with CONFIG_BT_*."

So what I gather is that the bluez.o module
functionality is already part of the bluetooth.ko
module.  Is there anything else I need to know in
terms of what modules need to be loaded for things to
work?  The reason for asking is that most
documentation I have read so far is most likely old
and refers to bluez.o.  To make a long story short
does the following seem correct to get USB and
Bluetooth to work (using kernel 2.6) barring any other
problems: 

1. load usbcore
2. load proper USB host driver (OHCI, UHCI, EHCI)
3. load bluetooth.ko
4. load (RFCOMM, L2CAP, BNEP, etc)


p.s. I apologize for the new post relating to an
existing post.  For the life of me I could not find
how to reply to my previous thread.  I have done this
before on other sourceforge lists but I cannot find it
here.  Once again, my apologies.


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
