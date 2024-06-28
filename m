Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FA1C2323
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587433; cv=none; b=RwHmP+Vk4ZraYozB0w/XaVBdeRuLR2qGH4bCLXghYiaQQR6vOpkLYOwlRv2KzLT9Sq/UD4o+qvBlcPq+wNwk+zyt7Eow0K6QKgyha23CoS2OWtwfoYb8PxnsEsktMN7ShpK43YTlpd3++ucfk98GkAV4IXz6rD7jXvHi5D3mTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587433; c=relaxed/simple;
	bh=nEybdsdXwXlraE3/ck9rP4LqgPC1H6OBkkDfjRbiRGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdC7tPHPqPi/oGYAwl35VrizDqpCod12MJD/280XzsY4xlQZeN8Ca5Qf1K98RYuLMcgxRdcerart5vKzv1zJUIVp10RAQ14N/wecrnLmlQGK0lgBpBpRtDjQ8FQyJCDX73OIwagJvbmXP6K4VjYN4CHCEqlKj0kIyf8QymQEAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se4JPLWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se4JPLWY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 612B1C4AF0E;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=nEybdsdXwXlraE3/ck9rP4LqgPC1H6OBkkDfjRbiRGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Se4JPLWYgiHst1/1EWK6dDz8nyIHa8/jExMQ9GR1J2+Up16OMzITDXBchFg2uybP8
	 4VrSDmOEUYd3DcF3Tvp0JVvHJfMJzIMVvZkG97uZEQAqKWRmyFR2U5Bcz91dP9Ojhr
	 d8be6Dl+I9yx5ADcW5kIAcGFeo0blRDq3aJ31kQ48UMwEYQO1i44v7csPqQXLkin8r
	 jbVT0MSOjOM+zvIJpIS6VmUaYhNfMfOHjdqyuz1B7iwUXHhRGUvZ37jd8c9IYuPSC0
	 d1oc/KlM58ibn9sOryK8k4Y3aSb5CIZevMFLPb1TANewKppu4/AgtEs0rKG9/eO7ym
	 zITMcPXfvWaaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51AE3DE8DF5;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mcp: replace sprintf() with snprintf() in
 cb_track_duration()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743033.13318.15199270108572513655.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628123647.547516-1-r.smirnov@omp.ru>
In-Reply-To: <20240628123647.547516-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 15:36:46 +0300 you wrote:
> Use snprintf() instead of sprintf() to avoid buffer overflow.
> 
> Found with the SVACE static analysis tool
> ---
>  profiles/audio/mcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] mcp: replace sprintf() with snprintf() in cb_track_duration()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9886a7557b3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


