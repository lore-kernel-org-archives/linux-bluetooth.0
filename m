Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <C1B29E01A9B748458D51DBBE04E4B9EA080CB5@7layers.7layers-uk.com>
From: "Halam Rose" <Halam.Rose@7layers-uk.com>
To: "BlueZ-devel Mailing List (E-mail)" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] TCRL updated
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 14 Nov 2003 11:04:58 -0000

The TCRL was updated on 11 November, the new version can be found at =
http://qualweb.bluetooth.org/Template2.cfm?LinkID=3D4

The TCRL tells us the status of each test case, that is whether the test =
has to be done at all and if it has to be carried out whether it must be =
done at a BQTF or if you can do it yourselves.  The TCRL also shows =
which errata should be applied.

Key to the Categories=09
Cat.	Short description
A	Validated and commercially available at BQTF
B	Declaration with evidence
C	Declaration without evidence
D	Informative
	Detailed description in current Program Reference Document (PRD) =
section 5.3.2.
=09

As a quick overview you can expect B, C & D category tests at all levels =
of the stack but generally the following applies
RF Cat A
BB Cat A
LM Cat A
GAP Cat A
SDP Cat A
L2CAP Cat B
RFCMM/SPP CAT B
Profiles CAT B apart from SDAP which id all D

BW

Halam

--------------------------------------------
Halam Rose
Bluetooth Specialist
7 layers UK Ltd
BQTF: RF, Protocol and Profile=20

Tel: +44 (0)1763 262524=20
Fax: +44 (0)1763 261177=20
Mob: +44 (0)7876 560922
Halam.Rose@7layers-UK.com=20
www.7layers-UK.com=20

Melbourn Science Park
Cambridge Road
Melbourn
Hertfordshire SG8 6HB=20

--------------------------------------------
The information contained in this message
is confidential and should not be disclosed
to any third party whether or not you are the=20
intended addressee indicated in the message.
Addressees of this email may exercise their
rights under the 1988 Data Protection Act.=20
--------------------------------------------


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
