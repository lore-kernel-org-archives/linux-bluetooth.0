Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: snik1 <mathias@mammoth.se>
To: bluez-users@lists.sourceforge.net
Cc: mathias@mammoth.se
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_LFc5BuXWmBg3KKy"
Message-Id: <200501130131.07302.mathias@mammoth.se>
Subject: [Bluez-users] Apple BT connection problem
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
Date: Thu, 13 Jan 2005 01:31:06 +0100

--Boundary-00=_LFc5BuXWmBg3KKy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,
I've searched the archive but didn't really hit the spot there... ...so I 
guess I need some help.

I'm running SuSE9.2 and trying to connect a Apple BT keyboard and mouse, this 
what's happends:

1, If I reset the mouse and keyboard and do a server side connect it works 
just fine. After I changed to "lm master" in hcid.conf I also could reconnect 
after a sleep without a problem, so far so good, see the output.
"keyboard reset (off/on)"
# hidd --connect 00:0A:95:3B:1B:6E

New HID device 00:0A:95:3B:1B:6E (Apple Wireless Keyboard)
Jan 12 22:30:57 linux kernel: evdev_connect: evdev cddd3b40 handle cddd3b5c 
name event3

# hcitool con
Connections:
        lt; ACL 00:0A:95:3B:1B:6E handle 41 state 1 lm MASTER

hidd --show
00:0A:95:3B:1B:6E HID Boot Device [05ac:0209] connected [boot-protocol]




2, Now, if I reboot or some how looses the connection and then initiate the 
connection from the keyboard or mouse the following happends:

Keaboard reset (on/off)
(tap keaboard)
# hcitool con
Connections:
        > ACL 00:0A:95:3B:1B:6E handle 42 state 1 lm MASTER
# hidd --show
<nothing>

output from messages
Jan 12 22:29:10 linux hidd[7815]: New HID device 00:0A:95:3B:1B:6E (Apple 
Wireless Keyboard)
Jan 12 22:29:10 linux hidd[7815]: HID create error 25 (Inappropriate ioctl for 
device)

And when I try to connect from the server side:
# hidd --connect 00:0A:95:3B:1B:6E
Can't create HID control channel: Device or resource busy

# hidd --connect 00:0A:95:3B:1B:6E
Can't create HID control channel: Connection refused

And the log shows:
Jan 12 22:36:35 linux hcid[7808]: link_key_request (sba=00:0F:3D:39:02:19, 
dba=00:0A:95:3B:1B:6E)
Jan 12 22:36:35 linux kernel: hci_acldata_packet: hci0 ACL packet for unknown 
connection handle 42


The only way to get it to work again is to reset the keyboard and mouse and 
connect from the serverside. This means it always fail after a reboot.

Can anyone give me a pointer in right direction...?!

regards
Mathias


--Boundary-00=_LFc5BuXWmBg3KKy
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Sans Serif">
<p></p>
<p>Hi,</p>
<p>I've searched the archive but didn't really hit the spot there... ...so I guess I need some help.</p>
<p></p>
<p>I'm running SuSE9.2 and trying to connect a Apple BT keyboard and mouse, this what's happends:</p>
<p></p>
<p>1, If I reset the mouse and keyboard and do a server side connect it works just fine. After I changed to &quot;lm master&quot; in hcid.conf I also could reconnect after a sleep without a problem, so far so good, see the output.</p>
<p>&quot;keyboard reset (off/on)&quot;</p>
<p># hidd --connect 00:0A:95:3B:1B:6E</p>
<p></p>
<p>New HID device 00:0A:95:3B:1B:6E (Apple Wireless Keyboard)</p>
<p>Jan 12 22:30:57 linux kernel: evdev_connect: evdev cddd3b40 handle cddd3b5c name event3</p>
<p></p>
<p># hcitool con</p>
<p>Connections:</p>
<p>        lt; ACL 00:0A:95:3B:1B:6E handle 41 state 1 lm MASTER</p>
<p></p>
<p>hidd --show</p>
<p>00:0A:95:3B:1B:6E HID Boot Device [05ac:0209] connected [boot-protocol]</p>
<p></p>
<p></p>
<p></p>
<p></p>
<p>2, Now, if I reboot or some how looses the connection and then initiate the connection from the keyboard or mouse the following happends:</p>
<p></p>
<p>Keaboard reset (on/off)</p>
<p>(tap keaboard)</p>
<p># hcitool con</p>
<p>Connections:</p>
<p>        &gt; ACL 00:0A:95:3B:1B:6E handle 42 state 1 lm MASTER</p>
<p># hidd --show</p>
<p>&lt;nothing&gt;</p>
<p></p>
<p>output from messages</p>
<p>Jan 12 22:29:10 linux hidd[7815]: New HID device 00:0A:95:3B:1B:6E (Apple Wireless Keyboard)</p>
<p>Jan 12 22:29:10 linux hidd[7815]: HID create error 25 (Inappropriate ioctl for device)</p>
<p></p>
<p>And when I try to connect from the server side:</p>
<p># hidd --connect 00:0A:95:3B:1B:6E</p>
<p>Can't create HID control channel: Device or resource busy</p>
<p></p>
<p># hidd --connect 00:0A:95:3B:1B:6E</p>
<p>Can't create HID control channel: Connection refused</p>
<p></p>
<p>And the log shows:</p>
<p>Jan 12 22:36:35 linux hcid[7808]: link_key_request (sba=00:0F:3D:39:02:19, dba=00:0A:95:3B:1B:6E)</p>
<p>Jan 12 22:36:35 linux kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 42</p>
<p></p>
<p></p>
<p>The only way to get it to work again is to reset the keyboard and mouse and connect from the serverside. This means it always fail after a reboot.</p>
<p></p>
<p>Can anyone give me a pointer in right direction...?!</p>
<p></p>
<p>regards</p>
<p>Mathias</p>
<p></p>
<p></p>
</body></html>
--Boundary-00=_LFc5BuXWmBg3KKy--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
