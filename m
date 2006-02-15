Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3ac394050602151127l1ec3a30bo7008905058cd8c6a@mail.gmail.com>
From: Irfan Ahmad <irfan.amd@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3651_15296850.1140031623330"
Subject: [Bluez-devel] multiple connection problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Feb 2006 14:27:03 -0500

------=_Part_3651_15296850.1140031623330
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am working on a software for bluetooth scatternet formation and routing.

When I try to accept two connections from different BT devices, the second
device gives a page fault error. Here I paste the code which I am trying to
use in my test run.

 #include <stdio.h>#include <string.h>#include <sys/socket.h>#include
<bluetooth/bluetooth.h>#include <bluetooth/l2cap.h>
#define LQ 10int main(int argc, char **argv)
{
=09*struct* sockaddr_l2 loc_addr =3D { 0 }, rem_addr =3D { 0 };
=09char buf[1024] =3D { 0 },rem_name[100] =3D { 0 };
=09int s, client, bytes_read;
=09int opt =3D *sizeof*(rem_addr);

    *// allocate socket*
=09s =3D socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

    *// bind socket to port 0x1001 of the first available *
    *// bluetooth adapter*
=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09loc_addr.l2_bdaddr =3D *BDADDR_ANY;
=09loc_addr.l2_psm =3D htobs(0x1001);

=09bind(s, (*struct* sockaddr *)&loc_addr, *sizeof*(loc_addr));

    *// put socket into listening mode*
=09listen(s, LQ);
=09
=09*while*(1)
=09{
=09=09*// accept one connection*
=09=09client =3D accept(s, (*struct* sockaddr *)&rem_addr, &opt);

=09=09ba2str( &rem_addr.l2_bdaddr, rem_name );
=09=09fprintf(stderr, "accepted connection from %s\n", rem_name);
=09=09*if* (fork()=3D=3D0)
=09=09{
=09=09=09close(s);
=09=09=09memset(buf, 0, *sizeof*(buf));
    =09=09=09*// read data from the client*
=09=09=09bytes_read =3D read(client, buf, *sizeof*(buf));
=09=09=09*if*( bytes_read > 0 ) {
=09=09=09=09fprintf(stderr,"%s: %s\n", rem_name,buf);
=09=09=09}
=09=09=09*// close connection*
=09=09=09close(client);
                        exit(0);
                }
=09}
=09close(s);
}

Please help me regarding this problem. Also if some has worked on scatterne=
t
projects or know about any, then please give me reference.

Thanks,
Irfan Ahmad

------=_Part_3651_15296850.1140031623330
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I am working on a software for bluetooth scatternet formation an=
d routing. <br><br>When I try to accept two connections from different BT d=
evices, the second device gives a page fault error. Here I paste the code w=
hich I am trying to use in my test run.
<br><br>


<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8">
<meta name=3D"Generator" content=3D"Kate, the KDE Advanced Text Editor">

<pre><span style=3D"color: rgb(0, 128, 0);">#include &lt;stdio.h&gt;</span>
<span style=3D"color: rgb(0, 128, 0);">#include &lt;string.h&gt;</span>
<span style=3D"color: rgb(0, 128, 0);">#include &lt;sys/socket.h&gt;</span>
<span style=3D"color: rgb(0, 128, 0);">#include &lt;bluetooth/bluetooth.h&g=
t;</span>
<span style=3D"color: rgb(0, 128, 0);">#include &lt;bluetooth/l2cap.h&gt;</=
span>

