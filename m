Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Waldram <andy@samuri.demon.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 01 Aug 2006 07:25:14 +0100
Message-Id: <1154413514.27192.8.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error
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

Hi guys ,

Sorry this is a bit noddy but I'm not a developer

the latest changes to a2pd plugin stop btsco compiling as your trying to
re-use variables.

Adding

bin_PROGRAMS = a2dpd
a2dpd_SOURCES = a2dpd.c a2dplib.c a2dp_timer.c a2dp_ipc.c
----->>>>> a2dpd_CFLAGS = $(AM_CFLAGS)

to the makefile.am in the pluggin filder will fix it by renaming the
variable timer and icp during compile time, 

it almost a no-op just fixes the compiler dont know if thats the right
way to do it though.

Also when I use XMMS with my HP bluetooth headphones then every time a
track finishes the the headphones stop (next also does this), but
alsaplayer is fine.

here is whats happening during skip

SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
Awaiting command
SBC Bandwidth = 26 kbps [27324 bps]
SBC Bandwidth = 26 kbps [27324 bps]
DEBUG: a2dp_stop: a2dp 0x82668d8
DEBUG: a2dp_stop: Listen thread terminating
Thread in signal handler 14
Error while receiving -1 (errno=4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x82668d8
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x82668d8
DEBUG: a2dp_close: OK
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:2A:5C:12
DEBUG: a2dp_constraint: TEST a2dp 0x82668d8
DEBUG: a2dp_params: a2dp 0x82668d8
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048
buffer_size 4096
DEBUG: a2dp_prepare: a2dp 0x82668d8
SBC Bandwidth = 19 kbps [19872 bps]
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [26703 bps]

Yet it doesn't start playing again , but restarting xmms start sound
again


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
