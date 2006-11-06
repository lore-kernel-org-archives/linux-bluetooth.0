Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 6 Nov 2006 15:08:15 +0100
From: "Chafik Moalem" <Chafik.Moalem@perdictum.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <1111743.1162822095031.JavaMail.root@mail.prologistik.com>
Mime-Version: 1.0
Subject: [Bluez-devel] btsco/alsa-plugins Kernel 2.6.18-mh7 (and mh4-fch)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1061810980=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1061810980==
Content-Type: multipart/alternative;
	boundary="----=_Part_319_27503240.1162822095030"

------=_Part_319_27503240.1162822095030
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear Marcel, Dear Fabien,

ok ... my latest try was with vanilla 2.6.18-mh4 and fabiens (2006-10-12)=
 patch :
1. on my gentoo with gcc 3.4.5-r1 the applied mh4 patch leads to a compil=
ation error on linux/net/bluetooth/l2cap.c=A0 =3D=3D>=A0 I=A0 had to=A0 c=
omment out=A0 the=A0 prototype "static inline int l2cap_do_send_rfc( ..)"=
 and to=A0 move=A0 the=A0 implementation=A0 block=A0 to=A0 just=A0 before=
=A0  l2cap_retransmission_timer(..) where it is used the first time ....
for applying fabiens patch from 2006-10-12 some more work had to be done .=
=2E. since the formatting of the patch and (strangely) the ranges of the h=
unks where not that precise (fuzz up to 6 and one line offset of 10 and s=
ome manual delete /copy /paste stuff) ... finally everything was complete=
 and compiled fine with no warnings ;)

2. on 2.6.18-mh4-fch I just followed the new instructions with alsa-plugi=
n method ... FAILS with running headsetd and aplay with following message=
s :

=A0messages :
Nov=A0 6 14:24:05 chmo headsetd[18692]: Configuration phase ended: target=
 bdaddr is 00:17:91:01:00:08, timeout is 6000 ms
Nov=A0 6 14:24:05 chmo headsetd[18692]: unable to create bluetooth L2CAP s=
ocket: Operation now in progress
Nov=A0 6 14:24:05 chmo l2cap_sock_create: sock db74f9c0
Nov=A0 6 14:24:05 chmo l2cap_sock_init: sk cd75ca00
Nov=A0 6 14:24:05 chmo l2cap_sock_connect: sk cd75ca00
Nov=A0 6 14:24:05 chmo l2cap_do_connect: 00:00:00:00:00:00 -> 08:00:01:91=
:17:00 psm 0x01
Nov=A0 6 14:24:05 chmo l2cap_conn_add: hcon c0e49400 conn dcadf7c0
Nov=A0 6 14:24:05 chmo __l2cap_chan_add: conn dcadf7c0, psm 0x01, dcid 0x=
0000
Nov=A0 6 14:24:05 chmo l2cap_sock_set_timer: sk cd75ca00 state 5 timeout 4=
0000
Nov=A0 6 14:24:05 chmo l2cap_sock_release: sock db74f9c0, sk cd75ca00
Nov=A0 6 14:24:05 chmo l2cap_sock_shutdown: sock db74f9c0, sk cd75ca00
Nov=A0 6 14:24:05 chmo l2cap_sock_clear_timer: sock cd75ca00 state 5
Nov=A0 6 14:24:05 chmo __l2cap_sock_close: sk cd75ca00 state 5 socket db7=
4f9c0
Nov=A0 6 14:24:05 chmo l2cap_sock_clear_timer: sock cd75ca00 state 5
Nov=A0 6 14:24:05 chmo l2cap_chan_del: sk cd75ca00, conn dcadf7c0, err 0
Nov=A0 6 14:24:05 chmo l2cap_sock_kill: sk cd75ca00 state 9
Nov=A0 6 14:24:05 chmo l2cap_sock_destruct: sk cd75ca00
Nov=A0 6 14:24:05 chmo l2cap_connect_cfm: hcon c0e49400 bdaddr 08:00:01:9=
1:17:00 status 2
Nov=A0 6 14:24:05 chmo l2cap_conn_del: hcon c0e49400 conn dcadf7c0, err 1=
07

