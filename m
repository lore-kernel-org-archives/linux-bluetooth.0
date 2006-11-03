Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <001001c6ff87$c1d41f50$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 3 Nov 2006 21:36:27 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=======AVGMAIL-454BA8545789======="
Subject: [Bluez-devel] To blueZ developers : can't do two "connect"
	concurrently, help required !
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--=======AVGMAIL-454BA8545789=======
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C6FF90.1E236F10"

------=_NextPart_000_000D_01C6FF90.1E236F10
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

For the ones who have read my messages a few days ago ...
I am still performing concurrency tests !

I run a server on 2 remote devices (one on channel 24, the
other on channel 25), and I try to connect to them concurrently=20
from the same Linux box / BT key (the remote servers are simple "echo"=20
ones, the linux client is sending numbers from 1 to 10 with a sleep(1) =
at=20
each step).

I have a simple batch :

client.sh :
./client 00:16:4E:83:2D:19  25 &
./client 00:0D:88:9B:FF:D7  24 &

where client is called with BDADDR and channel

Here is what I get in my logs :

Connection to remote 00:16:4E:83:2D:19 channel 25
Connection to remote 00:0D:88:9B:FF:D7 channel 24
[00:16:4E:83:2D:19] Can't connect(111)    =3D=3D=3D=3D> 111 is =
connection refused
[00:0D:88:9B:FF:D7] Connected to remote 00:0D:88:9B:FF:D7 channel 24, =
from local 00:11:67:0D:2E:2C channel 24
[00:0D:88:9B:FF:D7] Sent 0 received 0
...

If I swap the order of calling "client" i.e :

client.sh :

./client 00:0D:88:9B:FF:D7  24 &
./client 00:16:4E:83:2D:19  25 &

Then it's still the first which can't connect (now it will be =
00:0D:88:9B:FF:D7)

So basically, it seems that there can't be two "connect"
concurrently on the same adaptor.

Can please BlueZ developers confirm ?

Thanks a lot
Oli

For who is interested, here is the interesting part of client.c :

