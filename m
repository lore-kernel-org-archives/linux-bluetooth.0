Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
To: bluez-users@lists.sourceforge.net
Message-Id: <05E769BE-BEE2-4902-A32F-7EF9BEC311A9@shirishranjit.com>
Content-Type: multipart/alternative; boundary=Apple-Mail-1--572059659
References: <CD1B5315-1B8A-41E0-9D9B-766B3D59634E@shirishranjit.com>
From: Shirish Ranjit <shirish.ranjit@shirishranjit.com>
Subject: [Bluez-users] loosing connection to local bluetooth device
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
Date: Sat, 7 Jan 2006 10:48:50 -0500


--Apple-Mail-1--572059659
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I am working on bluetooth devices on a debian linux installed in hp  
pavilion
ze5460us machine.  I have a usb bluetooth dongle Actiontec BTM200B  
that I use
for working with bluetooth devices. I am working on learning bluetooth
programming with python with pybluez. However, the usb dongle seems to
disapper after once I do the query such as bluetooth.discover_devices().

I run the program once and then I have to reboot my debian linux to  
run the
program again. Once the dicover_devices() call fails, I try to to the  
hcitool scan and it
says time out.

I have the latest debian linux installed through network install a  
week ago.
Following is the output from the uname

uname -a
Linux ranlinux 2.4.27-2-386 #1 Wed Aug 17 09:33:35 UTC 2005 i686 GNU/ 
Linux


Following is the error  from the bluetooth call

performing inquiry...
Traceback (most recent call last):
     nearby_devices = bluetooth.discover_devices()
   File "/usr/local/lib/python2.3/site-packages/bluetooth.py", line  
172, in
discover_devices
     raise BluetoothError("error communicating with local bluetooth  
device")
bluetooth.BluetoothError: error communicating with local bluetooth  
device
----

This is the output from the hciconfig -a

ranlinux:/home/sranjit# hciconfig -a
hci0:   Type: USB
         BD Address: 00:20:E0:CC:2B:8D ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1570 acl:0 sco:0 events:41 errors:0
         TX bytes:409 acl:0 sco:0 commands:30 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out (110)

!DSPAM:43b86354198356491211187!

Regards,

Shirish Ranjit




--Apple-Mail-1--572059659
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV><BLOCKQUOTE =
type=3D"cite"><BLOCKQUOTE type=3D"cite"><BLOCKQUOTE =
type=3D"cite"></BLOCKQUOTE></BLOCKQUOTE></BLOCKQUOTE></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#550000">I =
am working on bluetooth devices on a debian linux installed in hp =
pavilion</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">ze5460us machine.</FONT><FONT class=3D"Apple-style-span"=
 color=3D"#550000">=A0 </FONT><FONT class=3D"Apple-style-span" =
color=3D"#550000">I have a usb bluetooth dongle Actiontec BTM200B that I =
use</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">for working with bluetooth devices. I am working on =
learning bluetooth</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">programming with python =
with pybluez. However, the usb dongle seems to</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">disapper after once I do the query such as =
bluetooth.discover_devices().</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#550000">I =
run the program once and then I have to reboot my debian linux to run =
the</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">program again. Once the dicover_devices() call fails, =
I try to to the hcitool scan and it</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">says time =
out.</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#550000">I =
have the latest debian linux installed through network install a week =
ago.</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">Following is the output from the =
uname</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">uname -a</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">Linux ranlinux 2.4.27-2-386 =
#1 Wed Aug 17 09:33:35 UTC 2005 i686 GNU/Linux</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000"><BR></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">Following is the error</FONT><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 </FONT><FONT =
class=3D"Apple-style-span" color=3D"#550000">from the bluetooth =
call</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">performing inquiry...</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">Traceback (most recent call last):</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#550000">=A0=
 =A0 </FONT><FONT class=3D"Apple-style-span" =
color=3D"#550000">nearby_devices =3D =
bluetooth.discover_devices()</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 </FONT><FONT =
class=3D"Apple-style-span" color=3D"#550000">File =
"/usr/local/lib/python2.3/site-packages/bluetooth.py", line 172, =
in</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">discover_devices</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 </FONT><FONT =
class=3D"Apple-style-span" color=3D"#550000">raise BluetoothError("error =
communicating with local bluetooth device")</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">bluetooth.BluetoothError: error communicating with =
local bluetooth device</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">----</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000"><BR></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">This is the output from the =
hciconfig -a</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">ranlinux:/home/sranjit# hciconfig -a</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">hci0: </FONT><FONT class=3D"Apple-style-span" =
color=3D"#550000">=A0 </FONT><FONT class=3D"Apple-style-span" =
color=3D"#550000">Type: USB</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">BD Address: =
00:20:E0:CC:2B:8D ACL MTU: 192:8 SCO MTU: 64:8</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#550000">=A0=
 =A0 =A0 =A0 </FONT><FONT class=3D"Apple-style-span" color=3D"#550000">UP =
RUNNING PSCAN ISCAN</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">RX bytes:1570 =
acl:0 sco:0 events:41 errors:0</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">TX bytes:409 =
acl:0 sco:0 commands:30 errors:0</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">Features: 0xff =
0xff 0x0f 0x00 0x00 0x00 0x00 0x00</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">Packet type: =
DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">Link policy: =
RSWITCH HOLD SNIFF PARK</FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">=A0 =A0 =A0 =A0 =
</FONT><FONT class=3D"Apple-style-span" color=3D"#550000">Link mode: =
SLAVE ACCEPT</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000">Can't read local name on =
hci0: Connection timed out (110)</FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: =
normal normal normal 12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#550000"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000">!DSPAM:43b86354198356491211187!</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><FONT class=3D"Apple-style-span" =
color=3D"#550000"><BR></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#0000DF">Regards,</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><FONT class=3D"Apple-style-span" =
color=3D"#0000DF"><BR></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#0000DF">Shirish =
Ranjit</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><FONT =
class=3D"Apple-style-span" color=3D"#0000DF"><BR></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><BR =
class=3D"khtml-block-placeholder"></DIV></BODY></HTML>=

--Apple-Mail-1--572059659--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
