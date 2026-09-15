Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02D3AFAE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509544; cv=none; b=XT6Sl8YjQvb1mIWy1BqnoAjU8EneBieKo96mTdg1jDVkxJkT7A4TNKZKvgy/fkIX63Tq2cTTYiOHNBy3Zhtr2Uecc3460oqLmh2PGIadgbfDpMqeEk7w70oDzzqRYoMcwXzbXH3gHH+I6NqDtAllsbWAm41CFlKxrzkDEDNAGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509544; c=relaxed/simple;
	bh=r3A05xd2MuFYLwhfZUKBJ+0KAwSmU8EvMNg8+wrlFKU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AG0PAhqA5drFeSNXm3KlcRweM3TT3yY+uRjsqR/VAXCFkYMwsDCk9TUY7J3QWdbXUEftMZVVqyrZ/j6AntB1yM7rNfshS4i9L73Czk0zIrohgTDSdnB0LjAYG1MoX6bVQhu0C5uXE+0pny1/yGx70VPFYwVVEuv9S8RCNmdBd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rnk+hPpK; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rnk+hPpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789509542;
	bh=/c+FWwWTmVjpDzcfsvAYDPxwMn0LJNydaE8DoEfsO9g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rnk+hPpKFlTUC3Ja0SsD4El5d3H2jxI0TR5Oq3Jl57RX6IMl7LMlffOUTMy829vvt
	 Q1TlEjK4b3/w0DXtjnjF9CPNCQVcowh7zbbNLbwL5tM3+B7iMNrNpwk50/7d6s3G5q
	 75YNrtHJFq35TyOsPj6AvEJ4gMeRdcpkIJI4XxyE=
Received: from github.com (hubbernetes-node-44c98f4.ac4-iad.github.net [10.52.145.25])
	by smtp.github.com (Postfix) with ESMTPA id C02617804C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:59:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:59:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165938/000000-d6364a@github.com>
Subject: [bluez/bluez] d6364a: test-runner: Enable interrupt remapping for
 PCIe p...
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

  Branch: refs/heads/1165938
  Home:   https://github.com/bluez/bluez
  Commit: d6364a067cb841d8efee11bc1044c5f7643c32e5
      https://github.com/bluez/bluez/commit/d6364a067cb841d8efee11bc1044c5f7643c32e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Enable interrupt remapping for PCIe passthrough

A device passed through with -P fails to allocate its MSI-X vectors
(-ENOSPC) as the guest has no way to remap interrupts, so give it a
virtual IOMMU with interrupt remapping enabled, which in turn requires
the irqchip to be split.

Without this the guest is not presented with a DMAR table at all, so
enabling CONFIG_INTEL_IOMMU and CONFIG_IRQ_REMAP on the test kernel has
no effect, and both are now documented as required.

The machine type is moved out of the static argument list as it now
depends on whether -P is used, the resulting command line is otherwise
unchanged.

The model wrote the change and confirmed the guest is only presented
with a DMAR table once the virtual IOMMU is added; it was reviewed and
tested by the author.

Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
