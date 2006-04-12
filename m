Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <443D4707.80402@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] error when loading snd-bt-sco
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
Date: Wed, 12 Apr 2006 14:29:27 -0400

I have downloaded 2.6.16.4, compiled and installed it, rebooted. ( I am 
using centos 4.3)

I downloaded alsa-project.org 1.0.11rc5, compiled and installed it. 
Sound works on my machine.
I downloaded bluetooth-alsa.sourceforge.net and compiled and installed 
snd-bt-sco kernel module.
When I modprobe snd-bt-sco it says:

Error inserting snd_bt_sco  (/lib/modules/2.6.16.4/extra/snd-bt-sco.ko) 
Unknown symbol in module. see dmesg

the output from dmesg gives:
snd_bt_sco: disagrees about version of symbol snd_ctl_add
snd_bt_sco: Unknown symbol snd_ctl_add
snd_bt_sco: disagrees about version of symbol snd_pcm_new
snd_bt_sco: Unknown symbol snd_pcm_new
snd_bt_sco: disagrees about version of symbol snd_card_register
snd_bt_sco: Unknown symbol snd_card_register
snd_bt_sco: disagrees about version of symbol snd_card_free
snd_bt_sco: Unknown symbol snd_card_free
snd_bt_sco: disagrees about version of symbol snd_ctl_new1
snd_bt_sco: Unknown symbol snd_ctl_new1
snd_bt_sco: disagrees about version of symbol snd_card_new
snd_bt_sco: Unknown symbol snd_card_new
snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl
snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl
snd_bt_sco: disagrees about version of symbol snd_hwdep_new
snd_bt_sco: Unknown symbol snd_hwdep_new
snd_bt_sco: disagrees about version of symbol snd_ctl_notify
snd_bt_sco: Unknown symbol snd_ctl_notify
snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops
snd_bt_sco: Unknown symbol snd_pcm_set_ops
snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed
snd_bt_sco: Unknown symbol snd_pcm_period_elapsed

What have I not down correctly... Thanks,

Jerry



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
