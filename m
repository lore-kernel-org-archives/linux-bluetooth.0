Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508e92ca1003190133m1e2769ev36430d3c3b28504@mail.gmail.com>
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com>
	<a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com>
	<35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com>
	<4B87A10C.4070100@nokia.com>
	<4B95F67A.9090305@nokia.com>
	<35c90d961003082331p6798006do17d6178ae2840591@mail.gmail.com>
	<508e92ca1003190133m1e2769ev36430d3c3b28504@mail.gmail.com>
Date: Fri, 29 Oct 2010 18:04:08 +0530
Message-ID: <AANLkTikNyeU+uj3WVtuxsBU7t2iDGiPHQSmCfGx9UWLK@mail.gmail.com>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on rfcomm_session
From: Simantini Bhattacharya <simantini.bhattacharya@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Nick Pelly <npelly@google.com>, Ville Tervo <ville.tervo@nokia.com>,
	Dave Young <hidave.darkstar@gmail.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary=20cf301d431cc7729f0493c0ac87
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf301d431cc7729f0493c0ac87
Content-Type: text/plain; charset=ISO-8859-1

Hi All ,
I have seen a similar issue when testing my device with Motorola 17 mono
headset . The use-case tried was as follows :
1)Pair connect device to Motorola H17
2)Power up Bluetooth on my device
3)Power back Bluetooth on the device .
On repeating this sequence for around 10-15 times I see the following kernel
panic . Trace shown as  below .
Can you let me know your comments on this ?

