Return-Path: <lucharse@yahoo.com.cn>
Message-ID: <20060621093306.95930.qmail@web15806.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 17:33:06 +0800 (CST)
From: Mingfan lu <lucharse@yahoo.com.cn>
Subject: =?gb2312?q?Re:=20[Bluez-deve]Re:=20Re:=A3=BA=20Re:=20=20RE=A3=BA=20RE:=20?=
 =?gb2312?q?FWD:Re:=20Re:Request=20with=09RSSI?=
To: marcel@holtmann.org
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150881922.3950.28.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1077111339-1150882386=:94472"
List-ID: <bluez-devel.lists.sourceforge.net>

--0-1077111339-1150882386=:94472
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

I see. Thank you for your patience and nice answer. 
  I will get a new dongle :)
  ps, is there any plan for  official document for bluez, although the bluez is being under development. 

Marcel Holtmann <marcel@holtmann.org> Ð´µÀ£º 
  Hi,

> I reviewed the hciconfig.c.
> If you set mode 5, it just output like you test. I can see any
> limitation of the mode num, 5 it can be dealt with. So, I don't think
> it can give such a conclusion you claimed.

this has nothing to do with our code. The chip must refuse any values
other than 0 and 1. And such a behavior leads the conclusion that their
implementation doesn't care about the inquiry mode at all. Otherwise
they would have been more careful with the implementation.

Anyway, the firmware of this chip is broken. Get yourself a working
dongle from CSR and you can use Inquiry with RSSI. Otherwise you can't.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



With respects,
        Mingfan.Lu 

 		
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-1077111339-1150882386=:94472
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>I see. Thank you for your patience and nice answer. </div>  <div>I will get a new dongle :)</div>  <div>ps, is there any plan&nbsp;for &nbsp;official document for bluez, although the bluez is&nbsp;being under development.&nbsp;<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> Ð´µÀ£º </div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; I reviewed the hciconfig.c.<BR>&gt; If you set mode 5, it just output like you test. I can see any<BR>&gt; limitation of the mode num, 5 it can be dealt with. So, I don't think<BR>&gt; it can give such a conclusion you claimed.<BR><BR>this has nothing to do with our code. The chip must refuse any values<BR>other than 0 and 1. And such a behavior leads the conclusion that their<BR>implementation doesn't care about the inquiry mode at all. Otherwise<BR>they would have been more careful with the implementation.<BR><BR>Anyway, the firmware of this chip is
 broken. Get yourself a working<BR>dongle from CSR and you can use Inquiry with RSSI. Otherwise you can't.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE><BR><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-1077111339-1150882386=:94472--
