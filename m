Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C491C2325
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587430; cv=none; b=CL144iOzR0Sz4QZRK+zb0NQt++bn8kB6KaEiS61tNwBx0lqDKxEs8cE8HYCUdaDshL4pOVVT2VOLY3g6rWE+eeKHEFUryJS6KuQDE6DyKG5MzzS0W2MA17i05MJnVsi75PBQPJd+z0f5eG6uIJbu0d4kw0QGepbqju3TIyOtRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587430; c=relaxed/simple;
	bh=ciJsQ7pCpIXi8ag0FhmW8tS2LreDQXOrbkfzE3MFDXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B1dYe0hwgI/zwg1poCFuAOYtbu2jvC4brD64IY7EEmWKx56fMqUAdiNlAcfrWLYall8N/b9GLRP89+F6Lc4bzV2SPJmTGcq+4Kywr9XveDgc+VDS3azI3zNepRMvaZJi3XoaLqzn3So2IvaGG+dZnJy7Zky9Dk0y0hnUWz0lKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+lcS77Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+lcS77Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BE3C32786;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=ciJsQ7pCpIXi8ag0FhmW8tS2LreDQXOrbkfzE3MFDXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+lcS77Z3Mt02J4LMotz4/1tWkBKnPzLTLTIeFiXNOWZpspxU6AXlyGvK7HzM1emp
	 1WrT6eHodj68QssI40X1gGEhL5ZXSZQcXr021A/YoQU8BXVpiunm1cci3rtwN3CVD+
	 DUjXmrqbHdKRTZ82Y4m8BsVwnyaeIowValXDYjHQXgENKFkcEk1IKgvuqEXufppW3t
	 fNtI8DgptdpAyVwdAtXn0peuXisl4RTCFfG+l7/xpFJXU46qm3awIqMFPWTIRWjEde
	 6X4ufCpGhRlWZq5b2ZaTw9tTZ3GbAX62bp7O/tmXBlX/SE9r8ukL6MavwanNUkYwJ6
	 8tJIgQFmK9Exg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CDB0C4332E;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: add NULL check to bass_bcast_src_free()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743018.13318.13684639526018339736.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628073542.20896-1-r.smirnov@omp.ru>
In-Reply-To: <20240628073542.20896-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 10:35:41 +0300 you wrote:
> Make bass_bcast_src_free() safe for passing NULL pointers.
> ---
>  src/shared/bass.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] bass: add NULL check to bass_bcast_src_free()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=920c4576907d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


