Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B013A894;
	Mon, 24 Jun 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237312; cv=none; b=F/9yYRJDhEe32vi/phMFnKJ56KDPWtGlvJgWRtwLZwAcJWK5RTK9lLw8XZhLhONI1Kvw0PYxybQx+Xugw0wD/R27kq4sHozjPVGg/E14JJOQKtdSkDQ3R9pjibdECopDKQra5DUq6wFjce+eQdtdd3JjiB8bj+TAZDbElqzbVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237312; c=relaxed/simple;
	bh=OTVvvIzT8s68MzaFas47pQxyxeuMB/eUVz9FaLjaqWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3WM1ma8sgEkJnB+9XkN2b6qGy2B8JLvR9PWNRIudmuYs0Xg+cK40eky+x3Fqyq8xuAPxRKcEwt0vlSGsFPEAsnO1KQ6YPqhQ/R6yGrGWo7i3ys6kaLBsdR3IAT8wpZmmQkAu+Y/3c9ULhUpgKfTYUugnyhCsbebH5bj7Y00fNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHFZ8wyy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHFZ8wyy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso48349701fa.1;
        Mon, 24 Jun 2024 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719237309; x=1719842109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Bx3uoP0RpXGONQOgl54hoJE/GZm/I0mWhu2NNUDKo=;
        b=nHFZ8wyy81Lx7uFf0X+97Zq1igNnCxLe3pIBUD+HZBH/bMCC0LhmXtck3yda1urX78
         XipwPlmzvQBIIC8EgU3IRauelphPrwmuxUT180Th98+9FaR2c5ZjGlaWuXeDuW+Nlh48
         PDWGnavoKZGH4Bh8N/8b+lZVBDHr+asAYbxzTBscari6usZ7+Oie5/wO2rPETN8D+fGd
         gG+eHlQbXVLpqtyIwJWexAdiOhRrmvPjWCjig2z1lGHplNnlqGwbi7IkoWQMp7eagr4f
         wfK2wuXx4Up2hLqqdki/X9m3YL4LgYEUERExa5cRLozbGf/Z20J8AbachdhEG3L5jLxD
         Szfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237309; x=1719842109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Bx3uoP0RpXGONQOgl54hoJE/GZm/I0mWhu2NNUDKo=;
        b=ISyBzsBj7DRzWoXxCpB24MPrGEpknBOgfF0Y8GAqwwPhiBgwKumt5SrKzmGO/rFTV6
         +k/HZ4I7DJtTIawUyLpC3jNZqaqRwT07q19wbBC56PAJtjt9cgF5Wic/jxvCHdMwDI5T
         WZgA+TKv2pykcjVJNIFPYT9mCkwJ7fMvQMkE91mq8MTKhIfZSO7bBG/j4oqfocSk1XIW
         ZfAv+umnM5VNVkFMtMkL9KSRWgEqghfqxjurJW3AKtoRojyWmXLJ5zGFrYw1Vc8E+y7H
         egXUyi3VWuqMivS9DOqcFD4otMJMyVf++ywpRjf5y5azR1a0nb2H7CwAaJX48w/+Fmh9
         7A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY05l78C97W2xUUlYigJdUVaEX1iLg58ZmlmKOQ87sFRQ6zVQDSg7qZiKBHXtSRVlWwvFTOj7ouWbApRHeVfHnO964EYVRTvnwryjQdkr8u+q1nJHiCEaO41P2RN4dvy5F4dcluttbbKuBsgaI
X-Gm-Message-State: AOJu0Yzc57S8oAB8ziIHHaep01hTpM3hjLq42ZZAQJtgXBo11lmHe9F6
	uPfPLCLEMB8uZwWcQOLh6Nqtrn3MjTxpTKlFowdGYrRpsqedRAJSFk24FnMe5AW1WTQKwQp9oO9
	ijjpGACGBXs5ikVp2BTLKN5LgPs4=
X-Google-Smtp-Source: AGHT+IFj7wettLHFG8rd6oFnB5L4JcffGYfYp4659LCbNJPrZ3m46yWaY2woucbv2e5+0OFsY+iWKthKs7riWM82tUU=
X-Received: by 2002:a2e:9cd4:0:b0:2ec:520d:f1dd with SMTP id
 38308e7fff4ca-2ec593be843mr29581371fa.3.1719237308619; Mon, 24 Jun 2024
 06:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <181de5a745458f349b93b05a51438d3608046c49.camel@iki.fi> <tencent_7C66AC3C8B36B8978636E04B46744F77B109@qq.com>
In-Reply-To: <tencent_7C66AC3C8B36B8978636E04B46744F77B109@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Jun 2024 09:54:56 -0400
Message-ID: <CABBYNZ+SPSGnPagYAQijd7jvdg=1CZsOhD6PcVd-m8LmKEijpw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix double free in hci_req_sync_complete
To: Edward Adam Davis <eadavis@qq.com>
Cc: pav@iki.fi, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Sun, Jun 23, 2024 at 8:02=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> On Sun, 23 Jun 2024 13:30:50 +0300, Pauli Virtanen wrote:
> > > cpu1                       cpu2
> > > =3D=3D=3D=3D                       =3D=3D=3D=3D
> > >                            sock_ioctl
> > >                            sock_do_ioctl
> > >                            hci_sock_ioctl
> > > hci_rx_work                hci_dev_cmd
> > > hci_event_packet           hci_req_sync
> > > req_complete_skb           __hci_req_sync
> > > hci_req_sync_complete
> > >
> > > If hci_rx_work executes before __hci_req_sync releases req_skb, every=
thing
> > > is normal, otherwise it will result in double free of req_skb.
> > >
> > > Adding NULL check of req_skb before releasing it can avoid double fre=
e.
> >
> > Do you understand why?
> >
> > kfree_skb(NULL) is allowed, so this is logically a no-op.
> >
> > Probably it perturbs the timings so syzkaller repro no longer hits the
> > race window, ie doesn't fix the issue.
> Good, even if you already know race, let me ask you a question: how to re=
duce race window?

We actually need to stop using hci_req_sync since that has been
deprecated, instead it shall use hci_cmd_sync_submit, we could for the
time being just make hci_req_sync use hci_cmd_sync_submit to avoid
such races.

> ``
> Edward
>


--=20
Luiz Augusto von Dentz
