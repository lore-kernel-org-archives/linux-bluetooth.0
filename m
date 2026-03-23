Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD80352C39
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293417; cv=pass; b=qioVumz4p4doruKiZGe0xVXb0kdHGELSSnFymYe9DXGHxdUO20nbbcN4f6T9EKFSLGRGNnTUqT5yKlS9NhAPSRwcQScXp6HPHt6JVVGe5BRD4B5Ui8+Ii21Q237m+DUsDeBz1oSh2L8msfYzzseIVdnurWw0GdXE3rDjj4L7idI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293417; c=relaxed/simple;
	bh=alaKU4AL0mS4Tx+qwirF0IepP5CmUFOzdym37sZNxI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Moq1zeFT0dNA0xurjj/RdH+MknW6+i564uRZmsPqDB6yP3XG6KWIXmQ5YlqzTz6NSgqUZ+73CQVRjQBowmnIpLAB9+V0Di8oNtCRSeDmAMrl4ZwPYv0QHSiXhcMSkwmAGd4v71mCqK0voNAjfS29VMbtiB/Ir5uipuWGfffV6o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsQ5EfO+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsQ5EfO+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a74765703so29120567b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 12:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293409; cv=none;
        d=google.com; s=arc-20240605;
        b=B5DyM8k6WRwZeJC+bERtWXv8NkreuClJPeaTn2yfcV0MXmnBSdJd0PlRYq4Aa7+Rq1
         V7EO+LY0xqs2ol7rxAWvvPLkUmvxyToco40T8oirgAQqF4deeTRAaWydnc7VoqfgC6Qu
         6VA037APIaWpss0wk4KKbO+lfR0quIoKqKp5MN5Wef05KNJwU+KXJfVgx66pEqjhMkpP
         L1BFx/dU6y2YMKeB6Vu4AHvojWu2qa8oIPp3KadRTMyiUye/P8dJxxblg5ajF0GofpyN
         q5jjDqwCXeeDGbk5lqxAo++pn+x3BAfDbq31m+UTIe0M2G8pm8xQ7i8rm388DhzW3xE8
         UuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PlOivenCQRGdyw1l04dBOJhxNvPlSpmacm27Q+vkBU=;
        fh=+rmq6ttu0LeZHlqDgArhiG1/hgA7BPrUjxohJE2IKk0=;
        b=J0Tf9g6WlT765MjvuwPL04CXzhN4tqmaXZQMwTIDKBD9I7Ldvs2BzDXRZiNrgbNzWg
         tseT7zpGr/vsMvjQhDP/n2wLCDjQKAtTWOqM3oQX798852r7cuUKo2Z42h0e1TYePVNR
         GtYBUiyLWYfjughncjepfIQ0gU1R87Spa/88bx2ADdeDJJ/SfeS1cLnOO4EmfYXe/JaN
         ULSB294UpuHnkwoDHDlAi3hcIylpyaYXM0IHfl/z/FHKAdLBtZSoZpHt5oOoVBryCvKD
         sTjHxI02nYNZgM6uly5sSx119go/81IDn0BQu+Wz6w1AiUonc3xhre6i31Kzhk+WhmiP
         xm2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774293409; x=1774898209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PlOivenCQRGdyw1l04dBOJhxNvPlSpmacm27Q+vkBU=;
        b=qsQ5EfO+9UPuKGzAuKo9kJALCC+qxhP5Tql0qtNodylds4lGuKi/gfZpzJfusF7Cag
         EcP6Mh9evaKWwrQO0SmZnvF5NtYKNuU1pDP+wRjl/zzfBueKKzGtgQXa2hW5lELkeFz8
         P9nSHq5H6grMZfUPrOF6QGcYfoW8BlCYWtdMmN43xcH8eU8cfcyDEi1Epx+wM/WHzYuD
         wGbfNnUiW5YuRAYVeANLhDeeVoCotgI+sJ6XAfrRX9xUZ+HTuc0hVI88FqUnof+MCUjZ
         aZckRmksPAxgg0+9ZsFIjXRAYyUdjrtL2R7WNjka9JBWVXDhQ9dVbdiClpP6KuPM+nbO
         3FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293409; x=1774898209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PlOivenCQRGdyw1l04dBOJhxNvPlSpmacm27Q+vkBU=;
        b=ewf90sa6Hs87oT+KaXOvgCQaWNK27Te2CfB6L+iKj6khHOCrkjuqeTMmNLe7U27hlr
         rzJGZd7adZm1VwKUYEfmhVMie6pq/2oNOPZv2t7Vcj9KX8V1EwLKAFKzPNQsO1dO0Xib
         BCyTNa/t7yyLIokGygMXO38W/zp7M8WgW/Jn8lXAC5gzYM26Daf43NZeX9VcMUBzh9fm
         wJrulhFimhTF/ep1PtDde4R5hz+llo+M2HbIqBJolGkOCz1kRXgDx9/m2JR7N4+3mDxp
         LjYaAVqVXERmxbw6UIhK+t5n23Tn7nY2t38R+Iq5vOBoHSWYookHeS4RklnL/WTW4y44
         VYtg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/LcONHWGyWk0OtXmKCxYd1A+VafELvVS5/8KYZ5Cg3smpRmRBTPu9dcXUKIacUPBbyw5j8L3bXxgxYyYl6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aG7B+vsoSIwWkLctj7r3cdPdcSuqnXULfdTbEkdnOY1RajC4
	7atkwOsGDrs/4cjR5XNXcSVZDsKjWCWN72qftnI6dsUiuYOJjOBd7w/yf7FCUxyf3WvknrVQhvf
	dSbD1FAjl0eYbgp0mfr6AYrtiZtCAk6s=
