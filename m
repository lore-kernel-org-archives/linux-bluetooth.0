Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEA12B93;
	Tue, 25 Jun 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284916; cv=none; b=TFdgAisL9OM0QQL8zEAT4g7FKR37cG2aTUcQ/TPNxvDONOO6LVFvnnYjeJnu2Q3iAW+l9VmkvLGSUB0/Od1RBbbkjW4eMhRcihvDf83CS9x0FHOOvUwT33v4FwA0MWrTz60O34g4sdWfTDJyRF7aAxuafrNaCUllkFbRvdq6ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284916; c=relaxed/simple;
	bh=wvXvpOpHcg9fE84BGcPt5U7WDSHWhdr37tQDAIuFOGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2eMh2R2BwGS3vCbeffUmfcIgCcN3ETJcEZakM6m5PPwp3AAYmiTsQ00nJFxUsWvO08ZNoAMInPyGHIMRGeaOYevAij8T4m638aS+2hwY0YdHiYum/yvNzjPrX3gW15UTTyCkLJeDSjWfeGMw2eOANFx+dKhEFxiLLv21zget78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR7Arvtv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR7Arvtv"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so57806411fa.3;
        Mon, 24 Jun 2024 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719284912; x=1719889712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8NST6f3dVKUFTt2czVMzr91bl3NANiLvrjnar+fBwY=;
        b=NR7ArvtvA9iVDG1cHOkMJytoUcyVjkYIj05mIv0+335iAVgFaH0vJ5yie/9VmPDBZx
         SGCiXnx7tfGgePaV6gCtEMmFXLsyx84thXduyZkrZ5SL8r4niS+xOA7kfJcUO5X4aa7t
         EXwXAOWlY6n0kiGs887fgaAvHbNBSt3yEH2D6rOL1jAZ51x+bqezI+cu54Kovz2WcH5V
         QXzhKPxmuxktj9Vou/cEX+1UZJf2Qc5I+BYDCQg4e3V2bO+fXd2dYK3Cy5fEJEgG1lE5
         uIWr9u0iOvSr/hh4pyW2a40dV/TiFXTsK7ZUF5E+z/7WuNAE+2QCKV+vcBfhrXzQ/v6R
         ToBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284912; x=1719889712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8NST6f3dVKUFTt2czVMzr91bl3NANiLvrjnar+fBwY=;
        b=i0H8KsEt/IPUnmz8MQcgSfj3elz4xgDKCbmQGenee5f34h7LCPLsLoNaIj3VkHMK6W
         7V90oc8yVew/9EZBshSvLwp7pXrMsiDshuytTUJiEtc18mSWzZFJ5u2VIuEci6j3fpFQ
         bL1NENCArMj+AUyJh2AaY914KdZ0ThX5c2W0jOi8x77fi0W9uBThT+TH9YWtzs7TTe9C
         7r0NOKNjGuOTtU8sLz5u87Qq/YWk7APD0IQD0+PfeqCLpiDWvlLFSw7M8JoQrEI2I6lJ
         6UTjALFB65AauhyBh7ZgMR6UTkXjYMKiwkg9RxFUMbPGIGbatfv42pra5X0P4FS2TNYz
         PzuA==
X-Forwarded-Encrypted: i=1; AJvYcCX1BGH3vz3e4mXwI+8vbeYHL9HZwPtmAZ6pKXE9ARTYi5Yf4IeEprQmI+Xnx442rjKHnOGQnLYjJnMnGNzgyz8WI3VO5387k0MmwWIAEcjanNIZxSH/IWMHaRqCCXpCUwegABBaze6wC6apxH0Y
X-Gm-Message-State: AOJu0YxZUPA21CAJQ1UufM2cP6V/oT3aUUo7YOB2tMdPIS3sTgl2LiNr
	ugz1/nuFWQ5L6PIuiq7UFtT/gAM5fcFM/8sOjPwGM0fOgmJgQcOt4pjY49SPUpSCRDzMLimprXp
	09Ez62L5cquOQZRec/bzwBJ8RsZ6Jb2hyU98=