int main(int argc, char **argv)
{
    struct sockaddr_rc laddr, raddr;
    int sk, i;

    memset(&laddr, 0, sizeof(laddr));
    memset(&raddr, 0, sizeof(raddr));

    laddr.rc_family =3D AF_BLUETOOTH;
    bacpy(&laddr.rc_bdaddr, BDADDR_ANY);
    laddr.rc_channel =3D 0;

    raddr.rc_family =3D AF_BLUETOOTH;
    str2ba(argv[1], &raddr.rc_bdaddr);
    raddr.rc_channel =3D atoi(argv[2]);
=20
   if (argc !=3D 3) {
     fprintf(stderr,"Usage: client address channel\n");
     exit(EXIT_FAILURE);
   }

 debugOutput("Connection to remote %s channel %s", argv[1], argv[2]);

    sk =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
    if (sk < 0) {      =20
        debugOutput("[%s] Can't create RFCOMM socket", argv[1]);
        return -1;
    }

    if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
        debugOutput("[%s] Can't bind RFCOMM socket", argv[1]);
        close(sk);
        return -1;
    }

    if (connect(sk, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
        debugOutput("[%s] Can't connect(%d)", argv[1], errno);
        close(sk);
        return -1;
    }

 char loc_addr[30];
 strcpy(loc_addr, "");
=20
    int len =3D sizeof(laddr);=20
    if (getsockname (sk, &laddr, &len ) > 0)
       debugOutput("[%s] Can't getsockname", argv[1]);
 else ba2str(&laddr.rc_bdaddr, loc_addr);
 =20
 debugOutput("[%s] Connected to remote %s channel %s, from local %s =
channel %d", argv[1], argv[1], argv[2], loc_addr, laddr.rc_channel);
=20
 for (i =3D 0; i<10; i++)
 {
  char buf[1024];
  sprintf(buf, "%d%c", i, 10);
  write(sk, buf, strlen(buf));
  strcpy(buf, "");
 =20
  readString(sk, buf);
  if( strlen(buf) > 0 ) {
   debugOutput("[%s] Sent %d received %s", argv[1], i, buf);
    } else {
   debugOutput("[%s] Sent %d received no answer", argv[1], i);
   break;
  }
  sleep(1);
 }
=20
    close(sk);
 debugOutput("[%s] Disconnected", argv[1]);

    return 0;
}

------=_NextPart_000_000D_01C6FF90.1E236F10
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>For the ones who have read my messages =
a few days=20
ago ...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am still performing concurrency tests =

!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I run a server on 2 remote devices (one =
on channel=20
24, the</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>other on channel 25), and I try to =
connect to=20
</FONT><FONT face=3DArial size=3D2>them concurrently </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>from the same Linux box / BT&nbsp;key =
(the remote=20
</FONT><FONT face=3DArial size=3D2>servers&nbsp;are simple "echo" =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ones, the linux client is sending =
numbers=20
</FONT><FONT face=3DArial size=3D2>from 1 to 10 with a sleep(1) at =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>each step).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a simple batch :</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>client.sh=20
:<BR>./client&nbsp;00:16:4E:83:2D:19&nbsp; 25 &amp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>./client&nbsp;00:0D:88:9B:FF:D7&nbsp; =
24=20
&amp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>where client is called with BDADDR and=20
channel</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Here is what I get in my logs =
:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Connection to remote 00:16:4E:83:2D:19 =
channel=20
25<BR>Connection to remote 00:0D:88:9B:FF:D7 channel =
24<BR>[00:16:4E:83:2D:19]=20
Can't connect(111)&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D&gt; 111 is connection=20
refused<BR>[00:0D:88:9B:FF:D7] Connected to remote 00:0D:88:9B:FF:D7 =
channel 24,=20
from local 00:11:67:0D:2E:2C channel 24<BR>[00:0D:88:9B:FF:D7] Sent 0 =
received=20
0<BR>...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If I swap the order of calling "client" =
i.e=20
:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>client.sh :<BR>
<DIV><FONT face=3DArial size=3D2>./client&nbsp;00:0D:88:9B:FF:D7&nbsp; =
24=20
&amp;</FONT></DIV>./client&nbsp;00:16:4E:83:2D:19&nbsp; 25 =
&amp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>Then it's still the first which can't connect (now it will be=20
00:0D:88:9B:FF:D7)</DIV>
<DIV>&nbsp;</DIV>
<DIV>So basically, it seems that&nbsp;there can't&nbsp;be=20
two&nbsp;"connect"</DIV>
<DIV>concurrently on the same adaptor.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Can please BlueZ developers confirm ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks a lot</DIV>
<DIV>Oli</DIV>
<DIV>&nbsp;</DIV>
<DIV>For who is interested, here is the interesting part of client.c =
:</DIV>
<DIV>&nbsp;</DIV>
<DIV>int main(int argc, char **argv)<BR>{<BR>&nbsp;&nbsp;&nbsp; struct=20
sockaddr_rc laddr, raddr;<BR>&nbsp;&nbsp;&nbsp; int sk, i;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; memset(&amp;laddr, 0,=20
sizeof(laddr));<BR>&nbsp;&nbsp;&nbsp; memset(&amp;raddr, 0,=20
sizeof(raddr));</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; laddr.rc_family =3D =
AF_BLUETOOTH;<BR>&nbsp;&nbsp;&nbsp;=20
bacpy(&amp;laddr.rc_bdaddr, BDADDR_ANY);<BR>&nbsp;&nbsp;&nbsp; =
laddr.rc_channel=20
=3D 0;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; raddr.rc_family =3D =
AF_BLUETOOTH;<BR>&nbsp;&nbsp;&nbsp;=20
str2ba(argv[1], &amp;raddr.rc_bdaddr);<BR>&nbsp;&nbsp;&nbsp; =
raddr.rc_channel =3D=20
atoi(argv[2]);<BR>&nbsp;<BR>&nbsp; &nbsp;if (argc !=3D 3) =
{<BR>&nbsp;&nbsp;&nbsp;=20
&nbsp;fprintf(stderr,"Usage: client address =
channel\n");<BR>&nbsp;&nbsp;&nbsp;=20
&nbsp;exit(EXIT_FAILURE);<BR>&nbsp; &nbsp;}</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;debugOutput("Connection to remote %s channel %s", argv[1],=20
argv[2]);</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; sk =3D socket(AF_BLUETOOTH, SOCK_STREAM,=20
BTPROTO_RFCOMM);<BR>&nbsp;&nbsp;&nbsp; if (sk &lt; 0)=20
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugOutput("[%s] Can't =
create=20
RFCOMM socket", argv[1]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return=20
-1;<BR>&nbsp;&nbsp;&nbsp; }</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; if (bind(sk, (struct sockaddr *)&amp;laddr,=20
sizeof(laddr)) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
debugOutput("[%s] Can't bind RFCOMM socket",=20
argv[1]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
close(sk);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
-1;<BR>&nbsp;&nbsp;&nbsp; }</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; if (connect(sk, (struct sockaddr *)&amp;raddr,=20
sizeof(raddr)) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
debugOutput("[%s] Can't connect(%d)", argv[1],=20
errno);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
close(sk);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
-1;<BR>&nbsp;&nbsp;&nbsp; }</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;char loc_addr[30];<BR>&nbsp;strcpy(loc_addr,=20
"");<BR>&nbsp;<BR>&nbsp;&nbsp; &nbsp;int len =3D sizeof(laddr);=20
<BR>&nbsp;&nbsp;&nbsp; if (getsockname (sk, &amp;laddr, &amp;len ) &gt;=20
0)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;debugOutput("[%s] Can't =
getsockname",=20
argv[1]);<BR>&nbsp;else ba2str(&amp;laddr.rc_bdaddr,=20
loc_addr);<BR>&nbsp;&nbsp;<BR>&nbsp;debugOutput("[%s] Connected to =
remote %s=20
channel %s, from local %s channel %d", argv[1], argv[1], argv[2], =
loc_addr,=20
laddr.rc_channel);<BR>&nbsp;<BR>&nbsp;for (i =3D 0; i&lt;10;=20
i++)<BR>&nbsp;{<BR>&nbsp;&nbsp;char =
buf[1024];<BR>&nbsp;&nbsp;sprintf(buf,=20
"%d%c", i, 10);<BR>&nbsp;&nbsp;write(sk, buf,=20
strlen(buf));<BR>&nbsp;&nbsp;strcpy(buf,=20
"");<BR>&nbsp;&nbsp;<BR>&nbsp;&nbsp;readString(sk, =
buf);<BR>&nbsp;&nbsp;if(=20
strlen(buf) &gt; 0 ) {<BR>&nbsp;&nbsp;&nbsp;debugOutput("[%s] Sent %d =
received=20
%s", argv[1], i, buf);<BR>&nbsp; &nbsp;&nbsp;} else=20
{<BR>&nbsp;&nbsp;&nbsp;debugOutput("[%s] Sent %d received no answer", =
argv[1],=20
i);<BR>&nbsp;&nbsp;&nbsp;break;<BR>&nbsp;&nbsp;}<BR>&nbsp;&nbsp;sleep(1);=
<BR>&nbsp;}<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp;=20
close(sk);<BR>&nbsp;debugOutput("[%s] Disconnected", argv[1]);</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; return =
0;<BR>}<BR></DIV></DIV></FONT></BODY></HTML>

------=_NextPart_000_000D_01C6FF90.1E236F10--

--=======AVGMAIL-454BA8545789=======
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.13.25/515 - Release Date: 03/11/2006
=


--=======AVGMAIL-454BA8545789=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=======AVGMAIL-454BA8545789=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=======AVGMAIL-454BA8545789=======--