X-Gm-Gg: ATEYQzx4VKruqamfddnfYnixFVnC7XBRTJT9dRTxofMxsot1dwM4mkSTq1ynt7zigK0
	MgLPYgEs5nivlELmLSG/Q/tbGE2yCWuqiShlL9mwjh0istLHAVkEyyClQxisUYjMSlrUdcSXNly
	u6DLduep8ILr4m7e5EMtjHU3MFP6UdEKh2AIiLn6JgcCAEsVoKBXVjfrbP4maiNG4Nx4sp4324G
	yK2DhJDfHeTlzsQt09U3gqqh86Xs74tvFfoYDoGf7bM7hVuYOEFgDdyuq9ZJssviak+ePfQTFf6
	FdftZq5TTrGvCHRDz5isc1cOUxwpdVMIFfcgcq9U3dQbgkQoBtX3oQ2xEFNqednrLysHbA==
X-Received: by 2002:a05:690c:6611:b0:79a:c28b:b04b with SMTP id
 00721157ae682-79ac28bce3cmr12407877b3.19.1774293408534; Mon, 23 Mar 2026
 12:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab0yX61gGSlEaMEF@v4bel> <CABBYNZL0t9dvLcoxdAXCb37EdTU3+iEkpicSSz=w0iBJi5=P=w@mail.gmail.com>
 <ab7HhEkCVH-K0iCN@v4bel>
In-Reply-To: <ab7HhEkCVH-K0iCN@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Mar 2026 15:16:37 -0400
X-Gm-Features: AaiRm53yt6hZkZRLA9Uewa-UhuWmyC47vmU4wCzb7CMBT_pmpN4ClOC2Rr-f0R8
Message-ID: <CABBYNZLguntAEGvrJ=4wCBmsfJO0awvjgMvFj7irBxANh=8E7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Sat, Mar 21, 2026 at 12:30=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wr=
ote:
>
> On Fri, Mar 20, 2026 at 09:59:50AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Hyunwoo,
> >
> > On Fri, Mar 20, 2026 at 7:41=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com>=
 wrote:
> > >
> > > l2cap_chan_timeout() reads chan->conn without holding any lock and
> > > without taking a reference on the connection. If l2cap_conn_del()
> > > frees the connection concurrently, mutex_lock(&conn->lock) operates
> > > on freed memory. Additionally, the existing NULL check early return
> > > leaks the channel reference held by the timer.
> > >
> > > Fix the root cause by disabling channel timers when the channel is
> > > being destroyed. Use disable_delayed_work() in l2cap_chan_del() to
> > > prevent timers from being rearmed, and disable_delayed_work_sync()
> > > in l2cap_conn_del() to ensure running timer work has completed
> > > before the connection is freed.
> > >
> > > The sync cannot be done directly inside l2cap_chan_del() because it
> > > would deadlock in three independent ways: (1) l2cap_chan_timeout()
> > > can call l2cap_chan_close() -> l2cap_chan_del(), so syncing chan_time=
r
> > > would wait for itself; (2) callers hold conn->lock while
> > > l2cap_chan_timeout() acquires it; (3) callers hold chan->lock while
> > > the ERTM timer functions acquire it. Therefore, the sync is
> > > performed in l2cap_conn_del() after releasing conn->lock.
> > >
> > > Also fix the reference leak on the !conn early return path in
> > > l2cap_chan_timeout().
> > >
> > > Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Moved the fix from l2cap_chan_timeout() to l2cap_chan_del()/l2cap_c=
onn_del() to address the root cause instead of adding locking in the callba=
ck
> > > - Used disable_delayed_work()/disable_delayed_work_sync() to prevent =
timer rearming and ensure completion, as suggested by Luiz
> > > - Applied the fix to all four channel timers (chan_timer, retrans_tim=
er, monitor_timer, ack_timer)
> > > - Removed l2cap_conn_get()/l2cap_conn_put() and the lock reordering t=
hat caused a circular locking dependency in v1
> > > - v1: https://lore.kernel.org/all/abwSxg_C6n8Avid3@v4bel/
> > > ---
> > >  net/bluetooth/l2cap_core.c | 30 ++++++++++++++++++++++++++++--
> > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 5deb6c4f1e41..c08478e4512b 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struc=
t *work)
> > >
> > >         BT_DBG("chan %p state %s", chan, state_to_string(chan->state)=
);
> > >
> > > -       if (!conn)
> > > +       if (!conn) {
> > > +               l2cap_chan_put(chan);
> > >                 return;
> > > +       }
> > >
> > >         mutex_lock(&conn->lock);
> > >         /* __set_chan_timer() calls l2cap_chan_hold(chan) while sched=
uling
> > > @@ -649,6 +651,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int=
 err)
> > >         struct l2cap_conn *conn =3D chan->conn;
> > >
> > >         __clear_chan_timer(chan);
> > > +       /* Prevent the timer from being rearmed since the channel is =
about
> > > +        * to be destroyed. Running timer work will be synced by
> > > +        * l2cap_conn_del() after releasing conn->lock.
> > > +        */
> > > +       disable_delayed_work(&chan->chan_timer);
> >
> > Hmm, so we can't use the _sync version because it could be pending on
> > conn->lock while this could be called from l2cap_conn_del? I wonder if
> > we should clarify the comment or if we actually need to mark the
> > l2cap_chan as deleted/disconnected or something, perhaps via state,
> > also we may want to return something like -EINPROGRESS if a timer
> > could not be disabled which would indicate to the likes of
> > l2cap_conn_del that it need a cleanup.
> >
> > >         BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
> > >                state_to_string(chan->state));
> > > @@ -688,6 +695,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int=
 err)
