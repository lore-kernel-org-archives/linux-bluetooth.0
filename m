Return-Path: <wuninsu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2C9BF94E-E383-4931-9BE8-9FB65F693242@holtmann.org>
References: <1452054993-76111-1-git-send-email-wuninsu@gmail.com>
	<62ADF1E9-4974-4F54-8D86-CE0E38CC4619@holtmann.org>
	<CAGoFzNdUiySA6YqDnHHo8VbSYciG3gNC9chg=UZW2Jb_Wb6eTQ@mail.gmail.com>
	<2C9BF94E-E383-4931-9BE8-9FB65F693242@holtmann.org>
Date: Wed, 6 Jan 2016 10:37:12 -0500
Message-ID: <CAGoFzNfZmRYneta5RPr_WdVKmNCUGRKjh=J_+zmjU2gGz+3e+Q@mail.gmail.com>
Subject: Re: [PATCH] rfcomm: fix information leak in rfcomm_sock_bind
From: Insu Yun <wuninsu@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Peter Hurley <peter@hurleysoftware.com>,
	JAGANATH KANAKKASSERY <jaganath.k@samsung.com>, ying.xue@windriver.com,
	"Eric W. Biederman" <ebiederm@xmission.com>, BlueZ development <linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Taesoo Kim <taesoo@gatech.edu>, Yeongjin Jang <yeongjin.jang@gatech.edu>,
	"Yun, Insu" <insu@gatech.edu>, Changwoo Min <changwoo@gatech.edu>
Content-Type: multipart/alternative; boundary=001a114f37e4c8710c0528ac20a2
List-ID: <linux-bluetooth.vger.kernel.org>

