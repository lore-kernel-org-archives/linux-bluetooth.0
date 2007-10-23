Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <OF8924A15A.C478BABF-ON4825737A.000A932C@mxic.com.cn>
References: <OF8924A15A.C478BABF-ON4825737A.000A932C@mxic.com.cn>
Message-Id: <2D887441-23BB-4560-AEA4-BF0C9EC23B8C@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Tue, 23 Oct 2007 10:13:08 +0300
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth headset not working
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

(resending since the first try seems to have gotten stuck somewhere  
between gmail and sourceforge)

On Oct 20, 2007, at 5:10, KyoYin@mxic.com.cn wrote:
>       Do u mean the bluetoothd-service-audio will read .asoundrc?

No. The values in .asoundrc are given to the bluetooth alsa plugin  
which then passes them over to the audio service using a unix socket.

>       could you tell me how to write .asoundrc if i want to use  
> a2dp and
> hsp.now my .asoundrc is:
>
>       pcm.headset {
>       type bluetooth
>       }
>
>       ctl.headset {
>       type bluetooth
>       }
>
>       pcm.bluetooth {
>       type bluetooth
>       device 00:0D:3C:EB:53:F0
>       }

If you want to have one alsa device for A2DP and another for HSP it  
might be a good idea to explicitly state the profile you want to use  
for each device. You do this by providing a line such as "profile  
a2dp" in addition to the device and type lines. I just checked the  
code and the plugin will map "hifi" and "a2dp" to A2DP and "voice"  
and "hfp" to HSP (it's actually a bug that it doesn't recognize "hsp").

> when i use  "aplay -D bluetooth -f S16_LE /1.wav ",i will get the  
> following
> error.
<snip>
> audio[837]: START request succAlignment trap: bluetoothd-serv (837)
> PC=0x0001ce50 Instr=0xe1c320b0 Address=0xbe871a89 FSR 0x813
> eeded
> audio[837]: SBC Source: Start_Cfm
> audio[837]: SBC Source SEP 0x376b8 locked
> hcid[825]: Service owner exited: :1.1

Looks like the audio service crashed. What architecture are you  
running this on and what compiler did you use? It would be good if  
you could try to reproduce this by running bluetoothd-audio-service  
through valgrind or gdb and get a proper backtrace of the crash. To  
do this remove the /etc/bluetooth/audio.service file (hcid should  
detect this and unregister the service but if it doesn't you need to  
restart hcid), and run "/usr/lib/bluetooth/bluetoothd-service-audio - 
s" either through gdb or valgrind.

Johan


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
