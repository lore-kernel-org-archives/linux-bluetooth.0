Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1431588488-16666-1-git-send-email-jaganath.k@samsung.com>
References: <1431588488-16666-1-git-send-email-jaganath.k@samsung.com>
Date: Sat, 6 Jun 2015 11:07:27 +0530
Message-ID: <CAJzH+boPOK9n_HscOQiHRYf-AGDwW2=4_b2mTcK_petYJfq-Dg@mail.gmail.com>
Subject: Fwd: [PATCH v1] Bluetooth: Fix potential NULL dereference
From: Jaganath K <jaganath.k.os@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=14dae9cc9492de68340517d2cd66
List-ID: <linux-bluetooth.vger.kernel.org>

--14dae9cc9492de68340517d2cd66
Content-Type: text/plain; charset=UTF-8

addr can be NULL and it should not be dereferenced before NULL checking.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/rfcomm/sock.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 825e8fb..f9e9a81 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -334,16 +334,19 @@ static int rfcomm_sock_create(struct net *net, struct
socket *sock,

 static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr,
int addr_len)
 {
-       struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
+       struct sockaddr_rc sa;
        struct sock *sk = sock->sk;
-       int chan = sa->rc_channel;
-       int err = 0;
-
-       BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
+       int len, err = 0;

        if (!addr || addr->sa_family != AF_BLUETOOTH)
                return -EINVAL;

+       memset(&sa, 0, sizeof(sa));
+       len = min_t(unsigned int, sizeof(sa), addr_len);
+       memcpy(&sa, addr, len);
+
+       BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
+
        lock_sock(sk);

        if (sk->sk_state != BT_OPEN) {
@@ -358,12 +361,13 @@ static int rfcomm_sock_bind(struct socket *sock,
struct sockaddr *addr, int addr

        write_lock(&rfcomm_sk_list.lock);

-       if (chan && __rfcomm_get_listen_sock_by_addr(chan, &sa->rc_bdaddr))
{
+       if (sa.rc_channel &&
+           __rfcomm_get_listen_sock_by_addr(sa.rc_channel, &sa.rc_bdaddr))
{
                err = -EADDRINUSE;
        } else {
                /* Save source address */
-               bacpy(&rfcomm_pi(sk)->src, &sa->rc_bdaddr);
-               rfcomm_pi(sk)->channel = chan;
+               bacpy(&rfcomm_pi(sk)->src, &sa.rc_bdaddr);
+               rfcomm_pi(sk)->channel = sa.rc_channel;
                sk->sk_state = BT_BOUND;
        }

--
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--14dae9cc9492de68340517d2cd66
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote">addr can be NULL and it should =
not be dereferenced before NULL checking.<br>
<br>
Signed-off-by: Jaganath Kanakkassery &lt;<a href=3D"mailto:jaganath.k@samsu=
ng.com">jaganath.k@samsung.com</a>&gt;<br>
---<br>
=C2=A0net/bluetooth/rfcomm/sock.c |=C2=A0 =C2=A020 ++++++++++++--------<br>
=C2=A01 file changed, 12 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c<br>
index 825e8fb..f9e9a81 100644<br>
--- a/net/bluetooth/rfcomm/sock.c<br>
+++ b/net/bluetooth/rfcomm/sock.c<br>
@@ -334,16 +334,19 @@ static int rfcomm_sock_create(struct net *net, struct=
 socket *sock,<br>
<br>
=C2=A0static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *add=
r, int addr_len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr_rc *sa =3D (struct sockaddr_rc =
*) addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr_rc sa;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sock *sk =3D sock-&gt;sk;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int chan =3D sa-&gt;rc_channel;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;sk %p %pMR&quot;, sk, &amp;sa-&gt;=
rc_bdaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int len, err =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!addr || addr-&gt;sa_family !=3D AF_BLUETOO=
TH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;sa, 0, sizeof(sa));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D min_t(unsigned int, sizeof(sa), addr_le=
n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;sa, addr, len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;sk %p %pMR&quot;, sk, &amp;sa.rc_b=
daddr);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock_sock(sk);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sk-&gt;sk_state !=3D BT_OPEN) {<br>
@@ -358,12 +361,13 @@ static int rfcomm_sock_bind(struct socket *sock, stru=
ct sockaddr *addr, int addr<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_lock(&amp;rfcomm_sk_list.lock);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (chan &amp;&amp; __rfcomm_get_listen_sock_by=
_addr(chan, &amp;sa-&gt;rc_bdaddr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sa.rc_channel &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__rfcomm_get_listen_sock_by_addr(=
sa.rc_channel, &amp;sa.rc_bdaddr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EADDRINUSE=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Save source addr=
ess */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bacpy(&amp;rfcomm_p=
i(sk)-&gt;src, &amp;sa-&gt;rc_bdaddr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rfcomm_pi(sk)-&gt;c=
hannel =3D chan;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bacpy(&amp;rfcomm_p=
i(sk)-&gt;src, &amp;sa.rc_bdaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rfcomm_pi(sk)-&gt;c=
hannel =3D sa.rc_channel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sk-&gt;sk_state =3D=
 BT_BOUND;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</font></span></div><br></div>

--14dae9cc9492de68340517d2cd66--
