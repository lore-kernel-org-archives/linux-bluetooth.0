Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I8T80S$914236AECE25C0455D98517D1D8A2F3C@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] how detect bnep disconnection ?
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
Date: Thu, 16 Dec 2004 11:05:16 +0100

Hi, 
i am working on a "pand" based that basically sets up bnep connecti=
ons.
For my tests, i use simple usb bluetooth dongles (in particolar, so=
me CSR dongle).
My question is: how an endpoint (es a PANU) can detect a=
 link lost ? I see
w4_hup shuld
handle this, but if i mnually remove th=
e GN dongle, the PANU does't signal nothing.
can someone help me ??
tha=
nks!!
andrea
 =0A=0A=0A=0A_____________________________________________=
_______________=0ARegala e regalati Libero ADSL: 3 mesi gratis, navighi v=
eloce e scarichi a 1.2 Mega. =0AAbbonati subito senza costi di attivazion=
e su http://www.libero.it=0A=0A



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