<6>[ 1100.245300] Bluetooth:
<6>[ 1100.247985] Bluetooth:
<6>[ 1100.251068] Bluetooth: sock ca817360, sk cbe32e00
<6>[ 1100.263336] Bluetooth: sock ca817360, sk cbe32e00
<6>[ 1100.268524] Bluetooth: sock cbe32e00 state 4
<6>[ 1100.273468] Bluetooth: sk cbe32e00 state 4 socket ca817360
<6>[ 1100.279296] Bluetooth: parent cbe32e00
<6>[ 1100.283325] Bluetooth: sock d3832080 state 7
<6>[ 1100.287872] Bluetooth: hu db514b00 count 52 rx_state 0 rx_count 0
<6>[ 1100.294372] Bluetooth: Event packet
<6>[ 1100.298126] Bluetooth: Event header: evt 0x13 plen 5
<6>[ 1100.303375] Bluetooth: len 5 room 1078
<6>[ 1100.307403] Bluetooth: Complete data
<6>[ 1100.311218] Bluetooth: Event packet
<6>[ 1100.314941] Bluetooth: Event header: evt 0x13 plen 5
<6>[ 1100.320281] Bluetooth: hci0
<6>[ 1100.323272] Bluetooth: hdev cbe32980 len 7
<6>[ 1100.327606] Bluetooth: hci0 num_hndl 1
<6>[ 1100.331665] Bluetooth: hci0 acl 3 sco 4
<6>[ 1100.335723] Bluetooth: hci0
<6>[ 1100.338714] Bluetooth: conn (null) quote 0
<6>[ 1100.343139] Bluetooth: hci0
<6>[ 1100.346099] Bluetooth: conn (null) quote 0
<6>[ 1100.350463] Bluetooth: hci0
<6>[ 1100.353515] Bluetooth: conn (null) quote 0
<6>[ 1100.357849] Bluetooth: len 5 room 1078
<6>[ 1100.361846] Bluetooth: Complete data
<6>[ 1100.365722] Bluetooth: ACL packet
<6>[ 1100.369262] Bluetooth: ACL header: dlen 14
<6>[ 1100.373596] Bluetooth: hci0
<6>[ 1100.376586] Bluetooth: hdev cbe32980 len 7
<6>[ 1100.381011] Bluetooth: hci0 num_hndl 1
<6>[ 1100.384979] Bluetooth: hci0 acl 4 sco 4
<6>[ 1100.389038] Bluetooth: hci0
<6>[ 1100.392089] Bluetooth: conn (null) quote 0
<6>[ 1100.396453] Bluetooth: hci0
<6>[ 1100.399414] Bluetooth: conn (null) quote 0
<6>[ 1100.403839] Bluetooth: hci0
<6>[ 1100.406799] Bluetooth: conn (null) quote 0
<6>[ 1100.411163] Bluetooth: len 14 room 1076
<6>[ 1100.415283] Bluetooth: Complete data
<6>[ 1100.419097] Bluetooth: ACL packet
<6>[ 1100.422637] Bluetooth: ACL header: dlen 24
<6>[ 1100.427032] Bluetooth: hci0
<6>[ 1100.430023] Bluetooth: hdev cbe32980 len 18
<6>[ 1100.434448] Bluetooth: hci0 ACL data packet
<6>[ 1100.438934] Bluetooth: hci0 len 14 handle 0x1 flags 0x2
<6>[ 1100.444458] Bluetooth: conn d3a0f5c0 mode 0
<6>[ 1100.448913] Bluetooth: conn db5473c0 len 14 flags 0x2
<6>[ 1100.454284] Bluetooth: len 10, cid 0x0001
<6>[ 1100.458557] Bluetooth: conn db5473c0
<6>[ 1100.462341] Bluetooth: code 0x05 len 6 id 0x02
<6>[ 1100.467132] Bluetooth: scid 0x0040 flags 0x00 result 0x00
<6>[ 1100.472808] Bluetooth: sk d3832080, parent (null)
<6>[ 1100.477874] Bluetooth: sock d3832080 state 1
<6>[ 1100.482421] Bluetooth: len 24 room 1076
<6>[ 1100.487579] Bluetooth: sock ca817b08
<6>[ 1100.491485] Bluetooth: cmd 400448ca arg 0
<6>[ 1100.498565] Bluetooth: sk d3832080 state 1 socket (null)
<6>[ 1100.504699] Bluetooth: 0
<6>[ 1100.507415] Bluetooth: hci0 cbe32980
<6>[ 1100.511230] Bluetooth: hci0 err 0x13
<6>[ 1100.515014] Bluetooth: cache cbe32bc0
<6>[ 1100.518981] Bluetooth: hdev hci0
<6>[ 1100.522430] Bluetooth: hcon d3a0f5c0 reason 22
<6>[ 1100.527130] Bluetooth: hcon d3a0f5c0 conn db5473c0, err 103
<6>[ 1100.533081] Bluetooth: sock d3832080 state 1
<6>[ 1100.537597] Bluetooth: sk d3832080, conn db5473c0, err 103
<6>[ 1100.543487] Bluetooth: sk d3832080 state 9
<6>[ 1100.547821] Bluetooth: sk d3832080
<6>[ 1100.551452] Bluetooth: hcon d3a0f5c0 reason 22
<6>[ 1100.556213] Bluetooth: hci0 conn d3a0f5c0 handle 1
<6>[ 1100.561279] Bluetooth: conn d3a0f5c0
<1>[ 1100.566925] Unable to handle kernel paging request at virtual address
6b6b6b6b


