Return-Path: <cyrus@holtmann.org>
Message-ID: <2ced936d0809281240k46c15812va7c80172bd0b92c9@mail.gmail.com>
Date: Sun, 28 Sep 2008 16:40:00 -0300
From: "Breno Jacinto" <breno@freeunix.com.br>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] BNEP Broadcasting
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

   I'm working on an experiment involving the Bluetooth network with
the PAN profile enabled and BNEP implemented in a simple scenario: one
master node with the GN role enabled, and another one with the PANU
role.

   According to the BNEP spec, page 16, it's said:

"Either the destination or the source address may be an IEEE Ethernet
address, if
the actual destination/source is an IEEE device and not a Bluetooth device.
BNEP shall use IEEE Ethernet broadcast and multicast addresses for the sour=
ce
and/or destination addresses for broadcast and multicast packets."

   So, I suppose that broadcasting should be supported in a BNEP
network, just like an Ethernet network? I'm concerned about this
because I'm trying to broadcast a message from PANU to other devices
(in this case, just the master) and vice-versa, without any success.

    If someone is aware of how this could be achieved, or if I'm
misunderstanding something, please share your opnion.

best regards,

-- =

-- =

:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
