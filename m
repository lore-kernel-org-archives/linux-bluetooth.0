Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E72175A7C
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778385686; cv=pass; b=ib/NRXa8EQeNUraeFQtZWiN/LOi2Sah+wC6A3NzWzJ+vrY72mZhyu9myc5HbHEbDBfEWGgLrJlztfrFL9gX983przt3U8foCHExCuJBX5v6jIf7MoAno128eDBA0N0xQX9Hwr+cYrvzz6ZwUO9nA8G/ykbvCkvr57QbsB2Fj4WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778385686; c=relaxed/simple;
	bh=44rsVwlxlEL6D1wUnqO/ieQfIq69HLe+iUYfc5dZ99w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THJ3Eg3iYCVb3xQWTP4oWvK0lTQSWGxd1RJIsqN4HmyCrPxr4zzuw+8zXAGmwC7w7SejEaB+BSBKkiGhL7jx/hvqbmWMlh/PSEneDTAHkqLybhBJY0AH97P5z3FNWvK7KD9leZM5apgI1WaQzugaPQz3daQtyFMLl+Se3VS55Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj/glYWY; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj/glYWY"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso28432341fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 21:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778385683; cv=none;
        d=google.com; s=arc-20240605;
        b=H3V0pIJVwKRkqwXo48SV+ACy5Zt5rOb0T2uwXFlAcu0lM1IJbrQO8Z0+caVK7O1xcF
         C48XGca0sh4JUAdNNh6wwVkOD5cYhtIQuBh4wqSDbOolQdvf800kJqSCjaueqE68leVJ
         xhlFAf0Qp8CmvqWLmqfDtWe9BlO+HaU75uB8G+6Lo3ZB7iMyZqUNHeqLUwKx780ODH9X
         tXAHOuvGJbmt4cAk9KGjl4ywYlQUW/AISg4fMXXGiE8gFE6h543hD4cRK+0jjMu1m/Ls
         Fj1IlICQbVwMKdgIgDTUSt5WsuaFoKsUU2/nFztb+wwK7lYZOL3Zka6q+YODufceZyC5
         OcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RFfuLwJFc+MDN96Sntac+G4tOidoaCxrdu76xaS1s0w=;
        fh=kCsRdwBBQUDRdzvpLo+WYzZx97WAOVs4VLpMLELCrcg=;
        b=K+ZWyC1D60fD+BT1R/zDZHPt81nXVyK62fMWDv+9XEdbs65YFzNtUlI8rAlgfSOyDu
         XVKA90FLpD7pjYcoUTCjt3huOqd7CmIh1JtVXFF8XtO81DWhVF6KFxllI0GcVP6PMyJw
         rRZ1NgBHgKBRPLH1RwirTNLGobnE3cCVQeMvgbdCwSljFeMBhFhVzINMpYhvaNB/xaKT
         jVqt5KZLYUZcCPwVdOZXRlc9orgkbpiJ4updRTxRkzv0qDPFDlK9+9wb+qfB9/soL8Kp
         jgTCxfsnR+ERmGxrgLQgT24OvRu/spaqqiWeJAZA39PksAoc2ETZNU+x8yMvpjV5BXxk
         6udA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778385683; x=1778990483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFfuLwJFc+MDN96Sntac+G4tOidoaCxrdu76xaS1s0w=;
        b=hj/glYWY0SKdee4ay2YOAp437He6kO8a2zKVP456A4A5/qioG9tEROIWabp9JvxSxa
         2hUeaiWCEw1J1HulYDB5bzcB4LESu2Zf6lDG9k6AQTOtPd14xqeyfDmgiFQgbEBmpP/y
         Br2+K2olDv/sF9G977+t8l1RIOj+Q5+ChYD9rjKF86w44cC/rQ3PzzjBgwM3+spwnsz2
         6kFc8pFH+0KmDygCmoSv0CjvLhqtUK7ih+Kth6wdZpaAVvWncCWd4UEkeqDJMW0+rLF5
         AF8VVa4yXQuaCLSD80Ljgji6n+cRPsyj7pWNnR8fPMyIDndAmFXkJt8vLqPdGDyd641F
         sliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778385683; x=1778990483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFfuLwJFc+MDN96Sntac+G4tOidoaCxrdu76xaS1s0w=;
        b=PZb/xEAINNF+vjyi0nS5XXWZ386A3FYKhqmL/QOZe4gsc8xiokQf+5EFblOmieBc0R
         LE8PTIWnZVaiz5rKJqQRJgTwjoHq5oR78RNo5CQbEu7X31NhuBlV7KxY+cdGCVIcw7HI
         695nh+smBsJBe2mubqQ7SbO95zk9NbxtvYBUc2F68W34CWoHq3tp0wnaU6NuUmhhvacg
         L4V0wQUfEEgJe80E2EUrzKyFJBbCIVxKzImx8sXNyvPoaT2wQptXFMHa1c+FFf7FPULb
         4FHS5YsO/m7xqdjyuQ6DX8hDYtKcndVryna8L4LRPdO95DJaD5HLb2zkbAc7WXnZ3wKF
         x2zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+O4FEgnEeabW5MA7+Bw0VJe8AHq2SUc4KAzfRwURgyeniDQl487GHrdY1XeCAovYtwzU5aJyQ17ihuJpwItY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9ywZYnR6bGkwo5RLj/+MvK0bxi/sXfb4LxJAIAhxDyaamvjJ
	rpyBflo3/8t7A0hPOg6MJ6ZPLkAvilaGX5DKd34BJJVabFPXguUJs/ErCrpv/UBlSHo2xc9KmgE
	v/bV/WXRrP4QDHKUtIUcBmzHuUibUXTk=
