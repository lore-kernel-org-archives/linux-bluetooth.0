Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1111142878.2085.28.camel@panic>
Mime-Version: 1.0
Subject: [Bluez-devel] obex bluetooth - slightly off topic
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 18 Mar 2005 02:47:57 -0800

Hi List,

I was playing around with bluetooth/bluez and obexftp (openobex) and
found that there are some issues with windows xp. This means I could not
send files via OPUSH to a windows host but receiving works fine.
Surprisingly btftp from the bluez cvs obex tree works fine in both
directions. The same applies for PocketPC (wince 4.2). I would like to
know what your experiences with obex bluetooth are.

I started looking at the openobex code and doing some hci dumps.
WinXp/PPC allway return error 0x53 for a PUT. Also all obex
implementations but openobex seem to handle the final chunck of a PUT
differently, they finallize it with a zero length body-part-header where
openobex just finallizes the last chunck. The only strange thing is
btftp because PUTs seem to work with PPC and also uses openobex as
backend.


... Collin

PS: I never had any problems with PalmOS or Symbian

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
I thought I made a mistake once, but I was wrong.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
