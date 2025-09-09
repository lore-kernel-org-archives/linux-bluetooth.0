Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEC279DAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451007; cv=none; b=ckCv1KuFPW8pcdsPzFusqMGZpZtKd09O5kTpaWthM1vdZX3RG7cYXIHBv7N5rxCCSReF/Bx7EDE3uspMlsysNT9sxIpBw2qfonoTB9X/YMUa0Qi53ROwSEjQxcYX9MjW7Hw2Xx1Q470FeAdHzhl7ZgCWyiuzJBiWwlfbfBa6l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451007; c=relaxed/simple;
	bh=KJE0KFXFnJnh86sHdziq8SS80Nb32CkNfUvWJCIRv1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J8p4U/uCR34Oqz7G7P2uRGRlYwMWt16SWxrCkqlg3oY1OgVkzwstMZp04Jo93o7y773n+Yldmw7M+Bqa7BZLTMcnV2LCZDWLOQ5s2yox8zd7o/rzLIaGNfHD8pHwV3qnbtFXNwLby3N3ZbwfZgYe0DY2vGkHE35+MW87doKwrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnCF+n/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnCF+n/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B991CC4CEF4;
	Tue,  9 Sep 2025 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451006;
	bh=KJE0KFXFnJnh86sHdziq8SS80Nb32CkNfUvWJCIRv1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnCF+n/Bhz/XmWUgV5DMrTwCPJnYV3bjrzkaVgAHN6BB31egQMXz4VKLSRb4BESlE
	 sNxAjzEINGq0vFQ/XPen9J6aM1dJ20Z/uZeA/AnAREwPmr5hWQhNq05n642fIHpW98
	 l0TlfOUuBKj5A13SHPiyJj7uFrc5xwAnabTN62V2lMYTPHqoKtTHmSLeoOljb2ARtQ
	 lxRnAsU5JylJ8BBqVzoxHCWatxsTmQV73+Kf8Q9BsFalAmbBacdXF7IhoSvk8xjQ/+
	 knT4kGcGg/2/uilIFoYTeCN6nyJ4EUcQLYmmymIzxlKyhjlDpbFb5QAU5PUQkjOnpg
	 4mfmQvlgv9+ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3404E383BF69;
	Tue,  9 Sep 2025 20:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/assistant: Use strnlen() instead of strlen()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175745100974.813171.15186987934449324009.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 20:50:09 +0000
References: <20250905134942.80833-1-r.smirnov@omp.ru>
In-Reply-To: <20250905134942.80833-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 5 Sep 2025 16:49:39 +0300 you wrote:
> Using strlen() can lead to undefined behavior.
> ---
>  client/assistant.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] client/assistant: Use strnlen() instead of strlen()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2efd925db0b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


