Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1139411355.8712.24.camel@bluez.bueche.ch>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>  <1138880751.21953.38.camel@bluez.bueche.ch>
	 <1139331334.12556.3.camel@pc-05.ycom.ch>
	 <1139351059.22790.63.camel@localhost>
	 <1139411355.8712.24.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=utf-8
Message-Id: <1139489430.7543.7.camel@pc-05.ycom.ch>
Mime-Version: 1.0
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
Date: Thu, 09 Feb 2006 13:50:30 +0100

Le mercredi 08 f=C3=A9vrier 2006 =C3=A0 16:09 +0100, Charles Bueche a =C3=
=A9crit :

> Hi all,
>=20
> thanks for the analysis and explanations. From what I have read and
> tested, here is a resum=C3=A9 of the Logitech V270 situation :
>=20
> - Logitech ignore Linux (this is not new, but need to be repeated)
> - the V270 mouse basically works as expected HID input device, but is
> overly sensible (probably due to its high resolution)
> - the mouse events go into /dev/input/mice by default
> - if evdev is loaded, mouse events go to /dev/input/event{1..N}
> - udev doesn't have the info to create a rule in 10-local.rules so the
> V270 get mapped to a fix name like /dev/input/v270
> - none of the tools I tried (locomo, logitech-applet) know the V270 for
> now. I tried to change some of them, but failed, due to lacking know-ho=
w
> in HID/USB/etc
> - KDE control center or xset cannot reduce the mouse sensibility enough
> to make it usuable (at least for my 40 years muscles control ability)


Thanks for this good resum=C3=A9, you point out the major current issue.

I just can add about udev-rules, Marcel and UDEV team are searching for
a better solution to add more infos on the udev struct, to let user
creates good rules with devices.

We can expect a workaround not so far :)

And about Linux support on Logitech product, I've several friends
working for this compagny, and with some insiders informations, I can
tell that Logitech try  now to make better software. They are aware of
the poor quality of their driver / software.
Just hope they can spend some time to change their devs :)





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
