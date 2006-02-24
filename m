Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602231604i5574b370uba09acf45c7d1a14@mail.gmail.com>
From: "John McCabe-Dansted" <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
In-Reply-To: <43FE2C18.7030306@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43FB7C2C.2030203@tootai.net>
	 <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
	 <43FC9783.5050708@tootai.net>
	 <fd87b6160602221602i3e3ea582md5f31fb4b69e5d65@mail.gmail.com>
	 <43FE2C18.7030306@tootai.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 24 Feb 2006 13:04:20 +1300

> No. I made <lsof | grep snd> then kill all programs showed.

Cool. I didn't realize you could do that. In my case though, e.g. xmms
doesn't stop the machine hibernating even though it uses /dev/snd.

> >
> > Have  you tried applying the patch below and replacing your hci_usb
> > module (probably only useful if you are using a bluetooth usb dongle)?
>
> There is no bluetooth device attached, just the module is loaded.

I am not sure what you mean. Surely you must have some sort of
bluetooth adapter, even if it is built into the motherboard?

If you really don't have any bluetooth devices, you may as well stop
snd-bt-sco from loading next time you boot, e.g. by typing
         sudo mv /lib/modules/`uname -r`/extra/snd-bt-sco.ko{,.bak}

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
