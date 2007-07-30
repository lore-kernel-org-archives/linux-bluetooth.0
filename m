Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46AE7340.4010603@gmail.com>
Date: Mon, 30 Jul 2007 20:24:48 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] a2dp, sco and kernel version
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello guys,

After a long time without trying my headset under linux. Yesterday I 
grabbed the last plugz and sbc as told here: 
http://bluetooth-alsa.sourceforge.net/build.html with this and by using 
Mandriva 2007.1 with kernel: 2.6.17-13mdv I got a much more improved 
quality audio when using a2dp. Now I really get sound in HiFi.

Then as I was enthusiastic I wanted to test the headsetd daemon, but I 
can't get it to work. When running from mplayer I get this error:
alsa-lib: pcm_sco.c:277:(sco_headset_hw_params) Unable to set number of 
SCO buffers : please upgrade your Kernel !

So as I'm used to this stuff I downloaded the latest kernel I got 2.6.22 
patched by mandriva, I compiled but now It's not only sco the one that's 
not working, even a2dpd works awfully no, it sounds crappy and 
disconnects from the headset all the time. Same happens when I compile a 
vanilla 2.6.22-1 kernel.

Finally I compiled snd-bt-sco in my original kernel (2.6.17-13mdv) and I 
got sco working. But with a very low quality of audio. So my question 
is... How should I update my kernel?

Cheers,
Manuel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
