Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD473BE624
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030701; cv=none; b=eYd1aMMfTgL3N+OpbV/qcCT2oAF+WAZQCxE28ZcR4lniZ2/NrguiA/5+wBYbjlnFDjHCLjeMHYKpqObyfksNIw32JipCO2RAhuIgiYzPAfTkesukuX4d9450+hPD34tVu1BjplDUrvm/feLz9z+9KO4Sic8D1jWSq8QAq8cvCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030701; c=relaxed/simple;
	bh=11wqATdJd9uiOqrvI9u0loUKqZlcaAn+H7K3JSsdgKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ8Bk8yoC/Eh3DYrI9dGRiHKV6WG/3YbaaAK989YsuvnJ27iiI+dVIsHNSQ7F1+fdbeypuzWCIVR6mnjlMwhrrM/N9YJ8+oj2L+ntLj54t+d5nbud/6GgZY3B66M+t7/XPhCU2YixL/ArzIBn/mBD0cZpOUA/WRLUdVUX3qk680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Gg3fFDrc; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Gg3fFDrc"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4g29lG6dYPz8gGK;
	Fri, 24 Apr 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1777030282;
	bh=11wqATdJd9uiOqrvI9u0loUKqZlcaAn+H7K3JSsdgKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gg3fFDrc9h1WJZib+4Augf9otyWKM4KCZEPkQ3eTnX3ZTLTJmXg4q9sB5y/pG77nL
	 wlWYE2up6ZK1t7o76bRAKXCnVZhsLbX8Cn2oiNiB47AKuVgtAZPYiDoNUDbLH3hFTr
	 tspVIqxj3rGsLLZifcgHc2Xz12nZGxljoKJroUqD09kvIn3HAlpMiEesBOumSHZMIq
	 9fHuql0JDzhLhWGqBgdQDOWhTvhAnW0HHx2ZP+oWihllUx1hkC6akGKXx3FMcrHoAB
	 z4ZohDp37xU2vKTqvxSSVvLoTc3cVyIn46yf/Pt9/a/IhNvN5ocsFxQXypQMin5RXV
	 6THYmC0sIPskA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4g29lG5vD8z8gFh;
	Fri, 24 Apr 2026 11:31:22 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g29lG2LpNz8sZh;
	Fri, 24 Apr 2026 13:31:22 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B0BB3632CC;
	Fri, 24 Apr 2026 13:31:17 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ff141080-e94a-4c58-8fe0-f1c309d3f579@leemhuis.info>
Date: Fri, 24 Apr 2026 13:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops with 6.19.10: RIP: 0010:hci_sock_get_channel+0x5/0x20
To: Gabor Gombas <gombasgg@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
 regressions@lists.linux.dev
References: <actZBr+wqcABY5mt@lan>
 <e96776d6-ce8c-4626-984e-474f3606445d@molgen.mpg.de>
 <b3a60d9e-b811-42d9-bf05-f400e1302a30@leemhuis.info> <acwk5Z6AwTwE4H7D@lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <acwk5Z6AwTwE4H7D@lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177703027796.991585.11373475514707063773@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B0BB3632CC
X-NC-CID: iEAja7G2/FoEdy85d3eUDy5UqwAh2mAZg3JDYHIvMNNWhe4SUH8=



On 3/31/26 21:47, Gabor Gombas wrote:
> On Tue, Mar 31, 2026 at 09:07:48AM +0200, Thorsten Leemhuis wrote:
>> On 3/31/26 08:24, Paul Menzel wrote:
>>> Am 31.03.26 um 07:17 schrieb Gabor Gombas:
>>>
>>> Can you reproduce the issue? If yes, it’d be a great help, if you could
>>> bisect the issue.
>>
>> For instructions see:
>> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
>> or https://docs.kernel.org/admin-guide/bug-bisect.html
>>
>> Checking if mainline is affected is also important (the first guide
>> handles that), as that determines how this needs to be handled.
> 
> Unfortunately it's unlikely that I would have time for a bisection
> before the weekend. The bug can be reproduced, I've booted 6.19.10
> again, and this time hit the oops after a few minutes. The oops is
> slightly different, so likely it's some kind of memory corruption. The
> box in question is running Home Assistant, so it is constantly scanning
> for Bluetooth devices.
> 
> I have a 6.19.8 kernel which I've built some time ago but then never
> used, I've booted it now, we'll see how it fares.
FYI, 6.19.y is now EOL, so this won't be fixed. But if the problem
persists with 7.0 or 7.1-rc1, a bisection is likely needed to resolve this.

Ciao, Thorsten

#regzbot resolve: inconclusive: 6.19.y is EOL now and it's unknown if
7.0 is affected
