Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101210071716.GK874@null>
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
	<20101206211516.GH883@vigoh>
	<4CFE32A0.6090601@nokia.com>
	<20101207155037.GA2944@vigoh>
	<4CFF6359.7000305@nokia.com>
	<20101210071716.GK874@null>
Date: Thu, 13 Jan 2011 16:37:37 +0200
Message-ID: <AANLkTikujeb2tF-eU7mXhfuKtswBQGNXS8BZBDxkouE0@mail.gmail.com>
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: Yuri Ershov <ext-yuri.ershov@nokia.com>,
	"ext Gustavo F. Padovan" <padovan@profusion.mobi>,
	andrei.emeltchenko@nokia.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 10, 2010 at 9:17 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Yuri,
>
> On Wed, Dec 08, 2010 at 01:52:09PM +0300, Yuri Ershov wrote:
>
>
>> >>>So in which situations (n == p), or (p == p->next)? That should happen only
>> >>>when p is the only element in the list, then p == head, right?
>> >>The (n == p) is in situation, when sk is unlinked by task
>> >>responsible for handling connect/disconnect requests while the
>> >>"bt_accept_dequeue". This condition is indirect checking of sk
>> >>validity.
>> >
>> >Why not using a list lock here instead? Fits a way better.
>> >
>> Yes, it's better. I tried to use the locks in this function, but it
>> slows down the task handling connect/disconnect/etc. events and the
>> task skips some events from fast clients.

What about preventing tasklet from removing socket with disabling bh?

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8cfb5a8..7ac4ba5 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -199,6 +199,7 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)

        BT_DBG("parent %p", parent);

+       local_bh_disable();
        list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
                sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);

@@ -217,11 +218,14 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)
                        if (newsock)
                                sock_graft(sk, newsock);
                        release_sock(sk);
+                       local_bh_enable();
                        return sk;
                }

                release_sock(sk);
        }
+       local_bh_enable();
+
        return NULL;
 }
 EXPORT_SYMBOL(bt_accept_dequeue);
