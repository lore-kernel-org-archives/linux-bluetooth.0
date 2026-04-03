Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17326980F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194005; cv=none; b=D+eCjrExo/w6FR7ARKiYtWCxyqXUmjAiePpTk5en0XQxn9CqwHgFsylah/qIKIAdMXShoRk0uXw3O/Z6LHbkZdwVkquGI2LElHLAFnbPTy/iNk9/hSxhBmxiDvZjWGoRU3LTMCMPGqp6cW9X4tvwVTgd+lboKnDOJoq5dyf5hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194005; c=relaxed/simple;
	bh=gDhmvC6pQtzd1rtpf26g0R6ycbuWz8+GQuqYFe5t3hU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H61OXuB0AppP3RS/26yUCgknSU9d5K3edIBOF6u6a9UMH+ux36x1xuhaTUkUj909gy1VKa1DdmgEy7hC+Of3amjKFeEnU3+QbwLBLU64YHhhGDqCdh85qnbCTsEdJvmHrt483IZw7eevJE6XpjFy5SGi81RW56A7fUOedQJCfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aB/+j8y3; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aB/+j8y3"
Received: from github.com (hubbernetes-node-917f80e.va3-iad.github.net [10.48.209.49])
	by smtp.github.com (Postfix) with ESMTPA id 5EA43E03F6
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775194003;
	bh=VAtfZdiG6U1wUt7mPLYSErsWW3mZT6EfXrgwyDOwAuc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aB/+j8y3r4TT7zqiTbs3fT9ZLSOy7mvbUZkgUn25NajDXxhDqYkv4hfgJGEhmPDVn
	 0x1Pw29OKjaWYcBlP1YoKisdzSKfD2CGP4DLCCiKoZr2E6vE7ZifZGo4Yg2dHMoAMc
	 2x27KHY/RV6/1TX5uBoKsa0RcCM+V4cnDTAqFIPU=
Date: Thu, 02 Apr 2026 22:26:43 -0700
From: caitao123456789 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076781/000000-3632c1@github.com>
Subject: [bluez/bluez] 3632c1: src/log.h: Add line number information to log
 output.
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

  Branch: refs/heads/1076781
  Home:   https://github.com/bluez/bluez
  Commit: 3632c13b391acfece9415e485b66846801bbf96e
      https://github.com/bluez/bluez/commit/3632c13b391acfece9415e485b66846801bbf96e
  Author: caitao <caitao@kylinos.cn>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/log.h

  Log Message:
  -----------
  src/log.h: Add line number information to log output.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
