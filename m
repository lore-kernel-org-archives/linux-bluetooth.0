Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061206111617.d8f16a0c.ml133@netpole.com.br>
References: <20061206111617.d8f16a0c.ml133@netpole.com.br>
Date: Wed, 06 Dec 2006 14:39:45 +0100
Message-Id: <1165412385.2756.52.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] suggestion for device control
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

> I'm not a kernel developer, but have a suggestion, which could benefit
> a fair amount of the user comunity.
> 
> Unfortunately, BlueZ doesn't do always what a particular application
> needs, or it does it in a version of a kernel which is just not
> available to a particular device. Here is a suggestion which should be
> very simple to implement and could provide some relieve:
> 
> Would it be possible to have one more socket option, an exclusive
> flag, which would allow a programmer to tell the kernel, that this
> application will take care of everything itself for the device the
> socket is bound to, and that the kernel should just pass the HCI
> packets to and from the controller? If this flag was not set,
> everything would be as it is now, otherwise, an application could do
> any non-standard operation with this device, without having to worry
> about interferences. A user could have at the same time one device for
> really strange stuff, but another using say an rfcomm device file with
> full kernel support.

you can tell the kernel to switch a HCI device into raw mode and after
that point you have full control over that device. However this of
course also means that you have to implement L2CAP and RFCOMM by
yourself.

If you don't like our L2CAP or RFCOMM implementation, you can always
write and load your own one. The kernel API is simple and open for that
stuff.

However all this stuff only works to a certain degree, because the
specification doesn't allow that much crazy stuff and our current
implementation are giving away the most freedom to developers. You might
wanna ask around people that are using other stacks. Handling Bluetooth
within BlueZ is really simple.

> According to a message in bluez-user, recently a user was in trouble
> because he isn't able to update the kernel of his devices to the
> latest version. This flag wouldn't help him today, but once it was
> available to his kernels, he might get a choice to work around his
> problem. As soon as anything non-standard needs to be done, this could
> be the only possible solution. Anyway, I don't think, that I'm alone
> here. Also, this option would fit well to linux philosophy where there
> is not one single windows wishing to control everything
> inconditionally.

You don't work around problems. You fix them. This is open source and if
someone wants to stick to its ancient kernel, then it is their problem.
I am not supporting people that stick to a 2.4 kernel on an embedded
systems, because some companies aren't able to port their architecture
to the 2.6 kernel series. And nobody has to use the latest 2.6 kernel,
but a 2.4 one is way too old and a 2.6.9 kernel is too.

Companies like Red Hat and SuSE have realized that a long time ago, that
you can't drift away from upstream. And even embedded products like
Nokia 770 and the TomTom GO are following the upstream kernel. This is
the way to go. Everything else will come and haunt you at some point. I
tried this with my -mh patches for 2.4 and I am not going to this ever
again.

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
