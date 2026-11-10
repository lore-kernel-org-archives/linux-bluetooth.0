Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308591;
	b=KM5Sx8u5NO/VbJQV9pgXVyqHD12CT8pz843zlCamHkSfvfYBFmUuyr5Ltq7LQt4ovvAu
	 qJKZaF44KR57zR2Zi4L4GqPfqdwqVkVa2uo9CcC4w8dc5z9Kxa/IVmsUN7gjYD7qlkKB6
	 +SkVU7lDto7WKvVLF/l7Dqt0HnpblCBa/R3vrW2b8a/qSVldPHn4378aYGoGAT0pdxKf2
	 +b8PuRAVI74y/vwDErMiesvgLF2Z3R8AK1lsDJDAx11U3nHPz4Tzmc40idQ/qWiYdEwqK
	 wvDuTvwEzH/pe8vwT09Zw1TevObHJ0IJBrQ/Bk9mNzH1EkysPsjRUlILRzHHxQGqx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308591;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=BZRqNPkVHbDtKON6wv6OQaO7er0kYUMxGcWb88xBRWU=;
	b=yCDb+STFWXf/9eHndLRYtUDwNhNfmD8MLdaRldvzgJ1kTXpHZooGQiJhRM9MmhlSBmwc
	 k1Q/o7RSlaaM+5kZ3eUxGNH05DIpHjKfYOdqe6F0JPJACkaJcWp/6bvhwJa7FFt03DMTg
	 X0neG+JlfoPIOzCHkaYzvqPy97Ocb8dCzRvTopalfLuuqB2l8kkAxpglOjugqCEJY2FXP
	 HH7ktrx0EeslcCDodd6YEOtplJXm+fYvb2vQZWxJ+tbxmq3x/wK/wW9X6LYkeJV2CmblP
	 YYfzQ1PUNlUrsHabYlaoiGp6nT2fTAaqCU++wW1yq5782k+KonOGpNZqLGWRc32Eg3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Wf3JovIS;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4A606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F4A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Wf3JovIS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794308588; x=1794567788;
	bh=BZRqNPkVHbDtKON6wv6OQaO7er0kYUMxGcWb88xBRWU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wf3JovISJQKvxIHhu4gnnOUOlHwAjFvXnojjbYOeSYw01J5lrYINFyJ+RxZ2KD1OC
	 k2YkS30LrYMAIWavXGmgHc9cz2HsIyG/zE9d9KI1qFGaKD+1YPBfEkpAD3FoLMu71p
	 aUgE7KtGlriELzcJMLE2tuwxwBrzrfTJOKMDFSE2IpSkJzud18e2+UVmQVgYDZRN/L
	 G7JcMBTbxM5V9usJrC4weOlRyErtjCD6YWvHhj7Ciev3LtvdMJ9ry0k5xZ7ejoihp0
	 zbTVa4wTEWVD190XyKFEm6yU1Jha9hUR2DlxR6RDOmFCnn1roHFMYfGAvRRbJehZSz
	 6Ss0tkRHhxQzA==
Date: Tue, 10 Nov 2026 11:03:01 +0000
To: Cen Zhang <zzzccc427@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Chad Aldreda <ca@modelmiser.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] Bluetooth: vhci: Flush suspend work after removing debugfs
Message-ID: <20261110110253.1118214-2-ca@modelmiser.com>
In-Reply-To: <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
References: <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: d83fc3b1e44738560cbe08a5fe327f6227997fd9
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Oct 2026, Cen Zhang wrote:
> Runtime testing of this change was not performed.

The use-after-free in your report reproduces on mainline with the two
test-only delays below, and your patch removes it.

Tested on mainline d48723711bae (v7.4-rc1-672), whose hci_vhci.c and
hci_sync.c match bluetooth-next at 983f3fcb1282 (hci_core.c differs
only in rfkill handling), on x86_64 in QEMU (4 vCPUs) with KASAN,
lockdep, DEBUG_LIST, kmemleak and hung-task detection. A test program
opens /dev/vhci, answers every HCI command with a Command Complete,
brings the controller up with HCIDEVUP, then closes /dev/vhci while
another thread keeps toggling force_suspend in debugfs. One mode keeps
answering commands until close() returns; the other stops answering
before close().

Unaided the window is too narrow: 300 cycles in the answering mode on
the unpatched kernel gave no reports. Both kernels therefore carried
two test-only delays, not for merging:

  vhci_release():
  =09cancel_delayed_work_sync(&data->open_timeout);
  =09flush_work(&data->suspend_work);
  +=09msleep(50);

  hci_suspend_dev():
  =09hci_req_sync_unlock(hdev);
  +=09msleep(200);
  =09hci_clear_wake_reason(hdev);

With the delays and without your patch, 30 cycles in each mode gave
834 and 621 KASAN reports (kasan_multi_shot, so one bad close gives
many). Two objects are hit. The hci_dev is accessed after free from
hci_suspend_dev(), including the __mutex_lock() site in your report; it
is page-backed, so KASAN shows no free stack, and once the page is
reused the same accesses show up as slab-out-of-bounds against
unrelated slab objects. The vhci_data (kmalloc in vhci_open(), kfree in
vhci_release()) is read by vhci_suspend_work() and read and written by
process_one_work() after free, because suspend_work is embedded in it.
hci_resume_dev() was also reached, with an hdev pointer read from the
freed vhci_data, so it dereferenced an unrelated address.

With the delays and your patch, 160 cycles (130 answering, 30 not) had
no KASAN, lockdep, DEBUG_LIST, kmemleak or hung-task reports. Without
the delays, 150 cycles with the patch (answering mode) were also
clean; since the unpatched kernel was clean without them too, that run
only shows no regression. As expected, release can now also wait for
suspend or resume work that is already running, including an HCI
command timeout inside it, as the existing first flush_work() already
can.

Not tested: suspend with force_wakeup set, with connections, or with
scanning, advertising or discovery active (the controller was brought
up with HCIDEVUP and no bluetoothd, so hci_suspend_sync() had nothing
to pause), mgmt, real controllers or btvirt, module unload (Bluetooth
was built in), other architectures, and a build of bluetooth-next
itself (compared at source level only).

The harness and this report were produced with an AI assistant (Claude
Opus 5.5), which also did the earlier runs, including the unpatched
comparison. I ran the final version on the patched kernel myself and
got the same results. The harness is available on request.

Tested-by: Chad Aldreda <ca@modelmiser.com>

