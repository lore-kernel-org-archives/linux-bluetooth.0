Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4795101D5;
	Tue, 25 Jun 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277150; cv=none; b=RzOpjBBZAK+d1RANY8tFKFOldlETJpXlyBBH/Ohp00kdd5vHlMc+U6ito+411ndj6MWYw8DYJa85kUu4y8K5ZYUt3xJTBpTI8h3PGu8EONCSlfUWvbzoMG+pvyAmWrFVEIuXd8ynHpsUh2bCMxZekM3sLM+qkg59BrCHg762J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277150; c=relaxed/simple;
	bh=lfHcF9+YNdVfg+N+RLmGW9ZSr+Fodz9MaspRiRq+dto=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aCBFXy7k8J7Brlqx7V6cgHo1ATgd7j+O/psKuWs8fRpoiRx4facm/LVYUT8nSg+DiOFFT0GAWtyxwmqu+Ecn/WaOOjFFs5obBNfuqhmzU+X15jnKpyNp+jOEyZ+Veu0B5L6gg5psKAdoR5VXzClF/3wrNwcI1k7hcFgpNI7Jni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hNSj4Mvo; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hNSj4Mvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719277138; bh=AYeOusEFQaPhJ+TDyfATKT7SDOMHhmvXv4ipZOM1CMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNSj4Mvo3t2OTeNrZxtueUr4BtCL8MfHBMet4uLlnalM3Ic7fjy1gSZxwpoKeoguH
	 zsNccPsH5fwa58+HI+6ylA9WoPs+lswtLHfJT3VzX73az3woT8+TKp6jiD3eOq22s+
	 pvQCe5iq3fhGwz/cfguI6dDVZhbRRYGkGOxqw7Pk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D3585468; Tue, 25 Jun 2024 08:52:53 +0800
X-QQ-mid: xmsmtpt1719276773tw2y02inm
Message-ID: <tencent_A9AED2AEE28CA4E7D206D152E6464DC9B206@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVVgYBMuObIt7vHY7+Ht+pSRS3/Su//BmCT8x7SxbCx2tPC6s40z
	 5IBcanO6irGU7n8WoLTZ5gRcbv3nVVNkCbvxETxA/akUoPiRvywhrszSHUqmV2lB7TS7gUnuU9VC
	 N3p7lBY9pIxZEtTe6g/+B2KjDq9E1s/z70UykIshR9BIUe7CvEm0cyTbO6IZ/ZqlxwnCiXFpHzeV
	 pqLVn7i2zZlVhIOOwHsXRaNyQBiDIVDUm3ScNPFqw3qlf98bO2x9MXPqX7nkP0L6HkAPeB1rfN9o
	 7GMbkK8NOr0BLri7BYeaj8W76TuXgC4B5/ZjimhJbOOvt4pvKM/86X2hy5veK2Rhy+tKTV26pKUV
	 7Yir8HzLc4Gv25ldWyoYp/1Fe6HviMyx27GpDtgYItD5w3yNUmXBtC3K6kdqRtM4+mSo9L4Ts55x
	 la2PlzvFodpPE3tnC3am4I1Nigh3JowXJAVGFZcgVcebmubiwnxAgKgKHsrPSgoCWSR53+QQVaLG
	 epYV6ClO8ZdPYd91t+5C3SQuiU8MJmr24dBjoZ2j7LAlPtkl6/FQ95p20OlhgsjKWiyMN4l+aHR+
	 GLaptaeC4SYphUXXQUZSVtQccH9oJQi/RDVxYziltFh4uIbnpkKFmpnPCFeHpQWmfQzDnapX3VeA
	 0sGaCTX9zFKNaCpLpzelR71CdYECWAtsh0ONalNXizmdDbRb5FLMnhzy+l2TIOy76wzdeddT5GLK
	 SsO8HwQhe8f6JYORC85OcF5rcsPO9cuc3SVoQEp4E9rUybLUqErot2+RiiEh1MBgUcybSSX9BQlO
	 5kA2zrmTa+Ps/i0pet6CrslNPh01A5KLHhhSygvo+HHCyTlYR7yFLhZygi5FIVWqm/U7R6LYtyfq
	 HmeltsxY3DT83s8iHmonScRhWDTHd+d+GIQfYp2kIXQ1VJUTkwaZSrncDt5vJjovUdaAz3RlF2
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
Date: Tue, 25 Jun 2024 08:52:54 +0800
X-OQ-MSGID: <20240625005253.48708-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZ+_sEiu-4790zY7pH7-AOi7L2Da0AFeD8W+_bSjTrXENQ@mail.gmail.com>
References: <CABBYNZ+_sEiu-4790zY7pH7-AOi7L2Da0AFeD8W+_bSjTrXENQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz Augusto von Dentz,

On Mon, 24 Jun 2024 09:36:14 -0400, Luiz Augusto von Dentz wrote:
> > > Looks like this was never really tested properly:
> > >
> > > ============================================
> > > WARNING: possible recursive locking detected
> > > 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> > > --------------------------------------------
> > > kworker/u5:0/35 is trying to acquire lock:
> > > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > l2cap_sock_recv_cb+0x44/0x1e0
> > >
> > > but task is already holding lock:
> > > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > l2cap_get_chan_by_scid+0xaf/0xd0
> > >
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0
> > >        ----
> > >   lock(&chan->lock#2/1);
> > >   lock(&chan->lock#2/1);
> > >
> > >  *** DEADLOCK ***
> > >
> > >  May be due to missing lock nesting notation
> > >
> > > 3 locks held by kworker/u5:0/35:
> > >  #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> > > process_one_work+0x750/0x930
> > >  #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> > > at: process_one_work+0x44e/0x930
> > >  #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > > l2cap_get_chan_by_scid+0xaf/0xd0
> > >
> > > l2cap_sock_recv_cb is assumed to be called with the chan_lock held so
> > > perhaps we can just do:
> > >
> > >        sk = chan->data;
> > >        if (!sk)
> > >                return -ENXIO;
> >
> > If the release occurs after this judgment, the same problem will still occur.
> > Recv and release must be synchronized using locks, which can be solved by
> > adding new lock.
> >
> > Please use the new patch https://syzkaller.appspot.com/text?tag=Patch&x=15d2c48e980000, I have tested in
> > https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
> 
> Hmm, why don't we just fix l2cap_conless_channel? Btw,
> l2cap_conless_channel is normally not used by any profiles thus why
> there isn't any CI covering it, on the other hand l2cap_data_channel
> is used by 99% of the profiles.
Yes, we can fix l2cap_conless_channel, but key point is that "chan->lock"
cannot be used to synchronize l2cap_conless_channel and l2cap_sock_release,
otherwise it will form an AA lock with l2cap_data_channel.

Why not fix it in l2cap_conless_channel but in l2cap_sock_recv_cb, because
l2cap_sock_recv_cb is on the same layer as l2cap_sock_kill, using a new 
lock for synchronization is more appropriate.
--
Edward

