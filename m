Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200605312040.k4VKeUGa011961@smtp-frr01.proxy.aol.com>
From: "Andreas Vedral" <andreas.vedral@fh-bochum.de>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 31 May 2006 22:40:19 +0200
MIME-Version: 1.0
In-reply-to: <20060531170736.25650@gmx.net>
Subject: Re: [Bluez-users] sdpd not working on arm based linux
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

Hi, =


it seems that you don't have start the sdp data base daemon (sdpd) on your
local system which handles the incoming sdp queries from other BT devices.
First of all try to start the ./sdpd.

Sincerely, =

Andreas =


  =


 =


-----Urspr=FCngliche Nachricht-----
Von: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] Im Auftrag von pea sen
Gesendet: Mittwoch, 31. Mai 2006 19:08
An: bluez-users@lists.sourceforge.net
Betreff: [Bluez-users] sdpd not working on arm based linux

hello,

we`re trying to integrate bluez into an arm-based embedded-linux. =

we crosscompiled the bluez-libs and utils.
everything works fine: hciconfig, hcitool, sdptool are working correctly.
But when we try to start sdp-server "sdpd", nothing is done. no errormsg and
"ps" does not list sdpd-process.
typing "sdptool browse local" result following errormsg:
Failed to connect to SDP server on FF:FF:FF:00:00:00: Address family not
supported by protocol

we're not sure if we did everything right, but other bluez-tools working...
so what can be there? what is missing? what does sdpd need to work and why
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



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
