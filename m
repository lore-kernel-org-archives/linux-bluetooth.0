Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2008 15:09:50 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <796960.85710.qm@web8401.mail.in.yahoo.com>
Subject: Re: [Bluez-users] BRF6350 support
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1596994532=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1596994532==
Content-Type: multipart/alternative; boundary="0-1671343121-1215769190=:85710"

--0-1671343121-1215769190=:85710
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry Ohad=0AThey were sent once but to different mailing list.=0AAnyways i=
'll take care it won't happen again.=0A=0A Thanks and Best regards=0A=0A=0A=
Pramod=0A=0A=0A=0A----- Original Message ----=0AFrom: Ohad Ben-Cohen <ohad@=
bencohen.org>=0ATo: BlueZ users <bluez-users@lists.sourceforge.net>=0ASent:=
 Friday, 11 July, 2008 2:47:19 PM=0ASubject: Re: [Bluez-users] BRF6350 supp=
ort=0A=0AHi Pramod,=0A=0APlease don't send the same question so many times.=
=0AI will shortly repeat my answer for the general interest.=0A=0AOn Fri, J=
ul 11, 2008 at 11:41 AM, pramod gurav=0A<pramod_gurav_etc@yahoo.co.in> wrot=
e:=0A> Hi All,=0A> I am working on arm platform. I want to configure TI's b=
rf6350 bluetooth=0A> chip on UART.=0A> I read some of the mail on the list.=
 I came to know that hci_ll.c provides=0A> support for brf6350.=0A> Support=
 for these chip is being added to bluez hciattach.=0A> Is the hci lower lev=
el support in kernel enough to drive the chip?=0A=0AYes, though you may wan=
t to add platform-specific power management=0Afeatures that let you control=
 the chip power leg and/or let the chip=0Awake up the host in case of a blu=
etooth acitivity.=0AYou can take a look how we did that on the OMAP 2430 pl=
atform at=0Ahttp://brflinux.sourceforge.net/.=0A=0A> Where would I get the =
brf script file for my chip?=0A=0AThat depends on your specific chip versio=
n and personal preferences.=0A=0AWe have a dedicated list for supporting TI=
's chip - please send your=0Aquestion there (for details visit the site I m=
entioned above).=0A=0ABR,=0AOhad.=0A>=0A> Thanks and Best regards=0A>=0A> P=
ramod=0A>=0A> ________________________________=0A> Meet people who discuss =
and share your passions. Join them now.=0A> -------------------------------=
------------------------------------------=0A> Sponsored by: SourceForge.ne=
t Community Choice Awards: VOTE NOW!=0A> Studies have shown that voting for=
 your favorite open source project,=0A> along with a healthy diet, reduces =
your potential for chronic lameness=0A> and boredom. Vote Now at http://www=
.sourceforge.net/community/cca08=0A> ______________________________________=
_________=0A> Bluez-users mailing list=0A> Bluez-users@lists.sourceforge.ne=
t=0A> https://lists.sourceforge.net/lists/listinfo/bluez-users=0A>=0A>=0A=
=0A------------------------------------------------------------------------=
-=0ASponsored by: SourceForge.net Community Choice Awards: VOTE NOW!=0AStud=
ies have shown that voting for your favorite open source project,=0Aalong w=
ith a healthy diet, reduces your potential for chronic lameness=0Aand bored=
om. Vote Now at http://www.sourceforge.net/community/cca08=0A______________=
_________________________________=0ABluez-users mailing list=0ABluez-users@=
lists.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-=
users=0A=0A=0A=0A      Share files, take polls, and make new friends - all =
under one roof. Go to http://in.promos.yahoo.com/groups/
--0-1671343121-1215769190=:85710
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Sorry Ohad<br>They were sent once but to different mailing =
list.<br>Anyways i'll take care it won't happen again.<br><div>&nbsp;</div>=
Thanks and Best regards<br><br><div>Pramod<div><br></div><div style=3D"font=
-family: times new roman,new york,times,serif; font-size: 12pt;"><br><div s=
tyle=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;">----- Or=
iginal Message ----<br>From: Ohad Ben-Cohen &lt;ohad@bencohen.org&gt;<br>To=
: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Friday, 11=
 July, 2008 2:47:19 PM<br>Subject: Re: [Bluez-users] BRF6350 support<br><br=
