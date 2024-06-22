Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7C818;
	Sat, 22 Jun 2024 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028070; cv=none; b=GHqhsHGD6Va7p9HVI+yyUMCAQQzHgfo5fvGAIXUyzzegHFoThAggL+hfPr7BgF0BS06FGXpOjSSq/pJ6OBurR8HPsG/jvGyF8ISdrqWwahaGfwQDCJ3Bv7ZF1mrzd8UeGNChEWqsSEkQ/sh7c/MSw+VkNWpSuR9hu6npUKfVF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028070; c=relaxed/simple;
	bh=1YdC8dVZUivWYaOUyLpVfDeqC5jH5OshBQiWogc3Y5g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=e4knDOjvPbzd+qCPyuhcQgCEKBDhgdvsutEg6E64evBwcMVEezexydOYU9vRCfxJY1BX2zHJmlJp9PXwtcf6JP4LIUhHOD3q048OZXVtcubWHMC7oN6nX7SNVjfDz66bXPwvYfYeXZoiAgwQA9ifjwj9GtmxLb9G9V1hSW3KxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sWyDLZ7V; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sWyDLZ7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719028065; bh=SmsKJlT7qHcBcmMM13UpP7tIzHjJn0vqilRM5lHVSew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sWyDLZ7VJzsps3prOdBGuBPJMMvyEJcIn3OMfQXk7Ur20f5ECfaZet7wo7GCY9yiT
	 rA5RInkGW2QLAJqUqidfGr/axdy6w7HZj/YLYQLqw+nU3kuRxDVbUFN6hcXZHnq0JK
	 GzW08S19RvpkBn3VAYtNymcjb5jc13xAaobRBY4g=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id B980FCB0; Sat, 22 Jun 2024 11:46:24 +0800
X-QQ-mid: xmsmtpt1719027984th7y16c0x
Message-ID: <tencent_832C796CAC95F0E9A2EC6ECF00798E6DCC0A@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0agQgox6Fok8XUQ6fQNANJoNTfVVFP+VpXnFj57Lg82G4ZCzuNvQ
	 3TLtGs25uvwxsnLaDcC1UQmzcs6XWHRE56lr9htAhatasdefOhsqCWqBJiTOvCtisqdNfANZBnTF
	 kIPoaMsGGyqPb4/QmjsNCsviTckNnaqjdNLHe8Uagjj/qYbN+IkcJUhwjfgm3qax34xjcykWalUe
	 zMPA1n4SwihWi+ffOW+tmewHGgT8z0hdLosRTLbWE8qaaYEhU97y26pjSG+neUmzWx4D1OfheuqU
	 26eAPbxcK00Mc21mX59bMuCSOew2DOLp7Dh3ERSPI9MXQPOKTDtKDwF2DapABR0ygo8K5nGA6zDr
	 clKWLC1KjvOz30MQPTe2uM4SRXUKFVlALsFsTDKgCMiWCri4vD4BDB3qoMXSAGBGY3Pd2SOJO7zv
	 gcxSTIbo5HvqGmwjY0yfRCCgQLqGhUkvwoU7RPLdQDtRaGRgr2HSuIIofJDFkfj1z83v3I1nOpkN
	 VtbgLsig5nlGW1STm63v6xPpi56Bhe9Dj7JQzOGcxihmSb+ii6rWPT+Ka6z0KRDn2vD/qwfZvqeX
	 qczc+JnP7KBZlmfdIsPvSKG/sdCSFUZKTjPlA4e3eOKnHwJYrRybjwmNNZLi7e79pL4fzKjDzAx/
	 pIZtd+TabnHzOUUQCYk2CDlUvUSWBTF7Ua0Q4h5SOnaS+ewJ7//EJbA6XAT0SuDXYvNGJDIzQVis
	 Ec+n8XL5Y5sDNinn52YMrtFHZ//aVY30eISQ0LKh0SVjQ/gZxZpvf/jqsh9rUsjljLaHFW/EQ+EV
	 +sHeV1i9971OkOdSl0ea9/W6xpVh3Rs1cox8Pl61AKjJvfNol4bkyYUosD5CGZuzcYmHqWnqx6Y8
	 JXVYz5NPJ8axcHRh+eIZ1nUVsyb8hXV6YC8B752Vn/7YBKCJG7t06mWsxM/EKUJh6MubBibe16PL
	 MeYi8e2LU=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Date: Sat, 22 Jun 2024 11:46:23 +0800
X-OQ-MSGID: <20240622034622.2728558-2-eadavis@qq.com>
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

Please use the new patch https://syzkaller.appspot.com/text?tag=Patch&x=15d2c48e980000, I have tested in 
https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a

--
Edward

