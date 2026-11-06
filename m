Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006643;
	b=gfcDCz/XVbi1SVjNv7oMhKHDcmuQQJtoHoOIGDq2kucK8jqmir6kqvdkGSMANJCh7wW1
	 LOKG8ID5++7YbW3UCU0JF2dxEAwJe126BWtYZ0Ism0/Q7g99Vxl9bfq0nq0esQLhXMmsY
	 0jPtn9PhKrkClJ2hEhUgpyUBPrSsq27WVMZrM1MPFfLELm6YdkTd9Icu/7wuLSQYbyJDP
	 OKsxPUZ0Gzk0mNpE1PheCXXGfsLaAB3ghrFE0YVB/NhO7e6aWWtOo5kVvPc34XcgCDfYl
	 A0p6RDU5PvtiFkNx00GTxPgF6pUKfGn7XmlPw9cHv0bVwb3gvdv8D8Zl5reMtCL8cJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006643;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=SSu8sahHYtJP4tYEpVQa1z5i0RcdS7+U4e1oKrlexBE=;
	b=YUCCcH6DiuqKFOT/I7rUEzTOw/dTLwcD+822KiI/WkR4hEWFE3N2axbvielr7WxPCgiA
	 QZCAe5WI0VZ1Ld2KAdZNhxDgtXChD4RYeXxtacaSxkw/dd3STM/c9zA1NspY228hvtXAC
	 XyqR8QNdRmpBXxsA3a8NIce+ewcCo+XVbRBkrvk2Klrl5im0vPhGHFkDuGp4GCvGW9sJe
	 4UKvcOfZLyeHJHl6dlzHx2CBStQUjb4OOU7Qblyo3MnXF9oA6Nw0skGayHusEACn6hR7I
	 bj+iOraANHWor44PaXktcTGzcvIpjSZRwB2ZTUQ/rBPho7px8LGiNNOSWZKsZ2O5E3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QVdBHXCf;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063E606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 23:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2063E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QVdBHXCf
X-Envelope-To: linux-bluetooth@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bSp589ynlUSbkHZ/Pc8oj+44xLBN6TotbLXU3BpwP8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006640; v=1; x=1794611440;
 b=QVdBHXCf+YgkLKYumhrLD6fpuUKcp+E/ZAqbFq9mwZooLmomr5cTdrc4rP9finr0QLFyh2ne
 CHFzaErK1kkzmQMX9iLCJOvg8dXjH5A+LgjuIlEZCaje1eD93ZQkyCrW/+1Fk1R7XSi5/A6sWYc
 mOtLmfjd1H+usMO9Ytx58ofw=
X-Envelope-To: linux-bluetooth@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f5adb69807cbc1e0;
	Fri, 06 Nov 2026 23:10:40 +0000
X-Mizu-Trace-ID: f5adb69807cbc1e0
X-Migadu-Flow: FLOW_OUT
From: Roman Gushchin <roman.gushchin@linux.dev>
To: netdev-bot+sinfo@kernel.org
Cc: alex.aring@gmail.com,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  netdev@vger.kernel.org,  linux-wpan@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix netdev_priv() type confusion in
 lowpan_event()
In-Reply-To: <179400615048.488859.9102835578031186781@kernel.org>
	(netdev-bot's message of "Fri, 06 Nov 2026 23:02:30 +0000")
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
	<179400615048.488859.9102835578031186781@kernel.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 06 Nov 2026 23:10:33 +0000
Message-ID: <7ia4fqxd8sk6.fsf@castle.c.googlers.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

netdev-bot+sinfo@kernel.org writes:

> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I've a reproducer which I don't want to post publicly but can share
privately.
