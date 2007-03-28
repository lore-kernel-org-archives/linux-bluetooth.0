Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Wed, 28 Mar 2007 15:59:54 +0530
Message-ID: <007901c77124$06df3040$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1175077084.5815.123.camel@violet>
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

Hi Marcel, 

> > > HCI Event: Command Status (0x0f) plen 4
> > >     Remote Name Request Cancel (0x01|0x001a) status 0x01 ncmd 1
> > >     Error: Unknown HCI Command
> > 
> > Looks like a BT1.1 dongle to me since Remote Name Request Cancel was
> > introduced after that.
> > And since the device is not yet finished paging during the 
> remote name
> > request, it disallows the Inquiry Command.
> > 
> > Solution: Get yourself a dongle > BT1.1 !
> 
> actually it was the Create Connection Cancel that was introduced with
> Bluetooth 1.2. The Remote Name Request Cancel was always 
> present, but it
> seems we have a chip that doesn't support it.

You are right as well as wrong. Both Remote Name Request Cancel and 
Create Connection Cancel were introduced in BT1.2. Please check (I've
done that already!).

And since this is not an optional command it is impossible to have a
BT1.2 chip which doesn't support this command.

Best Regards,

Mayank



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