aplay :
aplay -D headset 400Hz.wav
DEBUG: _snd_pcm_sco_open: Starting pcm_sco plugin.
DEBUG: _snd_pcm_sco_open: Open mode is for Playback.
ALSA lib pcm_sco.c:485:(do_cfg) Unexpected packet type received: type =3D=
 2
aplay: main:550: audio open error: Das Argument ist ung=FCltig

By the way the l2cap socket problem AND the static inline problem exist=A0=
 the same way=A0 in an=A0 2.6.18-mh7(!)=A0 kernel=A0 with=A0 no fch=A0 mo=
difications=A0=A0 (and no=A0 manual=A0 poking by myself ;)=A0 )=A0=20

bluez libs und utils are 3.7=A0 ... alsa lib and utils 1.0.13
pairing works (!) at least with the snd_bt_sco / btsco-method and passkey=
-agent --default 1bla45
(verified with hcidump )=A0 ... but this method delivers only SILENCE in t=
he headset (though the sco-data seems to contain something valid in hcidu=
mp -X AND though using alsamixer to pump up the volume )
=20
aarggh ... is the l2cap_do_connect correct ?? why is source 00:00:00:00:0=
0:00

btw : l2test to that headset delivers a nice :
l2test -z 00:17:91:01:00:08
Connectionless MTU size is 670
Extended feature mask is 0x0000

and :
Nov=A0 6 14:46:16 chmo l2cap_sock_create: sock db74fb40
Nov=A0 6 14:46:16 chmo l2cap_sock_init: sk d31e2600
Nov=A0 6 14:46:16 chmo l2cap_sock_bind: sk d31e2600, 00:00:00:00:00:00 0
Nov=A0 6 14:46:16 chmo l2cap_sock_connect: sk d31e2600
Nov=A0 6 14:46:16 chmo l2cap_do_connect: 00:00:00:00:00:00 -> 08:00:01:91=
:17:00 psm 0x00
Nov=A0 6 14:46:16 chmo l2cap_conn_add: hcon dd582400 conn de6fa240
Nov=A0 6 14:46:16 chmo __l2cap_chan_add: conn de6fa240, psm 0x00, dcid 0x=
0000
Nov=A0 6 14:46:16 chmo l2cap_sock_set_timer: sk d31e2600 state 5 timeout 4=
0000
Nov=A0 6 14:46:17 chmo l2cap_connect_cfm: hcon dd582400 bdaddr 08:00:01:9=
1:17:00 status 0
Nov=A0 6 14:46:17 chmo l2cap_conn_ready: conn de6fa240
Nov=A0 6 14:46:17 chmo l2cap_sock_clear_timer: sock d31e2600 state 5
Nov=A0 6 14:46:17 chmo l2cap_sock_sendmsg: sock db74fb40, sk d31e2600
Nov=A0 6 14:46:17 chmo l2cap_do_send: sk d31e2600 len 6
Nov=A0 6 14:46:17 chmo l2cap_recv_acldata: conn de6fa240 len 14 flags 0x2=

Nov=A0 6 14:46:17 chmo l2cap_recv_frame: len 10, cid 0x0001
Nov=A0 6 14:46:17 chmo l2cap_raw_recv: conn de6fa240
Nov=A0 6 14:46:17 chmo l2cap_sig_channel: code 0x0b len 6 id 0x2a
Nov=A0 6 14:46:17 chmo l2cap_information_rsp: type 0x0001 result 0x00 ide=
nt 42
Nov=A0 6 14:46:17 chmo l2cap_sock_sendmsg: sock db74fb40, sk d31e2600
Nov=A0 6 14:46:17 chmo l2cap_do_send: sk d31e2600 len 6
Nov=A0 6 14:46:17 chmo l2cap_recv_acldata: conn de6fa240 len 16 flags 0x2=

