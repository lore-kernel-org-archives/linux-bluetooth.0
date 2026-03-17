Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562C3E122F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757103; cv=none; b=ZYTnU2LZDszrq/ZWYzCYWvFihbvEN8x3gGJHDFaeq84itchaGoWZxW6MEQycKBpO0p/0+s7lQzhO64v3n96O8+66PtULOe3Upw9ItBGVOCHvKw/2F/7z4J3RLdlt7ktKkhuuvrorZ+0PMbx+mQhyufM53SXrSg7tH+bto2oCNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757103; c=relaxed/simple;
	bh=rDSz/c5es2sWImHDYqQCcGYZr3RbXvTq6PSCJN0pqpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZSZUJMFq+1AzxG9R6vBwMSY3jh5Het3i/ABPjI/VGECUIS0u+d7ENcmWVzcyUC2iIa9uchkc+m8opvinvnCty+je/Qw0dqAcR/a0jB/BMFtZ2XlrswpYjLr9oVXKUz4cgg5RIOAX/ryflOg5RJclA6iB+27AStlnvf3CLmQCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BPlkrtqU; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BPlkrtqU"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fZvDL5zSrz83bf;
	Tue, 17 Mar 2026 15:17:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1773757042;
	bh=rDSz/c5es2sWImHDYqQCcGYZr3RbXvTq6PSCJN0pqpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BPlkrtqUeW5doAcV2prWa9Sw+u6F/VJEIuyXLf6nhbzGZY6xMWG0dVFy7uwOYhjyp
	 GpWBVEzVd5mu0obraYwrhrfcUVZFPtWQYK5N1g6s+aTjCZi7nod5VGdQM7ifIkZKcN
	 wpEP6/gFV0/C6zl0XGRFmeYUQ2RRoStFLybnA0E+mHwkdi74lqCMnxJrfCISqWsZ5I
	 plGmzIHDJrO3jS1PQM+u91z5jQ44LgMTuktvNYKutUeGFsmKRghkYUL/Xt6p5yK+dw
	 pC8f9CUibeEHSZzs7m2+a+fyNYbpokfgnVZ1dQHQDPy7rK1UWaUjsfG8wqurZ62/GR
	 rwtqtdpwWckmQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fZvDL5H8jz83ZS;
	Tue, 17 Mar 2026 15:17:22 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fZvDL0xSTz8sZP;
	Tue, 17 Mar 2026 15:17:21 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CDD01633C5;
	Tue, 17 Mar 2026 15:17:20 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <18e6418b-9df8-46fd-87b1-d6bbae63f616@leemhuis.info>
Date: Tue, 17 Mar 2026 15:17:19 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX
 ident
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: 
 <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
 <20260315194407.13904-1-joanbrugueram@gmail.com>
 <CABBYNZ+reKNjLhs5f_xjqdDP-jz3jjkoDpm67XUOw7QUjhKTmA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CABBYNZ+reKNjLhs5f_xjqdDP-jz3jjkoDpm67XUOw7QUjhKTmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177375704121.3989390.15106385976003174088@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: CDD01633C5
X-NC-CID: u4svMIVd+afKN/swzL3xlTKRnKaQIE6L1s4oWS2+OmbTQfZWARU=

CCing the net maintainers because this is a regression that Linus afaics
would like to have seen fixed by now.

On 3/16/26 14:37, Luiz Augusto von Dentz wrote:
> On Sun, Mar 15, 2026 at 3:44 PM Joan Bruguera Micó
> <joanbrugueram@gmail.com> wrote:
>>>> I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
>>>> and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it.

Side note: there is now a third report where the reporter confirmed that
reverting this patch (6c3ea155e5ee3e ("Bluetooth: L2CAP: Fix not
tracking outstanding TX ident") [v7.0-rc1]) fixes the issue:
https://bugzilla.kernel.org/show_bug.cgi?id=221177

But I'm writing for another reason:

Luiz, does it look like a fix will become available really soon now? If
not, I wonder if we should just revert the culprit at this point (and
reapply a improved change for 7.1), as the regression was first reported
on 2026-02-22 – so we are way beyond the ""rule of thumb should
generally be "[fix regressions] within a week", preferably before the
next rc."" that Linus recently mentioned:
https://www.kernel.org/doc/html/next/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

Ciao, Thorsten

>>> Weird, there shouldn't be any logical difference but perhaps it's
>>> device-specific. Can you collect the btmon traces? Actually it would
>>> be great to have the before and after traces for comparison.
>>
>> I have attached btmon traces (bad/good) to the open Bugzilla bug.
>> (https://bugzilla.kernel.org/show_bug.cgi?id=221120), hopefully they
>> are helpful in diagnosing the issue.
>>
>> I have also done experiments and found that the regression goes away
>> if the IDs are not re-used, for example by commenting out the `ida_free`
>> line, or by replacing `ida_alloc_range` (returns smallest available ID)
>> with `idr_alloc_cyclic` (returns all IDs before wrapping around).
> 
> Interesting, I didn't consider that the implementation would care
> about reusing the identifier as long as it is not outstanding, but if
> making it cyclic resolves the issue, that's probably the case.
> 
>> Though I'm not sure if that is just masking a Kernel bug (e.g. IDs
>> getting released/reused too early), or if that's necessary for my
>> hardware to not get confused by the same IDs being quickly reused.
> 
> Even if it is a bug in the remote side I guess we don't want to just
> break support, we will just need to make sure using idr_alloc_cyclic
> doesn't break L2CAP/COS/CED/BI-29-C qualification test.


