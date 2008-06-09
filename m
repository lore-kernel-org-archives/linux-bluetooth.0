Return-Path: <cyrus@holtmann.org>
Date: Mon, 09 Jun 2008 18:31:10 +0200
From: mulata@gmx.de
Message-ID: <20080609163110.282100@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] pairing problems
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
After an initial I always have to go through the complete pairing process, =
there is no reconnect.

I want to use a Bluetooth keyboard and it works fine so far, but there are =
some problems after the initial pairing.

To get the keyboard wokring I do the following steps:

hcid and passkey-agent are running.

hcitool scan
hcitool cc <bdaddr>
After this step hcitool con lists a established connection to the keyboard
auth <bdaddr>
Enter PIN on keyboard

Now the entry in hcitool con changes to AUTH
So the connection is authorized and established and the keyboard works (I u=
se bthid, anyway the process of authorization and pairing is done by hcid, =
and hcitools)

Usually from now this initial pairing process shouldnt be necessary for fur=
ther sessions, but unfortunately it is.
In oder to use the keyboard again (after disabling it) I have to go through=
 the whole process again, but befor I have to /var/lib/bluetooth/*

So how can I establish further connections without the whole pairing proces=
s?

thanks
-- =

Martin Kupf

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