<1>[ 1100.574584] pgd = c0004000
<1>[ 1100.577453] [6b6b6b6b] *pgd=00000000
<0>[ 1100.581420] Internal error: Oops: 5 [#1] PREEMPT
<0>[ 1100.586303] last sysfs file:
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
<4>[ 1100.594573] Modules linked in: em_u32 sch_htb cls_u32 act_police
sch_ingress act_mirred ifb sec
<4>[ 1100.604522] CPU: 0    Tainted: G        W   (2.6.32.9-g09b2432-dirty
#1)
<4>[ 1100.611602] PC is at release_sock+0x60/0xf0
<4>[ 1100.616088] LR is at release_sock+0x18/0xf0

<4>[ 1101.576324] [<c0309930>] (release_sock+0x60/0xf0) from [<c03e9f40>]
(__l2cap_sock_close+0x8c/0x31c)
<4>[ 1101.585876] [<c03e9f40>] (__l2cap_sock_close+0x8c/0x31c) from
[<c03ed9b4>] (l2cap_sock_shutdown+0x5c/0xa0)
<4>[ 1101.596069] [<c03ed9b4>] (l2cap_sock_shutdown+0x5c/0xa0) from
[<c03eda2c>] (l2cap_sock_release+0x34/0x90)
<4>[ 1101.606170] [<c03eda2c>] (l2cap_sock_release+0x34/0x90) from
[<c0307ccc>] (sock_release+0x20/0xb0)
<4>[ 1101.615570] [<c0307ccc>] (sock_release+0x20/0xb0) from [<c0307d7c>]
(sock_close+0x20/0x2c)
<4>[ 1101.624267] [<c0307d7c>] (sock_close+0x20/0x2c) from [<c00c978c>]
(__fput+0x11c/0x218)
<4>[ 1101.632659] [<c00c978c>] (__fput+0x11c/0x218) from [<c00c65a8>]
(filp_close+0x6c/0x78)
<4>[ 1101.641052] [<c00c65a8>] (filp_close+0x6c/0x78) from [<c0068f38>]
(put_files_struct+0x88/0xf0)
<4>[ 1101.650085] [<c0068f38>] (put_files_struct+0x88/0xf0) from
[<c006a7bc>] (do_exit+0x1b0/0x698)
<4>[ 1101.659088] [<c006a7bc>] (do_exit+0x1b0/0x698) from [<c006ad54>]
(do_group_exit+0xb0/0xdc)
<4>[ 1101.667846] [<c006ad54>] (do_group_exit+0xb0/0xdc) from [<c006ad90>]
(sys_exit_group+0x10/0x18)
<4>[ 1101.677032] [<c006ad90>] (sys_exit_group+0x10/0x18) from [<c0034f40>]
(ret_fast_syscall+0x0/0x2c)


On Fri, Mar 19, 2010 at 2:03 PM, Andrei Emeltchenko <
andrei.emeltchenko.news@gmail.com> wrote:

> Hi,
>
> On Tue, Mar 9, 2010 at 9:31 AM, Nick Pelly <npelly@google.com> wrote:
> > On Mon, Mar 8, 2010 at 11:19 PM, Ville Tervo <ville.tervo@nokia.com>
> wrote:
> >> Tervo Ville (Nokia-D/Helsinki) wrote:
> >>>
> >>> l2cap socket status might change while rfcomm is processing frames. And
> >>> that makes rfcomm_process_rx to do double rfcomm_session_put() for
> incoming
> >>> session reference. We cannot use sk_state.
> >>>
> >>> Could you try with this patch if it helps to your problems also? My OPP
> >>> problems went away with this patch.
> >>>
> >>> I moved rfcomm_session_put() for incoming session to
> rfcomm_session_close
> >>> in order to get more clear _hold()/_put() pairs.
> >>>
> >>>
> >>
> >> Any comments about the patch in previous mail?
> >
> > Your patch looks sane to me, although I know enough of the Bluez
> > rfcomm state machine to know that I don't know it that well :)
>
> We have tested this patch and it looks to be working. Shall we apply it?
>
> Regards,
> Andrei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--20cf301d431cc7729f0493c0ac87
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All ,<br>I have seen a similar issue when testing my device with Motorol=
a 17 mono headset . The use-case tried was as follows : <br>1)Pair connect =
device to Motorola H17<br>2)Power up Bluetooth on my device <br>3)Power bac=
k Bluetooth on the device . <br>
On repeating this sequence for around 10-15 times I see the following kerne=
l panic . Trace shown as=A0 below . <br>Can you let me know your comments o=
n this ?<br><br>&lt;6&gt;[ 1100.245300] Bluetooth: <br>&lt;6&gt;[ 1100.2479=
85] Bluetooth: <br>
&lt;6&gt;[ 1100.251068] Bluetooth: sock ca817360, sk cbe32e00<br>&lt;6&gt;[=
 1100.263336] Bluetooth: sock ca817360, sk cbe32e00<br>&lt;6&gt;[ 1100.2685=
24] Bluetooth: sock cbe32e00 state 4<br>&lt;6&gt;[ 1100.273468] Bluetooth: =
sk cbe32e00 state 4 socket ca817360<br>
&lt;6&gt;[ 1100.279296] Bluetooth: parent cbe32e00<br>&lt;6&gt;[ 1100.28332=
5] Bluetooth: sock d3832080 state 7<br>&lt;6&gt;[ 1100.287872] Bluetooth: h=
u db514b00 count 52 rx_state 0 rx_count 0<br>&lt;6&gt;[ 1100.294372] Blueto=
oth: Event packet<br>
&lt;6&gt;[ 1100.298126] Bluetooth: Event header: evt 0x13 plen 5<br>&lt;6&g=
t;[ 1100.303375] Bluetooth: len 5 room 1078<br>&lt;6&gt;[ 1100.307403] Blue=
tooth: Complete data<br>&lt;6&gt;[ 1100.311218] Bluetooth: Event packet<br>
&lt;6&gt;[ 1100.314941] Bluetooth: Event header: evt 0x13 plen 5<br>&lt;6&g=
t;[ 1100.320281] Bluetooth: hci0<br>&lt;6&gt;[ 1100.323272] Bluetooth: hdev=
 cbe32980 len 7<br>&lt;6&gt;[ 1100.327606] Bluetooth: hci0 num_hndl 1<br>
