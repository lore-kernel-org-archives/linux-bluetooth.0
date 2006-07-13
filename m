Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 01:42:40 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060713004239.GA17607@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] A2DP plugin success with HP bluetooth headphones
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

Hi,

I've finally got around to retesting my HP bluetooth headphones with the 
latest alsa-plugin code. They work almost perfectly, though with 
occasional brief audio dropouts. There doesn't seem to be any good 
pattern to these. Is there a good way of diagnosing what the problem 
might be?

Also, hitting "stop" in beep-media-player (using the alsa output plugin) 
seems to make things unhappy - the next time I hit play, everything 
looks normal, I get plenty of "SBC Bandwidth =" messages and no audio 
appears. The log from hitting stop is:

DEBUG: a2dp_stop: a2dp 0x838bd70
DEBUG: a2dp_stop: Listen thread terminating
Thread in signal handler 14
Error while receiving -1 (errno=4:Interrupted system call)
listen_thread: ending perfeclty
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_stop: a2dp 0x838bd70
DEBUG: a2dp_stop: Listen thread terminating
DEBUG: a2dp_stop: Listen thread terminated
DEBUG: a2dp_stop: OK
DEBUG: a2dp_close: a2dp Destroying 0x838bd70
DEBUG: a2dp_close: OK
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:2A:14:66
DEBUG: a2dp_constraint: TEST a2dp 0x838bd70
DEBUG: a2dp_params: a2dp 0x838bd70
DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048 
buffer_size 4096
DEBUG: a2dp_prepare: a2dp 0x838bd70
DEBUG: a2dp_prepare: a2dp 0x838bd70
SBC Bandwidth = 10 kbps [10557 bps]
DEBUG: a2dp_start: a2dp 0x838bd70
SBC Bandwidth = 26 kbps [26703 bps]
SBC Bandwidth = 26 kbps [26703 bps]

and so on. Restarting the player seems to clear things up some of the 
time, but other times it simply hangs at the connect stream state with 
"Host is down" (plainly not true - the light is on and it's beeping at 
me in an irritating way). Trying again after that seems to result in 
"retrying sdp connect: File descriptor in bad state". Power cycling the 
headphones seems to make things happy.

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
