Return-Path: <cyrus@holtmann.org>
Message-ID: <efbc7ae90805271708t4b4b92c0j841b93f1217c727e@mail.gmail.com>
Date: Tue, 27 May 2008 17:08:29 -0700
From: "Milosh Milosavljevic" <milosh.milosavljevic@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Jabra JX10 Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0410766340=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0410766340==
Content-Type: multipart/alternative;
	boundary="----=_Part_7041_11233770.1211933309602"

------=_Part_7041_11233770.1211933309602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have Jabra JX10 BT headset. Used it successfully on Fedora 7 with btsco
and snd-bt-sco. Skype, Ekiga, TeamSpeak working flowlessly. When I tried
them on Fedora 9 it seems to connect and pair right-away but no sound. I
tried steps from your tutorial on bluez wiki. First to put device address
into .asoundrc without any profile, with "auto" profile, with "voice"
profile and none of it worked. I got device listed in Skype though.

pcm.bluetooth {
   type bluetooth
   device <my bt address>
}



Second I tried with python script. With that one I managed to connect and
pair my headset (got the popup to type PIN). When I called Play method I was
getting NotAvailable bluez exception.

import dbus
bus = dbus.SystemBus()
manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = manager.ActivateService('audio')
audio = dbus.Interface(bus.get_object(bus_id, '/org/bluez/audio'),
'org.bluez.audio.Manager')

path = audio.CreateHeadset('<my bt address>')
#audio.ChangeDefaultHeadset(path) #change the device to be used by default
headset = dbus.Interface (bus.get_object(bus_id, path),
'org.bluez.audio.Headset')
#Connect and Play are not required in PCM mode
headset.Connect()
headset.Play()


I also tried btsco. Got the latest version, compiled it and installed it.
Module snd_bt_sco loaded properly but I am getting the following exception:

btsco v0.5c
Error: control open (hw:1): No such file or directory
Error: Can't find device. Bail


Any help is greatly appreciated,
Milosh

------=_Part_7041_11233770.1211933309602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have Jabra JX10 BT headset. Used it successfully on Fedora 7 with btsco and snd-bt-sco. Skype, Ekiga, TeamSpeak working flowlessly. When I tried them on Fedora 9 it seems to connect and pair right-away but no sound. I tried steps from your tutorial on bluez wiki. First to put device address into .asoundrc without any profile, with &quot;auto&quot; profile, with &quot;voice&quot; profile and none of it worked. I got device listed in Skype though. <br>
<br><pre class="wiki">pcm.bluetooth {<br>   type bluetooth<br>   device &lt;my bt address&gt;<br>}<br></pre><br><br>Second I tried with python script. With that one I managed to connect and pair my headset (got the popup to type PIN). When I called Play method I was getting NotAvailable bluez exception. <br>
<br><pre>import dbus<br>bus = dbus.SystemBus()<br>manager = dbus.Interface(bus.get_object(&#39;org.bluez&#39;, &#39;/org/bluez&#39;), &#39;org.bluez.Manager&#39;)<br>bus_id = manager.ActivateService(&#39;audio&#39;)<br>audio = dbus.Interface(bus.get_object(bus_id, &#39;/org/bluez/audio&#39;), &#39;org.bluez.audio.Manager&#39;)<br>
<br>path = audio.CreateHeadset(&#39;&lt;my bt address&gt;&#39;)<br>#audio.ChangeDefaultHeadset(path) #change the device to be used by default<br>headset = dbus.Interface (bus.get_object(bus_id, path), &#39;org.bluez.audio.Headset&#39;)<br>
#Connect and Play are not required in PCM mode<br>headset.Connect()<br>headset.Play()<br></pre><br>I also tried btsco. Got the latest version, compiled it and installed it. Module snd_bt_sco loaded properly but I am getting the following exception:<br>
<br>btsco v0.5c<br>Error: control open (hw:1): No such file or directory<br>Error: Can&#39;t find device. Bail<br><br><br>Any help is greatly appreciated,<br>Milosh<br>

------=_Part_7041_11233770.1211933309602--


--===============0410766340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0410766340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0410766340==--
