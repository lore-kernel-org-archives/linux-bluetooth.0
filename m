Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45896C24.2070106@pracucci.com>
References: <45896C24.2070106@pracucci.com>
Date: Wed, 20 Dec 2006 17:23:26 +0100
Message-Id: <1166631806.17802.10.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Inquiry cache management (clock offset)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marco,

> I have read a portion of bluez kernel sources and I have noticed, if I'm
> not wrong, that bluez looks up the inquiry cache before establish an ACL
> link, in order to get the clock offset of the remote device (returned
> from a previuos inquiry). This is a great features to speed up the
> paging process.
> 
> However, the scope of the inquiry cache is bounded to the interface that
> do an inquiry. So, suppose that I have 2 interfaces: the "interface A"
> does an inquiry and, after, the "interface B" creates a baseband
> connection. This last interface (B) sends an HCI "create connection"
> command with the default clock offset instead of the real clock offset,
> as determined by interface A.
> 
> Now, If we suppose that I can't inquiry and create the connection with
> the same interface, I think there are two solutions:
> - Kernel side: patch the kernel and let hci_inquiry_cache_lookup() to
> lookup the inquiry cache of each interface
> - Application side: create a baseband connection with
> hci_create_connection() before establish a L2CAP/RFCOMM communication
> 
> What are the main advantages/disadvantages of the above solutions?
> Do you have any suggestion?

the main disadvantage is that it gives you nothing. You can't move the
clock offset around from adapter A to adapter B. As the word says, it is
a clock _offset_ and this means it depends on the local clock on the
chip. So a received clock offset on adapter A is invalid on adapter B
and it might happen that the connection establishment takes longer than
if you would have used no clock offset at all.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
