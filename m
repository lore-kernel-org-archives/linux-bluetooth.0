Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4561A319.9080107@det.uvigo.es>
Date: Mon, 20 Nov 2006 13:44:09 +0100
From: scostas <scostas@det.uvigo.es>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45617D44.3010403@det.uvigo.es>
	<456184AD.4040009@eridani.co.uk>	<456187FC.1020606@det.uvigo.es>
	<45618C92.3070000@eridani.co.uk>
In-Reply-To: <45618C92.3070000@eridani.co.uk>
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

Hi:

> It's been a while since I had to play with inbound BT connections, but =

> IIRC rather than making a connection back to the PDA like what you've =

> done above, the PDA is trying to open a new session so you need =

> something listening for the inbound BT RFCOMM connection.

Yes, that was the point. I used

	rfcomm listen /dev/rfcomm0 0

and a little python script to answer the AT commands, and it started to =

work. But I don't know the right answer for the AT+CREG? command.

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
