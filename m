Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050410194827.23674.qmail@webmail47.rediffmail.com>
MIME-Version: 1.0
From: "adil  fulara" <talk2me_adil@rediffmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: Re: [Bluez-users] How to create a shortcut for connecting to internet
Content-type: multipart/alternative;
	boundary="Next_1113162507---0-203.199.83.33-23657"
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
Date: 10 Apr 2005 19:48:27 -0000

 This is a multipart mime message


--Next_1113162507---0-203.199.83.33-23657
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hey Bruno,=0A=0A            You are right. i was treating it as bind no. =
(bind Number), so i was always typing bind 0. neways just tried it out. it =
works. Thanx alot to u and marcel i have created a shortcut which fires thi=
s command and i get connected. How do i disconnect....?=0A=0AI guess i will=
 have to use KDE System Guard(ctrl+alt+delete) to kill the wvdial process. =
Any other ways of doing it....?=0A=0AThanx alot folks....!!=0A=0ACheerio=0A=
=0AAdil.=0A=0A=0AOn Sun, 10 Apr 2005 Bruno Abinader wrote :=0A>bind 0... i =
think it only can be a "yes/no" answer, not "0/1", but i'm not sure!=0A>=0A=
> >  Hi Marcel,=0A> >=0A> >            Well i tried doing as u directed but=
 it didnt seem to work.i=0A> > guess i am making some mistake.Newa i am put=
ting the contents of=0A> > /etc/bluetooth/rfcomm.conf file below and also t=
he console out i got after i=0A> > restarted the bluetooth service.=0A> >=
=0A> >=0A> >  root@localhost ~]# cat /etc/bluetooth/rfcomm.conf=0A> >  #=0A=
> >  # RFCOMM configuration file.=0A> >  #=0A> >  # $Id: rfcomm.conf,v 1.1 =
2002/10/07 05:58:18 maxk Exp $=0A> >  #=0A> >=0A> >  #=0A> >  # Example:=0A=
> >  #=0A> >  #rfcomm0 {=0A> >  #      # Automatically bind the device at s=
tartup=0A> >  #      bind no;=0A> >  #=0A> >  #      # Bluetooth address of=
 the device=0A> >  #      device 11:22:33:44:55:66;=0A> >  #=0A> >  #      =
# RFCOMM channel for the connection=0A> >  #      channel 1;=0A> >  #=0A> >=
  #      # Description of the connection=0A> >  #      comment "Example Blu=
etooth device";=0A> >  #}=0A> >  rfcomm0 {=0A> >          bind 0;=0A> >    =
      device 00:0F:DE:86:2F:66;=0A> >          channel  7;=0A> >          }=
=0A> >  [root@localhost ~]# service bluetooth restart=0A> >  Stopping Bluet=
ooth services:                              [  OK  ]=0A> >  syntax error li=
ne 24ervices:                              [  OK  ]=0A> >=0A> >  [root@loca=
lhost ~]#=0A> >=0A> >=0A> >  Please Advice...?=0A> >=0A> >  where do i put =
the init script....? am confused....=0A> >=0A> >  Thanx..=0A> >=0A> >  adil=
=0A>--=0A>Bruno de Oliveira Abinader=0A>GVoIP - INdT/UFAM=0A>=0A>=0A>------=
-------------------------------------------------=0A>SF email is sponsored =
by - The IT Product Guide=0A>Read honest & candid reviews on hundreds of IT=
 Products from real users.=0A>Discover which products truly live up to the =
hype. Start reading now.=0A>http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14=
396&op=3Dclick=0A>_______________________________________________=0A>Bluez-=
users mailing list=0A>Bluez-users@lists.sourceforge.net=0A>https://lists.so=
urceforge.net/lists/listinfo/bluez-users=0A
--Next_1113162507---0-203.199.83.33-23657
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; Hey Bruno,<BR>=0A<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; You are right. i was treating it as bind no. (bind Number), so i was al=
ways typing bind 0. neways just tried it out. it works. Thanx alot to u and=
 marcel i have created a shortcut which fires this command and i get connec=
