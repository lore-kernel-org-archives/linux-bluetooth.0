Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <38687c4a0711150553u51f761f4l87d53bcdf3aef910@mail.gmail.com>
Date: Thu, 15 Nov 2007 14:53:33 +0100
From: "Daniele Primon" <ledebass@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluez and headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0098927378=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0098927378==
Content-Type: multipart/alternative;
	boundary="----=_Part_5512_33474506.1195134813707"

------=_Part_5512_33474506.1195134813707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list. I'm moving first steps with bluez to pair a Nokia BH-100 Cell
phone to use it with VoIP application such as Skype. I'm a Debian user but
at the moment I'm configuring it on Ubuntu Gutsy. Kernel version is
2.6.20-16-generic which include standard bluez support and also has
snd-bt-sco module. The distro comes witch bluez-btsco package at version
0.50 and bluez-utils, at version 3.19. Following the wiki instructions  (
http://wiki.bluez.org/wiki/HOWTO/AudioDevices) pertaining to my utils
version lead me to pair the device. I've tested with aplay -dbluetooth
somefile.wav as indicated but heared only noise. Moreover, wengophone nor
alsamixer detects the device leaving my stuck at it.
Do I have miseed something?
So I tried with the 'old' way, by loading snd-bt-sco module and using the
btsco app, i've been able to have aplay and wengophone work as expected  but
yet still missing mixing. That way would be sufficient to me but I realized
that the btsco has to be restarted if the handset device becomes
unavailable. I think that it should be quite easy to have it started
automatically upon need (and maybe the kernel module reloaded too) - i.e.
when the handset becomes available again. Where should I look for this?
Thanks,
 Daniele Primon

------=_Part_5512_33474506.1195134813707
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list. I&#39;m moving first steps with bluez to pair a Nokia BH-100 Cell phone to use it with VoIP application such as Skype. I&#39;m a Debian user but at the moment I&#39;m configuring it on Ubuntu Gutsy. Kernel version is 
2.6.20-16-generic which include standard bluez support and also has snd-bt-sco module. The distro comes witch bluez-btsco package at version 0.50 and bluez-utils, at version 3.19. Following the wiki instructions&nbsp; (<a href="http://wiki.bluez.org/wiki/HOWTO/AudioDevices">
http://wiki.bluez.org/wiki/HOWTO/AudioDevices</a>) pertaining to my utils version lead me to pair the device. I&#39;ve tested with aplay -dbluetooth somefile.wav as indicated but heared only noise. Moreover, wengophone nor alsamixer detects the device leaving my stuck at it.
<br>Do I have miseed something?<br>So I tried with the &#39;old&#39; way, by loading snd-bt-sco module and using the btsco app, i&#39;ve been able to have aplay and wengophone work as expected&nbsp; but yet still missing mixing. That way would be sufficient to me but I realized that the btsco has to be restarted if the handset device becomes unavailable. I think that it should be quite easy to have it started automatically upon need (and maybe the kernel module reloaded too) - 
i.e. when the handset becomes available again. Where should I look for this?<br>Thanks, <br>&nbsp;Daniele Primon<br><br>

------=_Part_5512_33474506.1195134813707--


--===============0098927378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0098927378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0098927378==--
