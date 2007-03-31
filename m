Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a0eb67a90703311403x236db754ob26e7757096177cd@mail.gmail.com>
Date: Sun, 1 Apr 2007 00:03:11 +0300
From: Sander <yogizz@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Unable to pair PC with mobile phone
Reply-To: yogiz@hotmail.com, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0415087948=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0415087948==
Content-Type: multipart/alternative;
	boundary="----=_Part_44737_25838248.1175374991919"

------=_Part_44737_25838248.1175374991919
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 What I want is to get opensync and file transfers to work between my PC and

Sony Ericsson W810i. For that I need to get pairing work. All my current and

solved problems on this particular subject are documented in
http://www.linuxquestions.org/questions/showthread.php?t=536611
and you should probably read it through to get all the relevant information
but I'll try to add a little overview of what' the problem now.
The PC where I need the pairing to get to work is a desktopless computer
running Slackware 11.0 and now a 2.6.16.45 kernel. I installed latest dbus,
this time also dbus glibs, bluez-libs and bluez-utils. hcid works, I can
ping
the phone with l2ping, I just can't pair it. The phone sees PC but when it
tries to pair nothing happens on PC. I was suggested to use passkey-agent to

give a default pin to use (pin_helper in hcid.conf didn't work) but the
passkey-agent gives the error:

Can't register passkey agent
Method "RegisterDefaultPasskeyAgent" with signature "s" on
interface "org.bluez.Security" doesn't exist

bluetoothd which I had to start to get it even this far gives the error:

root@SERVER:/usr/src/bluez-utils-3.9/daemon#
/usr/src/bluez-utils-3.9/daemon/bluetoothd
--debug --nodaemon
bluetoothd[2179]: Bluetooth daemon ver 3.9
bluetoothd[2179]: Enabling debug information
bluetoothd[2179]: Could not become the primary owner of org.bluez

After that I ran out of ideas and I was suggested to try to find help from
this mailing list. To get all the relevant information you should probably
read the forum topic. Thanks in advance.

------=_Part_44737_25838248.1175374991919
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

	What I want is to get opensync and file transfers to work between my PC and <br>Sony Ericsson W810i. For that I need to get pairing work. All my current and <br>solved problems on this particular subject are documented in 
<br><a href="http://www.linuxquestions.org/questions/showthread.php?t=536611">http://www.linuxquestions.org/questions/showthread.php?t=536611</a><br>and you should probably read it through to get all the relevant information
<br>but I&#39;ll try to add a little overview of what&#39; the problem now.<br>The PC where I need the pairing to get to work is a desktopless computer <br>running Slackware 11.0 and now a <a href="http://2.6.16.45">2.6.16.45
</a> kernel. I installed latest dbus, <br>this time also dbus glibs, bluez-libs and bluez-utils. hcid works, I can ping <br>the phone with l2ping, I just can&#39;t pair it. The phone sees PC but when it <br>tries to pair nothing happens on PC. I was suggested to use passkey-agent to 
<br>give a default pin to use (pin_helper in hcid.conf didn&#39;t work) but the <br>passkey-agent gives the error: <br><br>Can&#39;t register passkey agent<br>Method &quot;RegisterDefaultPasskeyAgent&quot; with signature &quot;s&quot; on 
<br>interface &quot;org.bluez.Security&quot; doesn&#39;t exist<br><br>bluetoothd which I had to start to get it even this far gives the error:<br><br>root@SERVER:/usr/src/bluez-utils-3.9/daemon# /usr/src/bluez-utils-3.9/daemon/bluetoothd --debug --nodaemon
<br>bluetoothd[2179]: Bluetooth daemon ver 3.9<br>bluetoothd[2179]: Enabling debug information<br>bluetoothd[2179]: Could not become the primary owner of org.bluez<br><br>After that I ran out of ideas and I was suggested to try to find help from 
<br>this mailing list. To get all the relevant information you should probably <br>read the forum topic. Thanks in advance.<br><br><br>

------=_Part_44737_25838248.1175374991919--


--===============0415087948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0415087948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0415087948==--
