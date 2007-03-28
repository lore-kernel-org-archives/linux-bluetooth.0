Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <007901c77124$06df3040$9d0cc70a@dlh.st.com>
References: <007901c77124$06df3040$9d0cc70a@dlh.st.com>
Date: Wed, 28 Mar 2007 12:42:13 +0200
Message-Id: <1175078533.5815.127.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
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

Hi Mayank,

> > > > HCI Event: Command Status (0x0f) plen 4
> > > >     Remote Name Request Cancel (0x01|0x001a) status 0x01 ncmd 1
> > > >     Error: Unknown HCI Command
> > > 
> > > Looks like a BT1.1 dongle to me since Remote Name Request Cancel was
> > > introduced after that.
> > > And since the device is not yet finished paging during the 
> > remote name
> > > request, it disallows the Inquiry Command.
> > > 
> > > Solution: Get yourself a dongle > BT1.1 !
> > 
> > actually it was the Create Connection Cancel that was introduced with
> > Bluetooth 1.2. The Remote Name Request Cancel was always 
> > present, but it
> > seems we have a chip that doesn't support it.
> 
> You are right as well as wrong. Both Remote Name Request Cancel and 
> Create Connection Cancel were introduced in BT1.2. Please check (I've
> done that already!).

I don't have the Bluetooth 1.1 specification at hand. I was pretty sure
that the Remote Name Request Cancel was always present since I only
added a dependency against Bluetooth 1.2 for the Create Connection
Cancel support I added to the kernel lately.

> And since this is not an optional command it is impossible to have a
> BT1.2 chip which doesn't support this command.

You wish. I have seen chips where the set of supported HCI commands is
limited. Remember there is no real HCI qualification.

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
