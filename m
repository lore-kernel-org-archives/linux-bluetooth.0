Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38C279DAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451005; cv=none; b=ZuAU257PhSrWN6Ud6MOZmSM45XBpzcED//IwXZDbwQNl3L72QKesK8QTY5cIE7oxcQmNNEl5gm4gPpFP5HuJNBOiR6dOrOyfvhjogU+gkFheiPkEnhU98IgC+GjtvAmBN1NiN+sAP9kDhRwYE/PK3JrGCrnLeLcShDWIUYIhx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451005; c=relaxed/simple;
	bh=FwINP/H+0JMeie24izlcdg/E+aHoDkYkTPZlGJvWy48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzUia4aznVA+V0vlDnPZslFL4N0qv7CJWjPhy4ZAWV4bfSvt1e+Xkv6+4EkzEDF7tVGnqf/f+VOdeg0uVXTu0kwm4j+XKrKrgLJaDD42OlUBsjQMGybd32x7oF5qCjfHFZupsfXYRqVGOlQcl1q7iHsWF1SCGd3yibaAiXH89KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2ad0DTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2ad0DTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC9C4CEF4;
	Tue,  9 Sep 2025 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451005;
	bh=FwINP/H+0JMeie24izlcdg/E+aHoDkYkTPZlGJvWy48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g2ad0DTcbInihfEii7Rlzs43DYljQFf2puzxwjylH2LwXWxLTefP9iMhO8pC9vFLg
	 DXpMXyQnOYywEgjaBzwBwaxameSs+NTb0aTsRLMQgOtgptAdg+6jnz3/Lb3uPcCZQU
	 F5RZgyNpxJgUG4xjF0a1Ne9o8tQROsJ6ozVS2GrHobDwXFxA2YF0a4R1Uy7QBSgsSM
	 nFqropZ+raaY8CkkYJhwCIW6zCe5ofx/+4fg3SNydun3Cl+qoSB4Mhq3F4868JB59Z
	 mnzIHxKwVP8K6gSTzqXUjzu03xuqafn6yU4VhQoWKVFnA984GllnvD76hUQpl9Vu4U
	 mgpgmp52Oul0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A7383BF69;
	Tue,  9 Sep 2025 20:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] main.conf: Add FilterDiscoverable option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175745100851.813171.17652191238500964542.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 20:50:08 +0000
References: <20250908213833.1518432-1-luiz.dentz@gmail.com>
In-Reply-To: <20250908213833.1518432-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Sep 2025 17:38:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds FilterDiscoverable option which can be use to control if
> devices in non-discoverable mode shall be filtered or not, the default
> is true to adhere to core spec:
> 
>  9.2. Discovery modes and procedures
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] main.conf: Add FilterDiscoverable option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=393e81a7473c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


