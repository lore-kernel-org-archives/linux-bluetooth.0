Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Sjoerd Simons <sjoerd@spring.luon.net>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20041001181143.GB4230@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net>
	 <1096563173.4371.5.camel@notepaq> <20040930170602.GA13427@spring.luon.net>
	 <1096641358.4265.8.camel@notepaq>  <20041001181143.GB4230@spring.luon.net>
Content-Type: text/plain
Message-Id: <1096701500.4809.2.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 02 Oct 2004 09:18:20 +0200

Hi Sjoerd,

> > I already tracked this problem. The T610 has an old Bluetooth chip that
> > can't do a role switch and this is forced when you run hidd. The CVS
> > already contains a fixed hidd that can deal with it.
> 
> Is this only a problem when running hidd or can i also expect it when using 
> other bluetooth apps (pand ?).

it is a problem whenever you run an application that forces an role
switch. For example using pand with --master option.

> I've tested the cvs hidd version on my x86, but to no avail. When starting
> hidd --server --master sending files from the phone start failing :(.

Leave the --master option out. CSR based HID input devices will trigger
the role switch by themself. Only the Broadcom stuff (Apple) have a
problem there.

> Do i need the -mh2 patches for this ?

No.

> For the record hcitool info on my phone says:
> Requesting information ...
>         BD Address:  00:0F:DE:1D:3F:75
>         Device Name: Winter
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x503
>         Manufacturer: Ericsson Technology Licensing (0)
>         Features: 0x04 0xca 0x31 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <RSSI> <SCO link> <u-law log> <A-law log> <CVSD> 

The missing <role switch> is here important.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
