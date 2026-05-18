Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D930567B
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141455; cv=pass; b=oTQl71pMeifo3CWR9P66N08v6h3jvfHJ3Ym4ptjyRAOPBOiDl60yeKrlMIw0MG1WzDs/4HRYx7t9bclJJAUWxfKXf0KXaDVx8W4dOPt8U0o8xyYYVUt/gvtdUytfD6fDnTFvjXVqeWcVIGV7dbYUbKA0SFVmdV40wwryBYYK+3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141455; c=relaxed/simple;
	bh=W0JV+dzXRkeZji3MKXxrXkhWVQhAHjDDnSFU6FdruQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCiUaOHsI3+6QJx7O7YGYlU+uwSEfahKhW7z0XU65NTvjLsNU6nxYoZxNhs+fgCxAwOJ1aj1lR0H5+Zkm7vwQNR6p4SGE8zlgntk0r9pEu0cPW0JIEgKY/f82XxHjDdizP4wWrPHq86Pm4O7L5W7LRSNuMN1oCzYK+OaZQb0D28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH4718H2; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH4718H2"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c477a3278so3026915d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141452; cv=none;
        d=google.com; s=arc-20240605;
        b=TBLI1Oo+s8xV4MR+VDTtqFpi6cuW+UAxN9+XhoRC6unJgZAZqDrP4WPMDO3jmTKEuA
         Q6Gw7IWUdm6p18xFnpPO0rIsy8RJhpDQFiSZ4qe6suU14W3JQjcMXaOep8ycombGQ8IS
         rTG1MuLHuHT2OwX3eHBfX42UcYs+CLZK0vmpqRGj+ODrngGgg7ZSjHlecftyKZBNSKc5
         /XT02xLtvHLAz7+X+Q6KJVnB2gGftaqSPaC+7eKuoIQpy5C/mrQURMv5Mkk64du29Cpn
         IEbUqMKYTGiTyKkrJS5KLLwoIe4sjAezb+tUS2O0IBgqsUhTqws+nRsnZVE8f1kGFqco
         rDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jKzqkBsSJ/6hsOm14qSznIA2rxVOjNzDNkM7X86EKic=;
        fh=d/VqpzRea23GuCh/baekE+spfb11d6ij/VZHX16ayqs=;
        b=f72M0hopU4tBhgP5K7eCD25zTLT8Z+vBuEvS6lxNyrjChwZzRucjzZr6yxiyk0M+Y7
         lEWsMQkpnVH270AHsNEJl5MEqD4sDkh0TR8JOnWGhVmsKa4SZwESxUdOy9BFf6FRWIY5
         BO0GMKYX/WadJ/5aW8EHCFwFRILVRtXWdf9H9EGT4znoxELULYInP+Eb7Zem2ARJrqRD
         DF4NkHUf4yf92PrzYHGecyfOSJz4+RQOyVYPPM1ACO1aYQIS56OfKt9RY9OhLk2rhB71
         75FOkwlpOc5dZ0Wg2KPSH7AcHjHR2mX5gdi4L6VL7xLpVQ7y38peB2WPyL9ubXeDJ+fO
         d9IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141452; x=1779746252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKzqkBsSJ/6hsOm14qSznIA2rxVOjNzDNkM7X86EKic=;
        b=YH4718H2WqCQ11tzMo1jon8qPZAjH6XAllPdF8ZgSF9UhybvJGHk6+9CysjWfDcsug
         nM2n3UcZ4lxk8fMKvOKsMOf7UiB1AgREMoJcXkgn+3gLCvizjOQ/TkdD1G9t6A0zPdcf
         4vddb4j/qD+Jgeq65XCPOwPxSP9cd4Y9zCTNn8CyndFxdFpdTQWbk0xs91eY6ahphgmg
         Hv5uiECofujhXmAFSnT4GOwXoOrLiZMn60mPkEXUsGGSyRr19c33GkCoGL6y1u1Z0/zh
         bAkBCIT+zbD4aOrUSqHYC+KIilFJxqMyOs0j766MtzdzEwGa5fxPLHO9mBsasZKUFiPX
         PUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141452; x=1779746252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKzqkBsSJ/6hsOm14qSznIA2rxVOjNzDNkM7X86EKic=;
        b=bsvxN5C10h7OooPeuN5TM6Q0wOsSUo8uNn9RZ77QhNe0kymYqe41jngh9NwKM/k3Qv
         aHtLE7kNTvSfJmdNnJfRWFHra2wogo/MkN97CnW7upKIikq41U2ts4MOvC8xBTPT9u/g
         n7SqfpxH2DopRinPytsZ1iVT5l/v9v4F3lB50aQDuE49sdfr3NkR9+C2HIOYkM/ysChF
         1Fuk+mRo2o3JmLXnFwsymkO9UGOLuzR0YmjE/k3ITwsZB4ty7i6EaMPcG5DytPH4V2MQ
         XyRf4UmosdBRCrtR1v+7l2vYFyJ8WXgaWrrhhsrIcBSNzOFmmxDDPxrs/OrdQmeBySyy
         D+7w==
