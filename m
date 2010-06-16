Return-Path: <cyrus@holtmann.org>
Message-ID: <497946.31108.qm@web52603.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com> <1265156906.31341.106.camel@localhost.localdomain> <90704.85857.qm@web52601.mail.re2.yahoo.com> <1265209673.31341.116.camel@localhost.localdomain> <AANLkTikNH3_CC3OottoqMnZEwu4sbqvchFxZ2Q7-GlRZ@mail.gmail.com>
Date: Wed, 16 Jun 2010 06:39:06 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
  Marcel Holtmann <marcel@holtmann.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
  liejuntao001@gamail.com
In-Reply-To: <AANLkTikNH3_CC3OottoqMnZEwu4sbqvchFxZ2Q7-GlRZ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Anrel,  what kernel version are you using?
Previously it was happening with a Blackberry on 2.6.31-17. I was planning to dig into it, then I upgraded my ubuntu with (2.6.32-22) and the problem disappeared. I am guessing it might be a raising condition with certain phone during certain circumstance. I think Liejun Tao <liejuntao001@gmail.com> has investigate this one too.

Cheers,
Ed



----- Original Message ----
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ed Tsang <netdesign_98@yahoo.com>; Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Sent: Wed, June 16, 2010 6:21:55 AM
Subject: Re: double Connect req: psm 1 scid 0x0040 ?

Hi,

On Wed, Feb 3, 2010 at 6:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> >> In hcidump I seem to see a problem in #3. After the Encrypt Change there seem to be 2 >con. req. psm 1 scid 0x0040
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

                        l2cap_pi(sk)->ident = l2cap_get_ident(conn);

+                       if (l2cap_pi(sk)->conf_state &
L2CAP_CONF_CONNECT_PEND) {
+                               printk(KERN_ERR "\n!!! %s: Connection
pending !!!\n", __FUNCTION__);
+                               return;
+                       }
+
+                       l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
                        l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
                                        L2CAP_CONN_REQ, sizeof(req), &req);
                }
@@ -448,6 +454,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)

                                l2cap_pi(sk)->ident = l2cap_get_ident(conn);

+                               if (l2cap_pi(sk)->conf_state &
L2CAP_CONF_CONNECT_PEND) {
+                                       printk(KERN_ERR "\n!!! %s:
Connection pending !!!\n", __FUNCTION__);
+                                       bh_unlock_sock(sk);
+                                       continue;
+                               }
+
+                               l2cap_pi(sk)->conf_state |=
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

                                l2cap_pi(sk)->ident = l2cap_get_ident(conn);

+                               l2cap_pi(sk)->conf_state |=
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
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
