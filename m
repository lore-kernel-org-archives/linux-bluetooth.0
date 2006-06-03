Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>
Date: Sat, 3 Jun 2006 15:39:42 -0500
From: "Carl Karsten" <cfkarsten@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149362263.1977.4.camel@localhost>
MIME-Version: 1.0
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
	<1149362263.1977.4.camel@localhost>
Subject: Re: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0628660252=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0628660252==
Content-Type: multipart/alternative;
	boundary="----=_Part_1045_15863091.1149367182134"

------=_Part_1045_15863091.1149367182134
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> >
> > carl@asus17 :/etc/bluetooth$ lsusb
> > Bus 003 Device 002: ID 044e:3001 Alps Electric Co., Ltd UGTZ4
> > Bluetooth
> >
> > carl@asus17:~$ hciconfig
> > hci0:   Type: USB
> >         BD Address: 00:02:C7:97:22:6C ACL MTU: 192:8 SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:10657 acl:36 sco:0 events:236 errors:0
> >         TX bytes:2218 acl:36 sco:0 commands:106 errors:0
> >
> >
> > carl@asus17:~$ sdptool browse 08:00:37:03:EF:36
> > Browsing 08:00:37:03:EF:36 ...


> >
> > Service Name: Dialup Networking
> > Service RecHandle: 0x10003
> > Service Class ID List:
> >   "Dialup Networking" (0x1103)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 4
> > Profile Descriptor List:
> >   "Dialup Networking" (0x1103)
> >     Version: 0x0100
> >
> > I am not sure what to do next.  looks like audio and dun are the only
> > profiles the phone supports, so DUN seems like a good place to start.
>
> with DUN you can use your mobile phone to dialup to the Internet. It
> makes you phone look like a modem. The audio profiles allow you to
> connect a headset to your phone.



I am assuming I can connect minicom to it and issue AT commands.  I couln't
find any instructions on how.

Carl K

------=_Part_1045_15863091.1149367182134
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt; carl@asus17 :/etc/bluetooth$ lsusb<br>&gt; Bus 003 Device 002: ID 044e:3001 Alps Electric Co., Ltd UGTZ4
<br>&gt; Bluetooth<br>&gt;<br>&gt; carl@asus17:~$ hciconfig<br>&gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:C7:97:22:6C ACL MTU: 192:8 SCO MTU: 64:8<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:10657 acl:36 sco:0 events:236 errors:0
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2218 acl:36 sco:0 commands:106 errors:0<br>&gt;<br>&gt;<br>&gt; carl@asus17:~$ sdptool browse 08:00:37:03:EF:36<br>&gt; Browsing 08:00:37:03:EF:36 ...</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>&gt;<br>&gt; Service Name: Dialup Networking<br>&gt; Service RecHandle: 0x10003<br>&gt; Service Class ID List:<br>&gt;&nbsp;&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&gt; Protocol Descriptor List:<br>&gt;&nbsp;&nbsp; &quot;L2CAP&quot; (0x0100)
<br>&gt;&nbsp;&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Channel: 4<br>&gt; Profile Descriptor List:<br>&gt;&nbsp;&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Version: 0x0100<br>&gt;<br>&gt; I am not sure what to do next.&nbsp;&nbsp;looks like audio and dun are the only
<br>&gt; profiles the phone supports, so DUN seems like a good place to start.<br><br>with DUN you can use your mobile phone to dialup to the Internet. It<br>makes you phone look like a modem. The audio profiles allow you to
<br>connect a headset to your phone.</blockquote><div><br><br>I am assuming I can connect minicom to it and issue AT commands.&nbsp; I couln't find any instructions on how.<br>&nbsp;</div></div>Carl K<br>

------=_Part_1045_15863091.1149367182134--


--===============0628660252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0628660252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0628660252==--
