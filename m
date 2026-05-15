Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D242E01E
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836089; cv=none; b=hCRC/a53+i+1fIrMVKhIWzhRK+irpZ0fgZdJCbYSK5yK3jd+L1ZEKnghq9WlMTegvnNCcwax8B/xL6VFvfrcmRRC1vYBq8RZtAdwx1H30SPLeYOCiVPg8qHaqK2C71GOu2sbuRCNo8xZq6xJVdWAzG5OtzFcA3HSYd+gzMcMWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836089; c=relaxed/simple;
	bh=BaVsgbuwAhiwM2mPBF861vbKlFQGDkOsdMgwD+YqctY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrhxoTc3UXUW5Y9c2EJzddgzeHjIs/MNLLOPAa3iHDNc+2Lg6p/JgNOfQ+h/0P0EDrQCeiYHFIyPyObc8+QKkT4roQst6NxoOdEcVc5veYz6DxJ+PDlmvoAIMHVX++poSCAs+Qxml/uHUEv8PZLfyz/HlR4DCW1uGeU//L9t4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gUpwyZMK; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gUpwyZMK"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gH1Z82P02z8fHd;
	Fri, 15 May 2026 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778836080;
	bh=BaVsgbuwAhiwM2mPBF861vbKlFQGDkOsdMgwD+YqctY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gUpwyZMKWE8oNDHpRgDBQOEyyCKswR9u01/QwI55xB/2pGjzVn7DAJlABsLLEqA1L
	 /4tiZxCRhrDUNtRU2njArBGqG/ejzo32T5H89la28Lsz6Rore/DleV4VQ6YfTFm8fm
	 4vTw2WdEp6IzLWY7oyvvrKj0Tdfx6bJCfkFmM+6eLX9MMRPFef4zG4blDaQ6AHM4YQ
	 h4pRsDq/g7iVKhmn4uPAoe0o1uKOLpeERqoghqaxOg/5B/uooftmziA4ei8G9wAy/S
	 YJyAivE6tFYS93qcC1iNrFv5EKbm0KPxlBTbQTxubES6BpKQFJkOwwbAelPpKQlVk+
	 sFgXMcqJZ3F8Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gH1Z81f8tz8f87;
	Fri, 15 May 2026 09:08:00 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gH1Z7439pz8sh8;
	Fri, 15 May 2026 11:07:59 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 774576178E;
	Fri, 15 May 2026 11:07:58 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <81bcf9fd-2f07-4fc6-be90-da4e448379e4@leemhuis.info>
Date: Fri, 15 May 2026 11:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] MT7925 Bluetooth fails to initialize after btmtk fix
 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length")
To: Aaron Muir Hamilton <aaron@correspondwith.me>,
 linux-bluetooth@vger.kernel.org
Cc: regressions@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>,
 Tristan Madani <tristan@talencesecurity.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5i35wmc4z7sz54jo5uj6ywext2enh4ik3oxmfmperqk2v5kc27@ppvm6oodzipn>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <5i35wmc4z7sz54jo5uj6ywext2enh4ik3oxmfmperqk2v5kc27@ppvm6oodzipn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177883607888.804668.7438681875265663672@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 774576178E
X-NC-CID: 8JgQrUGFSbq3KukrF8ydsezEm1ccybYionuWYz7otemQiFqSVGk=

On 5/15/26 04:49, Aaron Muir Hamilton wrote:
> I bisected a regression on MediaTek MT7925 (Framework Desktop) in linux-7.0.y which appears responsible for this issue. It initializes and works correctly in 7.0.6 but not in 7.0.7.
> 
> The bisect landed on commit 70d37a8b9229e394cc17ddad47e90b81d80fcd09 which is a backport of 634a4408c0615c523cf7531790f4f14a422b9206:

Thx for the report, known issue, we are sorting this out currently. Fix
for it is here:

Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/

Ciao, Thorsten
