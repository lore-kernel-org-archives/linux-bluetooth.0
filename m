Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3A29A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729143192; cv=none; b=kENWT+NFhI+azMWrW6Z883KrFjurCKJbAz7+aGKoFwjinPz1dMQ6t7R6jFgCdumPXOf+oYF/TaNwiu2SXCTHencKEgMwlkH/AszrZecmj8NWyNaB3klo5vF8ZLWeHvkV9xpTaurZFPjs9TK3zkkpoDdKqrAdD56gNR5qy+xQkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729143192; c=relaxed/simple;
	bh=8jdunE+T2+Z/f73MahG5I3JWl359g9AQhz+HXdKrmaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvQjzohyLamNTcecXOHXliK4npfS+0q8b/lTWL+5I1SXJx35wnoIjJVeyp4x8K8Rb8fcxPqH15sTfVsJrY7PYn3RWer4kFANWKwDvSV2tAnOut/T+N/+5A3uM3qdGJhR4kQQcp0fuyv86wRpxx1H0zQUjkY6I81fcgVWYzkNOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=skiFBa4r; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="skiFBa4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0AY5hrTFuNbBnDoy56Pd4pHj7TkEsF6iaAjF+WAlDco=; t=1729143188;
	x=1729575188; b=skiFBa4rODyd6Yml85r/m7NwJViYAPwzinJYfR586FQAMXrXjfc/Gyv4C+hUp
	d+8os9GrnUW/axpt0Sf5Rpdk/2kElsIRoTi6ZPauCPPJu8xLbeVNIhfOX4ob/xc7Ll3ToGu0BHI5h
	7TjiO40KQ6cdww7AnACd74rGpz+1FA4jgqOyVzEEMm30bD/0yy0AXrtZnqhQpc58j0I/Y+C2MebUx
	F2Ipnvtf/4xyWHyUlIg106pOZ/tIxoLPwMfh9AGby9b80Yg/eUikwJpnjDfW7HJfMkbJapn9YTkjH
	Tu+YUsU0r8xKCzvzSiwPQl85nnWT3adQNvKVtUQISwtgC1OI7A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t1J87-0005Ig-1Y; Thu, 17 Oct 2024 07:32:59 +0200
Message-ID: <5711b892-593e-42d0-8186-39e5e611d43d@leemhuis.info>
Date: Thu, 17 Oct 2024 07:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dedicated -fixes branch in the bt tree
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20241014202326.381559-1-luiz.dentz@gmail.com>
 <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
 <cdc7072b-239b-491b-a1c5-ff9eaf4d5222@leemhuis.info>
 <CABBYNZLC17+si9FLXHO5ujH_OzmTgdWDpMmSStyCnZsEmkthSA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CABBYNZLC17+si9FLXHO5ujH_OzmTgdWDpMmSStyCnZsEmkthSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729143188;e20b91f6;
X-HE-SMSGID: 1t1J87-0005Ig-1Y

On 16.10.24 21:01, Luiz Augusto von Dentz wrote:
> On Wed, Oct 16, 2024 at 2:29 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 16.10.24 07:12, Paul Menzel wrote:
>>>
>>> Thank you for the patch.
>> +1
>>
>>>> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend
>>>> requests")
>>>
>>> That commit is not in the master branch,
>>> 610712298b11b2914be00b35abe9326b5dbb62c8 is.
>>
>> Luiz, please allow me to ask: is there a reason why the bluetooth tree
>> does not use a dedicated "-fixes" branch like many other subsystems do?
>> That would avoid mishaps like the one above and all those "duplicate
>> patches in the bluetooth tree" messages Stephen has to sent every few
>> weeks
>> (https://lore.kernel.org/all/?q=f%3Astephen+duplicate+%22bluetooth+tree%22
>> ); reminder, you can have both your -fixes and your -for-next branch in
>> linux-next for test coverage.
> 
> Not sure I follow, we do have bluetooth tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git)
> for fixes during the RC phase,

Ahh, I see, you have two different trees, and not different branches in
one tree. Sorry, should have noticed that.

> or are you saying the fixes for RC
> shall not be integrated thru bluetooth-next but directly into
> bluetooth tree and then once merged they are pulled into
> bluetooth-next by rebasing to avoid changing the hash?

I'm no expert here, but subsystems use different strategies afaics. Most
afaics have two branches in one tree or (like you) two trees. Both are
in next. And they only merge the -fixes branch into their -next tree
when there is a need, not regularly (that iirc would upset Linus).

> While possible
> this would be hard with our CI which only tests patches against
> bluetooth-next tree

Can't that be changed? Also: that sounds (but I might be wrong there!)
like -fixes you send to Linus don't get tested independently. Wouldn't
that be better?

> so by not integrating the RC fixes we may be able
> to detect similar changes.
> 
> Regarding the duplicate detection, I wonder if that really a problem
> or some script failing to detect it is just a hash change, because git
> seems fine with those and in most cases it will just say it has
> already been applied and move on.

Stephen might be the better one to answer that, but from his mails and
my understanding of it it's more like "if duplicates happen occasionally
(for example because some change queued for -next turns out needs to be
send through -fixes quickly), it's not a problem. But it shouldn't be
something that happens due to the regular workflow.

I've also seen a few people including Greg complain about Fixes: tags
for commits that don't exist -- which is the case until the duplicate
commit (like the 81b3e33bb054 that triggered this discussion) lands
during the next merge window. But during that time window it can easily
confuse people I guess.

Anyway, maybe I shouldn't have send anything, this is not my area of
expertise. It's just that I noticed the mails from Stephen, the
complains from Greg, and that one discussion at maintainers summit or
LPC where "more trees should have their -fixes branch in next" very
briefly came up.

Ciao, Thorsten
