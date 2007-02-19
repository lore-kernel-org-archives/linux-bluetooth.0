Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sascha Turczyk <Sascha.Turczyk@gmx.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 19 Feb 2007 20:20:48 +0100
MIME-Version: 1.0
Message-Id: <200702192020.49437.Sascha.Turczyk@gmx.de>
Subject: [Bluez-users] Epox Presenter BT-PM01B: How to use buttons?
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

Hello,

I want to use this presenter under Linux: Kubuntu 6.10 Edgy Eft. But it doe=
s =

not work. Perhaps somebody can help me.
First of all I shortly tell you, what I have done so far to get this thing =
to =

work.


Using the bluezutils I can find the presenter and even connect to it.

"quote"

sascha@Sascha-Notebook:~$ hcitool scan
Scanning ...
        <baddr>       Presenter 838995 =


sascha@Sascha-Notebook:~$ sudo hcitool cc <baddr> =


sascha@Sascha-Notebook:~$ hcitool info <baddr>
Requesting information ...
        BD Address:  <baddr>
        Device Name: Presenter 838995
        LMP Version: 1.1 (0x1) LMP Subversion: 0x436
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
 sascha@Sascha-Notebook:~$ hcitool con
Connections:
        < ACL <baddr> handle 41 state 1 lm MASTER
               <park state> <RSSI> <channel quality> <SCO link> <HV2 packet=
s>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>

"quote end"

But the buttons do not work, so I cannot use the epox presenter.
Then I searched in the internet and found the webpage

http://www.holtmann.org/linux/bluetooth/epox.html

There you can download a software especially written to use this presenter =

under linux. One has to compile this software with some scripts coming alon=
g =

with the download.
But the problem is, that this software uses some old packages which I canno=
t =

install =


"quote"

*cut some uninteresting stuff*
checking for libsdp... no
configure: error: SDP library not found.
                Please compile and install bluez-sdp package.


sascha@Sascha-Notebook:~/Downloads/epox-presenter-0.2$ sudo apt-get install =

bluez-sdp
Password:
Paketlisten werden gelesen... Fertig
Abh=E4ngigkeitsbaum wird aufgebaut
Reading state information... Fertig
Paket bluez-sdp ist nicht verf=FCgbar, wird aber von einem anderen
Paket referenziert. Das kann hei=DFen, dass das Paket fehlt, dass es veralt=
et
ist oder nur aus einer anderen Quelle verf=FCgbar ist.
Doch die folgenden Pakete ersetzen es:
  bluez-utils
E: Paket bluez-sdp hat keinen Installationskandidaten =


"quote end"

Sorry for the german text. But apt-get says, that this bluez-sdp is too old=
, =

Now one has to use "bluez-utilz" which I have already installed on my =

computer.

Does anyone have an idea how I can get this Presenter finally work?

Thanks a lot

Sascha

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
