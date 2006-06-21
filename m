Return-Path: <lucharse@yahoo.com.cn>
Message-ID: <20060621085014.80178.qmail@web15802.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 16:50:14 +0800 (CST)
From: Mingfan lu <lucharse@yahoo.com.cn>
Subject: =?gb2312?q?=BB=D8=B8=B4=A3=BA=20Re:=20=BB=D8=B8=B4=A3=BA=20Re:=20[Bluez-d?=
 =?gb2312?q?evel]=20RE=A3=BA=20RE:=20FWD=A3=BA=20Re:=20Re:Request=20with?=
 =?gb2312?q?=20RSSI?=
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150878088.3950.22.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-764976140-1150879814=:78658"
List-ID: <bluez-devel.lists.sourceforge.net>

--0-764976140-1150879814=:78658
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

I can't understand your test , why you set the mode 5? 
  what is the relation between  your result and the problem?   

Marcel Holtmann <marcel@holtmann.org> ：
  Hi,

> mylinux:/home/lucharse/ContentPushing # hciconfig hci0 version
> hci0: Type: USB
> BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
> HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP
> Subver: 0x1f4
> Manufacturer: Integrated System Solution Corp. (57)

this chips firmware is totally broken. I just checked mine and I am
seeing the same. No Inquiry with RSSI Result events.

However their support for Inquiry with RSSI is simply not there. See my
tested inquiry mode settings:

# hciconfig hci0 inqmode 5
# sudo hciconfig hci0 inqmode
hci0: Type: USB
BD Address: 22:22:22:22:22:22 ACL MTU: 678:8 SCO MTU: 48:10
Inquiry mode: Unknown (0x05)

So they store the value somewhere, but that's it.

If you wanna really use Inquiry with RSSI, then you might wanna make
sure you get a CSR BlueCore4 based dongle. They simply work.

Regards

Marcel





With respects,
        Mingfan.Lu 

 		
---------------------------------
 Mp3疯狂搜-新歌热歌高速下   
--0-764976140-1150879814=:78658
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>I can't understand your test , why you set&nbsp;the mode 5? </div>  <div>what is the relation&nbsp;between &nbsp;your result and the problem?&nbsp;&nbsp;&nbsp;<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> ：</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; mylinux:/home/lucharse/ContentPushing # hciconfig hci0 version<BR>&gt; hci0: Type: USB<BR>&gt; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&gt; HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP<BR>&gt; Subver: 0x1f4<BR>&gt; Manufacturer: Integrated System Solution Corp. (57)<BR><BR>this chips firmware is totally broken. I just checked mine and I am<BR>seeing the same. No Inquiry with RSSI Result events.<BR><BR>However their support for Inquiry with RSSI is simply not there. See my<BR>tested inquiry mode settings:<BR><BR># hciconfig hci0 inqmode 5<BR># sudo hciconfig hci0 inqmode<BR>hci0: Type:
 USB<BR>BD Address: 22:22:22:22:22:22 ACL MTU: 678:8 SCO MTU: 48:10<BR>Inquiry mode: Unknown (0x05)<BR><BR>So they store the value somewhere, but that's it.<BR><BR>If you wanna really use Inquiry with RSSI, then you might wanna make<BR>sure you get a CSR BlueCore4 based dongle. They simply work.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR></BLOCKQUOTE><BR><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;
		<hr size=1><a href="http://music.yahoo.com.cn/?source=mail_mailbox_footer" target=blank> 
Mp3疯狂搜-新歌热歌高速下 
</a>
 
 

--0-764976140-1150879814=:78658--
