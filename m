Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6aeb672b1003010154u6660632fj53fdbac2c8d0e302@mail.gmail.com>
References: <6aeb672b1001220212u518836fds5df2a7e3de8463bf@mail.gmail.com>
	<6aeb672b1001272156m678aa8fepec2498386947936a@mail.gmail.com>
	<6aeb672b1003010154u6660632fj53fdbac2c8d0e302@mail.gmail.com>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Mon, 15 Mar 2010 10:27:29 -0700
Message-ID: <ac290f761003151027nc7ef2fava63c84eedad0f0dd@mail.gmail.com>
Subject: Re: Kernel panic when handing Motorola S305 headset
To: Liang Bao <tim.bao@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016367b6db63a27fe0481da3363
List-ID: <linux-bluetooth.vger.kernel.org>

--0016367b6db63a27fe0481da3363
Content-Type: multipart/alternative; boundary=0016367b6db63a27f60481da3361

--0016367b6db63a27f60481da3361
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel / Gustavo:

On Mon, Mar 1, 2010 at 2:54 AM, Liang Bao <tim.bao@gmail.com> wrote:

> I'd like to continue the previous thread on that Motorola S305 causes
> kernel panic because I did find some clue here. Sorry for misleading
> guess one month ago if any.
>
> Recap the problem here so that you don't to read the first long post.
> The pattern to reproduce the issue is:
> 1. Pair the S305 headset from the phone or the PC( I am using a Ubuntu)
> 2. Remove pairing on the phone or PC
> 3. Power off and then power on S305.
> 4. The S305 will try to connect and since link key removed on this
> side it will try to pair. Input 0000.
> 5. Kernel panic happens. This can be observed on kernel version
> 2.6.29(on the Droid phone, yes, it's a modified version),
> 2.6.31-19-generic on a Ubuntu and a pretty latest 2.6.33-020633rc8
> from Ubuntu official RC release.
>
> The exact kernel crash point is
>             if (l2cap_check_security(sk)) {
>                   if (bt_sk(sk)->defer_setup) {
>                      struct sock *parent = bt_sk(sk)->parent;
>                      rsp.result = cpu_to_le16(L2CAP_CR_PEND);
>                      rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
> >>>                   parent->sk_data_ready(parent, 0)
>                   } else {
>
> After tracing the issue for a couple of weeks, I find the difference
> between a normal flow and the panic one. If the user space process
> accepts the L2CAP connection request before L2CAP_INFO_RSP received,
> the following calls will be carried out:
>
> l2cap_sock_accept-> bt_accept_dequeue->bt_accept_unlink(in the branch
> bt_sk(parent)->defer_setup)-> set bt_sk(sk)->parent = NULL. Later when
> L2CAP_INFO_RSP arrives, the l2cap_conn_start() will try to call the
> marked line above and de-referring NULL happen.
>
> To fix this, shall we consider checking if a pending socket can be
> accepted in bt_accept_dequeue() prior to a pending L2CAP_INFO_REQ
> responded? For example,  adding a check to BT_CONNECT2 in
> af_bluetooth.c.
>
> 215         if (sk->sk_state == BT_CONNECTED || !newsock ||
> 216                         ( bt_sk(parent)->defer_setup &&
> (sk->sk_state != BT_CONNECT2))) {
>
> Again, I am not sure if this will bring a side-effect. Please advise
> the most appropriate way. Thanks.
>
> p.s: I attached partial trace files for those who're interested to the
> traces.
>


Can you ACK or NACK the analysis ?

Thanks
Jaikumar

--0016367b6db63a27f60481da3361
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel / Gustavo:<br><br><div class=3D"gmail_quote">On Mon, Mar 1, 2010 =
at 2:54 AM, Liang Bao <span dir=3D"ltr">&lt;<a href=3D"mailto:tim.bao@gmail=
.com">tim.bao@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">

I&#39;d like to continue the previous thread on that Motorola S305 causes<b=
r>
kernel panic because I did find some clue here. Sorry for misleading<br>
guess one month ago if any.<br>
<br>
Recap the problem here so that you don&#39;t to read the first long post.<b=
r>
<div class=3D"im">The pattern to reproduce the issue is:<br>
</div>1. Pair the S305 headset from the phone or the PC( I am using a Ubunt=
u)<br>
2. Remove pairing on the phone or PC<br>
<div class=3D"im">3. Power off and then power on S305.<br>
</div>4. The S305 will try to connect and since link key removed on this<br=
>
side it will try to pair. Input 0000.<br>
5. Kernel panic happens. This can be observed on kernel version<br>
2.6.29(on the Droid phone, yes, it&#39;s a modified version),<br>
2.6.31-19-generic on a Ubuntu and a pretty latest 2.6.33-020633rc8<br>
from Ubuntu official RC release.<br>
<br>
The exact kernel crash point is<br>
 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_check_security(sk)) {<br>
<div class=3D"im"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bt_sk(sk)-&gt;def=
er_setup) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sock *parent =3D bt_sk(s=
k)-&gt;parent;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rsp.result =3D cpu_to_le16(L2CA=
P_CR_PEND);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rsp.status =3D cpu_to_le16(L2CA=
P_CS_AUTHOR_PEND);<br>
&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent-&gt;sk_data_ready(p=
arent, 0)<br>
</div> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {<br>
<br>
After tracing the issue for a couple of weeks, I find the difference<br>
between a normal flow and the panic one. If the user space process<br>
accepts the L2CAP connection request before L2CAP_INFO_RSP received,<br>
the following calls will be carried out:<br>
<br>
l2cap_sock_accept-&gt; bt_accept_dequeue-&gt;bt_accept_unlink(in the branch=
<br>
bt_sk(parent)-&gt;defer_setup)-&gt; set bt_sk(sk)-&gt;parent =3D NULL. Late=
r when<br>
L2CAP_INFO_RSP arrives, the l2cap_conn_start() will try to call the<br>
marked line above and de-referring NULL happen.<br>
<br>
To fix this, shall we consider checking if a pending socket can be<br>
accepted in bt_accept_dequeue() prior to a pending L2CAP_INFO_REQ<br>
responded? For example, =A0adding a check to BT_CONNECT2 in<br>
af_bluetooth.c.<br>
<br>
215 =A0 =A0 =A0 =A0 if (sk-&gt;sk_state =3D=3D BT_CONNECTED || !newsock ||<=
br>
216 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( bt_sk(parent)-&gt;def=
er_setup &amp;&amp;<br>
(sk-&gt;sk_state !=3D BT_CONNECT2))) {<br>
<br>
Again, I am not sure if this will bring a side-effect. Please advise<br>
the most appropriate way. Thanks.<br>
<br>
p.s: I attached partial trace files for those who&#39;re interested to the =
traces.<br>
</blockquote></div><br><br>Can you ACK or NACK the analysis ?<br><br>Thanks=
<br>Jaikumar<br>

--0016367b6db63a27f60481da3361--

--0016367b6db63a27fe0481da3363
Content-Type: text/plain; charset=US-ASCII; name="s305-good-bad-trace.txt"
Content-Disposition: attachment; filename="s305-good-bad-trace.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g693azsd1

VHJhY2Ugd2hlbiBwYW5pYyBoYXBwZW5kZWQ6CjwzPlsgIDM1Ni43NTg0ODNdIGwyY2FwX2Nvbm5l
Y3RfcmVxOiBwc20gMHgxOSBzY2lkIDB4MDA0MQ0KPDM+WyAgMzU2Ljc2Mzg1NF0gbDJjYXBfY29u
bmVjdF9yZXE6IHBhcmVudCBjN2U4ZjYwMA0KPDM+WyAgMzU2Ljc2ODgyOV0gX19sMmNhcF9jaGFu
X2FkZDogY29ubiBjN2ZhMzdjMCwgcHNtIDB4MTksIGRjaWQgMHgwMDQxDQo8Mz5bICAzNTYuNzc1
NDgyXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVybiwgc2sgYzVkNjZjMDAgcGFyZW50
IGM3ZThmNjAwDQo8Mz5bICAzNTYuNzgyODk3XSBsMmNhcF9jb25uZWN0X3JlcTogcHNtIDB4MDEg
c2NpZCAweDAwNDINCjwzPlsgIDM1Ni43ODgxNzddIGwyY2FwX2Nvbm5lY3RfcmVxOiBwYXJlbnQg
YzdlOGZlMDANCjwzPlsgIDM1Ni43OTMxMjFdIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzdmYTM3
YzAsIHBzbSAweDAxLCBkY2lkIDB4MDA0Mg0KPDM+WyAgMzU2Ljc5OTc3NF0gbDJjYXBfY29ubmVj
dF9yZXE6IGJlZm9yZSByZXR1cm4sIHNrIGM1ZDY2YTAwIHBhcmVudCBjN2U4ZmUwMA0KPDM+WyAg
MzU2LjgzNzE1OF0gbDJjYXBfc29ja19hY2NlcHQ6IG5ldyBzb2NrZXQgYzVkNjZjMDANCjwzPlsg
IDM1Ni44NDI1OTBdIGwyY2FwX2Nvbm5fc3RhcnQ6IEJUX0NPTk5FQ1RFMiwgc2sgYzVkNjZjMDAs
IHBhcmVudCAobnVsbCkKClRyYWNlIHdoZW4gZXZlcnl0aGluZyBnb2VzIG9uIHdlbGwuCjwzPlsg
IDY0MS4zOTM0NjNdIGwyY2FwX2Nvbm5lY3RfcmVxOiBwc20gMHgxOSBzY2lkIDB4MDA0MQo8Mz5b
ICA2NDEuMzk4OTU2XSBsMmNhcF9jb25uZWN0X3JlcTogcGFyZW50IGM3ZTkxMjAwCjwzPlsgIDY0
MS40MDM3NzhdIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzk1MTk0NDAsIHBzbSAweDE5LCBkY2lk
IDB4MDA0MQo8Mz5bICA2NDEuNDEwNDYxXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVy
biwgc2sgYzk3ZTNhMDAgcGFyZW50IGM3ZTkxMjAwCjwzPlsgIDY0MS40MTc4NzddIGwyY2FwX2Nv
bm5lY3RfcmVxOiBwc20gMHgwMSBzY2lkIDB4MDA0Mgo8Mz5bICA2NDEuNDIzMTU2XSBsMmNhcF9j
b25uZWN0X3JlcTogcGFyZW50IGM2NGIwYzAwCjwzPlsgIDY0MS40MjgxMzFdIF9fbDJjYXBfY2hh
bl9hZGQ6IGNvbm4gYzk1MTk0NDAsIHBzbSAweDAxLCBkY2lkIDB4MDA0Mgo8Mz5bICA2NDEuNDM0
NzUzXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVybiwgc2sgYzk3ZTM0MDAgcGFyZW50
IGM2NGIwYzAwCjwzPlsgIDY0MS40NzYxNjVdIGwyY2FwX2Nvbm5fc3RhcnQ6IEJUX0NPTk5FQ1RF
Miwgc2sgYzk3ZTNhMDAsIHBhcmVudCBjN2U5MTIwMAo8Mz5bICA2NDEuNDgzODU2XSBsMmNhcF9z
b2NrX2FjY2VwdDogbmV3IHNvY2tldCBjOTdlM2EwMAo8Mz5bICA2NDEuNTUxNTEzXSBsMmNhcF9z
b2NrX2FjY2VwdDogbmV3IHNvY2tldCBjOTdlMzQwMAo8Mz5bICA2NDEuNTkyNzQyXSBsMmNhcF9z
b2NrX3NodXRkb3duOiBzb2NrIGNlYTdhODQwLCBzayBjOTdlM2EwMCwgaG93IDIKPDM+WyAgNjQx
LjYwNzcyN10gbDJjYXBfc29ja19zaHV0ZG93bjogc29jayBjZWE3YTBjMCwgc2sgYzk3ZTM0MDAs
IGhvdyAyCjwzPlsgIDY0NC4wNTU0MTldIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzk1MTk0NDAs
IHBzbSAweDAxLCBkY2lkIDB4MDAwMAo8Mz5bICA2NTAuMDU1ODE2XSBsMmNhcF9zb2NrX3NodXRk
b3duOiBzb2NrIGNlYTdhMGMwLCBzayBjOTdlMzQwMCwgaG93IDIKPDM+WyAgNjUwLjA2MzAxOF0g
bDJjYXBfc29ja19zaHV0ZG93bjogc2stc2h1dGRvd24gPSB0cnVlCjwzPlsgIDY1MC4wNjk0Mjdd
IF9fbDJjYXBfc29ja19jbG9zZTogc2sgYzk3ZTM0MDAgc3RhdGUgMSBzb2NrZXQgY2VhN2EwYzAg
cmVhc29uIDAKCg==
--0016367b6db63a27fe0481da3363--
