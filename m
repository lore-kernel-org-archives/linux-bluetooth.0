Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if
	bemused-bemusedlinuxserver connection is open
From: Marcel Holtmann <marcel@holtmann.org>
To: Jouni.Lohikoski@iki.fi
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041017184054.GA306443@kosh.hut.fi>
References: <20041017125132.GA274769@kosh.hut.fi>
	 <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi>
	 <1098026676.4911.96.camel@pegasus> <20041017165348.GA292044@kosh.hut.fi>
	 <1098032261.4911.102.camel@pegasus>  <20041017184054.GA306443@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1098042076.21553.0.camel@pegasus>
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
Date: Sun, 17 Oct 2004 21:41:16 +0200

Hi Jouni,

> > the simple question is now, do it works fine when you disable auth and
> > encrypt?
> 
> No. Works exactly same way. When Bemused connection is open, HID mouse
> cannot reconnect after sleep mode. 'hcitool con' shows AUTH and ENCRYPT
> is not used, otherewise looks the same. Also hcidump -x sees nothing
> when HID mouse is trying to reconnect but Bemused connection is open but
> idle. Commenting out " "auth enable; " and "encrypt enable; " in
> hcid.conf (and killall -HUP hcid) didn't fix the problem.

it is enough to do "hciconfig hci0 noauth noencrypt" for testing this,
but if this not helps then you should buy yourself a Bluetooth dongle
with at least HCI 16.4 firmware on it.

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