ted. How do i disconnect....?<BR>=0A<BR>=0AI guess i will have to use KDE S=
ystem Guard(ctrl+alt+delete) to kill the wvdial process. Any other ways of =
doing it....?<BR>=0A<BR>=0AThanx alot folks....!!<BR>=0A<BR>=0ACheerio<BR>=
=0A<BR>=0AAdil.<BR>=0A<BR>=0A<BR>=0AOn Sun, 10 Apr 2005 Bruno Abinader wrot=
e :<BR>=0A&gt;bind 0... i think it only can be a &quot;yes/no&quot; answer,=
 not &quot;0/1&quot;, but i'm not sure!<BR>=0A&gt;<BR>=0A&gt; &gt;&nbsp; Hi=
 Marcel,<BR>=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; Well i tried doing as u directed but it didnt seem to work.i<BR>=0A&=
gt; &gt; guess i am making some mistake.Newa i am putting the contents of<B=
R>=0A&gt; &gt; /etc/bluetooth/rfcomm.conf file below and also the console o=
ut i got after i<BR>=0A&gt; &gt; restarted the bluetooth service.<BR>=0A&gt=
; &gt;<BR>=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; root@localhost ~]# cat /etc/bl=
uetooth/rfcomm.conf<BR>=0A&gt; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; # RFCOMM =
configuration file.<BR>=0A&gt; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; # $Id: rf=
comm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $<BR>=0A&gt; &gt;&nbsp; #<BR>=
=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; # Example:<BR>=
=0A&gt; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; #rfcomm0 {<BR>=0A&gt; &gt;&nbsp;=
 #&nbsp; &nbsp; &nbsp; # Automatically bind the device at startup<BR>=0A&gt=
; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; bind no;<BR>=0A&gt; &gt;&nbsp; #<BR>=0A&=
gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; # Bluetooth address of the device<BR>=
=0A&gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; device 11:22:33:44:55:66;<BR>=0A&g=
t; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; # RFCOMM channe=
l for the connection<BR>=0A&gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; channel 1;=
<BR>=0A&gt; &gt;&nbsp; #<BR>=0A&gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; # Desc=
ription of the connection<BR>=0A&gt; &gt;&nbsp; #&nbsp; &nbsp; &nbsp; comme=
nt &quot;Example Bluetooth device&quot;;<BR>=0A&gt; &gt;&nbsp; #}<BR>=0A&gt=
; &gt;&nbsp; rfcomm0 {<BR>=0A&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bi=
nd 0;<BR>=0A&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; device 00:0F:DE:86:=
2F:66;<BR>=0A&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; channel&nbsp; 7;<B=
R>=0A&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<BR>=0A&gt; &gt;&nbsp; [r=
oot@localhost ~]# service bluetooth restart<BR>=0A&gt; &gt;&nbsp; Stopping =
Bluetooth services:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [&nbsp; OK&nbsp; ]<BR>=0A&=
gt; &gt;&nbsp; syntax error line 24ervices:&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [&=
nbsp; OK&nbsp; ]<BR>=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; [root@localhost ~]#<=
BR>=0A&gt; &gt;<BR>=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; Please Advice...?<BR>=
=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; where do i put the init script....? am c=
onfused....<BR>=0A&gt; &gt;<BR>=0A&gt; &gt;&nbsp; Thanx..<BR>=0A&gt; &gt;<B=
R>=0A&gt; &gt;&nbsp; adil<BR>=0A&gt;--<BR>=0A&gt;Bruno de Oliveira Abinader=
<BR>=0A&gt;GVoIP - INdT/UFAM<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;--------------=
-----------------------------------------<BR>=0A&gt;SF email is sponsored b=
y - The IT Product Guide<BR>=0A&gt;Read honest &amp; candid reviews on hund=
reds of IT Products from real users.<BR>=0A&gt;Discover which products trul=
y live up to the hype. Start reading now.<BR>=0A&gt;http://ads.osdn.com/?ad=
_id=3D6595&amp;alloc_id=3D14396&amp;op=3Dclick<BR>=0A&gt;__________________=
_____________________________<BR>=0A&gt;Bluez-users mailing list<BR>=0A&gt;=
Bluez-users@lists.sourceforge.net<BR>=0A&gt;https://lists.sourceforge.net/l=
ists/listinfo/bluez-users<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" H=
REF=3D"http://clients.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http:=
//ads.rediff.com/RealMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm=
@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1113162507---0-203.199.83.33-23657--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
