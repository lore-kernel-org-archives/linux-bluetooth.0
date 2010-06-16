Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265209673.31341.116.camel@localhost.localdomain>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>
	<1265156906.31341.106.camel@localhost.localdomain>
	<90704.85857.qm@web52601.mail.re2.yahoo.com>
	<1265209673.31341.116.camel@localhost.localdomain>
Date: Wed, 16 Jun 2010 13:21:55 +0300
Message-ID: <AANLkTikNH3_CC3OottoqMnZEwu4sbqvchFxZ2Q7-GlRZ@mail.gmail.com>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ed Tsang <netdesign_98@yahoo.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 3, 2010 at 6:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
>> >> In hcidump I seem to see a problem in #3. After the Encrypt Change th=
ere seem to be 2 >con. req. psm 1 scid 0x0040
>>
>> >what kernel version is this? I think we fixed that already.
>> It is a ubutunu distribution. 2.6.31-17-generic.
>
> can you test with a 2.6.33-rc6 vanilla kernel. I really thing this got
> fixed and you might see a side effect or bad patch here.

Marcel we are seeing "double L2CAP connect also" when connecting to
some smartphones using contran profile. What about following patch
proposal:

The idea is to use existing flag L2CAP_CONF_CONNECT_PEND to mark that
L2CAP request has been sent.

Currently it is durty hack, I will send modified patch later today.

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index fc81acb..27bff6e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -394,6 +394,12 @@ static void l2cap_do_start(struct sock *sk)

                        l2cap_pi(sk)->ident =3D l2cap_get_ident(conn);

+                       if (l2cap_pi(sk)->conf_state &
L2CAP_CONF_CONNECT_PEND) {
+                               printk(KERN_ERR "\n!!! %s: Connection
pending !!!\n", __FUNCTION__);
+                               return;
+                       }
+
+                       l2cap_pi(sk)->conf_state |=3D L2CAP_CONF_CONNECT_PE=
ND;
                        l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
                                        L2CAP_CONN_REQ, sizeof(req), &req);
                }
@@ -448,6 +454,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)

                                l2cap_pi(sk)->ident =3D l2cap_get_ident(con=
n);

+                               if (l2cap_pi(sk)->conf_state &
L2CAP_CONF_CONNECT_PEND) {
+                                       printk(KERN_ERR "\n!!! %s:
Connection pending !!!\n", __FUNCTION__);
+                                       bh_unlock_sock(sk);
+                                       continue;
+                               }
+
+                               l2cap_pi(sk)->conf_state |=3D
L2CAP_CONF_CONNECT_PEND;
                                l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
                                        L2CAP_CONN_REQ, sizeof(req), &req);
                        }
@@ -3809,6 +3822,7 @@ static int l2cap_security_cfm(struct hci_conn
*hcon, u8 status, u8 encrypt)
                bh_lock_sock(sk);

                if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
+                       printk(KERN_ERR "\n!!! %s: Connection pending
!!!\n", __FUNCTION__);
                        bh_unlock_sock(sk);
                        continue;
                }
@@ -3828,6 +3842,7 @@ static int l2cap_security_cfm(struct hci_conn
*hcon, u8 status, u8 encrypt)

                                l2cap_pi(sk)->ident =3D l2cap_get_ident(con=
n);

+                               l2cap_pi(sk)->conf_state |=3D
L2CAP_CONF_CONNECT_PEND;
                                l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
                                        L2CAP_CONN_REQ, sizeof(req), &req);



>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
