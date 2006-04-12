Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604121006w6ba7fccbm6c5d39fab1445e61@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth remote control
In-Reply-To: <20060411223157.86042.qmail@web61222.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2386_19291194.1144861569408"
References: <20060411223157.86042.qmail@web61222.mail.yahoo.com>
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
Date: Wed, 12 Apr 2006 13:06:09 -0400

------=_Part_2386_19291194.1144861569408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Take a look at Xbtrc

http://wwwhome.cs.utwente.nl/~dijkhw/index.php?p=3DKatlijk/Xbtrc


problems encountered: multiple remotes can't connect to the same server.
>
> i see that the accept method (unlike tcp implementation) returns the
> server port upon accepting an incoming connection. for instance, if the
> server is listening on port 16, when any remote connects to the server, t=
he
> server port 16 is used to establish end-to-end connection with the client=
.
> now, another device cannot connect to the same server until the first rem=
ote
> disconnects. this problem stops us from using multiple remotes with a sin=
gle
> linux server.
>

There is no such restriction in hardware or bluetooth software stack.
Multiple clients can be simultaneously connected to the same RFCOMM channel
on a server.  Use hcidump -X -V to find out where the connection fails.
Make sure that the server is always the master and that the clients are
always the slaves.  This probably requires a role switch after each connect=
.


> >rfcomm connect 00:0D:88:C0:61:55 16
> Can't connect RFCOMM socket: Host is down
>

This syntax is incorrect.  See the rfcomm documentation.

-albert

------=_Part_2386_19291194.1144861569408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Take a look at Xbtrc<br><br><a href=3D"http://wwwhome.cs.utwente.nl/~dijkhw=
/index.php?p=3DKatlijk/Xbtrc">http://wwwhome.cs.utwente.nl/~dijkhw/index.ph=
p?p=3DKatlijk/Xbtrc</a><br><br><div><span class=3D"gmail_quote"><br></span>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div style=3D"direction: ltr;">problems encountered: multiple remotes can't=
 connect to the same server.<br> <br> i see that the accept method (unlike =
tcp implementation) returns the server port upon accepting an incoming conn=
ection. for
 instance, if the server is listening on port 16, when any remote connects =
to the server, the server port 16 is used to establish end-to-end connectio=
n with the client. now, another device cannot connect to the same server un=
til the first remote disconnects. this problem stops us from using multiple=
 remotes with a single linux server.
</div></blockquote><div><br>There is no such restriction in hardware or blu=
etooth software stack.&nbsp; Multiple clients can be simultaneously connect=
ed to the same RFCOMM channel on a server.&nbsp; Use hcidump -X -V to find =
out where the connection fails.&nbsp; Make sure that the server is always t=
he master and that the clients are always the slaves.&nbsp; This probably r=
equires a role switch after each connect.
<br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><=
div style=3D"direction: ltr;">&gt;rfcomm connect 00:0D:88:C0:61:55 16<br> C=
an't connect RFCOMM
 socket: Host is down</div></blockquote><div><br>This syntax is incorrect.&=
nbsp; See the rfcomm documentation.<br>&nbsp;</div>-albert</div>

------=_Part_2386_19291194.1144861569408--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
