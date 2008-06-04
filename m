Return-Path: <cyrus@holtmann.org>
Date: Wed, 04 Jun 2008 10:39:29 +0200
From: mulata@gmx.de
Message-ID: <20080604083929.250690@gmx.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] hcid and pairing problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi!

Im using hcid 3.31 on Kernel 2.4.21
In order to use a bluetooth keyboard I've installed Peter's bthid.
With the Logitech Desktop 550 MX it works really fine so far, since this ke=
yboard has no pairing process.

But now I have another Keyboard (Keysonic) which goes through the whole pai=
ring process and I have problems.
I know I probably can't get any support here for bthid but the problem seem=
s to be related to the pairing process which is actually handled by hcid.
After scanning for the keyboard I can establish a connection with bthid. hc=
itool says:
Connections:
        < ACL 00:18:00:00:61:45 handle 6 state 1 lm MASTER

So this looks good so far.
But I cant pair the devices.

hcid.conf is set to "security auto", "pairing multi", "passkey 1234".
So usually the pairing process looks like that, right:
1. bthid connects the keyboard
2. keyboard asks bthid for a pin
3. bthid forwards this request to hcid
3 hcid provides the pin through bthid to the keyboard automatically (securi=
ty is auto in hcid.conf)
4 I have to type the pin in the keyboard and press enter
5 pairing should be done

Is this correct?
The problem is I dont get any feedback during this process, no echo and no =
prompt etc.

If I set security to user in hcid.conf actually hcid should ask me for a ke=
y to enter, but this doesn't happen either.

Anyway after a while bthid says this:
bthid[980]: read error 1 on Control channel: Operation not permitted

Thanks for any help...

martin.

PS, Marcel: Sorry but I really can't switch to Kernel 2.6 and with getting =
good results with the Logitech Keyboard I think others should work, too
-- =

Martin Kupf

Super-Aktion nur in der GMX Spieleflat: 10 Tage f=FCr 1 Euro.
=DCber 180 Spiele downloaden: http://flat.games.gmx.de

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
