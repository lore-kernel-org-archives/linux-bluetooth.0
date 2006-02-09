Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602081716t42384957x29919cf5f913ec83@mail.gmail.com>
From: John McCabe-Dansted <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] rmmoding snd-bt-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 9 Feb 2006 14:16:39 +1300

Is there anyway to rmmod snd-bt-sco when it claims that it is in use?
(So e.g. I can hibernate). I have tried killall btsco and physically
removing the usb bluetooth card but the kernel still claims it is in
use.

running
    lsmod | grep snd-bt-sco
gives me

snd_bt_sco             15916  1
snd_pcm                91144  4
snd_intel8x0,snd_ac97_codec,snd_bt_sco,snd_pcm_oss
snd_hwdep               9760  1 snd_bt_sco
snd                    55908  12
snd_intel8x0,snd_ac97_codec,snd_bt_sco,snd_pcm_oss,snd_mixer_oss,snd_pcm,sn=
d_timer,snd_hwdep
snd_page_alloc         10760  3 snd_intel8x0,snd_bt_sco,snd_pcm

So snd_bt_sco is using other modules, but I cannot see why the kernel
thinks snd_bt_sco is in use.

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
