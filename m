Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060531170736.25650@gmx.net>
MIME-Version: 1.0
Date: Wed, 31 May 2006 19:07:36 +0200
From: pea sen <Blade_MV@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] sdpd not working on arm based linux
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

hello,

we`re trying to integrate bluez into an arm-based embedded-linux. =

we crosscompiled the bluez-libs and utils.
everything works fine: hciconfig, hcitool, sdptool are working correctly.
But when we try to start sdp-server "sdpd", nothing is done. no errormsg an=
d "ps" does not list sdpd-process.
typing "sdptool browse local" result following errormsg:
Failed to connect to SDP server on FF:FF:FF:00:00:00: Address family not su=
pported by protocol

we're not sure if we did everything right, but other bluez-tools working...=
 so what can be there? what is missing? what does sdpd need to work and why=
 is no output-message there?

All hints are usefull
-- =



Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
      Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
    =



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
