Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I8T9T2$21C7D65B476B562F8D57DF910D116070@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Re: Disconnections are not being detected
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
Date: Thu, 16 Dec 2004 11:43:50 +0100

ok, but how can my program be aware of this ? it has to do some tasks in =
response of
a link-fall.....


 >Hi Andrea,
 
 >> i am working on a=
 "pand" based that basically sets up bnep connections.
 > >For my tests,=
 i use simple usb bluetooth dongles (in particolar, some CSR
dongle).=0D
=
 > >My question is: how an endpoint (es a PANU) can detect a link lost ? =
I see
 > >w4_hup shuld
 > >handle this, but if i mnually remove the GN =
dongle, the PANU does"t signal
nothing.
 > >can someone help me ??
 =0D
=
 >the bnep0 ethernet device will disappear.
 
 >Regards
 
 >Marcel=0A=
=0A=0A=0A____________________________________________________________=0AR=
egala e regalati Libero ADSL: 3 mesi gratis, navighi veloce e scarichi a =
1.2 Mega. =0AAbbonati subito senza costi di attivazione su http://www.lib=
ero.it=0A=0A



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
