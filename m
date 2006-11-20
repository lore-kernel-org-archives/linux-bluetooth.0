Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <456187FC.1020606@det.uvigo.es>
Date: Mon, 20 Nov 2006 11:48:28 +0100
From: scostas <scostas@det.uvigo.es>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45617D44.3010403@det.uvigo.es> <456184AD.4040009@eridani.co.uk>
In-Reply-To: <456184AD.4040009@eridani.co.uk>
Subject: Re: [Bluez-users] emulating a GPRS modem with a linux PC
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

Michael McConnell escribi=F3:

Hi Michael:

>> So I had the idea of emulating a BlueTooth GPRS modem with the PC. This =

>> is: the PDA will think that my PC has a GPRS modem and will use it to =

>> connect to the internet.

> You may need to set up some kind of "chat" script to emulate the AT =

> interface of the mobile phone, this will take some trial and error since =

> everything seems to want to send different commands :-/  The important =

> one would be the ATD<whatever> command, in that case send "CONNECT" =

> (chat will add the \r\n) then start PPP.

The problem is that I didn't receive AT commands. I'm not sure that I =

have configured the RFCOMM port fine. That's my first question: how do I =

have to set up it?

I tried with

	rfcomm connect 0 XX:XX:XX:XX:XX:XX

then I launched a cat /dev/rfcomm0 and tried to connect from the PDA, =

but I didn't receive AT commands.

Thanks.

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
