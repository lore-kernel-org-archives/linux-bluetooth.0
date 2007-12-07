Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <97aa57970712062200s630fac39ha145987f95741b5c@mail.gmail.com>
Date: Fri, 7 Dec 2007 14:00:33 +0800
From: "benson dong" <dongas86.bluez@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problems when playing bluetooth A2DP
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all
    I used aplay from alsa-utils to play audio through bluetooth A2DP
,but i could hear only a few seconds of the music from the headset
,then the audio ended and the "xrun" error happened. This error has
bothered me for several days .It's so hard to deal and now i think i
really need your help.If there's anyone who knows about this error and
how to get rid of it please tell me ,i would really appreciate your
help!

My board is arm920t and kernel is Montavista 2.6.18 .The alsa lib and
alsa utils vertion are 1.0.15.
Here is the configure parameter of bluez-utils 3.3.2
./configure --host=arm-9tdmi-linux-gnu
--prefix=/work/install/bluetooth1/ --enable-test --enable-usb
--enable-input --enable-obex --enable-serial --enable-initscripts
--enable-bccmd --enable-cups --disable-pcmia --enable-alsa
--enable-audio --enable-shared --enable-avctrl --enable-network
PKG_CONFIG=pkg-config


The error log is as follows:
/ # aplay -D bluetooth 1.wav
audio[320]: Accepted new client connection on unix socket (fd=8)
audio[320]: Package PKT_TYPE_CFG_REQ:0
audio[320]: avdtp_ref(0x2d9c8): ref=2
audio[320]: a2dp_source_request_stream: selected SEP 0x2d228
audio[320]: avdtp_ref(0x2d9c8): ref=3
hcid[313]: link_key_request (sba=11:11:11:11:11:11, dba=00:0D:3C:EB:53:F0)
audio[320]: AVDTP: connected signaling channel to 00:0D:3C:EB:53:F0
audio[320]: session_cb
audio[320]: DISCOVER request succeeded
audio[320]: seid 1 type 1 media 0 in use 0
audio[320]: seid 2 type 1 media 0 in use 0
audio[320]: session_cb
audio[320]: GET_CAPABILITIES request succeeded
audio[320]: seid 1 type 1 media 0
audio[320]: session_cb
audio[320]: GET_CAPABILITIES request succeeded
audio[320]: seid 2 type 1 media 0
audio[320]: Discovery complete
audio[320]: avdtp_set_configuration(0x2d9c8): int_seid=1, acp_seid=1
audio[320]: session_cb
audio[320]: SET_CONFIGURATION request succeeded
audio[320]: SBC Source: Set_Configuration_Cfm
audio[320]: avdtp_ref(0x2d9c8): ref=4
audio[320]: stream state changed: IDLE -> CONFIGURED
audio[320]: session_cb
audio[320]: OPEN request succeeded
audio[320]: stream state changed: CONFIGURED -> OPEN
audio[320]: AVCTP: connected to 00:0D:3C:EB:53:F0
input: i.Tech Clip Radio as /class/input/input1
audio[320]: AVRCP: uinput initialized for i.Tech Clip Radio
audio[320]: AVDTP: connected transport channel to 00:0D:3C:EB:53:F0
audio[320]: SBC Source: Open_Cfm
audio[320]: session_cb
audio[320]: START request succeeded
audio[320]: SBC Source: Start_Cfm
audio[320]: SBC Source SEP 0x2d228 locked
audio[320]: fd=11, fd_opt=1, pkt_len=672, sample_size=2, rate=44100
audio[320]: 34 bytes sent
audio[320]: 1 bytes sent
audio[320]: avdtp_unref(0x2d9c8): ref=3
audio[320]: stream state changed: OPEN -> STREAMING
Playing WAVE '1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: xrun:1094: read/write error, state = RUNNING
<-----------------xrun error here------------
audio[320]: Unix client disconnected (fd=8)
audio[320]: SBC Source SEP 0x2d228 unlocked
audio[320]: avdtp_unref(0x2d9c8): ref=2
/ # audio[320]: session_cb
audio[320]: SUSPEND request succeeded
audio[320]: stream state changed: STREAMING -> OPEN
audio[320]: SBC Source: Suspend_Cfm
audio[320]: session_cb
audio[320]: CLOSE request succeeded
audio[320]: stream state changed: OPEN -> CLOSING
audio[320]: SBC Source: Close_Cfm
audio[320]: stream state changed: CLOSING -> IDLE
audio[320]: avdtp_unref(0x2d9c8): ref=1
audio[320]: Disconnected from 00:0D:3C:EB:53:F0
audio[320]: avdtp_unref(0x2d9c8): ref=0
audio[320]: avdtp_unref(0x2d9c8): freeing session and removing from list

Best Regards!
Dongas

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
