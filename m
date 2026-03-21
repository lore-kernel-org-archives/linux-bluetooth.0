Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB631AF31
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110602; cv=none; b=FWfL4k2gD4eGyxN818cnyaTWPLrwNZ6MjxE2aTKQ795hCR5nqgCN7ZzsNDs9DVfPJO0gqN1gpPEK7rp8xeti386kkV3wpNAgs3d0Wckh0JDUHBoYsNndrLtf/CvsicEZ4D6Lxxo1O0DGYobrPrELj51Z7PNFz1PcOQ5PLurZ7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110602; c=relaxed/simple;
	bh=TqURdfO6riM84o9Sp3O1fbfwr4iRsFKy4yCgXxvthTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPwA6I2oDz48Cgo3kYeU1rHS/0NhwS+wsWRPqkzY7DyjAPfjYkNC8QwipSEsHjaMfUTeikSS+sMtemrMhZCq4xVTvBzy0ZK/3rELFCpY81ePIIfA1a/VeiBxZ7zHd7S9L8mj0pS9dfIy0AjbmBNcHlqv3Xl5yyfWQS6+jKfsv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDWIxDoo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDWIxDoo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso24793945ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774110600; x=1774715400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XdCpmpDUP6NIoTI8mjMuF2oltKLdSLv96QGXSmUFno=;
        b=JDWIxDoo9VxWr0mtYkKlsD+9Ij04UTfmaex+hbe9GA1QKL6A9uxRiU3usyvncaIyeX
         v8P085Ni4+U/GwWtFVLO3Ogk4KMbySbuoaAIEv6IcmAucF6lKLha+tv8WTcRo7m/DvYZ
         C08guzUI2LpF3Is5liutP3qr4//RL8X3anw2x4oFTWG5N0qjzu18lBDD7hZw2on5unFD
         KYnIi86VcHnR72S9fzEJh5j5S/NG7yK6KUeBOipOPZoO2fwWIOI1s80HBMjeb137rGNa
         IXzowOf5p2QuHeR8pZeQn49ceLJdORmtDXU049GtyhSq1n+ZDSSneVscsKHS8G1Ne2jf
         hcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774110600; x=1774715400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XdCpmpDUP6NIoTI8mjMuF2oltKLdSLv96QGXSmUFno=;
        b=MboWIr0vzB/RLFGCgCM7PIyUAt3tYD4NdfQdxbapVOVp4ATF/qyHRDld9VWArb1WUP
         bSiJ5zLftc0bIX4ToYqJYpXUVDAvi44BvnaUNCufIj80VL1rKX7vCz64LD1Vg94vqTfU
         7ws4adQ9M1HDpRhcXSE9Z7rR4cUs7asACGx3/BKk1ubYcfVldl6c6XN77KvoBNpHsIlX
         t069Con0fj1MFyDoY4ak3derqhvR+bChHny9jH4MnvXXhlc71nrCi0mhJl8UAA40sOyx
         vdeN1lgjvBSheh6K+NKnLUrk6NFASDwNAMqau+1Q1UKjSRt108ESoBHVxmKWMS9lNMOq
         xJgw==
X-Forwarded-Encrypted: i=1; AJvYcCW0D3ExD2LBZB21VPhEB6e7XHVGNL2kgabY57KQs/NbQ2RjzLABrVg0dRpLVyBVnw0OHux0etyn3pY3P05xT6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw720vsPz5g7CCVCY7G0MWJnROdxBTD7bWHje8ZJlHzI5FCv4J3
	uwY/sRiAH2JOtZGUjrGhpPfWncTBhEGktqmEQB0PyLteUsB+W/1tHnaYw9xMvQ==
