Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5a55627a0707121343h693e2f62q5dab9c6ab0645c58@mail.gmail.com>
Date: Thu, 12 Jul 2007 15:43:51 -0500
From: "Mirza Baig" <ambaig@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Alsa lib pcm.c2109 (snd_pcm_open_conf) cannot
	open shared library
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1619186983=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1619186983==
Content-Type: multipart/alternative;
	boundary="----=_Part_25073_21506189.1184273031089"

------=_Part_25073_21506189.1184273031089
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to bring up Bluez on an ARM embeded Linux 2.6.14 system. I get
the following message when I try to run 'aplay mp3 file'

Alsa lib pcm.c2109(snd_pcm_open_conf) Cannot open shared library
/arm-bin/rel/host/lib/alsa-lib/libasound_module_pcm_a2dpd.so
aplay: main:510: audio open error: no such file or directory.

start dbus-daemon
start hcid
start passkey-agent
create connection with BT stereo headset
start a2dpd server

aplay *.mp3

Regards

Mirza

------=_Part_25073_21506189.1184273031089
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to bring up Bluez on an ARM embeded Linux 2.6.14 system. I get the following message when I try to run &#39;aplay mp3 file&#39;<br><br>Alsa lib pcm.c2109(snd_pcm_open_conf) Cannot open shared library /arm-bin/rel/host/lib/alsa-lib/libasound_module_pcm_a2dpd.so 
<br>aplay: main:510: audio open error: no such file or directory.<br><br>start dbus-daemon<br>start hcid<br>start passkey-agent<br>create connection with BT stereo headset<br>start a2dpd server<br><br>aplay *.mp3<br><br>Regards
<br><br>Mirza<br>

------=_Part_25073_21506189.1184273031089--


--===============1619186983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1619186983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1619186983==--