Nov=A0 6 14:46:17 chmo l2cap_recv_frame: len 12, cid 0x0001
Nov=A0 6 14:46:17 chmo l2cap_raw_recv: conn de6fa240
Nov=A0 6 14:46:17 chmo l2cap_sig_channel: code 0x0b len 8 id 0x2a
Nov=A0 6 14:46:17 chmo l2cap_information_rsp: type 0x0002 result 0x00 ide=
nt 42
Nov=A0 6 14:46:17 chmo l2cap_sock_release: sock db74fb40, sk d31e2600
Nov=A0 6 14:46:17 chmo l2cap_sock_shutdown: sock db74fb40, sk d31e2600
Nov=A0 6 14:46:17 chmo l2cap_sock_clear_timer: sock d31e2600 state 1
Nov=A0 6 14:46:17 chmo __l2cap_sock_close: sk d31e2600 state 1 socket db7=
4fb40
Nov=A0 6 14:46:17 chmo l2cap_sock_clear_timer: sock d31e2600 state 1
Nov=A0 6 14:46:17 chmo l2cap_chan_del: sk d31e2600, conn de6fa240, err 0
Nov=A0 6 14:46:17 chmo l2cap_sock_kill: sk d31e2600 state 9
Nov=A0 6 14:46:17 chmo l2cap_sock_destruct: sk d31e2600
Nov=A0 6 14:46:19 chmo l2cap_disconn_ind: hcon dd582400 reason 22
Nov=A0 6 14:46:19 chmo l2cap_conn_del: hcon dd582400 conn de6fa240, err 1=
03

after sock_set_timer=20
here everything is fine ... hmm is it more on fabiens side ??

btw : with a kernel 2.6.17.r8 everything was ok with BOTH btsco AND alsa-=
plugin=A0 (but i=A0 just=A0 WANT to=A0 enable=A0 flow control=A0 ... so=A0=
 therefore=A0 mh patches=A0 AND (?)=A0 fch=A0 patches=A0 !!=20

I really appreciate your efforts ... and thank you a lot.=A0 My impressio=
n is that a proper implementation for extended SCO is REALLY needed (isn'=
t it what you are heading to?) and nobody really has had positive results=
 so far ... it would be great=A0 if bluez would do it first! (i will test=
/report as much as possible)
please help!

Fabien :
where can i find your scotest.c ??

best regards
Chafik

------=_Part_319_27503240.1162822095030
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} P {margin:0px=
;} --></style></head><body><font face=3D"times new roman, new york, times=
, serif" size=3D3><span style=3D"font-family: times new roman,new york,ti=
mes,serif;"><font size=3D"3">Dear Marcel, Dear Fabien,<br><br>ok ... my l=
atest try was with vanilla 2.6.18-mh4 and fabiens (2006-10-12) patch :<br=
>1. on my gentoo with gcc 3.4.5-r1 the applied mh4 patch leads to a compi=
lation error on linux/net/bluetooth/l2cap.c&nbsp; =3D=3D&gt;&nbsp; I&nbsp=
; had to&nbsp; comment out&nbsp; the&nbsp; prototype "static inline int l=
2cap_do_send_rfc( ..)" and to&nbsp; move&nbsp; the&nbsp; implementation&n=
bsp; block&nbsp; to&nbsp; just&nbsp; before&nbsp;  l2cap_retransmission_t=
imer(..) where it is used the first time ....<br>for applying fabiens pat=
ch from 2006-10-12 some more work had to be done ... since the formatting=
 of the patch and (strangely) the ranges of the hunks where not that prec=
ise (fuzz up to 6 and one line offset of 10 and some manual delete /copy /=
paste stuff) ... finally everything was complete and compiled fine with n=
o warnings ;)<br><br>2. on 2.6.18-mh4-fch I just followed the new instruc=
tions with alsa-plugin method ... FAILS with running headsetd and aplay w=
ith following messages :<br><br>&nbsp;messages :<br>Nov&nbsp; 6 14:24:05 c=
hmo headsetd[18692]: Configuration phase ended: target bdaddr is 00:17:91=
:01:00:08, timeout is 6000 ms<br>Nov&nbsp; 6 14:24:05 chmo headsetd[18692=
]: unable to create bluetooth L2CAP socket: Operation now in progress<br>=
Nov&nbsp; 6 14:24:05 chmo l2cap_sock_create: sock db74f9c0<br>Nov&nbsp; 6=
 14:24:05 chmo l2cap_sock_init: sk cd75ca00<br>Nov&nbsp; 6 14:24:05 chmo l=