X-Gm-Gg: ATEYQzwBI/Ozmp30FF0zWiszOjEbmp/Dd2A6tvYZ0AB+gk7Ok3bejZ82w9h7YfuAzbX
	vnWBLHAhd8NIuwUsoPBbZz6hJE9ly+Y4TV/NuFVuvj+dvFDasXDhAlic+wNeM4nRyLerXwodAio
	pHnc//Mjs6lKCqU4oUExeMAmh3Tm8tf/Ls241pM3si9y6uw0ZKmYGbbIhPyopghmhVqJ6Fgu1+G
	xDmJZdhU4VZ+i6aWHB1svlMuCknfUyn6Vr7UdbX6YRsWPLAHD9Lp/7KBcmEKxuHBU3lQM+ivZ3l
	BiJ6kbzMdGcHzvi+VFpqCbDww+ezZ8yvR9SNQphrnOs2bulIm6+TVVCg0SPjuRDt/ORaPhohA+u
	/ImY96l4k19gsgF03JKBJpYfvIZ8W5csQ/sCbjtTFpdSkTgKRcSr097CBTbHoVA9alTDJnnKhB8
	4nn4I3ND4QIVdfWBravVNT/UiXWpkScKwMLrHvuBrNiw==
X-Received: by 2002:a17:903:41d0:b0:2b0:6488:4957 with SMTP id d9443c01a7336-2b077264f52mr93949625ad.30.1774110599648;
        Sat, 21 Mar 2026 09:29:59 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bcf0sm57908595ad.33.2026.03.21.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 09:29:59 -0700 (PDT)
Date: Sun, 22 Mar 2026 01:29:56 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_chan_timeout
Message-ID: <ab7HhEkCVH-K0iCN@v4bel>
References: <ab0yX61gGSlEaMEF@v4bel>
 <CABBYNZL0t9dvLcoxdAXCb37EdTU3+iEkpicSSz=w0iBJi5=P=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZL0t9dvLcoxdAXCb37EdTU3+iEkpicSSz=w0iBJi5=P=w@mail.gmail.com>

