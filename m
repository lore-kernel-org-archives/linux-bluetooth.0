Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DE2940F;
	Fri, 21 Jun 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981614; cv=none; b=DsJFxBsNo1hL9KJQJc76aZH7wUfin0DGCrr5qKrxcsvAO1o6AxhG8520F9o104HxegnEhRbhpCGpkocHchSSUHFijFfr3zRlGQNLKiSLcZ+b2VDpvlklAU28ECLOZOncVsu5C+T7bUEhtCdJPKp2pggozavXkeTxWKE1hP2hESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981614; c=relaxed/simple;
	bh=Mx6dgVm7zvxMqJKaAF6ajtL8qQ23avXiryh6wLs6fkQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=C+isUQUwQBaEiwZnka85kHcQBwxFqzx58IYQqWH0cHGxJ9KSGhN03MlDnN27c4Tv+DD1uX0rI2B30nUPxj7hdMTTj7DyBdH5MLpfb9gvYm2W6XkM1lufE44ch9QFNh0mYHWI4yZf9r015qjZGy/wYitp2+bhtZ7O7mvcsQH0sPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h8fRXHvb; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h8fRXHvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718981602; bh=yrEHKGjDKt8ixCB7ppttczBEgFxHHq0Bjh5xMq23SLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8fRXHvbKAvwuLMZYEC8QRRk+GBavV7d+6PQ4avFLiLEIxRBZsca5r50P0KgR0FFj
	 hhIB2ErA4uQ8SePoDBN9bXKE+sidR0TBdd45BjIlxZAEPy05kb9N5+7mYZG1pgAEn5
	 pN/nO7lOzhx0fu6Cvt0OuKy6prjQvD4kJXwcMNso=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id B41950D4; Fri, 21 Jun 2024 22:45:01 +0800
X-QQ-mid: xmsmtpt1718981101txvlk5cbc
Message-ID: <tencent_8AF62ECF8CADE7DB86DA52DE864289872E06@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wOnsn7kdF1t9MzzqNu2WTDONPqYYLQbXtuBedKivw1ZqAkENd5X
	 XL1Nigu1IxNQ/K1yyDQMsuNnKrvKJmQlbFAE/QfW1dfjigcP7lXe3sM/vT+4IKeA1Pmk4WmAurYo
	 cEkTJUxUUWknMs7BqNUycEuY8f4n7qerwMCsNbftsGwXX4YxE17XH9iWJpFG+mcW2/KqB+y47h7/
	 g+raCYeh/P+vgrtllZ/FhVyqeC2qDYdTJ0rUURO2Sj7x4dTni4Hl6Vc0PkQr0ae8NFXC/U0jHzjD
	 Q5d7fvyHN+ON6MO+rZZAcxkI5OSlrIK14BmgSFgxqVP7bgML48hgCSPw7roFodi54TXNgVANgY13
	 mYH6SlLQKcE9c6mnTRD8m3OhBWyLrHkUPrNU+/LFY5O4aTpoiLmRwex59kWLw6f8FIGupvALyYgh
	 uCJ81Gt+qCTmDv7PskDBWkimUIHH+tQ6hRqL8j9gqpEzsOxpPxYX6bDkAyls+uCqLVLg/AuzadVo
	 sN/cb9wMEKZyuhpmHYsnYm4Jsv5newTAj5J1TSE5MJjjj01id9cSOJwKITEG1Etax5/WvEfkOsv1
	 81R7nEQAGkZyRzEjWGWqaq0/oIWghUYj8w3KdtNbUnnkUPfuI/31S1oxI2VpC+d+WlWznYmK46Te
	 MaV+3L/CkRCEqHZhHuOTjA3GEEjfkzevbIIYysK0iOev+IOwqG8ZcmkEARxDzileZ+KSWg8kT6kp
	 xy4zgeZ0DZa19ZRtxij9cwaHq3fvNvNdHige0c08nlvSEarWARdJD4JE1n0lSwDBhmeiu9MALVzh
	 OTbcF7OHAIZgzbUt7fm9k0mZ/G0hKkSr2ExDbUhGDweMo+kn33CaklfkvYNyF/qhylNjGNBvgkPD
	 THjjLOFG/T10SC4b0df9w3AbEnAxm/MvS149qynTourv5jU+pdSiGDqXLN4zFu79BgMhrWJW7K4z
	 KbHl0AMR0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Date: Fri, 21 Jun 2024 22:45:02 +0800
X-OQ-MSGID: <20240621144501.2680696-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZLu-wAu6cdyDVim=bP+0Ld-P=YvENO=fa6r=rdY4UqukQ@mail.gmail.com>
References: <CABBYNZLu-wAu6cdyDVim=bP+0Ld-P=YvENO=fa6r=rdY4UqukQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz Augusto von Dentz,

On Thu, 20 Jun 2024 12:53:19 -0400, Luiz Augusto von Dentz wrote:
> >         release_sock(sk);
> > +       l2cap_chan_unlock(chan);
> > +       l2cap_chan_put(chan);
> >
> >         return err;
> >  }
> > --
> > 2.43.0
> 
> Looks like this was never really tested properly:
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> --------------------------------------------
> kworker/u5:0/35 is trying to acquire lock:
> ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> l2cap_sock_recv_cb+0x44/0x1e0
> 
> but task is already holding lock:
> ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> l2cap_get_chan_by_scid+0xaf/0xd0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&chan->lock#2/1);
>   lock(&chan->lock#2/1);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by kworker/u5:0/35:
>  #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> process_one_work+0x750/0x930
>  #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> at: process_one_work+0x44e/0x930
>  #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> l2cap_get_chan_by_scid+0xaf/0xd0
> 
> l2cap_sock_recv_cb is assumed to be called with the chan_lock held so
> perhaps we can just do:
> 
>        sk = chan->data;
>        if (!sk)
>                return -ENXIO;

If the release occurs after this judgment, the same problem will still occur. 
Recv and release must be synchronized using locks, which can be solved by
adding new lock.

Can you provide a reproduction program for the AA lock mentioned above?

--
Edward