2cap_sock_connect: sk cd75ca00<br>Nov&nbsp; 6 14:24:05 chmo l2cap_do_conn=
ect: 00:00:00:00:00:00 -&gt; 08:00:01:91:17:00 psm 0x01<br>Nov&nbsp; 6 14=
:24:05 chmo l2cap_conn_add: hcon c0e49400 conn dcadf7c0<br>Nov&nbsp; 6 14=
:24:05 chmo __l2cap_chan_add: conn dcadf7c0, psm 0x01, dcid 0x0000<br>Nov=
&nbsp; 6 14:24:05 chmo l2cap_sock_set_timer: sk cd75ca00 state 5 timeout 4=
0000<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_release: sock db74f9c0, sk c=
d75ca00<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_shutdown: sock db74f9c0, s=
k cd75ca00<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_clear_timer: sock cd75=
ca00 state 5<br>Nov&nbsp; 6 14:24:05 chmo __l2cap_sock_close: sk cd75ca00=
 state 5 socket db74f9c0<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_clear_ti=
mer: sock cd75ca00 state 5<br>Nov&nbsp; 6 14:24:05 chmo l2cap_chan_del: s=
k cd75ca00, conn dcadf7c0, err 0<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_=
kill: sk cd75ca00 state 9<br>Nov&nbsp; 6 14:24:05 chmo l2cap_sock_destruc=
t: sk cd75ca00<br>Nov&nbsp; 6 14:24:05 chmo l2cap_connect_cfm: hcon c0e49=
400 bdaddr 08:00:01:91:17:00 status 2<br>Nov&nbsp; 6 14:24:05 chmo l2cap_=
conn_del: hcon c0e49400 conn dcadf7c0, err 107<br><br>aplay :<br>aplay -D=
 headset 400Hz.wav<br>DEBUG: _snd_pcm_sco_open: Starting pcm_sco plugin.<=
br>DEBUG: _snd_pcm_sco_open: Open mode is for Playback.<br>ALSA lib pcm_s=
co.c:485:(do_cfg) Unexpected packet type received: type =3D 2<br>aplay: m=
ain:550: audio open error: Das Argument ist ung=FCltig<br><br>By the way t=
he l2cap socket problem AND the static inline problem exist&nbsp; the sam=
e way&nbsp; in an&nbsp; 2.6.18-mh7(!)&nbsp; kernel&nbsp; with&nbsp; no fc=
h&nbsp; modifications&nbsp;&nbsp; (and no&nbsp; manual&nbsp; poking by my=
self ;)&nbsp; )&nbsp; <br><br>bluez libs und utils are 3.7&nbsp; ... alsa=
 lib and utils 1.0.13<br>pairing works (!) at least with the snd_bt_sco /=
 btsco-method and passkey-agent --default 1bla45<br>(verified with hcidum=
p )&nbsp; ... but this method delivers only SILENCE in the headset (thoug=
h the sco-data seems to contain something valid in hcidump -X AND though u=
sing alsamixer to pump up the volume )<br> <br>aarggh ... is the l2cap_do=
_connect correct ?? why is source 00:00:00:00:00:00<br><br>btw : l2test t=
o that headset delivers a nice :<br>l2test -z 00:17:91:01:00:08<br>Connec=
tionless MTU size is 670<br>Extended feature mask is 0x0000<br><br>and :<=
br>Nov&nbsp; 6 14:46:16 chmo l2cap_sock_create: sock db74fb40<br>Nov&nbsp=
; 6 14:46:16 chmo l2cap_sock_init: sk d31e2600<br>Nov&nbsp; 6 14:46:16 ch=
mo l2cap_sock_bind: sk d31e2600, 00:00:00:00:00:00 0<br>Nov&nbsp; 6 14:46=
:16 chmo l2cap_sock_connect: sk d31e2600<br>Nov&nbsp; 6 14:46:16 chmo l2c=
ap_do_connect: 00:00:00:00:00:00 -&gt; 08:00:01:91:17:00 psm 0x00<br>Nov&=
nbsp; 6 14:46:16 chmo l2cap_conn_add: hcon dd582400 conn de6fa240<br>Nov&=
nbsp; 6 14:46:16 chmo __l2cap_chan_add: conn de6fa240, psm 0x00, dcid 0x0=
000<br>Nov&nbsp; 6 14:46:16 chmo l2cap_sock_set_timer: sk d31e2600 state 5=
 timeout 40000<br>Nov&nbsp; 6 14:46:17 chmo l2cap_connect_cfm: hcon dd582=
