Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2008 11:42:49 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <693063.42845.qm@web8402.mail.in.yahoo.com>
Subject: Re: [Bluez-devel] [PATCH] Add support for Texas Instruments' chips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1995413193=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1995413193==
Content-Type: multipart/alternative; boundary="0-279058438-1215756769=:42845"

--0-279058438-1215756769=:42845
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ohad=0ASorry to break the link.=0AI am working on arm platform. I want t=
o configure TI's brf6350 on UART.=0AI read some of the mail on the list. I =
came to know that hci_ll.c provides support for brf6350.=0AIs the hci lower=
 level support in kernel enough to drive the chip?=0A=0AWhat else I have to=
 do at kernel side to bring UP my brf6350?=0AWhere would I get the brf scri=
pt file for my chip?=0A=0AYour response is much awaited.=0AThanks and Best =
regards=0A=0A=0APramod=0A=0A=0A=0A----- Original Message ----=0AFrom: Marce=
l Holtmann <marcel@holtmann.org>=0ATo: BlueZ development <bluez-devel@lists=
.sourceforge.net>=0ASent: Thursday, 10 July, 2008 6:03:23 PM=0ASubject: Re:=
 [Bluez-devel] [PATCH] Add support for Texas Instruments' chips=0A=0AHi Oha=
d,=0A=0A> > please put all the TI code into hciattach_ti.c and then I gonna=
 apply=0A> > this patch.=0A> =0A> I'm gonna have to put some common definit=
ions in hciattach.h then=0A> (mainly struct uart_t).=0A> =0A> Is that ok ?=
=0A=0Ano. Do the same as I did for hciattach_st.c=0A=0ARegards=0A=0AMarcel=
=0A=0A=0A=0A---------------------------------------------------------------=
----------=0ASponsored by: SourceForge.net Community Choice Awards: VOTE NO=
W!=0AStudies have shown that voting for your favorite open source project,=
=0Aalong with a healthy diet, reduces your potential for chronic lameness=
=0Aand boredom. Vote Now at http://www.sourceforge.net/community/cca08=0A__=
_____________________________________________=0ABluez-devel mailing list=0A=
Bluez-devel@lists.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/lis=
tinfo/bluez-devel=0A=0A=0A=0A      Explore your hobbies and interests. Go t=
o http://in.promos.yahoo.com/groups/
--0-279058438-1215756769=:42845
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Hi Ohad<br>Sorry to break the link.<br>I am working on arm =
platform. I want to configure TI's brf6350 on UART.<br>I read some of the m=
ail on the list. I came to know that hci_ll.c provides support for brf6350.=
<br>Is the hci lower level support in kernel enough to drive the chip?<br><=
div>What else I have to do at kernel side to bring UP my brf6350?<br>Where =
would I get the brf script file for my chip?<br><br>Your response is much a=
waited.<br></div>Thanks and Best regards<br><br><div>Pramod<div><br></div><=
div style=3D"font-family: times new roman,new york,times,serif; font-size: =
12pt;"><br><div style=3D"font-family: arial,helvetica,sans-serif; font-size=
: 10pt;">----- Original Message ----<br>From: Marcel Holtmann &lt;marcel@ho=
ltmann.org&gt;<br>To: BlueZ development
 &lt;bluez-devel@lists.sourceforge.net&gt;<br>Sent: Thursday, 10 July, 2008=
 6:03:23 PM<br>Subject: Re: [Bluez-devel] [PATCH] Add support for Texas Ins=
truments' chips<br><br>Hi Ohad,<br><br>&gt; &gt; please put all the TI code=
 into hciattach_ti.c and then I gonna apply<br>&gt; &gt; this patch.<br>&gt=
; <br>&gt; I'm gonna have to put some common definitions in hciattach.h the=
n<br>&gt; (mainly struct uart_t).<br>&gt; <br>&gt; Is that ok ?<br><br>no. =
Do the same as I did for hciattach_st.c<br><br>Regards<br><br>Marcel<br><br=
><br><br>------------------------------------------------------------------=
-------<br>Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!=
<br>Studies have shown that voting for your favorite open source project,<b=
r>along with a healthy diet, reduces your potential for chronic lameness<br=
>and boredom. Vote Now at <a href=3D"http://www.sourceforge.net/community/c=
ca08"
 target=3D"_blank">http://www.sourceforge.net/community/cca08</a><br>______=
_________________________________________<br>Bluez-devel mailing list<br><a=
 ymailto=3D"mailto:Bluez-devel@lists.sourceforge.net" href=3D"mailto:Bluez-=
devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a hr=
ef=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=3D"_=
blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></di=
v></div></div></div><br>=0A=0A=0A      <!--10--><hr size=3D1></hr> From Cha=
ndigarh to Chennai - find friends all over India. <a href=3D"http://in.rd.y=
ahoo.com/tagline_groups_10/*http://in.promos.yahoo.com/groups/citygroups/">=
 Click here.</a></body></html>
--0-279058438-1215756769=:42845--


--===============1995413193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1995413193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1995413193==--
