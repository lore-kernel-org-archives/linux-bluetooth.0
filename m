Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332A2DC791
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020396; cv=none; b=prqstU6Ya1mEN9qJpbqWwsSUqFlF4kxFvyi73GQ04U2VsPbpsr2A9DcwJ0MpYZSx4gcn+PT8ptG15v0BT1zrCpl6SEw/4B65K+vH/U6z7p3uR8x6LnURsrksFDAv9o0Q5mMYbp3SdIM4fAyMVjCRHyuN0ooKbrUJ27cQNIj5JVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020396; c=relaxed/simple;
	bh=iNouddO6ur3jqztHyY+VLjEdMtWpTn/RQ8V9QBbwHJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghged27SWg1xUVhgfk09HzVr0wzHuro/le6cvPl3fEI4aSOtx9KSrpnDTAkA0YK1OriDOujAGutEsoLd7hjt5NIWyGBZS0ABnnqmcXteVbKI6KX+gFtesxgGzHlSsUhtr8N/YtX5n+t67i4Mbid/OTVppGjWFuirynH75wW136A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdbj5CBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdbj5CBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A600C4CEE9;
	Wed, 30 Apr 2025 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746020396;
	bh=iNouddO6ur3jqztHyY+VLjEdMtWpTn/RQ8V9QBbwHJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xdbj5CBrw/4OUzJEWc4HnjRwjVKqDWJTBsck2cBku71eFpbOGUpRNzS4kdGgdIuME
	 oS9uyWT8LJG2q5NJwxq83CmcWpQcT8j6RQvhWrChIa4i+E2EkzF9PFQipleHefnqhp
	 PCru56aGcbmVI+I0FPu1PS3yDfMC11LXAuyNs49P9bnfGb58Ehu7NobQl9VYquc57l
	 shU5D6VXOIbp1p7qXYSPvjX4pJk8iOKykzoiGKn3viZ5M+nkt/IibSvnVW5Qc8FlPB
	 iN5e3TdwWbdluyjZVdt37Zx00BBJX6iaLNwKdyU+rENl42bU5qul2Zs5kbi5TnjExt
	 aVZ7wAQC4o7Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE93806642;
	Wed, 30 Apr 2025 13:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflows: Add codacy action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174602043498.2366402.13580831276100650540.git-patchwork-notify@kernel.org>
Date: Wed, 30 Apr 2025 13:40:34 +0000
References: <20250429221215.2253885-1-luiz.dentz@gmail.com>
In-Reply-To: <20250429221215.2253885-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Apr 2025 18:12:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  .github/workflows/codacy.yml | 61 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 .github/workflows/codacy.yml

Here is the summary with links:
  - [BlueZ,v1] workflows: Add codacy action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b6c096fb859

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


