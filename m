Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <IAI99B$27B712D2FEB9CD5A83872A7C35DCDB76@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] ipaq h5550 pand question
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
Date: Tue, 18 Jan 2005 10:05:35 +0100

Hi,
i ve an ipaq 5550 configured with familiar 0.8 (kernel 2.4.19-rmk6-p=
xa1-hh37).
I ve bluetooth running and all seems fine. But i ve a problem=
 with pand.
If i execute pand -listen on the ipaq (the connect executed =
from a pc) the bnep0 
interface is created and all works fine. But if i =
execute pand -c address on the 
ipaq (and the listen on the pc) i obtain=
 this error on the ipaq:

pand[2170]: Bluetooth PAN daemon version 2.13=

pand[2170]: Connecting to 00:10:60:A7:48:84
pand[2170]: Connect to 00:=
10:60:A7:48:84 failed. Function not implemented(38)

can someone tell m=
e why ?
thanks!

=0A=0A=0A=0A_________________________________________=
___________________=0ALibero ADSL: 3 mesi gratis e navighi a 1.2 Mega. E =
poi hai l'Adsl senza limiti a meno di 1 euro al giorno. =0AAbbonati subit=
o senza costi di attivazione su http://www.libero.it=0A=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
