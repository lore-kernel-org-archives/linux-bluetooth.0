Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox BT-MS02B Bluetooth HID mouse, authorization
	and encryption?
From: Marcel Holtmann <marcel@holtmann.org>
To: Jouni.Lohikoski@iki.fi
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040917202651.GA485579@kosh.hut.fi>
References: <20040917202651.GA485579@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1095456519.5973.15.camel@pegasus>
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
Date: Fri, 17 Sep 2004 23:28:39 +0200

Hi Jouni,
   
> I got it working, but few things (3) I'd need to find out still. hidd
> program seems to be so new, there is no yet any documentation with it.
> Maybe later there will FAQ for Linux HID.

the hidd manpage is still missing. May you wanna write it for me?
                                                                                
> I used to have authorization and encryption on in
> /etc/bluetooth/hcid.conf before, but I noticed "hidd --search"
> wanted a PIN then for outgoing connection. I have no idea what would be the
> Bluetooth PIN-code for my mouse, neither was it mentioned anywhere in the
> package or in the Windows-documentation which came with the mouse.

Don't set auth and encrypt in hcid.conf. This puts your device in
security mode 3 and you don't wanna do this. So mailing list archive for
more details.

> I'd still like to have authorization and encryption on, because I have also
> Bluetooth OBEX-server on the machine and someone could now easily without
> authorization write to my home directory. (gnome-obex-server)

This is a problem of the OBEX-server. Ask the author to implement proper
support for it.

> 1)
> How one turns encryption off just for HID devices, preferrably only for
> this one mouse,...or should I somehow be able to get the PID-code for 
> my mouse from somewhere? Is the VID:PID column in the table of the first URI
> meant for that PID-code information?

See above and read the Bluetooth specification to understand the
differences between device and service security.

> 2) After 11 minutes 
> (I assume from [URI2] <http://www.holtmann.org/linux/bluetooth/epox.html>)
> the mouse has disconnected and went to the sleep mode. Is there some
> way to reconnect it automaticly? Now I seem to need to push the mysterous
> grey button on the bottom of the mouse always, and do `hidd --search` again
> to get it reconnected. 

You only have to press a mouse button and what for the reconnect of the
mouse. To make this working you need to start hidd --server as root at
boot time.

> [This 2. one I seem to have solved by upgrading to bluez-utils-2.10, now
> hidd --server does accept reconnection after the power saving sleep, but
> only if auth+encryption is disabled.]

See above.

> I need to ask EPoX technical support what exactly is
> the little grey button on the bottom of the mouse for. Or would you know?

You need to press it if you wanna pair your device again. Speaking in
terms of the HID profile it means virtual cable unplug.

> I don't quite understand what hidd --server is for, [can guess now]
> as again, there was no documentation, at least in the rpm packages
> (bluez-utils-2.8*rpm) I also looked the newest bluez-utils-2.10 for
> hidd documentation, no luck. Is it suppose to accept and re-attach connection
> from the HID device which comes out of idle-state?

Correct. You need it for the reconnect.

> 3)
> What is the column "AFH" in the table of the first URI?
> (and VID:PID ?)

AFH = Adaptive Frequence Hopping (a Bluetooth 1.2 feature).
VID = Vendor ID
PID = Product ID

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
