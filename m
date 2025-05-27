Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF51ACEAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380794; cv=none; b=L19fZksuDyXh2pqVUtR8xvtOzfMEnRDfyJ42Wecei3XJIFDkrgAEidDwVfeI7ncyoWot0WGRpYp+U2naYgSj0fmKIDwaPGIAZRLkAXNK0SqNka0ZpDkSt//ezg67td775/a6TxzbtbVaA7gC4TCv4htKplvkPMBcHBTNIy+1k1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380794; c=relaxed/simple;
	bh=vHyQtiTtwgsb2q/rTIlyAwyOafqcoPLskRUjs2Psj7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0aw9vup8rUvDutNFIEepuRZFFe4xy9m8XaRoQAQZWyqMr8kGHl+EoBO6/1jAoRyG7vPZ0upK/d95c7Iw+YTAUrwZXvhHk6pWc/N/qT2q8g5vYMdLp+srAQUY8+6gWZHWbj1GGFuzbLfuJ63qpvVP9DsTvCLlktbl0Z8F1PIk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anXRYgP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anXRYgP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C57C4CEE9;
	Tue, 27 May 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748380793;
	bh=vHyQtiTtwgsb2q/rTIlyAwyOafqcoPLskRUjs2Psj7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=anXRYgP+UHsB3WYj7IRb7VXW4R4EiUOQlBYYV9n50jxzpqz22GhYE/gQ90/SEA424
	 sq3j+m0tY6e9ohT1zFBGIXRyiWd8fjUFIcLec1Lcq8pdkmJpiBkVXkQRxuh1f9K1Oq
	 S6q7vgS9EyPE8scBDbeBrHRDvvnhyay50QdkTGqk5PmAj4gp6b+hBJAuRm8BFYv0dM
	 PUpAX8nx/5F+BkuawRzSjp6CnHVK5daIUUOzLe1AYP+G/0pL5FmwRg0pp5Vgf3XZQz
	 mqzh/BCHoPVR3wdqPpiEY6ezk1SSN/1f9+i6hsOdM93flypzzqhyFt43uE19gq3Hsv
	 Ti2vQ8l26/O+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE45380AAE2;
	Tue, 27 May 2025 21:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] policy: Fix service retry counters reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174838082775.1782235.17410109323459610043.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 21:20:27 +0000
References: <20250527134521.4942-1-repk@triplefau.lt>
In-Reply-To: <20250527134521.4942-1-repk@triplefau.lt>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 May 2025 15:45:21 +0200 you wrote:
> Control and Target retries counter were reset when service state
> goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
> state is reached before going to DISCONNECTED. This causes retry counter
> to not being reset in this case, leading to service not being able to
> initialize on next connection. Source, sink and HS retry counter were
> only reset when limit was reached, moreover HS timer was not removed on
> CONNECTED state.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] policy: Fix service retry counters reset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a552b93de8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


