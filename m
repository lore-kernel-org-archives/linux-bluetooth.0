Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidp and hidd related bugs
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405120030.54220.cijoml@volny.cz>
References: <200405120030.54220.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1084368090.25099.22.camel@pegasus>
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
Date: Wed, 12 May 2004 15:21:30 +0200

Hi Michal,

> I did little research and here is output:
> 
> keys which are not reported in xev:
> Eigene Dateien
> Eigene Bilder
> Eigene Musik
> Messenger
> Abmelden
> 
> Reported badly
> Rechner is reported like Pause
> Standby like Print
> 
> Do you want send keycodes which reports bthid in 2.4.26 to have the same 
> hotkeys events?

you own a german keyboard ;)

However I can't help you in that case, because I have little interest to
fix this. The HID parser that is used by the HIDP kernel module is the
same parser as in the USB HID driver. In some near future they will be
joined to use the same generic parser. The parser in bthid was written
for the Microsoft keyboard and maybe did some assumptions that are wrong
for other keyboards. Try to get the buttons work with current HIDP and
some external programs like hotkeys.

> hidd --killall wants atribute BDADDR 

Silly typo. I only tested "-K" and that was working. It is fixed in CVS
now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
