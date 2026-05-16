Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6118EB0
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778907641; cv=none; b=m7yyTvC9jOELXuTbFyyEQnbH8mIBIVq1VULKhtupYSBnHVkEs2yrHeMigRQzMMrZZIcriE/BzuHEE1EEbGzuoE9F8uDr6sizkR2Hkn9WEzhvEkgXAvOzw00c1pdtTq9tvH1Zf95LiHd4tpL7Oj4zU9sZCAJUgFwUnl/l0O1HF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778907641; c=relaxed/simple;
	bh=9Arq76jPc3Tt110HVM78+n4zly+GtQgML33L96NniLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1+21cWqt/h3bVdEkh/+gmI3Ut4afoGNGt4St+wbDOy1jZQAyqJvvMAtYGCtj14fkPOiRPcVbYUxLQNOnRSerxTfVIdhXJI/wdI9StZeLw8G6/b3S4tdJesqR2HfdOxE0IFWCNz0GvVFHEMTp59MpB61Tc+UqKa5t0xSejmuCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PZryapRG; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PZryapRG"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gHX264nwkz71ly;
	Sat, 16 May 2026 07:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778907630;
	bh=9Arq76jPc3Tt110HVM78+n4zly+GtQgML33L96NniLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZryapRGsXop9V5NumgYqiQY2tQWuTBGJWBhpW1PFqYBELYYk8dUEnupr86DOaN+q
	 ixxVWgsUmZ/f76ZWg0oFyf2Gd5WIO6nzdAESVFMzXRdEnVAMwpkoA5ATJrGssP90yI
	 kG+4j/xOWWXUxZNyHA/KvD8xydBB1eUoy5Jb1Lipn3mfUi0Q6oPzYfmBupAznZWTfX
	 mq6YD9/Cq5y4zburW5mz3oYorjuHBEXJuwUg5fVe60/QIqQbYw6pdFb918GSgLsxBG
	 WxBR8+2oVuvXTdTW0V2JHH96y4CJ85XJTfIV24I7bz2FMguQWvfwV652Sb2jCLho/R
	 D/arf9wdLk3cw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gHX1t07B9z71qT;
	Sat, 16 May 2026 07:00:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gHX1r2KSnz8tbb;
	Sat, 16 May 2026 07:00:16 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6A72261829;
	Sat, 16 May 2026 07:00:15 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f9a01992-8fa6-48b5-8dfb-045bea94aee8@leemhuis.info>
Date: Sat, 16 May 2026 07:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: btmtk: MT7925 fails "wmt func ctrl" (-EINVAL) since
 634a4408c061
To: Bernie Innocenti <bernie@codewiz.org>, linux-bluetooth@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <9f6967e5-c37f-4e21-b0d2-8eea4a0b5809@codewiz.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <9f6967e5-c37f-4e21-b0d2-8eea4a0b5809@codewiz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177890761566.3787954.13725076437515354787@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 6A72261829
X-NC-CID: +8TevIF7Dc7cQKDjhmWN+Ksq0VzPstbGJpFHTVB5LA9cGXi3VDI=

On 5/16/26 04:27, Bernie Innocenti wrote:
> 
> Since commit 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB
> length before struct access") my MediaTek MT7925 Bluetooth adapter no
> longer initializes. The controller never registers and is absent from
> userspace.

Thx for the report, this is a known problem, the fix in heading towards
mainline:
https://lore.kernel.org/all/CABBYNZ+FfhYtU2=J-V4pjKf_vKV=Y5LhVhxS_epKe-qaUUt8_g@mail.gmail.com/

Ciao, Thorsten