<span style=3D"color: rgb(0, 128, 0);">#define LQ 10</span>
<span style=3D"color: rgb(128, 0, 0);">int</span> main(<span style=3D"color=
: rgb(128, 0, 0);">int</span> argc, <span style=3D"color: rgb(128, 0, 0);">=
char</span> **argv)
{
=09<b>struct</b> sockaddr_l2 loc_addr =3D { <span style=3D"color: rgb(0, 0,=
 255);">0</span> }, rem_addr =3D { <span style=3D"color: rgb(0, 0, 255);">0=
</span> };
=09<span style=3D"color: rgb(128, 0, 0);">char</span> buf[<span style=3D"co=
lor: rgb(0, 0, 255);">1024</span>] =3D { <span style=3D"color: rgb(0, 0, 25=
5);">0</span> },rem_name[<span style=3D"color: rgb(0, 0, 255);">100</span>]=
 =3D { <span style=3D"color: rgb(0, 0, 255);">
0</span> };
=09<span style=3D"color: rgb(128, 0, 0);">int</span> s, client, bytes_read;
=09<span style=3D"color: rgb(128, 0, 0);">int</span> opt =3D <b>sizeof</b>(=
rem_addr);

    <span style=3D"color: rgb(128, 128, 128);"><i>// allocate socket</i></s=
pan>
=09s =3D socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

    <span style=3D"color: rgb(128, 128, 128);"><i>// bind socket to port 0x=
1001 of the first available </i></span>
    <span style=3D"color: rgb(128, 128, 128);"><i>// bluetooth adapter</i><=
/span>
=09loc_addr.l2_family =3D AF_BLUETOOTH;
=09loc_addr.l2_bdaddr =3D *BDADDR_ANY;
=09loc_addr.l2_psm =3D htobs(<span style=3D"color: rgb(0, 128, 128);">0x100=
1</span>);

=09bind(s, (<b>struct</b> sockaddr *)&amp;loc_addr, <b>sizeof</b>(loc_addr)=
);

    <span style=3D"color: rgb(128, 128, 128);"><i>// put socket into listen=
ing mode</i></span>
=09listen(s, LQ);
=09
=09<b>while</b>(<span style=3D"color: rgb(0, 0, 255);">1</span>)
=09{
=09=09<span style=3D"color: rgb(128, 128, 128);"><i>// accept one connectio=
n</i></span>
=09=09client =3D accept(s, (<b>struct</b> sockaddr *)&amp;rem_addr, &amp;op=
t);

=09=09ba2str( &amp;rem_addr.l2_bdaddr, rem_name );
=09=09fprintf(stderr, <span style=3D"color: rgb(221, 0, 0);">&quot;accepted=
 connection from %s</span><span style=3D"color: rgb(255, 0, 255);">\n</span=
><span style=3D"color: rgb(221, 0, 0);">&quot;</span>, rem_name);
=09=09<b>if</b> (fork()=3D=3D<span style=3D"color: rgb(0, 0, 255);">0</span=
>)
=09=09{
=09=09=09close(s);
=09=09=09memset(buf, <span style=3D"color: rgb(0, 0, 255);">0</span>, <b>si=
zeof</b>(buf));
    =09=09=09<span style=3D"color: rgb(128, 128, 128);"><i>// read data fro=
m the client</i></span>
=09=09=09bytes_read =3D read(client, buf, <b>sizeof</b>(buf));
=09=09=09<b>if</b>( bytes_read &gt; <span style=3D"color: rgb(0, 0, 255);">=
0</span> ) {
=09=09=09=09fprintf(stderr,<span style=3D"color: rgb(221, 0, 0);">&quot;%s:=
 %s</span><span style=3D"color: rgb(255, 0, 255);">\n</span><span style=3D"=
color: rgb(221, 0, 0);">&quot;</span>, rem_name,buf);
=09=09=09}
=09=09=09<span style=3D"color: rgb(128, 128, 128);"><i>// close connection<=
/i></span>
=09=09=09close(client);<br>&nbsp;                       exit(0);<br>       =
         }
=09}
=09close(s);
}</pre>Please help me regarding this problem. Also if some has worked on sc=
atternet projects or know about any, then please give me reference.<br><br>=
Thanks,<br>Irfan Ahmad<br>

------=_Part_3651_15296850.1140031623330--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
