Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Choi Sonim <choisonim@gmail.com>
In-Reply-To: <4f436aae0701290157h3ac80220t801fffccdc2b8a8c@mail.gmail.com>
References: <4f436aae0701191104h376e9e89mca6769544b257e29@mail.gmail.com>
	<1169235297.29458.19.camel@violet>
	<4f436aae0701290157h3ac80220t801fffccdc2b8a8c@mail.gmail.com>
Date: Mon, 29 Jan 2007 11:05:45 +0100
Message-Id: <1170065145.15389.117.camel@violet>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
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

Hi Choi,

> > > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > > hci_uart.ko is loaded.
> > > I looked in hciattach.c but I do not see how is it done ?
> >
> > # modinfo hci_uart
> > alias:          tty-ldisc-15
> >
> > It tells the kernel to load this module if any application request the
> > line discipline 15.
> 
> can you please elaborate on this ? when the app request the HCI line
> discipline, how does the kernel knows it need to look for alias tty-ldisc-15 ?
> does it then run modprobe ?
> what code is responsible for that ?

the kernel actually doesn't care what's the module name of module
providing the line discipline 15. It simply requests the loading of the
module and the userspace (insmod/modprobe) has to resolve this.

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
