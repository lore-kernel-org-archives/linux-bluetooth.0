Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Choi Sonim <choisonim@gmail.com>
In-Reply-To: <4f436aae0701281359m320d7914hdcbb1e66fc68dfe8@mail.gmail.com>
References: <4f436aae0701280715x72e4430n5c072dc0067555b8@mail.gmail.com>
	<1170020887.4630.20.camel@violet>
	<4f436aae0701281359m320d7914hdcbb1e66fc68dfe8@mail.gmail.com>
Date: Sun, 28 Jan 2007 23:03:42 +0100
Message-Id: <1170021822.4630.22.camel@violet>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach <--> hcid
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

> > > when I do hciattach, i see that hcid automatically add the new device,
> > > and when i send -SIGTERM to hciattach, i see that hcid removed the device.
> > > how does hcid knows about all these changes ?
> > > where is the communication ?
> >
> > the kernel will tell hcid when a new host adapter has been attached or
> > removed from the system.
> 
> can you please point me to the code which takes care of that ?

it is in hcid/main.c:device_event().

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
