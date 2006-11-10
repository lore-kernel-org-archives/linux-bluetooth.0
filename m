Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d7dffb480611100605k76213ee2sf5da832c3ac31d6b@mail.gmail.com>
Date: Fri, 10 Nov 2006 19:35:27 +0530
From: "VANatFortuna amarnath" <van.bluez.list@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        christian.mager@gmail.com
In-Reply-To: <454B3AD7.7080401@gmail.com>
MIME-Version: 1.0
References: <454B3AD7.7080401@gmail.com>
Subject: Re: [Bluez-devel] bluetooth-alsa and HAMA BTH-155
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1046370077=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1046370077==
Content-Type: multipart/alternative;
	boundary="----=_Part_73185_8799893.1163167527736"

------=_Part_73185_8799893.1163167527736
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Christian !
    I am vey new to BlueZ and even bluetooth. I am trying to configure
bluetooth headset to 'skype' to make calls. and i downloaded both 'alsa
project' and 'btsco' and i followed as per the instruction. and even
bt-utils(3.7).

  But while running
      #btsco <my headset addr>
  i am facing the same proble what u faced.
-------------------
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied
--------------------------------

i am not able to solve this problem , can u help me how could you solve
this.

Thanx in adwance.
Amarnath
On 11/3/06, Christian Mager <christian.mager@gmail.com> wrote:
>
> Hello,
>
> I followed the instructions of bluetooth-alsa.sf.net to get my bt
> headset work but pairing doesn't work so far. snd_bt_sco is loaded and
> when I run btsco I get the following output:
>
> $ btsco -v 00:13:8A:04:A3:43
> btsco v0.42
> Device is 1:0
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
>
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Permission denied
>
> Yes, I have restarted /etc/init.d/bluez-utils. I also started btsco as
> root but same result. Pairing the headset with my cell phone works, but
> it asks for a pin, btsco desn't. Could this cause the problem? In
> /etc/blueooth/hci.conf there is 'pin_helper /usr/bin/bluez-pin;' and 'lm
> accept;'.
>
> On your project site you wrote, that the following information could be
> useful for you:
>
> - Output of hciconfig -a:
>
> hci0:   Type: USB
>         BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:790 acl:0 sco:0 events:63 errors:0
>         TX bytes:814 acl:0 sco:0 commands:43 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'chica-0'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x222
>         Manufacturer: Cambridge Silicon Radio (10)
>
> - Output from hciconfig hci0 revision:
>
> hci0:   Type: USB
>         BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8
>         Build 546
>         Chip version: BlueCore02-External
>         Max key size: 128 bit
>         SCO mapping:  HCI
>
> - Output of hcitool info 00:13:8A:04:A3:43:
>
> Requesting information ...
> Can't create connection: Input/output error
>
> - Systeminformation: Debian Sarge, Kernel 2.6.17.11 (self compiled),
> bluez-utils 2.15-1.1
>
> If you need more info just let me know.
>
> Could it be possible that my headset itself doesn't work with
> bluetooth-alsa? I would be very happy if someone could help me. Any
> ideas how to solve this?
>
> Greets, Christian Mager.
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_73185_8799893.1163167527736
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Christian !<br>&nbsp;&nbsp;&nbsp; I am vey new to BlueZ and even bluetooth. I am trying to configure bluetooth headset to 'skype' to make calls. and i downloaded both 'alsa project' and 'btsco' and i followed as per the instruction. and even bt-utils(
3.7).<br><br>&nbsp; But while running <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #btsco &lt;my headset addr&gt;<br>&nbsp; i am facing the same proble what u faced.<br>-------------------<br>Error: Failed to connect to SDP server: Permission denied<br>Assuming channel 2
<br><br>Voice setting: 0x0060<br>Can't connect RFCOMM channel: Permission denied<br>--------------------------------<br><br>i am not able to solve this problem , can u help me how could you solve this.<br><br>Thanx in adwance.
<br>Amarnath<br><div><span class="gmail_quote">On 11/3/06, <b class="gmail_sendername">Christian Mager</b> &lt;<a href="mailto:christian.mager@gmail.com">christian.mager@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br><br>I followed the instructions of <a href="http://bluetooth-alsa.sf.net">bluetooth-alsa.sf.net</a> to get my bt<br>headset work but pairing doesn't work so far. snd_bt_sco is loaded and<br>when I run btsco I get the following output:
<br><br>$ btsco -v 00:13:8A:04:A3:43<br>btsco v0.42<br>Device is 1:0<br>Error: Failed to connect to SDP server: Permission denied<br>Assuming channel 2<br><br>Voice setting: 0x0060<br>Can't connect RFCOMM channel: Permission denied
<br><br>Yes, I have restarted /etc/init.d/bluez-utils. I also started btsco as<br>root but same result. Pairing the headset with my cell phone works, but<br>it asks for a pin, btsco desn't. Could this cause the problem? In
<br>/etc/blueooth/hci.conf there is 'pin_helper /usr/bin/bluez-pin;' and 'lm<br>accept;'.<br><br>On your project site you wrote, that the following information could be<br>useful for you:<br><br>- Output of hciconfig -a:<br>
<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RX bytes:790 acl:0 sco:0 events:63 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TX bytes:814 acl:0 sco:0 commands:43 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name: 'chica-0'
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Service Classes: Networking, Rendering, Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:<br>0x222
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Manufacturer: Cambridge Silicon Radio (10)<br><br>- Output from hciconfig hci0 revision:<br><br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BD Address: 00:0F:B3:98:88:2E ACL MTU: 192:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build 546<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chip version: BlueCore02-External
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Max key size: 128 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SCO mapping:&nbsp;&nbsp;HCI<br><br>- Output of hcitool info 00:13:8A:04:A3:43:<br><br>Requesting information ...<br>Can't create connection: Input/output error<br><br>- Systeminformation: Debian Sarge, Kernel 
<a href="http://2.6.17.11">2.6.17.11</a> (self compiled),<br>bluez-utils 2.15-1.1<br><br>If you need more info just let me know.<br><br>Could it be possible that my headset itself doesn't work with<br>bluetooth-alsa? I would be very happy if someone could help me. Any
<br>ideas how to solve this?<br><br>Greets, Christian Mager.<br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>
Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_73185_8799893.1163167527736--


--===============1046370077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1046370077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1046370077==--
