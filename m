Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if
	bemused-bemusedlinuxserver connection is open
From: Marcel Holtmann <marcel@holtmann.org>
To: Jouni.Lohikoski@iki.fi
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041017165348.GA292044@kosh.hut.fi>
References: <20041017125132.GA274769@kosh.hut.fi>
	 <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi>
	 <1098026676.4911.96.camel@pegasus>  <20041017165348.GA292044@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1098032261.4911.102.camel@pegasus>
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
Date: Sun, 17 Oct 2004 18:57:41 +0200

Hi Jouni,

> > Check with "hciconfig hci0 revision" (as root) your firmware version of
> 
>         HCI 14.3
>         Chip version: BlueCore02 (ES2)
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> > your dongle, but it is not a HCI 16.x one and so it does not support any
> > kind of scatternet stuff and this is maybe the reason why it fails. Use
> > "hcidump -x" to check for the real HCI error codes and look them up in
> > the Bluetooth specification.
> oI did this, but there was nothing to be seen. When Bemused connection
> was active, ofcourse there was ACL data going between devices. When the
> bemused connection was open but idle, hcidump didn't show anything. Then
> I tried to reconnect the HID mouse by pressing mouse button 1. The mouse
> woke up (red led started blinking on the bottom of the mouse). Running
> hcidump didn't show anything, like hcid wasn't receiving or sending
> anything. Doing something on the Bemused client then again showed data
> sent and received.
> 
> So either bluetooth dongle or hcid desn't see connection requests when
> one ACL connection which uses SP profile is open (and in sec.mode 3)
> 
> For bemused this is run in rc.local
> sdptool add --channel=10 SP
> 
> But when HID connection is open and active, bemused connection can be
> opened without problems. What I currently quite not understand, is why
> other connection type is different that it blocks new connections, but
> other one does not. Both uses AUTH+ENCRYPT+MASTER when checked with
> hcitool con.

the simple question is now, do it works fine when you disable auth and
encrypt?

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
