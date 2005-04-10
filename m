Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050410141324.23307.qmail@webmail29.rediffmail.com>
MIME-Version: 1.0
From: "adil  fulara" <talk2me_adil@rediffmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: [Bluez-users] How to create a shortcut for connecting to internet
Content-type: multipart/alternative;
	boundary="Next_1113142404---0-203.199.83.37-23258"
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
Date: 10 Apr 2005 14:13:24 -0000

 This is a multipart mime message


--Next_1113142404---0-203.199.83.37-23258
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0AHi Marcel,=0A=0A          Well i tried doing as u directed but it didn=
t seem to work.i guess i am making some mistake.Newa i am putting the conte=
nts of /etc/bluetooth/rfcomm.conf file below and also the console out i got=
 after i restarted the bluetooth service. =0A=0A=0Aroot@localhost ~]# cat /=
etc/bluetooth/rfcomm.conf=0A#=0A# RFCOMM configuration file.=0A#=0A# $Id: r=
fcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $=0A#=0A=0A#=0A# Example:=0A#=
=0A#rfcomm0 {=0A#       # Automatically bind the device at startup=0A#     =
  bind no;=0A#=0A#       # Bluetooth address of the device=0A#       device=
 11:22:33:44:55:66;=0A#=0A#       # RFCOMM channel for the connection=0A#  =
     channel 1;=0A#=0A#       # Description of the connection=0A#       com=
ment "Example Bluetooth device";=0A#}=0Arfcomm0 {=0A        bind 0;=0A     =
   device 00:0F:DE:86:2F:66;=0A        channel  7;=0A        }=0A[root@loca=
lhost ~]# service bluetooth restart=0AStopping Bluetooth services:         =
                      [  OK  ]=0Asyntax error line 24ervices:              =
                 [  OK  ]=0A=0A[root@localhost ~]#=0A=0A=0APlease Advice...=
?=0A=0Awhere do i put the init script....? am confused....=0A=0AThanx..=0A=
=0Aadil=0A=0A
--Next_1113142404---0-203.199.83.37-23258
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0AHi Marcel,<BR>=0A<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; Well i tried doing as u directed but it didnt seem to work.i guess i am=
 making some mistake.Newa i am putting the contents of /etc/bluetooth/rfcom=
m.conf file below and also the console out i got after i restarted the blue=
tooth service. <BR>=0A<BR>=0A<BR>=0Aroot@localhost ~]# cat /etc/bluetooth/r=
fcomm.conf<BR>=0A#<BR>=0A# RFCOMM configuration file.<BR>=0A#<BR>=0A# $Id: =
rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $<BR>=0A#<BR>=0A<BR>=0A#<BR>=
=0A# Example:<BR>=0A#<BR>=0A#rfcomm0 {<BR>=0A#&nbsp; &nbsp; &nbsp;  # Autom=
atically bind the device at startup<BR>=0A#&nbsp; &nbsp; &nbsp;  bind no;<B=
R>=0A#<BR>=0A#&nbsp; &nbsp; &nbsp;  # Bluetooth address of the device<BR>=
=0A#&nbsp; &nbsp; &nbsp;  device 11:22:33:44:55:66;<BR>=0A#<BR>=0A#&nbsp; &=
nbsp; &nbsp;  # RFCOMM channel for the connection<BR>=0A#&nbsp; &nbsp; &nbs=
p;  channel 1;<BR>=0A#<BR>=0A#&nbsp; &nbsp; &nbsp;  # Description of the co=
nnection<BR>=0A#&nbsp; &nbsp; &nbsp;  comment &quot;Example Bluetooth devic=
e&quot;;<BR>=0A#}<BR>=0Arfcomm0 {<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; bind 0;=
<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; device 00:0F:DE:86:2F:66;<BR>=0A&nbsp; &=
nbsp; &nbsp; &nbsp; channel&nbsp; 7;<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; }<BR=
>=0A[root@localhost ~]# service bluetooth restart<BR>=0AStopping Bluetooth =
services:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  [&nbsp; OK&nbsp; ]<BR>=0Asyntax err=
or line 24ervices:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  [&nbsp; OK&nbsp; ]<BR>=0A<=
BR>=0A[root@localhost ~]#<BR>=0A<BR>=0A<BR>=0APlease Advice...?<BR>=0A<BR>=
=0Awhere do i put the init script....? am confused....<BR>=0A<BR>=0AThanx..=
<BR>=0A<BR>=0Aadil<BR>=0A<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" H=
REF=3D"http://clients.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http:=
//ads.rediff.com/RealMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm=
@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1113142404---0-203.199.83.37-23258--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
