Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D913C901;
	Mon, 24 Jun 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236190; cv=none; b=NucQgQr9+7l3qyCctOICzS0shIm30V+TtOLDMYaMMvJJZ5UghLpeY7MlmlwIX5Qh/ckJzvmtD43oDwA6i7yzXfnEq7AZVVewY4UDAkzzrCPYMUiOxHOqk1NynbBrT6eQCP0wZuQ2IiGGw6/LYVZ0lBmqHaqUlXWfcasTW8ujArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236190; c=relaxed/simple;
	bh=JTAp4UDEJHPEUUuCOnG+SgNv3EYBtS5fA24Vtxjriqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWhPTUBs+rLMZ/GMyB3brFEw9iQ+MVFaYQF3DeClqZ9EdrtMtGKoT1MOi9JptTF29SRpGAUeySuYqGcmeiZUV/3V2u3tGKvwLkfWYNGST6AdEmpxYIlSjnsTe+2hs2Jky33oOnDRB4JNZsZJL9Qm4kI6sojDkY7NJfE/s2X2kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFqTwqd4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFqTwqd4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec59193468so12915591fa.1;
        Mon, 24 Jun 2024 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236187; x=1719840987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkZfvD4PLKsiwgfdlYx63vmiI9ZpjsrWjgZ3Pa3uCRM=;
        b=dFqTwqd4jSKQNklK+FcenazlXRxCLiHvL+LFIFK8FNoFsVMYMnlttCRDcFPw0OiGZu
         Svfo9R0IkNzFCRq1SXLdpNY5Mlg6hoQcMnUVn+DkXjtOu3yEcg+4oAqWMgdtDcu0Hi9e
         GFLkZ90XOWP1Suc6943/P5wfpeHp8edHo9rCgw7yn4DT/PTUCwsPAz4brrAGw9hoCjPw
         zm/FAnt5nR1YZ0DZxL6uqVXdlhfDd5t4ikyks19FnM4TveptQVyob9bQIVB8DrLQsTiA
         tEjDcgkjgg2Ht2hsrqvnbMoiCU/SoavYo1juE79frbQkMior/inXkLpNDxo+GSCQmliI
         A3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236187; x=1719840987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkZfvD4PLKsiwgfdlYx63vmiI9ZpjsrWjgZ3Pa3uCRM=;
        b=bN2xNsWEvtMHDNLQftA4rukLGcKuccBAWYMLmDGl2r2xLw9wozqsl9QOL2NGrgVR/+
         FGzdtN7nOUq/zZJXs80Pwqa+sZKf5rksgLGEa8xXtWTTBfbsBAgxxmtUKPhBuIzQh9nN
         sB7305WI/OQqNtdbXyVet7BFhx3Soms9qt+fDUUlTQuT+AD7Jgo9udbsL2jzOgHWj5ye
         ZGFcTUzndqSK8nWacrG9S8jviN7JkeIPPdo1KH9HyiAgV6j7/EE5KOPLJWXCiRE4+E+h
         WX0liytNDKVrqllHSPc+/8GzhQ+VWONFBZnPtxqSkdA97cdsH99/gdMaSxzcTyJcqkb7
         NUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfheLeLEzfRx6r29/M6CyPuBnRaXGo5881OzgFvA2tBPxjGFBrSAPe/zi0EMNigeyewOIRG5/DL3F2uEuKagfxuQ7GKT6Hd7qziyRsY0sUzhzQPBblOOX5lJ1fywL3zL78ktVJ7TQExUNv82g
X-Gm-Message-State: AOJu0Yy7XXfkXo07d5ohWTC9XtXTTqNZJ7HB4OHQC4cD6Q4pYt/n3w5G
	5xyUcM6KyXprh0OkgRfAsEr3LKTVMwXVI9qH8cl2nGHH2A7Axo7C/8BnEYQWtDXYdVz7uc4bJ1B
	vlSK1uxcVv6p+q8ruJjFmtltilTo=
X-Google-Smtp-Source: AGHT+IE5BhcwNkSy/BtWPFiSKhg8DTn5SsxUV8uT+6cD8wWYGnIALqe1+2Sy7766l3SzLQhiaN0ZMN7I4LwytBUgKqI=
X-Received: by 2002:a2e:99cb:0:b0:2ec:4408:56ac with SMTP id
 38308e7fff4ca-2ec56c96be3mr13900391fa.17.1719236186875; Mon, 24 Jun 2024
 06:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLu-wAu6cdyDVim=bP+0Ld-P=YvENO=fa6r=rdY4UqukQ@mail.gmail.com>
 <tencent_832C796CAC95F0E9A2EC6ECF00798E6DCC0A@qq.com>
In-Reply-To: <tencent_832C796CAC95F0E9A2EC6ECF00798E6DCC0A@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Jun 2024 09:36:14 -0400
Message-ID: <CABBYNZ+_sEiu-4790zY7pH7-AOi7L2Da0AFeD8W+_bSjTrXENQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth/l2cap: sync sock recv cb and release
To: Edward Adam Davis <eadavis@qq.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Fri, Jun 21, 2024 at 11:46=E2=80=AFPM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> Hi Luiz Augusto von Dentz,
>
> On Thu, 20 Jun 2024 12:53:19 -0400, Luiz Augusto von Dentz wrote:
> > >         release_sock(sk);
> > > +       l2cap_chan_unlock(chan);
> > > +       l2cap_chan_put(chan);
> > >
> > >         return err;
> > >  }
> > > --
> > > 2.43.0
> >
> > Looks like this was never really tested properly:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> > --------------------------------------------
> > kworker/u5:0/35 is trying to acquire lock:
> > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_sock_recv_cb+0x44/0x1e0
> >
> > but task is already holding lock:
> > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_get_chan_by_scid+0xaf/0xd0
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&chan->lock#2/1);
> >   lock(&chan->lock#2/1);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 3 locks held by kworker/u5:0/35:
> >  #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> > process_one_work+0x750/0x930
> >  #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> > at: process_one_work+0x44e/0x930
> >  #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_get_chan_by_scid+0xaf/0xd0
> >
> > l2cap_sock_recv_cb is assumed to be called with the chan_lock held so
> > perhaps we can just do:
> >
> >        sk =3D chan->data;
> >        if (!sk)
> >                return -ENXIO;
>
> If the release occurs after this judgment, the same problem will still oc=
cur.
> Recv and release must be synchronized using locks, which can be solved by
> adding new lock.
>
> Please use the new patch https://syzkaller.appspot.com/text?tag=3DPatch&x=
=3D15d2c48e980000, I have tested in
> https://syzkaller.appspot.com/bug?extid=3Db7f6f8c9303466e16c8a

Hmm, why don't we just fix l2cap_conless_channel? Btw,
l2cap_conless_channel is normally not used by any profiles thus why
there isn't any CI covering it, on the other hand l2cap_data_channel
is used by 99% of the profiles.

> --
> Edward
>


--=20
Luiz Augusto von Dentz