> > >                 __clear_retrans_timer(chan);
> > >                 __clear_monitor_timer(chan);
> > >                 __clear_ack_timer(chan);
> > > +               /* Prevent the ERTM timers from being rearmed. */
> > > +               disable_delayed_work(&chan->retrans_timer);
> > > +               disable_delayed_work(&chan->monitor_timer);
> > > +               disable_delayed_work(&chan->ack_timer);
> >
> >
> > l2cap_clear_timer drops the reference if the timer was cancelled, so I
> > think we will need to check the return of disable as well, or create a
> > function like l2cap_disable_timer, that said Id return something to
> > indicate that l2cap_chan_del didn't cleanup everything.
> >
> > >                 skb_queue_purge(&chan->srej_q);
> > >
> > > @@ -1742,6 +1753,7 @@ static void l2cap_conn_del(struct hci_conn *hco=
n, int err)
> > >  {
> > >         struct l2cap_conn *conn =3D hcon->l2cap_data;
> > >         struct l2cap_chan *chan, *l;
> > > +       LIST_HEAD(del_list);
> > >
> > >         if (!conn)
> > >                 return;
> > > @@ -1780,7 +1792,7 @@ static void l2cap_conn_del(struct hci_conn *hco=
n, int err)
> > >                 chan->ops->close(chan);
> > >
> > >                 l2cap_chan_unlock(chan);
> > > -               l2cap_chan_put(chan);
> >
> > Let's populate the del_list only with channels that actually had a
> > pending timer.
> >
> > > +               list_add_tail(&chan->list, &del_list);
> > >         }
> > >
> > >         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> > > @@ -1791,6 +1803,20 @@ static void l2cap_conn_del(struct hci_conn *hc=
on, int err)
> > >
> > >         hcon->l2cap_data =3D NULL;
> > >         mutex_unlock(&conn->lock);
> > > +
> > > +       /* Disable and sync-wait for any running channel timer work w=
ithout
> > > +        * holding conn->lock to avoid AB-BA deadlock with
> > > +        * l2cap_chan_timeout() which acquires conn->lock.
> > > +        */
> > > +       list_for_each_entry_safe(chan, l, &del_list, list) {
> > > +               disable_delayed_work_sync(&chan->chan_timer);
> > > +               disable_delayed_work_sync(&chan->retrans_timer);
> > > +               disable_delayed_work_sync(&chan->monitor_timer);
> > > +               disable_delayed_work_sync(&chan->ack_timer);
> > > +               list_del(&chan->list);
> > > +               l2cap_chan_put(chan);
> > > +       }
> >
> > It might be better to place the disable sync-wait on
> > l2cap_chan_destroy then since l2cap_chan_del is not garanteed to do
> > it, which means l2cap_chan_put is not safe to be called with
> > conn->lock, but I guess it was never really safe since if we destroy
> > the chan while a timer is pending/running it would cause an UAF
> >
> > >         l2cap_conn_put(conn);
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> This is regarding the missing Reported-by credit that was discussed
> on security@kernel.org. My credit has still not been added to the
> commit in the netdev tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/net=
/bluetooth?id=3D9d87cb22195b2c67405f5485d525190747ad5493
>
> If this gets merged into mainline as-is, my credit will be
> permanently lost, correct?
>
> It seems like the mainline pull request is not far away. I would
> appreciate a quick confirmation on this.

Yeah, I rushed that due to a regression fix and unfortunately forgot
about your Reported-by:.

Don't see any comments regarding the changes above, the faster we got
to these in the less more likely are they to enter the next merge
window.

>
> Best regards,
> Hyunwoo Kim



--=20
Luiz Augusto von Dentz
