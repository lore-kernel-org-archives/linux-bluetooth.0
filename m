Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <3ac7eec00611080250q726243c3g538aeadef0392ab3@mail.gmail.com>
Date: Wed, 8 Nov 2006 11:50:30 +0100
From: "Maik Barz" <barzille@googlemail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] MS Keyboard/Mouse NoFocus Behaviour on Kubuntu Edgy
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1967729741=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1967729741==
Content-Type: multipart/alternative;
	boundary="----=_Part_28261_767991.1162983030346"

------=_Part_28261_767991.1162983030346
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,
I changed from Suse 10.1 to Kubuntu 6.10 Edgy because my Mouse-Wheel worked
properly on that distribution. I tried several ways on Suse but none worked.

Manual installation on Kubuntu with hcitool scan, hcitool cc and hidd
--search was no problem. The only thing was that I had to do this everytime
I rebooted.

So I changed my /etc/default/bluetooth file with this

############ HIDD
#
# To have Bluetooth mouse and keyboard support, get the
# Linux 2.6.6 patch or better from bluez.org, and set
# HIDD_ENABLED to 1.
HIDD_ENABLED=1    <----- I set this to 1
HIDD_OPTIONS="--master --server"
# to make hidd always use a particular interface, use something
# like this, substituting the bdaddr of the interface:
# HIDD_OPTIONS="-i AA:BB:CC:DD:EE:FF --server"
 HIDD_OPTIONS="-i 00:0D:3A:A2:F4:1C  --server"   <--- I set this for my
keyboard
 HIDD_OPTIONS="-i 00:0D:3A:A3:D7:38 --server"   <--- and this for my Mouse


After that I restarted bluetooth via /etc/init.d/bluetooth restart and had
my input devices working... But only for short time because now ther comes
my problem:

Sometimes I get no Focus on some Windows.... I can click and click and click
and nothing happens. With luck something happens if I click randomly my
mousebuttons. This is very frustrating and I dont know where I should start
to look for. I post my xorg.conf but I think that it's correct:

Section "InputDevice"
    Identifier     "Generic Keyboard"
    Driver         "kbd"
    Option         "CoreKeyboard"
    Option         "XkbRules" "xorg"
    Option         "XkbModel" "pc105"
    Option         "XkbLayout" "de"
    Option         "XkbOptions" "lv3:ralt_switch"
    Option       "XkbVariant"    "nodeadkeys"
EndSection

Section "InputDevice"
    Identifier     "Configured Mouse"
    Driver         "mouse"
    Option         "CorePointer"
    Option         "Buttons" "7"
    Option         "Device" "/dev/input/mice"
    Option         "Protocol" "ExplorerPS/2"
    Option         "ZAxisMapping" "4 5"
    Option         "Emulate3Buttons" "true"
EndSection

My Kernel version is: 2.6.17-10-generic

I hope that anybody has an idea and will share it with me.... Thanks

Maik

-- 
Maik Barz

Wilhelmplatz 4 - 24116 Kiel

www.Barzille.de

------=_Part_28261_767991.1162983030346
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,<br>I changed from Suse 10.1 to Kubuntu 6.10 Edgy because my Mouse-Wheel worked properly on that distribution. I tried several ways on Suse but none worked.<br><br>Manual installation on Kubuntu with hcitool scan, hcitool cc and hidd --search was no problem. The only thing was that I had to do this everytime I rebooted.
<br><br>So I changed my /etc/default/bluetooth file with this<br><br>############ HIDD<br>#<br># To have Bluetooth mouse and keyboard support, get the<br># Linux 2.6.6 patch or better from <a href="http://bluez.org">bluez.org
</a>, and set <br># HIDD_ENABLED to 1.<br>HIDD_ENABLED=1&nbsp;&nbsp;&nbsp; &lt;----- I set this to 1<br>HIDD_OPTIONS=&quot;--master --server&quot;<br># to make hidd always use a particular interface, use something<br># like this, substituting the bdaddr of the interface:
<br># HIDD_OPTIONS=&quot;-i AA:BB:CC:DD:EE:FF --server&quot;<br>&nbsp;HIDD_OPTIONS=&quot;-i 00:0D:3A:A2:F4:1C&nbsp; --server&quot;&nbsp;&nbsp; &lt;--- I set this for my keyboard<br>&nbsp;HIDD_OPTIONS=&quot;-i 00:0D:3A:A3:D7:38 --server&quot;&nbsp;&nbsp; &lt;--- and this for my Mouse
<br><br><br>After that I restarted bluetooth via /etc/init.d/bluetooth restart and had my input devices working... But only for short time because now ther comes my problem:<br><br>Sometimes I get no Focus on some Windows.... I can click and click and click and nothing happens. With luck something happens if I click randomly my mousebuttons. This is very frustrating and I dont know where I should start to look for. I post my 
xorg.conf but I think that it's correct:<br><br>Section &quot;InputDevice&quot;<br>&nbsp;&nbsp;&nbsp; Identifier&nbsp;&nbsp;&nbsp;&nbsp; &quot;Generic Keyboard&quot;<br>&nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;kbd&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;CoreKeyboard&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XkbRules&quot; &quot;xorg&quot;
<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XkbModel&quot; &quot;pc105&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XkbLayout&quot; &quot;de&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XkbOptions&quot; &quot;lv3:ralt_switch&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &quot;XkbVariant&quot;&nbsp;&nbsp;&nbsp; &quot;nodeadkeys&quot;
<br>EndSection<br><br>Section &quot;InputDevice&quot;<br>&nbsp;&nbsp;&nbsp; Identifier&nbsp;&nbsp;&nbsp;&nbsp; &quot;Configured Mouse&quot;<br>&nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;mouse&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;CorePointer&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Buttons&quot; &quot;7&quot;
<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Device&quot; &quot;/dev/input/mice&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Protocol&quot; &quot;ExplorerPS/2&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ZAxisMapping&quot; &quot;4 5&quot;<br>&nbsp;&nbsp;&nbsp; Option&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Emulate3Buttons&quot; &quot;true&quot;
<br>EndSection<br><br>My Kernel version is: 2.6.17-10-generic<br><br>I hope that anybody has an idea and will share it with me.... Thanks<br><br>Maik<br clear="all"><br>-- <br>Maik Barz<br><br>Wilhelmplatz 4 - 24116 Kiel<br>
<br><a href="http://www.Barzille.de">www.Barzille.de</a>

------=_Part_28261_767991.1162983030346--


--===============1967729741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1967729741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1967729741==--