X-Gm-Gg: Acq92OFEpv0dTS8U7b4Xqrm55MiI6k2hVQDOZmUgiVjH3EPVzX5wC3+puZLlDUKBMwT
	ssTq+tjVgddNl2hJ1cnQcZm2hN1sYXEmhSztkaUzvHcSFuUBW8f4TDaoch9Q+uxJANm1t9patiH
	oSSavAuEEqnwBqeBCP5edKIZswHWBidKFkOFHeaW0UHaER64/8lB2SflAqeK+pvSHw17apy+cOF
	31i/PhfBP27aZhLYApYvENLS6dRgWKGx9upqvpswhsjgQP60MlBmgFV9Cc9CukeZc2KTFOUFXFT
	p3F8NXYgjrTSJrCOTC2h8hy2UkeVdQ==
X-Received: by 2002:a2e:a547:0:b0:393:a0f0:57f7 with SMTP id
 38308e7fff4ca-394080fd3f2mr12695971fa.14.1778385683031; Sat, 09 May 2026
 21:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509173745.413473-1-rollkingzzc@gmail.com> <20260510014359.472-1-hdanton@sina.com>
In-Reply-To: <20260510014359.472-1-hdanton@sina.com>
From: c Z <rollkingzzc@gmail.com>
Date: Sun, 10 May 2026 12:01:10 +0800
X-Gm-Features: AVHnY4Jwp5552zawndH0wfq_8J74FYr4cNeD9UtIFdkyvfa0Q8aFWPrPtrs0Jdc
Message-ID: <CAB7XQsHk-g55Cxjjcpmdn=nSEq9NoqDfO1eG_yvrRqCatOYFKg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Defer peer channel release until RCU cleanup
To: Hillf Danton <hdanton@sina.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hillf Danton <hdanton@sina.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8810=E6=97=A5=
=E5=91=A8=E6=97=A5 09:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 10 May 2026 01:37:45 +0800 Zhang Cen wrote:
> > A 6LoWPAN peer stores the protocol-owned L2CAP channel reference in
> > peer->chan. chan_close_cb() removes the peer from the RCU list, but it
> > also drops that reference immediately. The peer object can still be see=
n
> > by in-flight RCU readers, and some paths keep using peer->chan after th=
e
> > lookup has finished.
> >
> > That lets transmit and disconnect paths dereference, lock, or send
> > through a channel whose last reference was released by the close path.
> >
> Sounds like the race between close and lookup paths
>
>         chan_close_cb()         setup_header()
>         ---                     ---
>         peer_del()
>           list_del_rcu(&peer->list);
>           kfree_rcu(peer, rcu);
>         l2cap_chan_put(c); // free chan
>
>                                 peer_lookup_dst(dev, &ipv6_daddr, skb);
>                                   rcu_read_lock();
>                                   peer =3D find peer;
>                                   rcu_read_unlock();
>                                 if (peer)
>                                         addr =3D peer->chan->dst; //uaf
>
> and on the lookup side, a) peer is unsafe outside rcu lock and
> b) chan is used after put.
>
> To fix the race, in addition to move l2cap_chan_put() to the rcu
> callback as this patch does, refcount should be added to peer to
> make the lookup path safe.
>
>         chan_close_cb()         setup_header()
>         ---                     ---
>         peer_del()
>           list_del_rcu(&peer->list);
>           call_rcu(&peer->rcu, peer_free_rcu);
>             if (peer->refcount-- =3D=3D 0) {
>                 //alternatively schedule workqueue if task context needed
>                 l2cap_chan_put(c);
>                 kfree(peer);
>                 module_put(THIS_MODULE);
>             }
>                                 peer_lookup_dst(dev, &ipv6_daddr, skb);
>                                   rcu_read_lock();
>                                   peer =3D find peer;
>                                   if (peer)
>                                         peer->refcount++;
>                                   rcu_read_unlock();
>                                 if (peer) {
>                                         addr =3D peer->chan->dst;
>                                         if (peer->refcount-- =3D=3D 0)
>                                                 schedule workqueue to fre=
e peer;
>                                 }
>
Hi Hillf,

Thanks for looking at this and for spelling out the lookup-side lifetime
issue.

I agree that v2 should make the peer lifetime explicit. v1 moves the
peer-owned l2cap_chan_put() behind the RCU grace period, and it also
changes the unicast transmit lookup to copy the peer fields / take a
channel reference before dropping RCU. But the broader point still
stands: helpers such as lookup_peer() should not hand a raw lowpan_peer
to users that continue after rcu_read_unlock().

I'll prepare v2 so the peer object has its own refcount. The plan is to:

  * add a refcount/kref to struct lowpan_peer and initialize it with the
    peer-list owner reference;
  * make RCU lookups that return a peer acquire a reference before
    unlocking, using the usual non-zero refcount pattern;
  * make peer_del() only unlink the peer and schedule an RCU callback
    which drops the owner reference after the grace period;
  * release the peer-owned L2CAP channel reference and module reference
    from the final peer put; and
  * audit the remaining lookup_peer()/peer_lookup_dst() users so every
    post-lookup use either holds a peer reference or only uses data copied
    while still under RCU.

Thanks,
Zhang Cen
