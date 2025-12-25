Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370C1DED4C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766685697; cv=none; b=OEqN0QxTXjblesoGLGq1c4FtAqJ/ftnSrFxBOAQ26wzTwCwFgPFii++RwWVqspeSd1laaJseFN090MIc7IHYU8pbPvtYOvSGFX0EkuYvpviBiR/8xncdTfBDyarxSpE/sK28k1vI2DJ7/EJpyCf4OkHYz6vOpWbiaGGWR/2WG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766685697; c=relaxed/simple;
	bh=NzWH2Vua2zqcj/uGhK7C4qLxJQCazJb0tS5u56pjfCA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W+7oTmxurIS7hphKW69RqjVOyuoP7Yg9xKjmv+IBC+JgXnXmDBSWF/p/F3u93sS7CCj7shQ+bMvy/jc4oeED/mtDNgEbFkmP8f50/oCbeJd5CMNNvI5NFcabmvgwg95gEF+lDEYWg31ashmqcGjKkZp71bmZ9qLTI9G7YuB51uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZrpDjfzD; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZrpDjfzD"
Received: from github.com (hubbernetes-node-e483f34.ash1-iad.github.net [10.56.171.12])
	by smtp.github.com (Postfix) with ESMTPA id D350F6003E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766685694;
	bh=x7IaxKXPIo2FDG0zk9uZtoKnJxktbjWDD4gDy2WaA9U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZrpDjfzD54Rv/VgHIeAPd4p2bTT0anNTZb7KStYQ1inAuQDzP7FnA5n94gnn8KlNt
	 urhJYbk5oeaslNTGpA+XNDpF4c/IdLZ7Pk6FcCDsF8oPQtpldhb8ixyoltZbU8IoDm
	 2MjVyxUtwWTu0f7vg5YFmqGZ3SASjBuIVmbJWnGM=
Date: Thu, 25 Dec 2025 10:01:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027465/df185f-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1027465
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
