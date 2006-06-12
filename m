Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 12 Jun 2006 23:38:55 +0200
Message-Id: <1150148335.7372.7.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,
I try to play mp3 with my headphones but I get some errors.
you give me a little help?

Both versions written in the README won't work.

Johannes



johannes@johannes_01:~/btsco> mpg123 --au - Din_Tei.mp3 | ./a2play
00:0A:94:A0:59:3b
subbands = 8 blocks = 16 bitpool = 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
Title  : Dragostea Din Tei               Artist: Haiducii
Album  :                                 Year  : 2004
Comment: I&T okay                        Genre : Blues

Playing MPEG stream from Din_Tei.mp3 ...
MPEG 1.0 layer III, 192 kbit/s, 44100 Hz stereo
len=2048
Header size=28
Sample Rate:44100
Channels:2
Using address: 00:0A:94:A0:59:3b
Found A2DP Sink
Found A2DP Sink at the destination
Can't connect to 3B:59:A0:94:0A:00. Connection refused(111)
cannot open psm_cmd = 25




johannes@johannes_01:~/btsco> mpg123 --au - Din_Tei.mp3 | sbc/sbcenc -
| ./sbc/rcplay 00:0A:94:A0:59:3b -
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
Title  : Dragostea Din Tei               Artist: Haiducii
Album  :                                 Year  : 2004
Comment: I&T okay                        Genre : Blues

Playing MPEG stream from Din_Tei.mp3 ...
MPEG 1.0 layer III, 192 kbit/s, 44100 Hz stereo
Can't get channel number: Success
johannes@johannes_01:~/btsco>









_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
