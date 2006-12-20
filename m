Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45896C24.2070106@pracucci.com>
Date: Wed, 20 Dec 2006 17:00:20 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Development ML <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Inquiry cache management (clock offset)
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

Hi,

I have read a portion of bluez kernel sources and I have noticed, if I'm
not wrong, that bluez looks up the inquiry cache before establish an ACL
link, in order to get the clock offset of the remote device (returned
from a previuos inquiry). This is a great features to speed up the
paging process.

However, the scope of the inquiry cache is bounded to the interface that
do an inquiry. So, suppose that I have 2 interfaces: the "interface A"
does an inquiry and, after, the "interface B" creates a baseband
connection. This last interface (B) sends an HCI "create connection"
command with the default clock offset instead of the real clock offset,
as determined by interface A.

Now, If we suppose that I can't inquiry and create the connection with
the same interface, I think there are two solutions:
- Kernel side: patch the kernel and let hci_inquiry_cache_lookup() to
lookup the inquiry cache of each interface
- Application side: create a baseband connection with
hci_create_connection() before establish a L2CAP/RFCOMM communication

What are the main advantages/disadvantages of the above solutions?
Do you have any suggestion?

Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