--001a114f37e4c8710c0528ac20a2
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 6, 2016 at 10:20 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Insu,
>
> > if addr_len < sizeof(sa), sa.rc_bdaddr(4bytes) can be leaked
>> > by using rfcomm_sock_getname()
>> >
>> > Signed-off-by: Insu Yun <wuninsu@gmail.com>
>> > ---
>> > net/bluetooth/rfcomm/sock.c | 9 +++++----
>> > 1 file changed, 5 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>> > index 7511df7..d61dfdc 100644
>> > --- a/net/bluetooth/rfcomm/sock.c
>> > +++ b/net/bluetooth/rfcomm/sock.c
>> > @@ -336,14 +336,15 @@ static int rfcomm_sock_bind(struct socket *sock,
>> struct sockaddr *addr, int addr
>> > {
>> >       struct sockaddr_rc sa;
>> >       struct sock *sk = sock->sk;
>> > -     int len, err = 0;
>> > +     int err = 0;
>> >
>> >       if (!addr || addr->sa_family != AF_BLUETOOTH)
>> >               return -EINVAL;
>> >
>> > -     memset(&sa, 0, sizeof(sa));
>> > -     len = min_t(unsigned int, sizeof(sa), addr_len);
>> > -     memcpy(&sa, addr, len);
>>
>> what are we leaking here?
>>
>> If you make addr_len (controlled by userspace) smaller than struct
>> sockaddr_rc, the kernel will only copy addr_len of sockaddr_rc to
>> userspace. What is the kernel leaking again? We are happy to hand out the
>> full sockaddr_rc in the first place.
>>
>
> Yes. sockaddr_rc is in the kernel stack initialized only amount of
> addr_len. Remaining part is uninitialized kernel stack which may contain
> some address.
>
>
> it is initialized to 0 via memset(&sa, 0, sizeof(sa)). It is not
> uninitialized kernel stack memory. It is initialized to zero.
>
>
>
>>
>> > +     if (addr_len != sizeof(sa))
>> > +             return -EINVAL;
>> > +
>> > +     memcpy(&sa, addr, addr_len);
>> >
>> >       BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
>>
>> While I give you the fact that we should require at minimum to provide
>> bdaddr_t and channel just as a good safe guard, but even if you don't, then
>> it just means you try to bind to a truncated address, which will fail when
>> calling connect().
>>
>
> bind will not be failed.
>
>
>>
>> So the sockaddr_rc sa will be memset to zero. Which means if you provide
>> less than sockaddr_rc you get a truncated rc_bdaddr and rc_channel set to
>> zero. So what is getname() leaking now. It will leak zeros. It will not
>> leak random kernel memory.
>>
>
> Yes not random. Sorry for confusing, it only leaks unitiailized memory in
> stack.
>
>
> Again, it is initialized to zero memory.
>
>
>
>>
>> Please help me to understand where this is an information leak. Since
>> leaking memory that is explicitly set to zero is not an information leak.
>>
>> And just FYI you can bind a RFCOMM socket to a truncated address and
>> channel 0 in a valid way with the full size of sockaddr_rc. That is still
>> valid. We do not discriminate any addresses. If some company manages to get
>> the IEEE to assign that address to them, than that is a valid address.
>>
>> Regards
>>
>> Marcel
>>
>
>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <stdint.h>
> #include <stdlib.h>
>
> #define BUG
>
> int main() {
>   int s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>   struct sockaddr addr;
>   int len = sizeof(addr);
>   int i;
>
>   if (s == -1) {
>     perror("socket");
>     exit(-1);
>   }
>
>   memset(&addr, 0, sizeof(addr));
>   addr.sa_family = AF_BLUETOOTH;
> #ifdef BUG
>   if (bind(s, &addr, sizeof(addr.sa_family)) == -1) {
> #else
>   if (bind(s, &addr, sizeof(addr)) == -1) {
> #endif
>     perror("bind");
>     exit(-1);
>   }
>   getsockname(s, &addr, &len);
>   printf("%08X\n", ((struct sockaddr_rc*)&addr)->rc_bdaddr);
> }
>
> This is PoC code. When bind, it passes kernel stack address initialized by
> addr_len.
> But in current rfcomm_sock_bind, it copies uninitialized memory value to
> src variable.
> After that, it can be accessed in user space using getsockname.
>
>
> You did run that PoC? It gives you 00000000 since as mentioned above the
> sockaddr_rc sa is actually set to zero.
>

Sorry. I got it now. I misread the code. You are right, it only leaks NULL
bytes.
I read code and I tested in older version of Linux which does not have that
memset code.
insu@insu:~$ ./a
880C93BE
In that version, it has memory leak.
But after this commit, 951b6a0717db97ce420547222647bcc40bf1eacd, it does
not produce such issue.
Sorry.



>
> Regards
>
> Marcel
>
>


-- 
Regards
Insu Yun

--001a114f37e4c8710c0528ac20a2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jan 6, 2016 at 10:20 AM, Marcel Holtmann <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><div style=3D"word-wrap:break-word"=
>Hi Insu,<div><br></div><div><div><span class=3D""><blockquote type=3D"cite=
"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:soli=
d;padding-left:1ex"><span>&gt; if addr_len &lt; sizeof(sa), sa.rc_bdaddr(4b=
ytes) can be leaked<br>
&gt; by using rfcomm_sock_getname()<br>
&gt;<br>
&gt; Signed-off-by: Insu Yun &lt;<a href=3D"mailto:wuninsu@gmail.com" targe=
t=3D"_blank">wuninsu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; net/bluetooth/rfcomm/sock.c | 9 +++++----<br>
&gt; 1 file changed, 5 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c=
<br>
&gt; index 7511df7..d61dfdc 100644<br>
&gt; --- a/net/bluetooth/rfcomm/sock.c<br>
&gt; +++ b/net/bluetooth/rfcomm/sock.c<br>
&gt; @@ -336,14 +336,15 @@ static int rfcomm_sock_bind(struct socket *sock,=
 struct sockaddr *addr, int addr<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr_rc sa;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sock *sk =3D sock-&gt;sk;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int len, err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!addr || addr-&gt;sa_family !=3D AF_BLUE=
TOOTH)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0memset(&amp;sa, 0, sizeof(sa));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0len =3D min_t(unsigned int, sizeof(sa), addr_len)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0memcpy(&amp;sa, addr, len);<br>
<br>
</span>what are we leaking here?<br>
<br>
If you make addr_len (controlled by userspace) smaller than struct sockaddr=
_rc, the kernel will only copy addr_len of sockaddr_rc to userspace. What i=
s the kernel leaking again? We are happy to hand out the full sockaddr_rc i=
n the first place.<br></blockquote><div><br></div><div>Yes. sockaddr_rc is =
in the kernel stack initialized only amount of addr_len. Remaining part is =
uninitialized kernel stack which may contain some address.</div></div></div=
></div></div></blockquote><div><br></div></span>it is initialized to 0 via =
memset(&amp;sa, 0, sizeof(sa)). It is not uninitialized kernel stack memory=
. It is initialized to zero.</div><div><span class=3D""><br><blockquote typ=
e=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"g=
mail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex">
<span><br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (addr_len !=3D sizeof(sa))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memcpy(&amp;sa, addr, addr_len);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;sk %p %pMR&quot;, sk, &amp;sa.r=
c_bdaddr);<br>
<br>
</span>While I give you the fact that we should require at minimum to provi=
de bdaddr_t and channel just as a good safe guard, but even if you don&#39;=
t, then it just means you try to bind to a truncated address, which will fa=
il when calling connect().<br></blockquote><div><br></div><div>bind will no=
t be failed.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">
<br>
So the sockaddr_rc sa will be memset to zero. Which means if you provide le=
ss than sockaddr_rc you get a truncated rc_bdaddr and rc_channel set to zer=
o. So what is getname() leaking now. It will leak zeros. It will not leak r=
andom kernel memory.<br></blockquote><div><br></div><div>Yes not random. So=
rry for confusing, it only leaks unitiailized memory in stack.</div></div><=
/div></div></div></blockquote><div><br></div></span>Again, it is initialize=
d to zero memory.</div><div><div><div class=3D"h5"><br><blockquote type=3D"=
cite"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);b=
order-left-style:solid;padding-left:1ex">
<br>
Please help me to understand where this is an information leak. Since leaki=
ng memory that is explicitly set to zero is not an information leak.<br>
<br>
And just FYI you can bind a RFCOMM socket to a truncated address and channe=
l 0 in a valid way with the full size of sockaddr_rc. That is still valid. =
We do not discriminate any addresses. If some company manages to get the IE=
EE to assign that address to them, than that is a valid address.<br>
<br>
Regards<br>
<span><font color=3D"#888888"><br>
Marcel<br></font></span></blockquote></div><div><br></div><div><div class=
=3D"gmail_extra"><br>#include &lt;bluetooth/bluetooth.h&gt;</div><div class=
=3D"gmail_extra">#include &lt;bluetooth/rfcomm.h&gt;</div><div class=3D"gma=
il_extra">#include &lt;sys/types.h&gt;=C2=A0</div><div class=3D"gmail_extra=
">#include &lt;sys/socket.h&gt;</div><div class=3D"gmail_extra">#include &l=
t;stdint.h&gt;</div><div class=3D"gmail_extra">#include &lt;stdlib.h&gt;</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">#define =
BUG</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">in=
t main() {</div><div class=3D"gmail_extra">=C2=A0 int s =3D socket(AF_BLUET=
OOTH, SOCK_STREAM, BTPROTO_RFCOMM);</div><div class=3D"gmail_extra">=C2=A0 =
struct sockaddr addr;</div><div class=3D"gmail_extra">=C2=A0 int len =3D si=
zeof(addr);</div><div class=3D"gmail_extra">=C2=A0 int i;</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=C2=A0 if (s =3D=3D -=
1) {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 perror(&quot;socket&quot=
;);</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 exit(-1);</div><div class=
=3D"gmail_extra">=C2=A0 }</div><div class=3D"gmail_extra"><br></div><div cl=
ass=3D"gmail_extra">=C2=A0 memset(&amp;addr, 0, sizeof(addr));</div><div cl=
ass=3D"gmail_extra">=C2=A0 addr.sa_family =3D AF_BLUETOOTH;</div><div class=
=3D"gmail_extra">#ifdef BUG</div><div class=3D"gmail_extra">=C2=A0 if (bind=
(s, &amp;addr, sizeof(addr.sa_family)) =3D=3D -1) {</div><div class=3D"gmai=
l_extra">#else</div><div class=3D"gmail_extra">=C2=A0 if (bind(s, &amp;addr=
, sizeof(addr)) =3D=3D -1) {</div><div class=3D"gmail_extra">#endif</div><d=
iv class=3D"gmail_extra">=C2=A0 =C2=A0 perror(&quot;bind&quot;);</div><div =
class=3D"gmail_extra">=C2=A0 =C2=A0 exit(-1);</div><div class=3D"gmail_extr=
a">=C2=A0 }</div><div class=3D"gmail_extra">=C2=A0 getsockname(s, &amp;addr=
, &amp;len);</div><div class=3D"gmail_extra">=C2=A0 printf(&quot;%08X\n&quo=
t;, ((struct sockaddr_rc*)&amp;addr)-&gt;rc_bdaddr);</div><div class=3D"gma=
il_extra">}</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra">This is PoC code. When bind, it passes kernel stack address initializ=
ed by addr_len.</div><div class=3D"gmail_extra">But in current=C2=A0<span s=
tyle=3D"font-size:12.8px">rfcomm_sock_bind, it copies uninitialized memory =
value to src variable.</span></div><div class=3D"gmail_extra"><span style=
=3D"font-size:12.8px">After that, it can be accessed in user space using ge=
tsockname.=C2=A0</span></div></div></div></div></div></blockquote><div><br>=
</div></div></div>You did run that PoC? It gives you=C2=A0<font face=3D"Men=
lo"><span style=3D"font-size:11px">00000000 since as mentioned above the so=
ckaddr_rc sa is actually set to zero.</span></font></div></div></div></bloc=
kquote><div><br></div><div>Sorry. I got it now. I misread the code. You are=
 right, it only leaks NULL bytes.</div><div>I read code and I tested in old=
