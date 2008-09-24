Return-Path: <cyrus@holtmann.org>
Message-ID: <2ced936d0809241116v67a7090dub5730b07b8409384@mail.gmail.com>
Date: Wed, 24 Sep 2008 18:16:38 +0000
From: "Breno Jacinto" <breno@freeunix.com.br>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] pand --search functionality
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

   I'm experimenting with the Bluetooth PAN Profile, and as documented
in the HOWTO http://bluez.sourceforge.net/contrib/HOWTO-PAN, as well
as in the man page, it is said:

To make life easier in case you don't know the device address of your desir=
ed
communication partner, the optional parameter '--search' allows you to sear=
ch
for PAN communication partners, e.g.:
	# pand --role PANU --search [duration]

performs Bluetooth inquiry for PAN devices in the vicinity and tries to
connect to any discovered device. The search continues for no longer than
'duration' units of 1.28 seconds.

    When trying this command and taking a look at /var/log/messages,
pand *only* searches for NAP nodes, failing to connect to any PANU or
GN nodes. Even if I force the --role option to GN or PANU, it still
only searches for NAP nodes. Is this an expected behavior or a bug?

     Some output for better understanding: scanning 2 PANU nodes :

Sep 24 17:27:11 (none) pand[11737]: Bluetooth PAN daemon version 3.12
Sep 24 17:27:11 (none) pand[11737]: Inquiring
Sep 24 17:27:11 (none) pand[11737]: Searching for NAP on 00:11:B1:07:A2:29
Sep 24 17:27:13 (none) pand[11737]: Searching for NAP on 00:1B:33:9D:33:53

     It keeps searching for NAP nodes and does not connect. Now, I
changed the first node to NAP, and here's what I get:

Sep 24 18:01:35 (none) pand[11877]: Searching for NAP on 00:11:B1:07:A2:29
Sep 24 18:01:35 (none) pand[11877]: Connecting to 00:11:B1:07:A2:29
Sep 24 18:01:35 (none) pand[11877]: bnep0 connected
Sep 24 18:01:35 (none) pand[11877]: Searching for NAP on 00:1B:33:9D:33:53

     So... I still dont get it. If anyone can clarify this, please do
so. Software versions:

Bluetooth PAN daemon version 3.12
Kernel 2.6.21.5 - Distribution BackTrack 3.0

best regards.

-- =

-- =

:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
 2F15 8A61 F566 E442 8581
 E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia. ::

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