On Fri, Mar 20, 2026 at 09:59:50AM -0400, Luiz Augusto von Dentz wrote:
> Hi Hyunwoo,
> 
> On Fri, Mar 20, 2026 at 7:41 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > l2cap_chan_timeout() reads chan->conn without holding any lock and
> > without taking a reference on the connection. If l2cap_conn_del()
> > frees the connection concurrently, mutex_lock(&conn->lock) operates
> > on freed memory. Additionally, the existing NULL check early return
> > leaks the channel reference held by the timer.
> >
> > Fix the root cause by disabling channel timers when the channel is
> > being destroyed. Use disable_delayed_work() in l2cap_chan_del() to
> > prevent timers from being rearmed, and disable_delayed_work_sync()
> > in l2cap_conn_del() to ensure running timer work has completed
> > before the connection is freed.
> >
> > The sync cannot be done directly inside l2cap_chan_del() because it
> > would deadlock in three independent ways: (1) l2cap_chan_timeout()
> > can call l2cap_chan_close() -> l2cap_chan_del(), so syncing chan_timer
> > would wait for itself; (2) callers hold conn->lock while
> > l2cap_chan_timeout() acquires it; (3) callers hold chan->lock while
> > the ERTM timer functions acquire it. Therefore, the sync is
> > performed in l2cap_conn_del() after releasing conn->lock.
> >
> > Also fix the reference leak on the !conn early return path in
> > l2cap_chan_timeout().
> >
> > Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> > Changes in v2:
> > - Moved the fix from l2cap_chan_timeout() to l2cap_chan_del()/l2cap_conn_del() to address the root cause instead of adding locking in the callback
> > - Used disable_delayed_work()/disable_delayed_work_sync() to prevent timer rearming and ensure completion, as suggested by Luiz
> > - Applied the fix to all four channel timers (chan_timer, retrans_timer, monitor_timer, ack_timer)
> > - Removed l2cap_conn_get()/l2cap_conn_put() and the lock reordering that caused a circular locking dependency in v1
> > - v1: https://lore.kernel.org/all/abwSxg_C6n8Avid3@v4bel/
> > ---
> >  net/bluetooth/l2cap_core.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5deb6c4f1e41..c08478e4512b 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
> >
> >         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
> >
> > -       if (!conn)
> > +       if (!conn) {
> > +               l2cap_chan_put(chan);
> >                 return;
> > +       }
> >
> >         mutex_lock(&conn->lock);
> >         /* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
> > @@ -649,6 +651,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >         struct l2cap_conn *conn = chan->conn;
> >
> >         __clear_chan_timer(chan);
> > +       /* Prevent the timer from being rearmed since the channel is about
> > +        * to be destroyed. Running timer work will be synced by
> > +        * l2cap_conn_del() after releasing conn->lock.
> > +        */
> > +       disable_delayed_work(&chan->chan_timer);
> 
> Hmm, so we can't use the _sync version because it could be pending on
> conn->lock while this could be called from l2cap_conn_del? I wonder if
> we should clarify the comment or if we actually need to mark the
> l2cap_chan as deleted/disconnected or something, perhaps via state,
> also we may want to return something like -EINPROGRESS if a timer
> could not be disabled which would indicate to the likes of
> l2cap_conn_del that it need a cleanup.
> 
> >         BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
> >                state_to_string(chan->state));
> > @@ -688,6 +695,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >                 __clear_retrans_timer(chan);
> >                 __clear_monitor_timer(chan);
> >                 __clear_ack_timer(chan);
> > +               /* Prevent the ERTM timers from being rearmed. */
> > +               disable_delayed_work(&chan->retrans_timer);
> > +               disable_delayed_work(&chan->monitor_timer);
> > +               disable_delayed_work(&chan->ack_timer);
> 
> 
> l2cap_clear_timer drops the reference if the timer was cancelled, so I
> think we will need to check the return of disable as well, or create a
> function like l2cap_disable_timer, that said Id return something to
> indicate that l2cap_chan_del didn't cleanup everything.
> 
> >                 skb_queue_purge(&chan->srej_q);
> >
> > @@ -1742,6 +1753,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> >  {
> >         struct l2cap_conn *conn = hcon->l2cap_data;
> >         struct l2cap_chan *chan, *l;
> > +       LIST_HEAD(del_list);
> >
> >         if (!conn)
> >                 return;
> > @@ -1780,7 +1792,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> >                 chan->ops->close(chan);
> >
> >                 l2cap_chan_unlock(chan);
> > -               l2cap_chan_put(chan);
> 
> Let's populate the del_list only with channels that actually had a
> pending timer.
> 
> > +               list_add_tail(&chan->list, &del_list);
> >         }
> >
> >         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> > @@ -1791,6 +1803,20 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> >
> >         hcon->l2cap_data = NULL;
> >         mutex_unlock(&conn->lock);
> > +
> > +       /* Disable and sync-wait for any running channel timer work without
> > +        * holding conn->lock to avoid AB-BA deadlock with
> > +        * l2cap_chan_timeout() which acquires conn->lock.
> > +        */
> > +       list_for_each_entry_safe(chan, l, &del_list, list) {
> > +               disable_delayed_work_sync(&chan->chan_timer);
> > +               disable_delayed_work_sync(&chan->retrans_timer);
> > +               disable_delayed_work_sync(&chan->monitor_timer);
> > +               disable_delayed_work_sync(&chan->ack_timer);
> > +               list_del(&chan->list);
> > +               l2cap_chan_put(chan);
> > +       }
> 
> It might be better to place the disable sync-wait on
> l2cap_chan_destroy then since l2cap_chan_del is not garanteed to do
> it, which means l2cap_chan_put is not safe to be called with
> conn->lock, but I guess it was never really safe since if we destroy
> the chan while a timer is pending/running it would cause an UAF
> 
> >         l2cap_conn_put(conn);
> >  }
> >
> > --
> > 2.43.0
> >
> 
> 
> -- 
> Luiz Augusto von Dentz


This is regarding the missing Reported-by credit that was discussed 
on security@kernel.org. My credit has still not been added to the 
commit in the netdev tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/net/bluetooth?id=9d87cb22195b2c67405f5485d525190747ad5493

If this gets merged into mainline as-is, my credit will be 
permanently lost, correct?

It seems like the mainline pull request is not far away. I would 
appreciate a quick confirmation on this.


Best regards,
Hyunwoo Kim
