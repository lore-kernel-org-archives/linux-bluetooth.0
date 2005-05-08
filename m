Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
References: <200505072203.45598.rdorsch@web.de> <200505081727.29246.rdorsch@web.de> <1115567196.9031.113.camel@pegasus>
In-Reply-To: <1115567196.9031.113.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200505081824.08678.rdorsch@web.de>
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
Date: Sun, 8 May 2005 18:24:08 +0200

Hi Marcel,

Am Sonntag, 8. Mai 2005 17:46 schrieb Marcel Holtmann:
> > Not asking for a PIN each time is actually fine (persisten pairing is a
> > nice invention;-). I just want to check that the system really wants to
> > see a PIN when a new device comes in.
> >
> > Are you saying when I delete
> >
> > 	/etc/bluetooth/link_key
> >
> > on both NAP and PANU I should be askef for a password?
>
> Yes. And with bluez-utils-2.16 the link key storage has been changed.

Worked excellent, thanks. Are the link keys valid forever or do they have an 
expiration date? I.e. if is do "security user" may it happen that bluez 
simply stops working (because e.g. bluez is started before X and I won't 
notice why until I figured out that the link key expired)

> Check the mailing list archive for more details.

I saw that before, "link key storage" and bluez does not have many hits on 
google ;-)

Many thanks,
Rainer

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
