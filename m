Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1208950651.6611.167.camel@pancake>
References: <1208950651.6611.167.camel@pancake>
Date: Wed, 23 Apr 2008 15:07:50 +0200
Message-Id: <1208956070.6611.173.camel@pancake>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Question about hci_create_connection and
	clock	offset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

A short followup to my own post: In the list archives, I've read
multiple times that the hci_* API is more or less deprecated and D-Bus
is the future. 

However, what I'm trying to do - repeating inquiries in one thread,
checking RSSI in another one (even for devices that haven't been seen by
the last inquiries) - doesn't seem possible in the D-Bus API, as there
is no function to create a low-level ACL connection to a device
address..?

Yours, Florian
-- 
0666 - Filemode of the Beast


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
