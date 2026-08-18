Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00133EC800
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078311; cv=none; b=MDvL6wDW4sp9cKQznBGfaBd98ZZL+6IiYCC7x/NLd09b1pdkiYg/ZW4hn3jxLIpRGj5W/YJocuMYdql31WmFcYcbboVm1krq70xKQaSAZox0Qp/Kd7BlN/5KvPrYTzSNb/7iriMLjYHxsKzOrUV+lGWP4IcYWy6TglYKDYORiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078311; c=relaxed/simple;
	bh=QEiLuJoYSRaKA5RHKlAiUO02vh3qRFg8B6ZiBhZDK30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gAWH6bxKJMNWlCh42wnvND6fmfOOsL0U0G9q1YzGteCErtCa3+aCaremJWCdIsqU0lE6qnlT3ymiVyLYYCQtlCvs15qjZX4ho2DHGL4jPDkXatDwETY5ijVHjzyj4j7Uj7W9ECtMezQ8tu3yGOghwzkHg6p5+iiQRpNN54KULzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz59qLq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz59qLq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514AC1F00A3A;
	Tue, 18 Aug 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078310;
	bh=KVdYmwnbOt3PsZVLnAw1YShaDjIjq35sLUXfCqEuvUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lz59qLq3C0eAUzQT3WNczRN0ivY0DXObaQ49sRHgWsQX2CESlyVHe33QjiT2uIuhf
	 yCmAcY8z+1TMQ3iBinppU7OknacezDhEYZ1mkqmG8cI7mj3hzna8lzSOlNUVsnMYef
	 cj+prn8HS5uEdyz2hzF4n6auz8FfcXLkQIRPaWsDa2heN0rqcZep2ryYpfojAyR1G9
	 1lqYC99VyYUBL5WZ/oGKyLkUltUG0qDyhcCtIlQJnobSXA5PG2lCF9vjmDTE1uSlEc
	 yQbWNh2NGckjZMhJRSSrm57bkUh7jMXcGXMb+cE5cyTXJNwKbqqwxPBCaAvXCkVRcd
	 ZuODoQYehGmkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1972F392704D;
	Tue, 18 Aug 2026 18:37:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] sdp-xml: Fix leaking the parse stack on
 malformed input
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178707826163.2194892.8557582282057693653.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:41 +0000
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
In-Reply-To: <20260814174731.1441738-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Aug 2026 13:47:29 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> sdp_xml_parse_record() frees its context but never the elements left on
> ctx_data->stack_head.
> 
> element_end() returns early without popping the stack when it rejects a
> document, for instance on a mismatched </sequence> close, so a malformed
> record leaves its elements behind and they are never freed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] sdp-xml: Fix leaking the parse stack on malformed input
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97521ab4dd79
  - [BlueZ,v1,2/3] unit/test-sdp-xml: Give each test its own test_data
    (no matching commit)
  - [BlueZ,v1,3/3] sdp: Fix memory leak when freeing alternates
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