&lt;6&gt;[ 1100.331665] Bluetooth: hci0 acl 3 sco 4<br>&lt;6&gt;[ 1100.3357=
23] Bluetooth: hci0<br>&lt;6&gt;[ 1100.338714] Bluetooth: conn (null) quote=
 0<br>&lt;6&gt;[ 1100.343139] Bluetooth: hci0<br>&lt;6&gt;[ 1100.346099] Bl=
uetooth: conn (null) quote 0<br>
&lt;6&gt;[ 1100.350463] Bluetooth: hci0<br>&lt;6&gt;[ 1100.353515] Bluetoot=
h: conn (null) quote 0<br>&lt;6&gt;[ 1100.357849] Bluetooth: len 5 room 107=
8<br>&lt;6&gt;[ 1100.361846] Bluetooth: Complete data<br>&lt;6&gt;[ 1100.36=
5722] Bluetooth: ACL packet<br>
&lt;6&gt;[ 1100.369262] Bluetooth: ACL header: dlen 14<br>&lt;6&gt;[ 1100.3=
73596] Bluetooth: hci0<br>&lt;6&gt;[ 1100.376586] Bluetooth: hdev cbe32980 =
len 7<br>&lt;6&gt;[ 1100.381011] Bluetooth: hci0 num_hndl 1<br>&lt;6&gt;[ 1=
100.384979] Bluetooth: hci0 acl 4 sco 4<br>
&lt;6&gt;[ 1100.389038] Bluetooth: hci0<br>&lt;6&gt;[ 1100.392089] Bluetoot=
h: conn (null) quote 0<br>&lt;6&gt;[ 1100.396453] Bluetooth: hci0<br>&lt;6&=
gt;[ 1100.399414] Bluetooth: conn (null) quote 0<br>&lt;6&gt;[ 1100.403839]=
 Bluetooth: hci0<br>
&lt;6&gt;[ 1100.406799] Bluetooth: conn (null) quote 0<br>&lt;6&gt;[ 1100.4=
11163] Bluetooth: len 14 room 1076<br>&lt;6&gt;[ 1100.415283] Bluetooth: Co=
mplete data<br>&lt;6&gt;[ 1100.419097] Bluetooth: ACL packet<br>&lt;6&gt;[ =
1100.422637] Bluetooth: ACL header: dlen 24<br>
&lt;6&gt;[ 1100.427032] Bluetooth: hci0<br>&lt;6&gt;[ 1100.430023] Bluetoot=
h: hdev cbe32980 len 18<br>&lt;6&gt;[ 1100.434448] Bluetooth: hci0 ACL data=
 packet<br>&lt;6&gt;[ 1100.438934] Bluetooth: hci0 len 14 handle 0x1 flags =
