Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80682F8BF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295099; cv=none; b=qJMj5HwV66rYId5/PvfhA9CmvhVHnlfs97oFtSl20bdX8NvjVvlYXitVvq2A+Efnqq6chz0cD4U5ZyAFIZjJQ9PcYuxJoYyQGX9B1qDOyUJDVPuFQvG/0wjA8zOGIVhBEYK1hXJVUhdxgPVs7rU6c29mCtIrN5a0ho0Mo8rYqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295099; c=relaxed/simple;
	bh=V470FPWFpBBlogwz4S1DA4/Z4FlytPt9N4ss5GFmmLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBXo4pbs8bTISq1URraUGetAicu3JvCbQgduHwqRNRjx8iMibWYra0yHz/InH5EjjjRh00+PKb/bJhmFlQmHjNrgvSxAxso/MoM9XJnnW5BfxtWM/svuUi3IULfy/giEcpTIZSdhy/mllSlOSblR97/cfRLnz8SQcrfAR1sOApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW3rLwwr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW3rLwwr"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so1789650a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295097; x=1774899897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHSmQnqruVYOPE2Nx/rhjr1MMlC15Zk+Y/aTWxMHjKg=;
        b=VW3rLwwrtRxUvEuYre3c8Tf/6P/1tvC1FWebHeeVbmEZY9n6y2p8WFXzPiygReObSC
         ak0G0DZDPd/DmOxdewCwvoqxe5CatsZgjTfdIGh/QX+lqU8UIikQotqP3YoyCi8d6edS
         ShqXvg5r9VAKaO1vb853j2Fth680gERpp8PTNSfns21bcHTY6EAch4u4KFK96mMRY5Yb
         +1mva4Lau/wq/1fkAiaAIOSTIOK3j0E4kUz91w35/+9nTNKIrNFdl1O3RRmvmWzxlTke
         WX7lojKUWIOCANrjeGF3hqLaJJX6poQEw7/fD/4w5HNDEjQ8AbqylKC4bXmXOmPIZ/PY
         KNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295097; x=1774899897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHSmQnqruVYOPE2Nx/rhjr1MMlC15Zk+Y/aTWxMHjKg=;
        b=JRZnAy8A6vAARfpZ6dtaR2VwclEAG74sMk8PVQoxMdbDaMkaaCl/DIaMVkcw5stkJq
         2zfqI6/fnNA6P4lZqW0vBo3WLDcmUviY0r74XSZqNZF7F4Aeu4GRHpeA07tNuuLlVr2Y
         ebnuKFpbEIndMkUHCzReU1oWsYBOn5L/GRw4HkMrqdpsF3iN+a7JpGZplMGwM9wm9u15
         7YUz3QN5uWsKhDdgKkbSbzVFfOCZMmK4e5Zay+SSQDQqTaa9ZBj6MToi2QNkM7GLE2Sq
         lQ9I7sUqrPeEh3aOZAXRzYsyBdyyW5scWZk/R1w2t8ogr/SXhv6sEytZfQ1HhYZOlFMw
         UlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhH+y/nNexGqErJ1By5JS7kx/z3Wk7lTN58sHdu0QDb09rdKZBZLLGNXnaUzuM8YvT+FFDDZrpfguFaXR6A6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsv6pfDthI09qhd/vKHbOOzN4ktE9Ll1pEKZONiyK09fIdbcRW
	j6VbmQVf4OScaSc8Rfrk3diZR3MeGX8ldBGi9ESpiX84NTzW1nNlvCSo
X-Gm-Gg: ATEYQzxk66PSHcFU657YAxOW2IkoocjqE7JacSQkKxLTwcY+bucw+NU80zGi1QzeCzk
	lCenp+Wc6FUMMtpmb/Ej6E+nrxMuY4JzwRYmalE00u70Np9Dl9o2sW0+bZH+Ia8T7QHO6fzys7S
	GUkFr3wgZ6m6sZkt71PKc/S+JfaGrCYv75iKJB3Z63yExfwbpxlJ9NnEEHpMxjmAGLPXFhV9AJ5
	mvOfmc4Rl20T+7GAMSF4MSMuG9EUvyMoPgpIoL3zrU/YR5jHEbGqr4aKpVedcUY4QaI7ViLZJI5
	5zHdExNZJbRGoAJrE2IvIgeW7AviEqIedMBBhCnitpiqg72XNQ4uDAjvDv2hON0+OJo1hn1v8i/
	0fD9qHzR8uBzntwfVbb0hajX6+4DaZpLezdhKsn+P+FrWbvq2FVF+/Y9EohyDrH5CNL+O+quTDr
	4HWZjYKAyEl1H/g2SlpzyXZFLD3wgv3XuLqQS0ZttanX831+2yaluN
