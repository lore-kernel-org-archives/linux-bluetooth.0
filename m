Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0B443A8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132403; cv=none; b=V5goFyVuK8KCL997HFb3h0SiLuySeABI0jbdBdpvteIUtf69VlLNRxI3JscZNRqG1L4+z6tV0I7bxDXhLK2hVN/IosKFbANWSRBQ6mdxxdC2EQfk4qRgX9WQRyXNzw/aTiHPvWk3CpjyLCB/kEBWzez5kabnIalnwrzZtMxEt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132403; c=relaxed/simple;
	bh=eoDMSDhD457vy8augvghLPNJbY1OB09jgxSv7iYud/M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jSfSKPfvG7TVTaAnsBIvf0rpNj1Z2r2sfL7mo/211Xhwb4EzFrzIi63+5TsNybukcfFP1N1pf/iRHxSyZlLZznv6xfeALI3FdO/ETinqdvRbOn+V0DLlBVJ/Hzxa5TsPU1mxaRjN4SLkwxvNo1TEo4fA9HuOfiq8i29GMVVopmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Whdyzi8Y; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Whdyzi8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787132397;
	bh=rnjkS4M/o4DeResx1OPO1MbPq7HNlgJk5/kOF8qwGDo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Whdyzi8YznM5KDRPkilZ3+8dnnLzxEdca6zK5pBL2o4Xm7UrNlCOJsV/PXeAyx+43
	 3N3qIT/iGbXP35l2vpLCgC+83+GgY848lKdrIgf2/ghLfc+UXvA4f0pOjKVhd3vmrQ
	 uGgL6FUWRL718S48kp0lPeTqbu8H+8WeqXngsDTM=
Received: from github.com (hubbernetes-node-5aa2be0.ac4-iad.github.net [10.52.152.41])
	by smtp.github.com (Postfix) with ESMTPA id D8AB47811F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 02:39:57 -0700 (PDT)
Date: Wed, 19 Aug 2026 02:39:57 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148341/000000-a51720@github.com>
Subject: [bluez/bluez] a51720: test-runner: "-a" option also stands for
 "--all"
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

  Branch: refs/heads/1148341
  Home:   https://github.com/bluez/bluez
  Commit: a517209812a82f115f34a88673a8c736335ee0ab
      https://github.com/bluez/bluez/commit/a517209812a82f115f34a88673a8c736335ee0ab
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: "-a" option also stands for "--all"

In the options for most command-line tools, -a stands for --all, and so
it does for test-runner. Add --all to the option description before
--auto as it's a more common option.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
