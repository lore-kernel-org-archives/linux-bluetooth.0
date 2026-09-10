Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEA38E11A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065839; cv=none; b=JgB74P5TuFDkJcH2Gtr+7zccT+fvrtMa3TGVJtDlhGrDYz1A79ZorATwpDmIyaj1xpIBh5NTnrzOp88LtA3QgeZ8x3R5EbeP0xK2eU7apnOE8Xn+zd5NMU+4Q3IY+j2wTC2mdzUgdtqRFmFutXxdXzcSudEhZh23Sv2Hs4xIiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065839; c=relaxed/simple;
	bh=TLG7udnvYve1NP8acUdwEQ6x8yaj2lJ3JnVT28mHgy8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IDlDvIRGnLa9FyRM9ac+sRkPfMuUQ17tMPRbGWOmAcfkRy6aoBWdMhiaOjGMKOYPrYojZwLT9V6wRNm5rgCP6jXiSBkRWK8TVha6fyPM49bT9KZK0RXCuIWXCy1qjnUinBgpuCM2dkhKJguogkqwrbUqYTTytaRratNZh66O6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gfm/PcX6; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gfm/PcX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065837;
	bh=JPcHchPp7vKviePyOoy2aOs3/a+1zPzv+jaxV8XoJQU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gfm/PcX6GCsKUxtWAvK2xiO+9PcOnkcWH741OrdgtLMAEfOSmDUTGAyrzw3WQ5xMF
	 JjHECn8n0xHchVb0AHdhAJw6EM1ebkOhwPp4oiLu9mGBNJ+dXrjB1rvU69Qk7F7i57
	 WYEHU3yMha3UELWhLuZ5tDulIE+/YIDU2iEiz2Ms=
Received: from github.com (hubbernetes-node-9625a07.ash1-iad.github.net [10.59.92.28])
	by smtp.github.com (Postfix) with ESMTPA id 935A43605A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:43:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:43:57 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1162236/000000-86f64a@github.com>
Subject: [bluez/bluez] 11a082: doc: enable virtio-fs in tester kernel configs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1162236
  Home:   https://github.com/bluez/bluez
  Commit: 11a082740637d5116451964b54ceb6077fbb2ece
      https://github.com/bluez/bluez/commit/11a082740637d5116451964b54ceb6077fbb2ece
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/ci.config
    M doc/tester.config

  Log Message:
  -----------
  doc: enable virtio-fs in tester kernel configs

Add support for virtio-fs in tester configs.


  Commit: 86f64a2e96dd1f6a571bf21c2fb0d2d766a22a56
      https://github.com/bluez/bluez/commit/86f64a2e96dd1f6a571bf21c2fb0d2d766a22a56
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M tools/test-runner.c

  Log Message:
  -----------
  tools: test-runner: use virtiofsd for filesystem passthrough

The 9p mount passthrough I/O is fairly CPU hungry and slow. This matters
for e.g. running Python in test-runner, since it has to read some amount
of files for startup.

Add support for virtio-fs, which is significantly less CPU intensive.

Enable it by default if /usr/libexec/virtiofsd is available, fall back
to 9p if virtiofsd not usable.

Before:
$ time make check-functional
real	2m9,736s
user	1m29,570s
sys	0m32,715s

After:
$ time make check-functional
real	1m35,703s
user	0m28,938s
sys	0m7,453s


Compare: https://github.com/bluez/bluez/compare/11a082740637%5E...86f64a2e96dd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