er version of Linux which does not have that memset code.</div><div><div><f=
ont color=3D"#444444" face=3D"Consolas, Liberation Mono, Menlo, Courier, mo=
nospace"><span style=3D"font-size:12px;line-height:24px">insu@insu:~$ ./a</=
span></font></div><div><font color=3D"#444444" face=3D"Consolas, Liberation=
 Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;line-height=
:24px">880C93BE</span></font></div></div><div>In that version, it has memor=
y leak.=C2=A0</div><div>But after this commit,=C2=A0<span style=3D"color:rg=
b(68,68,68);font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,mo=
nospace;font-size:12px;line-height:24px">951b6a0717db97ce420547222647bcc40b=
f1eacd, it does not produce such issue.</span></div><div>Sorry.</div><div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204)=
;border-left-style:solid;padding-left:1ex"><div style=3D"word-wrap:break-wo=
rd"><div><div><font face=3D"Menlo"><span style=3D"font-size:11px"><br></spa=
n></font></div><div><font face=3D"Menlo"><span style=3D"font-size:11px">Reg=
ards</span></font></div><span class=3D""><font color=3D"#888888"><div><font=
 face=3D"Menlo"><span style=3D"font-size:11px"><br></span></font></div><div=
><font face=3D"Menlo"><span style=3D"font-size:11px">Marcel</span></font></=
div><div><br></div></font></span></div></div></blockquote></div><br><br cle=
ar=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><div>Regard=
s</div>
<div>Insu Yun</div></div>
</div></div>

--001a114f37e4c8710c0528ac20a2--