0x2<br>
&lt;6&gt;[ 1100.444458] Bluetooth: conn d3a0f5c0 mode 0<br>&lt;6&gt;[ 1100.=
448913] Bluetooth: conn db5473c0 len 14 flags 0x2<br>&lt;6&gt;[ 1100.454284=
] Bluetooth: len 10, cid 0x0001<br>&lt;6&gt;[ 1100.458557] Bluetooth: conn =
db5473c0<br>
&lt;6&gt;[ 1100.462341] Bluetooth: code 0x05 len 6 id 0x02<br>&lt;6&gt;[ 11=
00.467132] Bluetooth: scid 0x0040 flags 0x00 result 0x00<br>&lt;6&gt;[ 1100=
.472808] Bluetooth: sk d3832080, parent (null)<br>&lt;6&gt;[ 1100.477874] B=
luetooth: sock d3832080 state 1<br>
&lt;6&gt;[ 1100.482421] Bluetooth: len 24 room 1076<br>&lt;6&gt;[ 1100.4875=
79] Bluetooth: sock ca817b08<br>&lt;6&gt;[ 1100.491485] Bluetooth: cmd 4004=
48ca arg 0<br>&lt;6&gt;[ 1100.498565] Bluetooth: sk d3832080 state 1 socket=
 (null)<br>
&lt;6&gt;[ 1100.504699] Bluetooth: 0<br>&lt;6&gt;[ 1100.507415] Bluetooth: =
hci0 cbe32980<br>&lt;6&gt;[ 1100.511230] Bluetooth: hci0 err 0x13<br>&lt;6&=
gt;[ 1100.515014] Bluetooth: cache cbe32bc0<br>&lt;6&gt;[ 1100.518981] Blue=
tooth: hdev hci0<br>
&lt;6&gt;[ 1100.522430] Bluetooth: hcon d3a0f5c0 reason 22<br>&lt;6&gt;[ 11=
00.527130] Bluetooth: hcon d3a0f5c0 conn db5473c0, err 103<br>&lt;6&gt;[ 11=
00.533081] Bluetooth: sock d3832080 state 1<br>&lt;6&gt;[ 1100.537597] Blue=
tooth: sk d3832080, conn db5473c0, err 103<br>
&lt;6&gt;[ 1100.543487] Bluetooth: sk d3832080 state 9<br>&lt;6&gt;[ 1100.5=
47821] Bluetooth: sk d3832080<br>&lt;6&gt;[ 1100.551452] Bluetooth: hcon d3=
a0f5c0 reason 22<br>&lt;6&gt;[ 1100.556213] Bluetooth: hci0 conn d3a0f5c0 h=
andle 1<br>
&lt;6&gt;[ 1100.561279] Bluetooth: conn d3a0f5c0<br>&lt;1&gt;[ 1100.566925]=
 Unable to handle kernel paging request at virtual address 6b6b6b6b<br><br>=
