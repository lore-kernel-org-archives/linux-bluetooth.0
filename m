Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59F44366
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829796; cv=none; b=rF+ytplSWlLr1mdiEl4zQLpCC3zBmpsWgC0v93tKh0gfSu7WF7dRMlh+CtFspLvF5cIa4L78bMIP2t/F4CLKq3tyUqFglWRYEgTVtbe5h1Whz59xn4lJuTx/nKo/62lJtw/ZO14VXBJ5gr7VNDvB4gpueBg0XfkaMngS5CmyoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829796; c=relaxed/simple;
	bh=sMCwF9hgcbPW7oSPR33WMu7u0HFqTNMMbe4r3T7PUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK3aGkzaDbWyoGWRnWlF3pcG4gpTYcud0OO3c9FqWba+yAzQKEGxshdPVZX+1jn38IYbjvcUZ5e9C3C9QjjNNLxEuHUHDOKV2Yxa+AirNKXe1vgDNnWQC197QlqghSNg7I/iyvkqXingOsmRtn77D5QWmg0lpnI/rJG7sBoQ8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=IqJ67Tg+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="IqJ67Tg+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e411e339b8so38410365ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1713829794; x=1714434594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSH/ta9tvvkfnz23V89jeS4FG3TLnawoqYHXMY2eZc=;
        b=IqJ67Tg+gbqdoezACA3Yg9s+1f80KioLkZ0RaDIMEWk8lt9h1giJmEtAD6Tojy5K6S
         /M2Eh8T+KbRRkOvB9qSBteDcN/iFgDLf9ok4fYUjEQAOjZk4ZUOQYfvh1fY6QMwkImUN
         ZNOd2SaFhLFwT8CIITC72Ht0/qaxO5KeZKAZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829794; x=1714434594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJSH/ta9tvvkfnz23V89jeS4FG3TLnawoqYHXMY2eZc=;
        b=OeeHvfIq/T29QjS60b8aL9oCHxaRbOHnGtG5fXDF+PWnpPjelUCgMtv5p9pHq7fx63
         hUMH6RVIa1sd7JdXj/AwBjYzrXHW3XKRSDalbN3FNWQzMX8IBFdmIDenOjr7mj5jgWNR
         htjh3dAMnXmyOvnjzRyU/HUzD4w/Z0ukUL/5T5QeaMVeP7Jd6qMcWnPvzkmmJLsAcz5w
         zy1walwBnb/0QmX6nkauh6Cr0Di+e0nrON1umOJzUhy8hKHMB/Oug9hh9okYvgyofZ5M
         NjmZCJxZG9mfuBKznLa/FdWiWciG09RCMBoHn1lzurlDvv30NNQyOEACCxH+OEyFAEZ4
         +Cgw==
X-Forwarded-Encrypted: i=1; AJvYcCWq4lCstw+i/el7BNDS3qoC+8SC/mJo4bGQqvepDHEhPG3c3buBRdscgB/PSfvvcMRqzOUR3qFQITYgstUfhsHhZ4v9Q1oGqFSNHi1fEDrI
X-Gm-Message-State: AOJu0YxT2gSvZsXF/vT4makFjB8li13ujHkQ4LK7UxRAVNfwiMBO3RzE
	aCBzK3c1h/B3rtRYZj105mIc4avJPupP6lANSDJUpwRbFRm8uEnSskHdbKA1P3E=
X-Google-Smtp-Source: AGHT+IE/KLW4V/oa2kX7nQ+u+B/+SvFu5Ac9dOPRHbfjOChoKwHFOfkeD7XHaP74dN0bN5X6Ab9CrA==
X-Received: by 2002:a17:902:720b:b0:1e4:b16e:7f10 with SMTP id ba11-20020a170902720b00b001e4b16e7f10mr10810750plb.33.1713829793728;
        Mon, 22 Apr 2024 16:49:53 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b001e0ea5c910dsm8729730plx.18.2024.04.22.16.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 16:49:53 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:49:49 -0400
From: Hyunwoo Kim <v4bel@theori.io>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, imv4bel@gmail.com,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	v4bel@theori.io
Subject: Re: [PATCH v2] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg
Message-ID: <Zib3nSvQZHcVS8l5@v4bel-B760M-AORUS-ELITE-AX>
References: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
 <8dad5b42-a843-4935-a31e-91a2eadf0c72@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dad5b42-a843-4935-a31e-91a2eadf0c72@collabora.com>

Dear Martyn Welch,

I apologize for the long delay in responding.


On Thu, Feb 22, 2024 at 11:23:05AM +0000, Martyn Welch wrote:
> Hi Hyunwoo,
> 
> I've been looking into a few CVEs, the one of interest in this case is
> CVE-2024-21803.
> 
> There seems to be little publicly available information about this CVE,
> however the title of this patch and the affected kernel range suggest this
> may be a fix for this CVE.
This patch is for CVE-2023-51779. 

> 
> Would you be able to clarify whether this is a fix for CVE-2024-21803?
IMO, CVE-2024-21803 appears to be the same vulnerability as CVE-2023-51779. 
It appears to be a duplicate CVE that was registered due to an unknown reporter's mistake.


Best Regards,
Hyunwoo Kim
> 
> Thanks,
> 
> Martyn
> 
> On 09/12/2023 10:55, Hyunwoo Kim wrote:
> > This can cause a race with bt_sock_ioctl() because
> > bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
> > and then frees it without holding lock_sock.
> > A use-after-free for a skb occurs with the following flow.
> > ```
> > bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> > bt_sock_ioctl() -> skb_peek()
> > ```
> > Add lock_sock to bt_sock_recvmsg() to fix this issue.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> > ---
> > v1 -> v2: Remove duplicate release_sock()s
> > ---
> >   net/bluetooth/af_bluetooth.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > index 336a76165454..b93464ac3517 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -309,11 +309,14 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >   	if (flags & MSG_OOB)
> >   		return -EOPNOTSUPP;
> > +	lock_sock(sk);
> > +
> >   	skb = skb_recv_datagram(sk, flags, &err);
> >   	if (!skb) {
> >   		if (sk->sk_shutdown & RCV_SHUTDOWN)
> > -			return 0;
> > +			err = 0;
> > +		release_sock(sk);
> >   		return err;
> >   	}
> > @@ -343,6 +346,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >   	skb_free_datagram(sk, skb);
> > +	release_sock(sk);
> > +
> >   	if (flags & MSG_TRUNC)
> >   		copied = skblen;
