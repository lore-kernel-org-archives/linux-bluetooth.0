Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB4426EDF;
	Fri, 15 May 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835702; cv=none; b=e9PH9+WSaqsELXYny/meNkthGcppVGOCqv4htU8ZZH4E6G0lEd+A06XTHcPFi6bOOLhnmnKq5/vUxFYDpLm/siYH9WNljkc9xvS3RvBJS3GUpzEXUjAeLYaVNOeOoboTrhITbTg6zHJsHt4VbBzj9VCLBv7wsYTNEGpScHadlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835702; c=relaxed/simple;
	bh=U0fUGOJ/7aXwRqQ5rEJgc+w1bP+vhSWAaPPSUOF2Gro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anAxN2S8G/kMcahQtZQcLVHp/QaQvdNlB4BcUJ47IQtBoUcIjlDajRf9F7U4ojJbDIUMbgg0p5usIdfWk/agMbuIokdzhYvNuxZ+awBetRPpzcIem7iKbWXBc44Bqpzq3J8THVN3xgr+f/Aqn3evUM62jdWOAJ51mBi8eEErjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iy0vPfz+; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iy0vPfz+"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gH1Jm5rrQz8fZb;
	Fri, 15 May 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778835384;
	bh=U0fUGOJ/7aXwRqQ5rEJgc+w1bP+vhSWAaPPSUOF2Gro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iy0vPfz+8e3q0iW+eDmKpB3ZCCt8q2vrZoBzN0LtNcjlC4dsopdyqbDPeUrsSUREQ
	 J3pP0vC+HeXzA5AV7gwyLIBGmrh5U5zCl1R+5cJqgN0JW8Kiutr7my4WK5zbUYxdUK
	 HHqLXAfVgKsKJOtgAv5FbsPibokEouUDkpKnc9lL2UWAPPyT0Fhao1rOuU7r4oZxWS
	 cpzEygrDEMPBfKzhOv1Tk8rWKWh5AK7W017pNA0LAB9ok3oUqUGUxB8KQuBXrxftmr
	 FHBFQ47K31zBIxK2EG6xTR7kLDoeidnPxsUOuegUjWNAM4V5gN+q3YZCBMTmD2Dt72
	 K887yuRCPTA3w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gH1Jh4gGJz8fFH;
	Fri, 15 May 2026 08:56:20 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gH1Jg5Ql5z8svF;
	Fri, 15 May 2026 10:56:19 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E426B6173B;
	Fri, 15 May 2026 10:56:18 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <46427118-677e-4a5e-9ee5-affa81cd90b6@leemhuis.info>
Date: Fri, 15 May 2026 10:56:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
To: johannes.goede@oss.qualcomm.com, Greg KH <greg@kroah.com>,
 August Wikerfors <git@augustwikerfors.se>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Pauli Virtanen <pav@iki.fi>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, markus.suvanto@gmail.com
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
 <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
 <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
 <2026051514-scorch-ecologist-5e7e@gregkh>
 <7ba6b4ee-fd2a-470e-951c-2c69961b977a@oss.qualcomm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <7ba6b4ee-fd2a-470e-951c-2c69961b977a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177883537942.760505.12750404302599804352@mxe9fb.netcup.net>
X-NC-CID: 5r8WIXO+qXAA5yv+QbtZRHwuJZtGdrpuz4IaZ8zlhF/EnCPguF0=

On 5/15/26 09:43, johannes.goede@oss.qualcomm.com wrote:
> On 15-May-26 07:37, Greg KH wrote:
>> On Fri, May 15, 2026 at 04:26:38AM +0200, August Wikerfors wrote:
>>> On 2026-05-11 08:30, Thorsten Leemhuis wrote:
>>>> On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
>>>>> I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
>>>>> hci0: Failed to send wmt func ctrl (-22)
>>>>> My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206
>>>> Thx for your report. FWIW, there are two proposed fixed for this change
>>>> floating around:
>>>> https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
>>>> https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
>>> [...]
>>> FYI the commit that caused this regression was backported to the latest
>>> stable releases (6.12.88, 6.18.30 and 7.0.7). I encountered it after
>>> [...]
>>> As a side note, it is unfortunate that there does not seem to be a
>>> process to prevent patches that are known to cause regressions from
>>> being backported to stable releases. As far as I can tell, this was
>>> added to regzbot tracking [3] a day before the culprit was queued for
>>> stable [4], so such a process could have prevented this regression in
>>> stable releases.
>> You can email stable@vger to let us know to drop a patch, or when the
>> -rcs are released, respond to the offending patch in that list.  THat's
>> why we have -rc releases!
> 
> That relies on someone actively intervening in the process though,
> I wonder if it would be an idea to have some CI which checks patches
> in stable RC releases vs regzbot tracking?
> 
> This assumes tegzbot tracking includes the mainline git hash of
> commits causing the regression (if/once known).
This is the case. And the idea to let regzbot help with preventing what
happened here is not new and even written on a todo list. The rough plan
was to let regzbot just export the list of mainline commit-ids with
unresolved regressions (together with a link to regzbot's webui with
more details) -- then all Greg would need to do is something like "curl
example.org/unresoved_regressions.txt | grep 1f2e3d4c5b6a" in his apply
script to notice potential problems.

That was how I envisioned things might be good for Greg -- of course
before implementing that I would have talked to him about it. But
regzbot development stalled for about two years due to lack of funding;
we are currently ramping it up again[1], but it will take some time to
get things sorted, so this is likely not something we'll implement
tomorrow. :-(

[1]
https://kernelci.org/blog/2026/05/04/regzbot-joins-kernelci-strengthening-linux-kernel-regression-tracking/

Ciao, Thorsten
