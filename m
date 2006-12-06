Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 6 Dec 2006 11:16:17 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20061206111617.d8f16a0c.ml133@netpole.com.br>
Mime-Version: 1.0
Subject: [Bluez-devel] suggestion for device control
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

Hi developers,

I'm not a kernel developer, but have a suggestion, which could benefit
a fair amount of the user comunity.

Unfortunately, BlueZ doesn't do always what a particular application
needs, or it does it in a version of a kernel which is just not
available to a particular device. Here is a suggestion which should be
very simple to implement and could provide some relieve:

Would it be possible to have one more socket option, an exclusive
flag, which would allow a programmer to tell the kernel, that this
application will take care of everything itself for the device the
socket is bound to, and that the kernel should just pass the HCI
packets to and from the controller? If this flag was not set,
everything would be as it is now, otherwise, an application could do
any non-standard operation with this device, without having to worry
about interferences. A user could have at the same time one device for
really strange stuff, but another using say an rfcomm device file with
full kernel support.

According to a message in bluez-user, recently a user was in trouble
because he isn't able to update the kernel of his devices to the
latest version. This flag wouldn't help him today, but once it was
available to his kernels, he might get a choice to work around his
problem. As soon as anything non-standard needs to be done, this could
be the only possible solution. Anyway, I don't think, that I'm alone
here. Also, this option would fit well to linux philosophy where there
is not one single windows wishing to control everything
inconditionally.

Thanks,

-- 
Cris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