X-Google-Smtp-Source: AGHT+IG4UyEfoPioa1SHoxAlLqqbAmIjy011k5qtlhT6BlnPPcis06ZPGfY0ixG3VV3fCYw6Equed6vnH0Ic6RO75dQ=
X-Received: by 2002:a05:651c:209:b0:2ec:5777:aa61 with SMTP id
 38308e7fff4ca-2ec5931002amr48440521fa.3.1719284912234; Mon, 24 Jun 2024
 20:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+_sEiu-4790zY7pH7-AOi7L2Da0AFeD8W+_bSjTrXENQ@mail.gmail.com>
 <tencent_A9AED2AEE28CA4E7D206D152E6464DC9B206@qq.com>
In-Reply-To: <tencent_A9AED2AEE28CA4E7D206D152E6464DC9B206@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Jun 2024 23:08:18 -0400
Message-ID: <CABBYNZL5xiNDzDa3JJiwx2D-qpmA8Y3RBVWLetZ0fd4jURpN7g@mail.gmail.com>
Subject: Re: [PATCH] bluetooth/l2cap: sync sock recv cb and release
To: Edward Adam Davis <eadavis@qq.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Mon, Jun 24, 2024 at 8:53=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> Hi Luiz Augusto von Dentz,
>
> On Mon, 24 Jun 2024 09:36:14 -0400, Luiz Augusto von Dentz wrote:
> > > > Looks like this was never really tested properly:
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: possible recursive locking detected
> > > > 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> > > > --------------------------------------------
> > > > kworker/u5:0/35 is trying to acquire lock:
> > > > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > > l2cap_sock_recv_cb+0x44/0x1e0
> > > >
> > > > but task is already holding lock:
> > > > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > > l2cap_get_chan_by_scid+0xaf/0xd0
> > > >
> > > > other info that might help us debug this:
> > > >  Possible unsafe locking scenario:
> > > >
> > > >        CPU0
> > > >        ----
> > > >   lock(&chan->lock#2/1);
> > > >   lock(&chan->lock#2/1);
> > > >
> > > >  *** DEADLOCK ***
> > > >
> > > >  May be due to missing lock nesting notation
> > > >
> > > > 3 locks held by kworker/u5:0/35:
> > > >  #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> > > > process_one_work+0x750/0x930
> > > >  #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:=
0},
> > > > at: process_one_work+0x44e/0x930
> > > >  #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > > l2cap_get_chan_by_scid+0xaf/0xd0
> > > >
> > > > l2cap_sock_recv_cb is assumed to be called with the chan_lock held =
so
> > > > perhaps we can just do:
> > > >
> > > >        sk =3D chan->data;
> > > >        if (!sk)
> > > >                return -ENXIO;
> > >
> > > If the release occurs after this judgment, the same problem will stil=
l occur.
> > > Recv and release must be synchronized using locks, which can be solve=
d by
> > > adding new lock.
> > >
> > > Please use the new patch https://syzkaller.appspot.com/text?tag=3DPat=
ch&x=3D15d2c48e980000, I have tested in
> > > https://syzkaller.appspot.com/bug?extid=3Db7f6f8c9303466e16c8a
> >
> > Hmm, why don't we just fix l2cap_conless_channel? Btw,
> > l2cap_conless_channel is normally not used by any profiles thus why
> > there isn't any CI covering it, on the other hand l2cap_data_channel
> > is used by 99% of the profiles.
> Yes, we can fix l2cap_conless_channel, but key point is that "chan->lock"
> cannot be used to synchronize l2cap_conless_channel and l2cap_sock_releas=
e,
> otherwise it will form an AA lock with l2cap_data_channel.

Don't follow, what l2cap_conless_channel has to do with
l2cap_data_channel? You can't have the same channel calling both, it
is either connectionless or it is not.

> Why not fix it in l2cap_conless_channel but in l2cap_sock_recv_cb, becaus=
e
> l2cap_sock_recv_cb is on the same layer as l2cap_sock_kill, using a new
> lock for synchronization is more appropriate.

There are dedicated locks for both layers and now that we are doing
chan->lock for before chan->recv the locking sequence should be the
same in all instances.

> --
> Edward
>


--=20
Luiz Augusto von Dentz
