Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <007801c77120$bb936640$9d0cc70a@dlh.st.com>
References: <007801c77120$bb936640$9d0cc70a@dlh.st.com>
Date: Wed, 28 Mar 2007 12:18:04 +0200
Message-Id: <1175077084.5815.123.camel@violet>
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

> > > > I've been wondering why my devices weren't showing up in
> > > > nautilus-sendto, and it looks like DiscoverDevices 
> > doesn't work. Here's
> > > > the snippet of code:
> > > > 
> > > >         dbus_g_proxy_call (object, "DiscoverDevices", &e,
> > > >                            G_TYPE_INVALID, G_TYPE_INVALID);
> > > >         if (e != NULL) {
> > > >                 g_warning ("Couldn't start discovery: %s: %s",
> > > >                            dbus_g_error_get_name (e), e->message);
> > > >                 g_error_free (e);
> > > >         }
> > > > 
> > > > I do a list ListBondings before that on the same object, 
> > so I know that
> > > > it works. But I still get that error:
> > > > Couldn't start discovery: org.bluez.Error.Failed: Device 
> > or resource busy
> > > 
> > > please run "hcidump -X -V" to see what happens on the HCI 
> > layer. Do you
> > > have running anything else at the same time.
> > 
> > Nope, not doing anything else, apart from having the applet 
> > running, let
> > me attach the hcidump output.
> 
> [...]
> 
> > HCI Event: Command Status (0x0f) plen 4
> >     Remote Name Request Cancel (0x01|0x001a) status 0x01 ncmd 1
> >     Error: Unknown HCI Command
> 
> Looks like a BT1.1 dongle to me since Remote Name Request Cancel was
> introduced after that.
> And since the device is not yet finished paging during the remote name
> request, it disallows the Inquiry Command.
> 
> Solution: Get yourself a dongle > BT1.1 !

actually it was the Create Connection Cancel that was introduced with
Bluetooth 1.2. The Remote Name Request Cancel was always present, but it
seems we have a chip that doesn't support it.

Bastien, what does "hciconfig hci0 version" tells you?

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
