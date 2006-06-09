Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 9 Jun 2006 09:47:01 +0200
Message-ID: <CA21EAA4DF189C40A3BC30A5A75DA56002551241@ratatosk>
From: "Birger Kroon" <Birger.Kroon@sys.teleca.se>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Changing default paths in hcid?
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

Hi

I've cross compiled BlueZ libs and utils for an arm based platform and most=
 things work nice. However, when running hcid it assumes to find things at =
a path that I defined as install path at the host system (i.e. set by the P=
REFIX flag). =


I did this since I do not want to install the cross compiled things on my h=
ost. =


I configured with:
./configure --prefix=3D[mypath] --host=3Darm-linux

Does anyone know the correct way of cross compiling and install bluez on a =
target system I would appreciate some hints.

Regards
// Birger =

 =

Birger Kroon =

Software Engineer =

Automotive Solutions

Teleca Sweden West AB =

Lindholmspiren 9 =

SE-417 56 G=F6teborg =

Sweden =

Tel +46 31 744 80 00 =

Fax +46 31 744 80 01 =


Direct +46 31 744 80 87 =

Mobile +46 703 79 19 11 =

birger.kroon@sys.teleca.se =

www.teleca.com



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
