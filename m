Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 14 Jun 2007 12:29:47 +0800 (CST)
From: =?GBK?B?t8nM7Nbt?= <wjs-198209@163.com>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <13741313.1010741181795387093.JavaMail.coremail@bj163app72.163.com>
MIME-Version: 1.0
Subject: [Bluez-users] Dbus error happened when I ran hcid
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1476342346=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1476342346==
Content-Type: multipart/Alternative;
	boundary="----=_Part_110401_23225587.1181795387092"

------=_Part_110401_23225587.1181795387092
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 Hello! Everyone .I have compile bluez-libs-3.11 and bluez-utils-3.11 in scratchbox for arm .
I could use hcitoll scan to find devices and sdptool to find services after I ran hciconfig hci0 up.
But when I ran hcid -n after start dbus-daemon --system,error happened.
[root@(none) /]# hcid -n
hcid[481]: Bluetooth HCI daemon
hcid[481]: Can't connect to system message bus: Did not receive a reply. Possibl
e causes include: the remote application did not send a reply, the message bus s
ecurity policy blocked the reply, the reply timeout expired, or the network conn
ection was broken.
hcid[481]: Unable to get on D-Bus
I think maybe the dbus was not configure properly.I also compile it in scratchbox for arm.
I have changed --localstatedir=/var --sysconfdir=/etc,and also made a link in /etc/ to
/var/bluetooth and a link dbus-1 in /etc to /var/dbus-1 because my file system is scram format,files can be
read only in the flash,only the var directory can be changed.
Can someone help me? I have no idea now though searching google so long time.
                                                                                                                                                                                                                                                                           Wang Jimscen
                    Jun 14,2007   
------=_Part_110401_23225587.1181795387092
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;Hello! Everyone .I have compile bluez-libs-3.11 and bluez-utils-=
3.11 in scratchbox for arm .<br>I could use hcitoll scan to find devices an=
d sdptool to find services after I ran hciconfig hci0 up.<br>But when I ran=
 hcid -n after start dbus-daemon --system,error happened.<br>[root@(none) /=
]# hcid -n <br>hcid[481]: Bluetooth HCI daemon <br>hcid[481]: Can't connect=
 to system message bus: Did not receive a reply. Possibl <br>e causes inclu=
de: the remote application did not send a reply, the message bus s <br>ecur=
ity policy blocked the reply, the reply timeout expired, or the network con=
n <br>ection was broken. <br>hcid[481]: Unable to get on D-Bus<br>I think m=
aybe the dbus was not configure properly.I also compile it in scratchbox fo=
r arm.<br>I have changed --localstatedir=3D/var --sysconfdir=3D/etc,and als=
o made a link in /etc/ to <br>/var/bluetooth and a link dbus-1 in /etc to /=
var/dbus-1 because my file system is scram format,files can be<br>read only=
 in the flash,only the var directory can be changed.<br>Can someone help me=
? I have no idea now though searching google so long time.<br><br><br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Wang Jimscen <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; J=
un 14,2007</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><br><!--=
 footer --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1" target=
=3D"_blank"><span style=3D"text-decoration:underline; color:blue">150 =CD=
=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =D3=CE=A3=AC=C4=E3 =B2=
=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF </span> </a>
------=_Part_110401_23225587.1181795387092--



--===============1476342346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1476342346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1476342346==--
