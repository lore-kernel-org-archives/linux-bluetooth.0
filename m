Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AC48BD30
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042887; cv=none; b=gR493J0gpOo1UkrNtlLhXjeGdvRfxUhuYMp9zJImkDuNA9WeRqCjTP7DGa7/k02kDkLhZ4cXyHOuvRXArVog5OQRHsqRVqWmCJF9m8sI2g4DAC9KhpVFGIRV5f2Wzntmf+WER9dAdaedxL//OFZYIXERCyIWpUlhRaOjcqh6VOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042887; c=relaxed/simple;
	bh=7BRBIasON9lh1HsqsRahNcqwDF9n1Ag8SNKwVXnMIZ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ghhd1lkt0ilblUv+W0E0v7GYkaRo75F3qrTW/KEmSegiWveaLB/gkBmMFCHvhGau8GVrIISoITDGX0oj0qt2ualrpwzT5hKLP/W/crVs9X8mn8o/a15QN/2sVy1AvKl05O2lYhfbiaFJvShde2oWvyYJbZHZWFkJclwVb63yrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h8CgrjKM; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h8CgrjKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042883;
	bh=bQUKwPWidjGFUizusXo/1OPVZanQynQ3msScpH+EK6w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h8CgrjKMlrKgAgbdCua0nJbXaMP0cCTwzJOr+/LlXteQFkkm+hO+yQVY5+Bo6Gf3l
	 shN9HD0yAiqRgxplTn+MwmItLXz4LHVrfM/6iev0i0aj4hzU/Ix0s+0G3fSdG0SKuU
	 588wG2A9arDw+ugTonkmSwC7xJf7jGwPI/56DTv0=
Received: from github.com (hubbernetes-node-1f0a588.ash1-iad.github.net [10.59.91.32])
	by smtp.github.com (Postfix) with ESMTPA id 8556392111C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:08:03 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:08:03 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108834/000000-da2011@github.com>
Subject: [bluez/bluez] da2011: avdtp: Return correct error when SEP is inuse
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

  Branch: refs/heads/1108834
  Home:   https://github.com/bluez/bluez
  Commit: da201148e7a288e2568a1822d55c69d932b77672
      https://github.com/bluez/bluez/commit/da201148e7a288e2568a1822d55c69d932b77672
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Return correct error when SEP is inuse

This fixes AVDTP/SNK/ACP/SIG/SMG/BI-08-C



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
