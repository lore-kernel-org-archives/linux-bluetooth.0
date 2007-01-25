Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Lauri Lubi" <lauri@lubi.se>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
References: <001e01c73b12$ea34afc0$9301a8c0@LUBI> <45B661F6.8010703@csr.com>
Date: Thu, 25 Jan 2007 07:51:49 +0100
Message-ID: <006801c7404d$49f4ade0$9301a8c0@LUBI>
MIME-Version: 1.0
In-Reply-To: <45B661F6.8010703@csr.com>
Subject: [Bluez-users] HCI version
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks, Marcel and Steven.

That explains why it reports ver 1.2. I understand that I have no need to
worry about it, as it does not affect performance or features. The dongles
are travelling (in use) and out of my sight currently, but I will check the
features as soon as possible.

Mvh
Lauri Lubi
Mob +46 730 39 31 00
 =

-----Ursprungligt meddelande-----
Fr=E5n: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Steven Singer
Skickat: den 23 januari 2007 20:29
Till: BlueZ users
=C4mne: Re: [Bluez-users] HCI version

Lauri Lubi wrote:
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x7a6 LMP Ver: 1.2 (0x2) LMP Subver:
0x7a6
> =

> Is HCI Ver the same as supported Bluetooth version?

Yes it is. Or, at least, it's supposed to be.

Sadly, this dongle reports the wrong spec version. The firmware (0x07a6)
is BT 2.0 + EDR compliant, it just the dongle reports itself as just
BT 1.2 compliant.

I'm sure this firmware reported itself as 2.0 + EDR when we shipped it.

We did add the ability for the firmware to spoof its spec version to
work round a problem in some host stacks where they were rejecting
devices complaint to a later version of the spec than that to which the
stack had been written. Since a 2.0 + EDR device will work quite happily
with a 1.2 stack (there are no new HCI events) this was an easy
workaround. It's possible that the dongle manufacturer is shipping this
device with spoofing enabled because it was being bundled with such a
host stack.

The problem should be easily remedied by resetting the PS key
HCI_LMP_LOCAL_VERSION back to its default value of 0x0303, though, in
practice, it shouldn't make any difference. All this key does is change
what version the dongle reports to the stack not how the firmware
behaves. No devices or host stacks are meant to use the version number to
change their behaviour, they're meant to use the supported features. This
device will continue give EDR performance even without this change and
BlueZ should treat it as having 2.0 + EDR features. If you're intending to
use this dongle with a host stack that might be upset by a 2.0 + EDR device,
you should leave this PS key alone.

If you want to know whether 2.0 + EDR features are really supported then
look at the supported features, not the version.

	- Steven
-- =


 =


-- =

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.432 / Virus Database: 268.17.8/649 - Release Date: 2007-01-23
20:40
 =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
