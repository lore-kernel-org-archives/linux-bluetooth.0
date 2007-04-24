Return-Path: <herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jikos@jikos.cz (Jiri Kosina)
Subject: Re: 2.6.21-rc7: BUG: sleeping function called from invalid context at net/core/sock.c:1523
Cc: jeremy@goop.org, gregkh@suse.de, marcel@holtmann.org, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net, clg@fr.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0704232257090.20657@twin.jikos.cz>
Message-Id: <E1HgBjF-0007Q9-00@gondolin.me.apana.org.au>
Date: Tue, 24 Apr 2007 13:30:09 +1000
List-ID: <bluez-devel.lists.sourceforge.net>

Jiri Kosina <jikos@jikos.cz> wrote:
> 
> Hmm, *sigh*. I guess the patch below fixes the problem, but it is a 
> masterpiece in the field of ugliness. And I am not sure whether it is 
> completely correct either. Are there any immediate ideas for better 
> solution with respect to how struct sock locking works?

Please cc such patches to netdev.  Thanks.

> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 71f5cfb..c5c93cd 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -656,7 +656,10 @@ static int hci_sock_dev_event(struct notifier_block *this, unsigned long event,
>                /* Detach sockets from device */
>                read_lock(&hci_sk_list.lock);
>                sk_for_each(sk, node, &hci_sk_list.head) {
> -                       lock_sock(sk);
> +                       if (in_atomic())
> +                               bh_lock_sock(sk);
> +                       else
> +                               lock_sock(sk);

This doesn't do what you think it does.  bh_lock_sock can still succeed
even with lock_sock held by someone else.

Does this need to occur immediately when an event occurs? If not I'd
suggest moving this into a workqueue.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