400 bdaddr 08:00:01:91:17:00 status 0<br>Nov&nbsp; 6 14:46:17 chmo l2cap_=
conn_ready: conn de6fa240<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_clear_t=
imer: sock d31e2600 state 5<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_sendm=
sg: sock db74fb40, sk d31e2600<br>Nov&nbsp; 6 14:46:17 chmo l2cap_do_send=
: sk d31e2600 len 6<br>Nov&nbsp; 6 14:46:17 chmo l2cap_recv_acldata: conn=
 de6fa240 len 14 flags 0x2<br>Nov&nbsp; 6 14:46:17 chmo l2cap_recv_frame:=
 len 10, cid 0x0001<br>Nov&nbsp; 6 14:46:17 chmo l2cap_raw_recv: conn de6=
fa240<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sig_channel: code 0x0b len 6 id 0=
x2a<br>Nov&nbsp; 6 14:46:17 chmo l2cap_information_rsp: type 0x0001 resul=
t 0x00 ident 42<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_sendmsg: sock db7=
4fb40, sk d31e2600<br>Nov&nbsp; 6 14:46:17 chmo l2cap_do_send: sk d31e260=
0 len 6<br>Nov&nbsp; 6 14:46:17 chmo l2cap_recv_acldata: conn de6fa240 le=
n 16 flags 0x2<br>Nov&nbsp; 6 14:46:17 chmo l2cap_recv_frame: len 12, cid=
 0x0001<br>Nov&nbsp; 6 14:46:17 chmo l2cap_raw_recv: conn de6fa240<br>Nov=
&nbsp; 6 14:46:17 chmo l2cap_sig_channel: code 0x0b len 8 id 0x2a<br>Nov&=
nbsp; 6 14:46:17 chmo l2cap_information_rsp: type 0x0002 result 0x00 iden=
t 42<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_release: sock db74fb40, sk d=
31e2600<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_shutdown: sock db74fb40, s=
k d31e2600<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_clear_timer: sock d31e=
2600 state 1<br>Nov&nbsp; 6 14:46:17 chmo __l2cap_sock_close: sk d31e2600=
 state 1 socket db74fb40<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_clear_ti=
mer: sock d31e2600 state 1<br>Nov&nbsp; 6 14:46:17 chmo l2cap_chan_del: s=
k d31e2600, conn de6fa240, err 0<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_=
kill: sk d31e2600 state 9<br>Nov&nbsp; 6 14:46:17 chmo l2cap_sock_destruc=
t: sk d31e2600<br>Nov&nbsp; 6 14:46:19 chmo l2cap_disconn_ind: hcon dd582=
400 reason 22<br>Nov&nbsp; 6 14:46:19 chmo l2cap_conn_del: hcon dd582400 c=
onn de6fa240, err 103<br><br>after sock_set_timer <br>here everything is f=
ine ... hmm is it more on fabiens side ??<br><br>btw : with a kernel 2.6.=
17.r8 everything was ok with BOTH btsco AND alsa-plugin&nbsp; (but i&nbsp=
; just&nbsp; WANT to&nbsp; enable&nbsp; flow control&nbsp; ... so&nbsp; t=
herefore&nbsp; mh patches&nbsp; AND (?)&nbsp; fch&nbsp; patches&nbsp; !! <=
br><br>I really appreciate your efforts ... and thank you a lot.&nbsp; My=
 impression is that a proper implementation for extended SCO is REALLY ne=
eded (isn't it what you are heading to?) and nobody really has had positi=
ve results so far ... it would be great&nbsp; if bluez would do it first!=
 (i will test/report as much as possible)<br>please help!<br><br>Fabien :=
<br>where can i find your scotest.c ??<br><br>best regards<br>Chafik<br><=
/font></span></font></body></html>
------=_Part_319_27503240.1162822095030--


--===============1061810980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1061810980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1061810980==--