X-Forwarded-Encrypted: i=1; AFNElJ94VeJQusdhJEHxJmnQ/0Ih5sCLgWEVrFl2DEX9YDgHHbjzLDkqCVKHuoKbIOmIdDQwnKfH5V1CnUrw0qP/slU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTill+CkC1fvR7VxjjL5qfxXV4HyTGkIythhOdkTYurVFdKYSQ
	VOiQS87euNxCgQu9ucuSIyZCGriDGRthSZjoHj7H7O75VOpKy/Bn1p5O4n7r2MmMmA4r5ooABiU
	vBZ0ooMtoDdiq2ZiR6YHkOA/inB/Z2jUqnjA5Ls0=
X-Gm-Gg: Acq92OHIVJL20K44f8ScxAnkZGd2x+2+SDfCTPq3c/w0vruSGADgR0TCjpZdhr2J01D
	nOFcHZMpyWH1caaVgu+d2wtuWgiLMV1CEqA37ZxoU8EAmZqpW2p5osYNekd9a2AbUO8d91b7GZU
	zfapfyMInhexM9O5rSa0cm0do962wMdpo9UrcU88P0imGHDctZ8VUny+PE6uRJEw2Hc5tBfG6dx
	Ch7smCRM9ZkxJLWXXi3bsIt5F9WXsrbBy6kk5Jt4reDOqIES1chGTzaKKaSy4pWPWu20YDd8W5P
	N3HU+Eb+y+5+RencyWu3SV3RgH1dpWtirfehcwWMbwB40MVeJNh1XhggIteZ9ZjQF2V6mQ==
X-Received: by 2002:a05:690e:148b:b0:651:c468:99a2 with SMTP id
 956f58d0204a3-65e2283833amr17809566d50.45.1779141452353; Mon, 18 May 2026
 14:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511170929.709823-1-oss@fourdim.xyz> <20260511170929.709823-2-oss@fourdim.xyz>
 <CABBYNZL3UVcogeJGiOzEcyGi3TCGf_pCCz+Vd32K3Li0GmPVwQ@mail.gmail.com> <558a354c-d2b6-4c7c-97cf-606753902b85@app.fastmail.com>
