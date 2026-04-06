Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D221F1F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473981; cv=none; b=FlPAXPMaaYMrt6UfrNII1e/KqNBp+1QmxPoezrOuHtkOeEw+m4JZMw28FewRFn78xkvFL2DPwi72LwoITVgkh0mWUrXz+eK0qnuV0OGww8Qh5RKoEaVN8vLlBcZpFtBNaU0g6AoKBnrDy0c+4FyCRxPipDcXJpIF1KzMKckD9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473981; c=relaxed/simple;
	bh=aSWfPY8FtWs9IRW4kMjOlk+2avxzvY0E6fDdlP9Fdto=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PJahl5EjhMskbqXfR5lpauRiJGiv/w7lj11b0AR1sgdy2khBfwu6k90NJ50gPQc7KY6JrYY+iuPcw9vzmpF6U9XSdy72fTdRSRQMWP1zWHLGKsHM4S4T+b7xOXYnjjK1NkGD4WgCgSY2bgdSx402fJrXQh/F1FJ8La0Cz/rYXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V8kmSAyy; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V8kmSAyy"
Received: from github.com (hubbernetes-node-1f5cc95.ac4-iad.github.net [10.52.170.40])
	by smtp.github.com (Postfix) with ESMTPA id CCC04700C11
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775473979;
	bh=Q7oBhvr3z261pxW6GDXaNyWNKEHJpheOqG1jqYu5Cl4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V8kmSAyyaOJMY6n/dBqSI6yYXRQf/rJAhNTvwkx7f4JyeZjkD33LnfWCakif5Cmgj
	 5W3f6Bo1yrpJyh7iEmJ8zmCZlHU0eNvcQoviNMp6v2ELGNrhEeXH99G/S5E2qpywvc
	 IDGNKSz+ckFMFlE+9OBKLLsjrptQVFDlQDCbTbPY=
Date: Mon, 06 Apr 2026 04:12:59 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077632/000000-422868@github.com>
Subject: [bluez/bluez] 422868: build: never build test-runner with ASAN
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

  Branch: refs/heads/1077632
  Home:   https://github.com/bluez/bluez
  Commit: 42286875951580790a76d02a7bce1ba8be56f68f
      https://github.com/bluez/bluez/commit/42286875951580790a76d02a7bce1ba8be56f68f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: never build test-runner with ASAN

test-runner cannot run as pid 1 inside VM when built with ASAN enabled.
Drop MISC_CFLAGS/LDFLAGS from its build; the additional flags they
contain beyond ASAN enable are not important for test-runner build.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
