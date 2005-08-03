Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42F0D338.8080502@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
From: Oliver Leitner <shadow333@gmail.com>
Subject: [Bluez-devel] Problem Debian Sarge and btscanner-1.0
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
Date: Wed, 03 Aug 2005 16:22:48 +0200

Dear Ladies and Gentleman

I have a slight problem with the current stable branch of debian, and bluez.

when i try to run ./configure within the btscanner-1.0 directory, i get
the following error:

lappy:/home/nevermind/btscanner-1.0# ./configure
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for main in -lcurses... yes
checking for main in -lbluetooth... yes
checking for main in -lsdp... no
configure: error: SDP not found

the next thing ive tried was to install the bluetooth things from your
page via the apt repository:

deb http://bluez.sourceforge.net/download/debian/ ./
deb-src http://bluez.sourceforge.net/download/debian/ ./

which gave me the following error for the bluez-sdp package (amongst
other errors with version dependencies...)

Paketlisten werden gelesen... Fertig
Abhängigkeitsbaum wird aufgebaut... Fertig
Einige Pakete konnten nicht installiert werden. Das kann bedeuten, dass
Sie eine unmögliche Situation angefordert haben oder dass, wenn Sie die
instabile Distribution verwenden, einige erforderliche Pakete noch nicht
kreiert oder aus Incoming herausbewegt wurden.

Da Sie nur eine einzige Operation angefordert haben ist es sehr
wahrscheinlich,
dass das Paket einfach nicht installierbar ist und eine Fehlermeldung über
dieses Paket erfolgen sollte.
Die folgenden Informationen helfen Ihnen vielleicht, die Situation zu lösen:

Die folgenden Pakete haben nichterfüllte Abhängigkeiten:
  bluez-sdp: Hängt ab: bluez-utils (>= 2.2-1) soll aber nicht
installiert werden

it seems that bluez-sdp needs a more actual bluez-utils package than
that, that is included with sarge... (Version: 2.2-2)

now when i try to install the bluez-utils package from your repository
via dpkg -i, and then the bluez-sdp via dpkg -i, i get the following error:

dpkg: Betrachte bluez-sdp_1.4-1_i386.deb, welches bluez-sdp enthält:
 bluez-utils kollidiert mit bluez-sdp (<= 1.5-2)
  bluez-sdp (Version 1.4-1) soll installiert werden.
dpkg: Fehler beim Bearbeiten von bluez-sdp_1.4-1_i386.deb (--install):
 kollidierende Pakete - installiere bluez-sdp nicht
Fehler traten auf beim Bearbeiten von:
 bluez-sdp_1.4-1_i386.deb

im runnind debian sarge, with the following kernel:
2.6.8-2-386 (generic stable sarge kernel)

currently installed bluez packages:
ii  bluez-firmware 1.0-2          Firmware for Bluetooth devices
ii  bluez-hcidump  1.17-1         Analyses Bluetooth HCI packets
ii  bluez-pin      0.25-1         Bluetooth PIN helper with D-BUS
support
ic  bluez-sdp      1.4-1          BlueZ Bluetooth SDP daemon and tool
ii  bluez-utils    2.15-1         Bluetooth tools and daemons
ii  libbluetooth1  2.15-2         Library to use the BlueZ Linux
Bluetooth sta
ii  libbluetooth1- 2.15-2         Development files for using the BlueZ
Linux

see the "ic" flag before bluez-sdp....
means "installed but conflicting", from what i can tell (maybe i
understood that wrong, but i think thats bout it...)

maybe im missing something, any help would be greatly appreciated.

Greetings
Oliver Leitner
Technical Staff
http://www.shells.at


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
