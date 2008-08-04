Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2008 14:41:06 +0800 (CST)
From: attaboyu <attaboyu@163.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <16515303.641251217832066401.JavaMail.coremail@bj163app113.163.com>
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth Headset (Only for MONO test)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0254104078=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0254104078==
Content-Type: multipart/alternative;
	boundary="----=_Part_169684_4588837.1217832066400"

------=_Part_169684_4588837.1217832066400
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 hi everyone

 I'm experimenting with the i-tech BlueBAND headset with bluez, this headset support HS,HF,A2DP and AVRCP profile, But for me, I only want to test the MONO for telephoning. it doesnt work well now.

toolchain: kernel 2.6.10, bluez-libs/utils-3.12, CSR BC4 UART interface
(the version of the toolchain is old, but I must work on that)

I will definitely test HeadSet profile, so btsco/snd-bt-sco are not included. and I use the hstest in bluez-utils. hcid,hciattach,sdpd are always work well.

when send audio to headset:

[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2 &
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
AT+VGS=11 
AT+CKPD=200
AT+CKPD=200
AT+CKPD=200
AT+VGS=12
AT+VGS=11
AT+VGS=10
AT+VGS=11
AT+VGS=12
AT+CKPD=200

Here the headset beeps (it does that everytime a connection is initiated) and I can hear only some noise through it. By pressing one of the buttons on the headset I even see the AT-comands which are submitteted via the rfcomm channel. But no audio. A hcidump during the connection procedure shows just a normal looking bunch of hci and acl commands and events, but no sco packets whatsoever.

here the SCO is connected
[root@root bin]$hcitool con
Connections:
        < SCO 00:0D:3C:E8:1A:AC handle 45 state 1 lm SLAVE 
        < ACL 00:0D:3C:E8:1A:AC handle 43 state 1 lm MASTER ENCRYPT 


Am I doing something wrong or missing a step? 



Thanks for your help and best regards

Tony

------=_Part_169684_4588837.1217832066400
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<div>&nbsp;hi everyone<br><br>&nbsp;I'm experimenting with the i-tech BlueBAND headset with bluez, this headset support HS,HF,A2DP and AVRCP profile, But for me, I only want to test the MONO for telephoning. it doesnt work well now.<br><br>toolchain: kernel 2.6.10, bluez-libs/utils-3.12, CSR BC4 UART interface<br>(the version of the toolchain is old, but I must work on that)<br><br>I will definitely test HeadSet profile, so btsco/snd-bt-sco are not included. and I use the hstest in bluez-utils. hcid,hciattach,sdpd are always work well.<br><br>when send audio to headset:<br><br>[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2 &amp;<br>Voice setting: 0x0060<br>RFCOMM channel connected<br>SCO audio channel connected (handle 45, mtu 64)<br>AT+VGS=11 <br>AT+CKPD=200<br>AT+CKPD=200<br>AT+CKPD=200<br>AT+VGS=12<br>AT+VGS=11<br>AT+VGS=10<br>AT+VGS=11<br>AT+VGS=12<br>AT+CKPD=200<br><br><tt>Here the headset beeps (it does that everytime a connection is initiated)  
</tt><tt>and I</tt> can hear only some noise through it. By pressing one of the buttons on the<tt> headset I even see the AT-comands which are submitteted via the rfcomm  
</tt><tt>channel.
</tt><tt>But no audio. </tt><tt>A hcidump during the connection procedure shows just a normal looking  
</tt><tt>bunch of</tt> hci and acl commands and events, but no sco packets whatsoever.<br><br>here the SCO is connected<br>[root@root bin]$hcitool con<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; SCO 00:0D:3C:E8:1A:AC handle 45 state 1 lm SLAVE <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:0D:3C:E8:1A:AC handle 43 state 1 lm MASTER ENCRYPT <br><br><pre style="margin: 0em;">Am I doing something wrong or missing a step? </pre><br><br><pre style="margin: 0em;">Thanks for your help and best regards<br></pre></div><div><div>Tony<br></div>
</div>
------=_Part_169684_4588837.1217832066400--



--===============0254104078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0254104078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0254104078==--