X-Received: by 2002:a17:902:f60a:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b09a611475mr48071085ad.32.1774295096870;
        Mon, 23 Mar 2026 12:44:56 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354772fsm119331365ad.28.2026.03.23.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:44:56 -0700 (PDT)
Date: Tue, 24 Mar 2026 04:44:53 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_chan_timeout
Message-ID: <acGYNd4RlVBjtcMv@v4bel>
References: <ab0yX61gGSlEaMEF@v4bel>
 <CABBYNZL0t9dvLcoxdAXCb37EdTU3+iEkpicSSz=w0iBJi5=P=w@mail.gmail.com>
 <ab7HhEkCVH-K0iCN@v4bel>
 <CABBYNZLguntAEGvrJ=4wCBmsfJO0awvjgMvFj7irBxANh=8E7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLguntAEGvrJ=4wCBmsfJO0awvjgMvFj7irBxANh=8E7Q@mail.gmail.com>

Hi Luiz,

On Mon, Mar 23, 2026 at 03:16:37PM -0400, Luiz Augusto von Dentz wrote:
> Hi Hyunwoo,
> 
> On Sat, Mar 21, 2026 at 12:30 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On Fri, Mar 20, 2026 at 09:59:50AM -0400, Luiz Augusto von Dentz wrote:
> > > Hi Hyunwoo,
> > >
> > > On Fri, Mar 20, 2026 at 7:41 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > > >
> > > > l2cap_chan_timeout() reads chan->conn without holding any lock and
> > > > without taking a reference on the connection. If l2cap_conn_del()
> > > > frees the connection concurrently, mutex_lock(&conn->lock) operates
> > > > on freed memory. Additionally, the existing NULL check early return
> > > > leaks the channel reference held by the timer.
> > > >
> > > > Fix the root cause by disabling channel timers when the channel is
> > > > being destroyed. Use disable_delayed_work() in l2cap_chan_del() to
> > > > prevent timers from being rearmed, and disable_delayed_work_sync()
> > > > in l2cap_conn_del() to ensure running timer work has completed
> > > > before the connection is freed.
> > > >
> > > > The sync cannot be done directly inside l2cap_chan_del() because it
> > > > would deadlock in three independent ways: (1) l2cap_chan_timeout()
> > > > can call l2cap_chan_close() -> l2cap_chan_del(), so syncing chan_timer
> > > > would wait for itself; (2) callers hold conn->lock while
> > > > l2cap_chan_timeout() acquires it; (3) callers hold chan->lock while
> > > > the ERTM timer functions acquire it. Therefore, the sync is
> > > > performed in l2cap_conn_del() after releasing conn->lock.
> > > >
> > > > Also fix the reference leak on the !conn early return path in
> > > > l2cap_chan_timeout().
> > > >
> > > > Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Moved the fix from l2cap_chan_timeout() to l2cap_chan_del()/l2cap_conn_del() to address the root cause instead of adding locking in the callback
> > > > - Used disable_delayed_work()/disable_delayed_work_sync() to prevent timer rearming and ensure completion, as suggested by Luiz
> > > > - Applied the fix to all four channel timers (chan_timer, retrans_timer, monitor_timer, ack_timer)
> > > > - Removed l2cap_conn_get()/l2cap_conn_put() and the lock reordering that caused a circular locking dependency in v1
> > > > - v1: https://lore.kernel.org/all/abwSxg_C6n8Avid3@v4bel/
> > > > ---
> > > >  net/bluetooth/l2cap_core.c | 30 ++++++++++++++++++++++++++++--
> > > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > > index 5deb6c4f1e41..c08478e4512b 100644
> > > > --- a/net/bluetooth/l2cap_core.c
> > > > +++ b/net/bluetooth/l2cap_core.c
> > > > @@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
> > > >
> > > >         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
> > > >
> > > > -       if (!conn)
> > > > +       if (!conn) {
> > > > +               l2cap_chan_put(chan);
> > > >                 return;
> > > > +       }
> > > >
> > > >         mutex_lock(&conn->lock);
> > > >         /* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
> > > > @@ -649,6 +651,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> > > >         struct l2cap_conn *conn = chan->conn;
> > > >
> > > >         __clear_chan_timer(chan);
> > > > +       /* Prevent the timer from being rearmed since the channel is about
> > > > +        * to be destroyed. Running timer work will be synced by
> > > > +        * l2cap_conn_del() after releasing conn->lock.
> > > > +        */
> > > > +       disable_delayed_work(&chan->chan_timer);
> > >
> > > Hmm, so we can't use the _sync version because it could be pending on
> > > conn->lock while this could be called from l2cap_conn_del? I wonder if
> > > we should clarify the comment or if we actually need to mark the
> > > l2cap_chan as deleted/disconnected or something, perhaps via state,
> > > also we may want to return something like -EINPROGRESS if a timer
> > > could not be disabled which would indicate to the likes of
> > > l2cap_conn_del that it need a cleanup.
> > >
> > > >         BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
> > > >                state_to_string(chan->state));
> > > > @@ -688,6 +695,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> > > >                 __clear_retrans_timer(chan);
> > > >                 __clear_monitor_timer(chan);
> > > >                 __clear_ack_timer(chan);
> > > > +               /* Prevent the ERTM timers from being rearmed. */
> > > > +               disable_delayed_work(&chan->retrans_timer);
> > > > +               disable_delayed_work(&chan->monitor_timer);
> > > > +               disable_delayed_work(&chan->ack_timer);
> > >
> > >
> > > l2cap_clear_timer drops the reference if the timer was cancelled, so I
> > > think we will need to check the return of disable as well, or create a
> > > function like l2cap_disable_timer, that said Id return something to
> > > indicate that l2cap_chan_del didn't cleanup everything.
> > >
> > > >                 skb_queue_purge(&chan->srej_q);
> > > >
> > > > @@ -1742,6 +1753,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> > > >  {
> > > >         struct l2cap_conn *conn = hcon->l2cap_data;
> > > >         struct l2cap_chan *chan, *l;
> > > > +       LIST_HEAD(del_list);
> > > >
> > > >         if (!conn)
> > > >                 return;
> > > > @@ -1780,7 +1792,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> > > >                 chan->ops->close(chan);
> > > >
> > > >                 l2cap_chan_unlock(chan);
> > > > -               l2cap_chan_put(chan);
> > >
> > > Let's populate the del_list only with channels that actually had a
> > > pending timer.
> > >
> > > > +               list_add_tail(&chan->list, &del_list);
> > > >         }
> > > >
> > > >         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> > > > @@ -1791,6 +1803,20 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> > > >
> > > >         hcon->l2cap_data = NULL;
> > > >         mutex_unlock(&conn->lock);
> > > > +
> > > > +       /* Disable and sync-wait for any running channel timer work without
> > > > +        * holding conn->lock to avoid AB-BA deadlock with
> > > > +        * l2cap_chan_timeout() which acquires conn->lock.
> > > > +        */
> > > > +       list_for_each_entry_safe(chan, l, &del_list, list) {
> > > > +               disable_delayed_work_sync(&chan->chan_timer);
> > > > +               disable_delayed_work_sync(&chan->retrans_timer);
> > > > +               disable_delayed_work_sync(&chan->monitor_timer);
> > > > +               disable_delayed_work_sync(&chan->ack_timer);
> > > > +               list_del(&chan->list);
> > > > +               l2cap_chan_put(chan);
> > > > +       }
> > >
> > > It might be better to place the disable sync-wait on
> > > l2cap_chan_destroy then since l2cap_chan_del is not garanteed to do
> > > it, which means l2cap_chan_put is not safe to be called with
> > > conn->lock, but I guess it was never really safe since if we destroy
> > > the chan while a timer is pending/running it would cause an UAF
> > >
> > > >         l2cap_conn_put(conn);
> > > >  }
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > This is regarding the missing Reported-by credit that was discussed
> > on security@kernel.org. My credit has still not been added to the
> > commit in the netdev tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/net/bluetooth?id=9d87cb22195b2c67405f5485d525190747ad5493
> >
> > If this gets merged into mainline as-is, my credit will be
> > permanently lost, correct?
> >
> > It seems like the mainline pull request is not far away. I would
> > appreciate a quick confirmation on this.
> 
> Yeah, I rushed that due to a regression fix and unfortunately forgot
> about your Reported-by:.

So does this mean my Reported-by credit will never be included? Or are 
you in the process of adding it to the netdev tree?

I understand you're really busy, but I would appreciate it if you could 
add the promised Reported-by credit to the netdev tree before it gets 
merged into mainline. I followed the process as requested by the security 
team, and my clean Signed-off-by credit was completely lost. 
I don't mind losing credit on other patches, but this is an important patch.

> 
> Don't see any comments regarding the changes above, the faster we got
> to these in the less more likely are they to enter the next merge
> window.

As for the l2cap_chan_timeout patch, it requires more careful consideration 
than I initially expected, so I need more time to analyze the issues you raised. 
I'll submit a v3 once the work is done -- though honestly, this may be beyond 
my current understanding of the Bluetooth layer.

> 
> >
> > Best regards,
> > Hyunwoo Kim
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