>Hi Pramod,<br><br>Please don't send the same question so many times.<br>I =
will shortly repeat my answer for the general interest.<br><br>On Fri, Jul =
11, 2008 at 11:41 AM, pramod gurav<br>&lt;<a
 ymailto=3D"mailto:pramod_gurav_etc@yahoo.co.in" href=3D"mailto:pramod_gura=
v_etc@yahoo.co.in">pramod_gurav_etc@yahoo.co.in</a>&gt; wrote:<br>&gt; Hi A=
ll,<br>&gt; I am working on arm platform. I want to configure TI's brf6350 =
bluetooth<br>&gt; chip on UART.<br>&gt; I read some of the mail on the list=
. I came to know that hci_ll.c provides<br>&gt; support for brf6350.<br>&gt=
; Support for these chip is being added to bluez hciattach.<br>&gt; Is the =
hci lower level support in kernel enough to drive the chip?<br><br>Yes, tho=
ugh you may want to add platform-specific power management<br>features that=
 let you control the chip power leg and/or let the chip<br>wake up the host=
 in case of a bluetooth acitivity.<br>You can take a look how we did that o=
n the OMAP 2430 platform at<br><a href=3D"http://brflinux.sourceforge.net/"=
 target=3D"_blank">http://brflinux.sourceforge.net/</a>.<br><br>&gt; Where =
would I get the brf script file for my chip?<br><br>That depends on your
 specific chip version and personal preferences.<br><br>We have a dedicated=
 list for supporting TI's chip - please send your<br>question there (for de=
tails visit the site I mentioned above).<br><br>BR,<br>Ohad.<br>&gt;<br>&gt=
; Thanks and Best regards<br>&gt;<br>&gt; Pramod<br>&gt;<br>&gt; __________=
______________________<br>&gt; Meet people who discuss and share your passi=
ons. Join them now.<br>&gt; -----------------------------------------------=
--------------------------<br>&gt; Sponsored by: SourceForge.net Community =
Choice Awards: VOTE NOW!<br>&gt; Studies have shown that voting for your fa=
vorite open source project,<br>&gt; along with a healthy diet, reduces your=
 potential for chronic lameness<br>&gt; and boredom. Vote Now at <a href=3D=
"http://www.sourceforge.net/community/cca08" target=3D"_blank">http://www.s=
ourceforge.net/community/cca08</a><br>&gt; ________________________________=
_______________<br>&gt; Bluez-users mailing list<br>&gt; <a
 ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:Bluez-=
users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; =
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br=
>&gt;<br>&gt;<br><br>------------------------------------------------------=
-------------------<br>Sponsored by: SourceForge.net Community Choice Award=
s: VOTE NOW!<br>Studies have shown that voting for your favorite open sourc=
e project,<br>along with a healthy diet, reduces your potential for chronic=
 lameness<br>and boredom. Vote Now at <a href=3D"http://www.sourceforge.net=
/community/cca08" target=3D"_blank">http://www.sourceforge.net/community/cc=
a08</a><br>_______________________________________________<br>Bluez-users m=
ailing list<br><a ymailto=3D"mailto:Bluez-users@lists.sourceforge.net"
 href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.source=
forge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bl=
uez-users" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/b=
luez-users</a><br></div></div></div></div><br>=0A=0A=0A      <!--6--><hr si=
ze=3D1></hr> Explore your hobbies and interests. <a href=3D"http://in.rd.ya=
hoo.com/tagline_groups_6/*http://in.promos.yahoo.com/groups/">Click here to=
 begin.</a></body></html>
--0-1671343121-1215769190=:85710--


--===============1596994532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1596994532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1596994532==--
