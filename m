Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC7148825;
	Sun, 23 Jun 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144528; cv=none; b=ZFd17gNOw3hpO0PaaAJ3Gan//t030HbcL3Qkc9p8148mq2wLczUP8Ju7xWFI+4elNibPq+bPejpvHSLzvLqWJGHMsY8t2IxHuoh2gNesmZPpvZaiNDr1ydga4/5KorXhrGlQV3T1T4JQCaGMSHV0nP0Wa8UcQ1+F7eYC1uATmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144528; c=relaxed/simple;
	bh=S0W0jXSZpqIZXk4eOCdVWgNGTLZh/flgZcJOrP69GIg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ml4kZSbzXsiA3Rcrl49sm/V6kFnSncnODqGtt3EoU2h5ToEG97+FsK4DJ/skaRCHpb2+NhMaS9n0gLHxy72E9YGzk0nDSWVz1w3M95+3mA4hyFvTK+TqppatTgyAeyF/4mmBRaOj4VJ1ilBN1mouR/93YEp7lX+4TUlbVZM6KBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v3M4Sh+U; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v3M4Sh+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719144524; bh=olpaJYh5H41ctECk8uHb2VAxub66u8b/JCefVdrzBxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v3M4Sh+UbnNVC2z/1E7c9oFcvErWS652fnCnSSaeNbngFVe/xRwbCCUXBJJe1M0Z2
	 +VnIf65rJ34QkSHffjjpvqIiQtsxZAJ2vvv+8OBAp2VF3O/2Fa92r6mBUKUX6NCoq7
	 ynQimyXTxzKsWi2Siyjb1FaAw3WJDz2sq1gk+hrE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A721C04; Sun, 23 Jun 2024 20:02:39 +0800
X-QQ-mid: xmsmtpt1719144159t7k3wobd2
Message-ID: <tencent_7C66AC3C8B36B8978636E04B46744F77B109@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zr1Fz3bmUwXziGNjQTEAyPZ759vfJ4eOGbqAtivT+Rl2DYUrICC
	 xzXXnxQ0P86pnOtvZg4fN3xR6T8hECr6Y/YQ9hnaipz933FhwscHmkk2BGCNrbHWKP7VZJTgkcDd
	 w5RFtvIet1d2uhWiScUuOuLH8nSwiZyUSAS/AJ1gY6YYZ90Bw7qZsXtl3U4bhn34rmtCVMIJvYqt
	 4IqAJPLT2r0nck3NHomydeoJmE/E8GIqevwUka+J6hqJnTV+1MYpgLtCbfsmI58D8Dzm2yPPgkB5
	 4222ytoe1Qo2Ujz5LmnDLub+f5HgrpUw/aaLRdpxKAiaMFS2iX6/uVJLfQKYe/0LqYFpYGASKtwt
	 VF3VCBo0eokGv2PPUBRYsz8YdYDXD/MElUN4NWjm6Df3+aFVYybTw/2/cEqzTNf5Gu/XR7ZSbOD9
	 78WqYMYtHxdlH3hYaFo+p0vuutpt3mkJvl7wKEv94G/f4VHXCeJ3gt/+MSI34NFurWl1+fpUXPyO
	 UI4qXvo+PLdZLWR4uAuhFpNlDMjusstV0pnRVMlj9rNIkXz+5gy4hzEYV/smG/m626yWgC2GlJwC
	 wZ1pSdwg2Gf1pJz4ZYGK2Kpakq9MfWA6ESEHLfOKAqz68oK/CFbjdnZLtW8CUNgVpEH6cXkuTebw
	 Hu99FlMB4hT4AH16o2xZGjosz04YV86u0RUtCVoNptK9BWfSTK0ugtw3SvPtVJDkRMZX+P17dWdt
	 p3zACqx1yU65/FAfCd70QkDtM7qIuPcDTxFUzFlMvHFA7ZQGgcndgIVUl1OK31JPunC+6MqLpGBL
	 6CBfV+Bubd9LVEqNwr9lct/zbxJAekFO/c/ssoNTxYVqN01n4k9FZfdpFYY39+3sqt3QV+gaYwqU
	 i5F3V/hmiSPmJOXm7S4qTmMIBbfYVaRLUK7OgXsKVYjk1E5lArRE2FbMt2wuGxtNWz4BgkkTDr
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: pav@iki.fi
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: fix double free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 20:02:39 +0800
X-OQ-MSGID: <20240623120239.3911447-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <181de5a745458f349b93b05a51438d3608046c49.camel@iki.fi>
References: <181de5a745458f349b93b05a51438d3608046c49.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 23 Jun 2024 13:30:50 +0300, Pauli Virtanen wrote:
> > cpu1                       cpu2
> > ====                       ====
> >                            sock_ioctl
> >                            sock_do_ioctl
> >                            hci_sock_ioctl
> > hci_rx_work                hci_dev_cmd
> > hci_event_packet           hci_req_sync
> > req_complete_skb           __hci_req_sync
> > hci_req_sync_complete
> >
> > If hci_rx_work executes before __hci_req_sync releases req_skb, everything
> > is normal, otherwise it will result in double free of req_skb.
> >
> > Adding NULL check of req_skb before releasing it can avoid double free.
> 
> Do you understand why?
> 
> kfree_skb(NULL) is allowed, so this is logically a no-op.
> 
> Probably it perturbs the timings so syzkaller repro no longer hits the
> race window, ie doesn't fix the issue.
Good, even if you already know race, let me ask you a question: how to reduce race window?

``
Edward