<br>&lt;1&gt;[ 1100.574584] pgd =3D c0004000<br>&lt;1&gt;[ 1100.577453] [6b=
6b6b6b] *pgd=3D00000000<br>
&lt;0&gt;[ 1100.581420] Internal error: Oops: 5 [#1] PREEMPT<br>&lt;0&gt;[ =
1100.586303] last sysfs file: /sys/devices/system/cpu/cpu0/cpufreq/stats/ti=
me_in_state<br>&lt;4&gt;[ 1100.594573] Modules linked in: em_u32 sch_htb cl=
s_u32 act_police sch_ingress act_mirred ifb sec<br>
&lt;4&gt;[ 1100.604522] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=
=A0=A0 (2.6.32.9-g09b2432-dirty #1)<br>&lt;4&gt;[ 1100.611602] PC is at rel=
ease_sock+0x60/0xf0<br>&lt;4&gt;[ 1100.616088] LR is at release_sock+0x18/0=
xf0<br><br>&lt;4&gt;[ 1101.576324] [&lt;c0309930&gt;] (release_sock+0x60/0x=
f0) from [&lt;c03e9f40&gt;] (__l2cap_sock_close+0x8c/0x31c)<br>
&lt;4&gt;[ 1101.585876] [&lt;c03e9f40&gt;] (__l2cap_sock_close+0x8c/0x31c) =
from [&lt;c03ed9b4&gt;] (l2cap_sock_shutdown+0x5c/0xa0)<br>&lt;4&gt;[ 1101.=
596069] [&lt;c03ed9b4&gt;] (l2cap_sock_shutdown+0x5c/0xa0) from [&lt;c03eda=
2c&gt;] (l2cap_sock_release+0x34/0x90)<br>
&lt;4&gt;[ 1101.606170] [&lt;c03eda2c&gt;] (l2cap_sock_release+0x34/0x90) f=
rom [&lt;c0307ccc&gt;] (sock_release+0x20/0xb0)<br>&lt;4&gt;[ 1101.615570] =
[&lt;c0307ccc&gt;] (sock_release+0x20/0xb0) from [&lt;c0307d7c&gt;] (sock_c=
lose+0x20/0x2c)<br>
&lt;4&gt;[ 1101.624267] [&lt;c0307d7c&gt;] (sock_close+0x20/0x2c) from [&lt=
;c00c978c&gt;] (__fput+0x11c/0x218)<br>&lt;4&gt;[ 1101.632659] [&lt;c00c978=
c&gt;] (__fput+0x11c/0x218) from [&lt;c00c65a8&gt;] (filp_close+0x6c/0x78)<=
br>
&lt;4&gt;[ 1101.641052] [&lt;c00c65a8&gt;] (filp_close+0x6c/0x78) from [&lt=
;c0068f38&gt;] (put_files_struct+0x88/0xf0)<br>&lt;4&gt;[ 1101.650085] [&lt=
;c0068f38&gt;] (put_files_struct+0x88/0xf0) from [&lt;c006a7bc&gt;] (do_exi=
t+0x1b0/0x698)<br>
&lt;4&gt;[ 1101.659088] [&lt;c006a7bc&gt;] (do_exit+0x1b0/0x698) from [&lt;=
c006ad54&gt;] (do_group_exit+0xb0/0xdc)<br>&lt;4&gt;[ 1101.667846] [&lt;c00=
6ad54&gt;] (do_group_exit+0xb0/0xdc) from [&lt;c006ad90&gt;] (sys_exit_grou=
p+0x10/0x18)<br>
&lt;4&gt;[ 1101.677032] [&lt;c006ad90&gt;] (sys_exit_group+0x10/0x18) from =
[&lt;c0034f40&gt;] (ret_fast_syscall+0x0/0x2c)<br><br><br><div class=3D"gma=
il_quote">On Fri, Mar 19, 2010 at 2:03 PM, Andrei Emeltchenko <span dir=3D"=
ltr">&lt;<a href=3D"mailto:andrei.emeltchenko.news@gmail.com">andrei.emeltc=
henko.news@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi,<br>
<div class=3D"im"><br>
On Tue, Mar 9, 2010 at 9:31 AM, Nick Pelly &lt;<a href=3D"mailto:npelly@goo=
gle.com">npelly@google.com</a>&gt; wrote:<br>
&gt; On Mon, Mar 8, 2010 at 11:19 PM, Ville Tervo &lt;<a href=3D"mailto:vil=
le.tervo@nokia.com">ville.tervo@nokia.com</a>&gt; wrote:<br>
&gt;&gt; Tervo Ville (Nokia-D/Helsinki) wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; l2cap socket status might change while rfcomm is processing fr=
ames. And<br>
&gt;&gt;&gt; that makes rfcomm_process_rx to do double rfcomm_session_put()=
 for incoming<br>
&gt;&gt;&gt; session reference. We cannot use sk_state.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Could you try with this patch if it helps to your problems als=
o? My OPP<br>
&gt;&gt;&gt; problems went away with this patch.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I moved rfcomm_session_put() for incoming session to rfcomm_se=
ssion_close<br>
&gt;&gt;&gt; in order to get more clear _hold()/_put() pairs.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Any comments about the patch in previous mail?<br>
&gt;<br>
&gt; Your patch looks sane to me, although I know enough of the Bluez<br>
&gt; rfcomm state machine to know that I don&#39;t know it that well :)<br>
<br>
</div>We have tested this patch and it looks to be working. Shall we apply =
it?<br>
<br>
Regards,<br>
<font color=3D"#888888">Andrei<br>
</font><div><div></div><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</div></div></blockquote></div><br>

--20cf301d431cc7729f0493c0ac87--
