Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1d49725d0704121242j7a278668gbea98b7bbc145b0b@mail.gmail.com>
References: <1d49725d0704121242j7a278668gbea98b7bbc145b0b@mail.gmail.com>
Date: Thu, 12 Apr 2007 22:13:59 +0200
Message-Id: <1176408839.7049.35.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error connecting after inquiry
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

Hi Donnie,

> We've narrowed the problem down to the hci_remote_name call - if we
> filter on device class alone, and never request the name, the
> connection works.  Are there any connections opened by hci_remote_name
> that need to be explicitly closed?  Would checking device class alone
> be sufficient?  From what I've read, device class is determined by
> capabilities, and isn't guaranteed to be unique to the Wiimote. 

the remote name request creates a temporary baseband connection and in
that case no other connection request will succeed. Reducing the timeout
for the remote name function is not helping here since it won't send the
remote name cancel in case of a timeout. This is probably a bug in the
library, but also not easy to handle since that command is not always
available.

So first of all you should only request the name for devices with the
correct class (since the others don't matter at all). Then you need to
use a bigger timeout. The name request can take some time. The baseband
needs to page the other side.

Other than that you can add a sleep(1) re-try the connect if it failed.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
