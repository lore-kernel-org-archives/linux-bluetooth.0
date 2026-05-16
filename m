Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A2350A0F
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910692; cv=none; b=VC/RMgS4BN7qqsP0YMeVzizXMZxS6pbtiyKQFmiYabXrN98hPJz76rkGm/aoCvOvQ087OJ7xRqe7G2XOCV6vqAphiq2fkFoZwXmjgbJcf2oKmlWBCkNx7x4BKz24nRkbZs2lMVR7naIcRfwLN/v3lLggpK7+1LJTYN3KTlncSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910692; c=relaxed/simple;
	bh=hFx6/s2sAYF13Pn/shDeL9QZnQJT6/4ZXNYrL1wlKqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKsLJ5UL9thrL6CbJZOXMxJIN24rYHaA2g3JFFwiizNsNZjiLRkwTerckHwBbDslH0LhXhDmxVtMnkQ+KCg26hXb+m2pYmsbGQCxpmXHCxgiNOWrrbBJRrUM8LN6rH2am3QMGws5G0EfMZ0bOWjCZ9i1xbw9xGdh7YsPt1eYSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ArzGe75j; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ArzGe75j"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gHY8v1YdTz8dC4;
	Sat, 16 May 2026 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778910687;
	bh=hFx6/s2sAYF13Pn/shDeL9QZnQJT6/4ZXNYrL1wlKqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ArzGe75jC//Onn+iTfNImIVG9a0CxCO4S94F3grozLglivsmu0adbQgwBDvIxmQh2
	 FYImq7u8QgSJROPtzox0EINJTeVA5H5SrP1sSG27fgcBhgo2xcHNBH1X7U1FUnDDgi
	 R5CgM75nrw2061eUspBJLSnCMAB44uz+Fy/mUam7auhWPgx5egu06gpeRh1ISgq0rx
	 RY6EURbaUuFn04fw2HBCUkjjgg2ODGhdXJWQEdX2VrMWvrfKwHUJ379Ij4ThfuS79w
	 +AKmB5zBxDOizGZGwGQ5Y+nvuD9JB3YuMU318l+ihWUkGVp3DaSft7gn4BTtM/u9Iy
	 xaNlewOF5uejQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gHY8v0nxXz8XyK;
	Sat, 16 May 2026 05:51:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gHY8t0Mwdz8tZK;
	Sat, 16 May 2026 07:51:26 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4AE496038A;
	Sat, 16 May 2026 07:51:25 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d7b819bd-f3e0-4931-bcd8-6bc4aa50a3f5@leemhuis.info>
Date: Sat, 16 May 2026 07:51:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: btmtk: regression in 634a4408c breaks MT7922 FUNC_CTRL
 handshake
To: Sergey Kasmy <sergey.kasmy@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: tristan@talencesecurity.com, marcel@holtmann.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: 
 <CAJ8Bt0iC5bVgCRw28YXB1mo+-p_sTM_cp6fF+qVNapyL-Hsayg@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAJ8Bt0iC5bVgCRw28YXB1mo+-p_sTM_cp6fF+qVNapyL-Hsayg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177891068561.3873274.8920997460952381602@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 4AE496038A
X-NC-CID: t1C18Qh/gqjwNjo2tqrjUxrg0DCqJL1mKijFd0aPK/rVQjKf7LY=

On 5/15/26 23:02, Sergey Kasmy wrote:
> 
> Commit 634a4408c0615c523cf7531790f4f14a422b9206 ("Bluetooth: btmtk:
> validate WMT event SKB length before struct access") introduced a
> regression that breaks my MediaTek MT7922 Bluetooth adapter (USB ID
> 0e8d:0616).

Thx for the report, this is a known problem, the fix in heading towards
mainline:
https://lore.kernel.org/all/CABBYNZ+FfhYtU2=J-V4pjKf_vKV=Y5LhVhxS_epKe-qaUUt8_g@mail.gmail.com/

Ciao, Thorsten
