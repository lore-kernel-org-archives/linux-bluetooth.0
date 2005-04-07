Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001a01c53b78$a1e1c7d0$344914ac@stu.nus.edu.sg>
From: "Khoo Teck Ping" <eng10166@nus.edu.sg>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01C53BBB.ACA736D0"
Subject: [Bluez-devel] Erasure of records of previously discovered devices
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
Date: Thu, 7 Apr 2005 21:49:29 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C53BBB.ACA736D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all

I wrote a small c program to continuously inquire for nearby bluetooth =
devices and record their address, name and time of discovery. However, =
the program always seems to return a list of devices found earlier, even =
when the discovered device has been switched off.=20

Following is part of the code, which does 5 rounds of inquiry, largely =
derived from Bastian Ballmann's hciscan program. Is there anyway I can =
erase records of previously found devices and do a fresh inquiry =
everytime?=20

Thanks.=20
Teck Ping



for(j =3D 1; j <=3D 5; j++)
  {
     for(i =3D 0; i < num_rsp; i++)=20
     {
        memset(name, 0, sizeof(name));

        if(hci_read_remote_name(dd, &(info+i)->bdaddr, sizeof(name), =
name, 100000) < 0)
        {
           strcpy(name, "na");
        }  =20

        baswap(&bdaddr, &(info+i)->bdaddr);
        time_t now;
        time(&now);

        printf("%d\t%s\t%s\t%s", j, batostr(&bdaddr), name, =
ctime(&now));
       =20
        /*a+ will append text to the end of file*/
        ptr =3D fopen("data.txt", "a+");
           fprintf(ptr,"%d;%s;%s;%s", j, batostr(&bdaddr), name, =
ctime(&now));     =20
        fclose(ptr); /*close the opened file*/
     }
  }
------=_NextPart_000_0017_01C53BBB.ACA736D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2604" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Dear all</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I wrote a small c program to =
continuously inquire=20
for nearby bluetooth devices and record their address, name and time of=20
discovery. However, the program always seems to return a list of devices =
found=20
earlier, even when the discovered device has been switched off. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Following is part of the code, which =
does 5 rounds=20
of inquiry, largely derived from&nbsp;Bastian Ballmann's hciscan =
program. Is=20
there anyway I can erase records of previously found devices and do a =
fresh=20
inquiry everytime? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Teck Ping</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>for(j =3D 1; j &lt;=3D 5; =
j++)<BR>&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp; for(i =3D 0; i &lt; num_rsp; i++)=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
memset(name, 0, sizeof(name));</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
if(hci_read_remote_name(dd, &amp;(info+i)-&gt;bdaddr, sizeof(name), =
name,=20
100000) &lt; 0)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
strcpy(name,=20
"na");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; =
</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
baswap(&amp;bdaddr,=20
&amp;(info+i)-&gt;bdaddr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
time_t=20
now;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
time(&amp;now);</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printf("%d\t%s\t%s\t%s", j, batostr(&amp;bdaddr), name,=20
ctime(&amp;now));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*a+ will append text to =
the end=20
of file*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D =
fopen("data.txt",=20
"a+");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
fprintf(ptr,"%d;%s;%s;%s", j, batostr(&amp;bdaddr), name,=20
ctime(&amp;now));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fclose(ptr); /*close the =
opened=20
file*/<BR>&nbsp;&nbsp;&nbsp;&nbsp; }<BR>&nbsp; =
}</FONT></DIV></BODY></HTML>

------=_NextPart_000_0017_01C53BBB.ACA736D0--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
