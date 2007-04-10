Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461B4E88.9010801@gmail.com>
Date: Tue, 10 Apr 2007 12:44:56 +0400
From: Sergey Smirnov <svs1957@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] btsco: Operation not supported
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Zaurus 750(ARM), Socket CF BT, kernel 2.6.20.2, btsco 0.5 (show btsco v0.42)
Modules sco and snd-bt-sco loaded, alsamixer -c1 show BT Headset.
./btsco  -v    00:0F:DE:3E:AE:12
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
recieved AT*ECBP=?
recieved AT+CLIP=1
recieved AT+CSCS="UTF-8"
recieved AT+CLAN?                <-(here start mplayer -ao alsa:device=hw=1.0 music.mp3)
speaker volume: 3 mic volume: 1
i/o needed: connecting sco...
Can't connect SCO audio channel
: Operation not supported

I did the same on my notebook. It's work correct.
Can anybody help me?
Thanks in advance.
--
Sergey

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
