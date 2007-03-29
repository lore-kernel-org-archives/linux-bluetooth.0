Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 29 Mar 2007 11:28:16 +0530
Message-ID: <002801c771c7$3e9f3400$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1175086057.5815.132.camel@violet>
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

> > > > > HCI Event: Command Status (0x0f) plen 4
> > > > >     Remote Name Request Cancel (0x01|0x001a) status 
> 0x01 ncmd 1
> > > > >     Error: Unknown HCI Command
> > > > 
> > > > Looks like a BT1.1 dongle to me since Remote Name 
> > > > Request Cancel was
> > > > introduced after that.
> > > > And since the device is not yet finished paging during 
> > > > the remote name
> > > > request, it disallows the Inquiry Command.
> > > > 
> > > > Solution: Get yourself a dongle > BT1.1 !
> > > 
> > > actually it was the Create Connection Cancel that was 
> > > introduced with
> > > Bluetooth 1.2. The Remote Name Request Cancel was always 
> > > present, but it
> > > seems we have a chip that doesn't support it.
> > > 
> > > Bastien, what does "hciconfig hci0 version" tells you?
> > 
> > Same device, different machine (the dongle followed me to 
> > the office):
> > 
> > $ hciconfig hci0 version
> > hci0:   Type: USB
> >         BD Address: 00:08:F4:00:43:8D ACL MTU: 192:8 SCO MTU: 64:8
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 
> > (0x1) LMP Subver:
> > 0x20d
> >         Manufacturer: Cambridge Silicon Radio (10)
> > 

So, this confirms that it is indeed a BT1.1 device and hence does not
recognize the Remote Name Request Cancel command.

> > I hope there's at least some way to get it working. I'd 
> > rather not have
> > to have another dongle just because hcid doesn't like it :)
> 
> the problem is that the baseband is busy with the remote name request.
> It has to page the remote device for getting the name and in that case
> you simply can't run an inquiry. All currently available 
> Bluetooth chips have this limitation.
> 
> Main question is why we have the remote name request just before you
> wanna start the inquiry. What D-Bus methods are you actually calling
in
> what order? I think you constructed a use case that we never tested.

But actually, the sequence of HCI commands issued is correct. First, a
remote
name request is issued. Then, since an inquiry is required, the remote
name
request is cancelled. Thus, paging should stop and inquiry should be
possible.
I think this use case should work with BT1.2 devices and above.

But you are right, maybe some workaround should be present in order to
be
compatible with BT1.1 devices as well.

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