In-Reply-To: <558a354c-d2b6-4c7c-97cf-606753902b85@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 17:57:21 -0400
X-Gm-Features: AVHnY4I_iiwp7ZbSjb2GslYZoZN2RHnYunI4Vd9Sh_bkgZYsQPF5fGX_bX5AHkg
Message-ID: <CABBYNZL8zf+mfnLcs+X+9S2Kd=0-nSN6roywWk4wz=Bcmzqa4A@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Thu, May 14, 2026 at 8:23=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> Hi Luiz,
>
> On Mon, May 11, 2026, at 3:17 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Mon, May 11, 2026 at 1:09=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> w=
rote:
> >>
> >> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> >> release_sock(parent). Once the parent lock is released, the child
> >> socket sk can be freed by another task.
> >>
> >> Save the channel pointer into a local variable while the parent lock
> >> is still held to prevent this.
> >>
> >> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap=
_core.c")
> >> Cc: stable@kernel.org
> >> Assisted-by: Claude:claude-opus-4-7
> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> ---
> >>  net/bluetooth/6lowpan.c    |  5 +++++
> >>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
> >>  net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
> >>  net/bluetooth/smp.c        |  5 +++++
> >>  4 files changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >> index 23a229ab6a33..71c1c04b61e5 100644
> >> --- a/net/bluetooth/6lowpan.c
> >> +++ b/net/bluetooth/6lowpan.c
> >> @@ -755,6 +755,11 @@ static inline struct l2cap_chan *chan_new_conn_cb=
(struct l2cap_chan *pchan)
> >>
> >>         BT_DBG("chan %p pchan %p", chan, pchan);
> >>
> >> +       /* Match the put that the caller of ops->new_connection() perf=
orms
> >> +        * once it is done with the returned channel pointer.
> >> +        */
> >> +       l2cap_chan_hold(chan);
> >> +
> >>         return chan;
> >>  }
> >>
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index 7701528f1167..0f6c3c651207 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn *con=
n, struct l2cap_cmd_hdr *cmd,
> >>
> >>         __l2cap_chan_add(conn, chan);
> >>
> >> +       /* Drop the ops->new_connection() ref; conn list now pins chan=
. */
> >> +       l2cap_chan_put(chan);
> >> +
> >>         dcid =3D chan->scid;
> >>
> >>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> >> @@ -4970,6 +4973,9 @@ static int l2cap_le_connect_req(struct l2cap_con=
n *conn,
> >>
> >>         __l2cap_chan_add(conn, chan);
> >>
> >> +       /* Drop the ops->new_connection() ref; conn list now pins chan=
. */
> >> +       l2cap_chan_put(chan);
> >> +
> >>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
> >>
> >>         dcid =3D chan->scid;
> >> @@ -5194,6 +5200,9 @@ static inline int l2cap_ecred_conn_req(struct l2=
cap_conn *conn,
> >>
> >>                 __l2cap_chan_add(conn, chan);
> >>
> >> +               /* Drop the ops->new_connection() ref; conn list now p=
ins chan. */
> >> +               l2cap_chan_put(chan);
> >> +
> >>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
> >>
> >>                 /* Init response */
> >> @@ -7407,6 +7416,9 @@ static void l2cap_connect_cfm(struct hci_conn *h=
con, u8 status)
> >>                         chan->dst_type =3D dst_type;
> >>
> >>                         __l2cap_chan_add(conn, chan);
> >> +
> >> +                       /* Drop the ops->new_connection() ref; conn li=
st now pins chan. */
> >> +                       l2cap_chan_put(chan);
> >>                 }
> >>
> >>                 l2cap_chan_unlock(pchan);
> >> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >> index cf590a67d364..295c79cf5cf3 100644
> >> --- a/net/bluetooth/l2cap_sock.c
> >> +++ b/net/bluetooth/l2cap_sock.c
> >> @@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct soc=
k *parent)
> >>  static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_c=
han *chan)
> >>  {
> >>         struct sock *sk, *parent =3D chan->data;
> >> +       struct l2cap_chan *child_chan;
> >>
> >>         if (!parent)
> >>                 return NULL;
> >> @@ -1523,9 +1524,19 @@ static struct l2cap_chan *l2cap_sock_new_connec=
tion_cb(struct l2cap_chan *chan)
> >>
> >>         bt_accept_enqueue(parent, sk, false);
> >>
> >> +       child_chan =3D l2cap_pi(sk)->chan;
> >> +
> >> +       /* Pin the channel for the caller. Once release_sock(parent) r=
eturns,
> >> +        * userspace can accept(2) and immediately close(2) the child =
socket,
> >> +        * which would drop the socket's references on the channel and=
 free
> >> +        * it before the caller (e.g. l2cap_connect_req()) is done usi=
ng the
> >> +        * returned pointer. The matching put is the caller's responsi=
bility.
> >> +        */
> >> +       l2cap_chan_hold(child_chan);
> >
> > The entire problem might be solvable by not removing `list_add` from
> > `l2cap_create_chan`. This way, it only allocates but does not attach
> > to global_l until __l2cap_chan_add is called which then handles the
> > addition.
>
> Could you please clarify what is "not removing `list_add` from
> `l2cap_chan_create`"? I am not touching that part of code nor removing
> the `list_add`. Do you want me to correspond the `chan` lifetime to `chan=
_list`?
>
> > Alternatively, we could allocate it first, given the
> > circular dependency involving `l2cap_core`.c->l2cap_sock.c)
> > new_connection -> l2cap_chan_create(l2cap_sock.c->l2cap_core.c) which
>
> This will change the signature of `l2cap_ops.new_connection`, which will =
be a large
> refactoring across multiple files.
>
> Signature will be changed from
> `struct l2cap_chan      *(*new_connection) (struct l2cap_chan *chan);`
> to
> `void (*new_connection) (struct l2cap_chan *chan, struct l2cap_chan *new_=
chan)`
> Do you want me to this in this patch or in the follow up patch?
> If in this patch, I will drop the backport cc to stable.
>
> > makes the code rather hard to follow.
> >
>
> I totally understand this will create a maintenance problem. I created th=
is patch
> mainly because it can be easily to be backported to the stable branches a=
nd it
> is the safest fix (though ugly). I can send a follow up patch for this to=
 refactor it
> according to your suggestions.

I don't think adding a new argument would be complicated. This
argument could replace the current void return, and although it will
affect a couple more places, it shouldn't be hard to backport if it
really needs to be backported to begin with.

>
> >>         release_sock(parent);
> >>
> >> -       return l2cap_pi(sk)->chan;
> >> +       return child_chan;
> >>  }
> >>
> >>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff=
 *skb)
> >> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> >> index 1739c1989dbd..9796c3030434 100644
> >> --- a/net/bluetooth/smp.c
> >> +++ b/net/bluetooth/smp.c
> >> @@ -3231,6 +3231,11 @@ static inline struct l2cap_chan *smp_new_conn_c=
b(struct l2cap_chan *pchan)
> >>
> >>         BT_DBG("created chan %p", chan);
> >>
> >> +       /* Match the put that the caller of ops->new_connection() perf=
orms
> >> +        * once it is done with the returned channel pointer.
> >> +        */
> >> +       l2cap_chan_hold(chan);
> >> +
> >>         return chan;
> >>  }
> >>
> >> --
> >> 2.54.0
> >>
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Best,
> Siwei



--=20
Luiz Augusto von Dentz
