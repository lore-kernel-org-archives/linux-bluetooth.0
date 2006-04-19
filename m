Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604191132v66b0e299nbd4f50071b907c2e@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Programming in C with Bluetooth Sockets
In-Reply-To: <c6a2f99a0604191126p744f86f5xa9c1a361381fa23a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4546_6057239.1145471558107"
References: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
	 <fe0a97c20604182118w6f25db3ei437dde8f23c93436@mail.gmail.com>
	 <c6a2f99a0604190804k7de31858i94b74e2d06b3ff11@mail.gmail.com>
	 <ef9938ec0604190956r40a902b5sce596c16e40ce8e1@mail.gmail.com>
	 <c6a2f99a0604191126p744f86f5xa9c1a361381fa23a@mail.gmail.com>
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
Date: Wed, 19 Apr 2006 14:32:38 -0400

------=_Part_4546_6057239.1145471558107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>                bytes_read =3D read(client, buf + count, sizeof(buf) -
> count);


sizeof(buf) will always return  4 because buf was allocated as a char* and
not a char[]
So it's never trying to read more than 4 bytes at a time

-albert

------=_Part_4546_6057239.1145471558107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bytes_read =3D read(client, buf + count, sizeof(buf) - count);</blockquot=
e>
<div><br>sizeof(buf) will always return&nbsp; 4 because buf was allocated a=
s a char* and not a char[]<br>So it's never trying to read more than 4 byte=
s at a time<br><br>-albert <br></div><br></div>

------=_Part_4546_6057239.1145471558107--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
