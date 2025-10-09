Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340926E146
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043553; cv=none; b=mzYBUNOtvYSfKBMvtz0LgteFzrLr10LZ7ixd0XElLxlHuizwMCU0kMdlusO1eiZa6YWCVRLrBxEgne0Aa6A+raqdmX/zT0xCmb5oXjMYXnHBDE28V0qNqJYu6/aPf85SzgSNTzsV4Dt79V6ijX6VpezmR7Jl3/xSQ4ZXku6M3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043553; c=relaxed/simple;
	bh=IxZoWxs/KuKJtTd68cAYCQUyeh19pDbAPrOf5Q+ttIA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fEwKoT2fdmVKqTr1mqXMcUz4s8ic3QKBBuVJnqV9EW86WeU3/lcC1BEYf7N42uohDG/FR9ZmwPx6A8Z/St4z4m0RMOTK8Fs1OVPWh9F1If3lkDbSt2y1E7cv64KR0m2f/J17HN9PWupC7V52Hi1grwarQIFzdnWRLUnxfE8TCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=exw2yfXA; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="exw2yfXA"
Received: from github.com (hubbernetes-node-f913317.ash1-iad.github.net [10.56.188.30])
	by smtp.github.com (Postfix) with ESMTPA id 41146600927
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760043551;
	bh=VwsfG/ZUE+xbtvUhaVxnttuZm6NqCaVPRYjUjuD5vSc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=exw2yfXAdVpy+m9lJVrDwnm9AxH/qoAIBbBievED+DVw8nwritybtUwDVLef3pTUm
	 Z7Pv5LYvAQznfI0amS//tFcMLy/nRAbudbw1hyipLuAti4JAC0i4ky/8++++DyQ/lw
	 nmRdBQRfv91VkiRLAqmDaPJO+RwAKRwEl0H1kfhw=
Date: Thu, 09 Oct 2025 13:59:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007578/54d5cd-000000@github.com>
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

  Branch: refs/heads/1007578
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
