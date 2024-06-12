Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B7382;
	Wed, 12 Jun 2024 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718153158; cv=none; b=V80c0b3+jtCPPhdpXRDnmGu7nVbAFzx22sd0dwXXby+UMR81UrB9GakqvCulrWH7q0ojz+NrPWciUqnDUdccrQnZtd5M5wsMTcqne571cs4aokN1bwA/NYx+fOGc3RtCdz+2Ihf4rPCdO1zXWW8FM2DPLc+Iyx/AvEt4tYBewpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718153158; c=relaxed/simple;
	bh=QvpkNZxNf+bFjGv98ZVz7V6Y9MPJqzMeA/NpE+cqGHE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ftaMSPsuVlFfDuufMWjlxqH5znMizlnf/KBketpwDDLI9DWlxVIAjjIVqD1dqf6/8cPdgtOP3EfHL58vhEKkYow+WI6OZ1Q/meUQ7AeZp+zA7vBAmxtVUgaP6hAwf+5Vs6WM1TgkZTqwivwNDn+rZmNS1C5lmUvYcbhGpsG0Njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uVZqYDKo; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uVZqYDKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718153146; bh=yaOB0WImsjwMeHU3xsRZ8tLXGhxiCvU4i19eY9tIWLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uVZqYDKoWj0M+t9HTrwsMbLgEnFD41htSq4Wh9jv0aZ2QItbfjN04Po2a4wgA8hPY
	 NZtqcg+1MzhsxiY62p2OecS0+TpPxMtoIXI61/3itcIRVflDX8WRArk1O3zBJk9hER
	 7xFHPg4JEs3B93RMqGsrY6FXymXJUaKQ0boXJj38=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8540D485; Wed, 12 Jun 2024 08:33:20 +0800
X-QQ-mid: xmsmtpt1718152400t34ok1r3k
Message-ID: <tencent_BD1DCF8F0DE1A5918DC69228DD91DDBE9907@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqczLxmdSG/DSQARvh5gSVrbRbiqSTeEHu60ddjYPpYonCah6M8R2
	 FJqEzr9OGd5mUmLIeIDv1sBE7ch3Y8kkHj4qV4QrOTb0ggZNDzKbWuPAS9RIp3eUfweONbcQxg+R
	 Sr+haabgyuoAOumT9y0+kDMAqWBURB1d4VTHWG2xQi9a+9n/KIaNs2V3rn9Z4fmv06X5jtyJzguP
	 2qQpwrN2Oyp2GMr55TW2bKWXFpADqwTtxmPfG9xVfKSJxNJcQfgcY/ejejOJpcr1oX2ZNPvJEu/6
	 PUG8f3QIzKZ3PMSJyEBqKU8LycnzoQsardQMDwV5nDwEYq0ToNS50UnfowXzQF8Gm9Ub4JJ6p1E8
	 9gCNXsVhXdxi+k8QP/KCV9f/CoQYAinz4sZ2M5evwVrFbrPfRmGkzV8e2fNrQ0cJBHpc9aYWv6W0
	 VZHngSXRXWjmj+hEK4fURvEQkHQBe30+1ctYd1H2n1KkQi9613mb5qiz3hXWM8Ujekw2Fm/u7pcI
	 G7tZx6nMFPUjBI+qsOhEMhvPlP8yErM+cJocTrhLomdN6zLXNNMBmLxulm98BXd8M0zgogg0bb+R
	 F999IV4HdImGAYSXwfROC8x7F/1KOvMPifTuEYTGWT/19FCQsdWFmDEWkGO8f/2xcW/gKez0aFlx
	 O0M2j6g6VZ4KjVhheH88KAXHAcLKtye13m+PV0y7fxap2UgW1MFByupwNRIfM9THm5mlomFALmHk
	 E/cmB8a+/EqGZ1NbbJSqdaIwVDD19zkthyzIMoGJ8LYMzdEG/m5yQppmHaLXd3zqRactJaGn/niK
	 /fwV1aCCckl30Cya/fQLB0YofAZWaoEIgGu51i0888djamz7DRxivaoagUKxnDNZeWZS2SJYkLDt
	 bHTHWsYnz1D8XdK5SjOx4J0BbkDDZ40JirygFAtQn6rHcmEVzD+2Iiw/PoF+VpUKU2au/tBvPK1W
	 0itXMDSKU=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: luiz.dentz@gmail.com
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bluetooth/l2cap: sync sock recv cb and release
Date: Wed, 12 Jun 2024 08:33:20 +0800
X-OQ-MSGID: <20240612003319.2141768-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
References: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz Augusto von Dentz,

On Tue, 11 Jun 2024 15:24:52 -0400, Luiz Augusto von Dentz wrote:
> > The problem occurs between the system call to close the sock and hci_rx_work,
> > where the former releases the sock and the latter accesses it without lock protection.
> >
> >            CPU0                       CPU1
> >            ----                       ----
> >            sock_close                 hci_rx_work
> >            l2cap_sock_release         hci_acldata_packet
> >            l2cap_sock_kill            l2cap_recv_frame
> >            sk_free                    l2cap_conless_channel
> >                                       l2cap_sock_recv_cb
> >
> > If hci_rx_work processes the data that needs to be received before the sock is
> > closed, then everything is normal; Otherwise, the work thread may access the
> > released sock when receiving data.
> >
> > Add a chan mutex in the rx callback of the sock to achieve synchronization between
> > the sock release and recv cb.
> >
> > Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/bluetooth/l2cap_sock.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 6db60946c627..f3e9236293e1 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -1413,6 +1413,8 @@ static int l2cap_sock_release(struct socket *sock)
> >         l2cap_chan_hold(chan);
> >         l2cap_chan_lock(chan);
> >
> > +       if (refcount_read(&sk->sk_refcnt) == 1)
> > +               chan->data = NULL;
> 
> Might be a good idea to add some comment on why checking for refcount
> == 1 is the right thing to do here, or perhaps we can always assign
> chan->data to NULL, instead of that perhaps we could have it done in
> l2cap_sock_kill?
In this case, it is possible to always set chan->data to NULL, but I think a
better approach would be to release sock in l2cap_sock_kill when the reference
count of the sock is 1. Previously, it was mentioned that setting chan->data to
NULL is more rigorous.
And chan->data is bound one-on-one to the sock, if the sock is not released,
I can't confirm whether setting chan->data to NULL will affect the operation of
the sock on other paths.
> 
> >         sock_orphan(sk);
> >         l2cap_sock_kill(sk);
> >
> > @@ -1481,12 +1483,22 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
> >
> >  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> >  {
> > -       struct sock *sk = chan->data;
> > -       struct l2cap_pinfo *pi = l2cap_pi(sk);
> > +       struct sock *sk;
> > +       struct l2cap_pinfo *pi;
> >         int err;
> >
> > -       lock_sock(sk);
> > +       l2cap_chan_hold(chan);
> > +       l2cap_chan_lock(chan);
> > +       sk = chan->data;
> > +
> > +       if (!sk) {
> > +               l2cap_chan_unlock(chan);
> > +               l2cap_chan_put(chan);
> > +               return -ENXIO;
> > +       }
> >
> > +       pi = l2cap_pi(sk);
> > +       lock_sock(sk);
> >         if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
> >                 err = -ENOMEM;
> >                 goto done;
> > @@ -1535,6 +1547,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> >
> >  done:
> >         release_sock(sk);
> > +       l2cap_chan_unlock(chan);
> > +       l2cap_chan_put(chan);
> >
> >         return err;
> >  }

--
Edward

