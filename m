Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707722FF643
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465413; cv=none; b=J61MluKBxpfE1zhI3kDP20P0q8yJairkwyu7jSQ31VdfmTGxKsRySwvwN8VHsMtFA3He4fooyLRr3WXlKnrTn4aht5SKXNG6Vv+gSRCGT6hYT5MoLdTkk3qwazULT0ktnHhfR16AMokFdXYqvrbSY8UeHXvItYUXAMzpy13pRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465413; c=relaxed/simple;
	bh=lodihZIwOH7y8b3E8Ho9EfF02kgAwa/HJDQ7h1hq2y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ahikr/C4pAqbHG87LiqzGim2rNk1UNYub3ihEjzBRluTMlljGI6fCQ+oFwOvFeCyq/pUhu1UjCZDRDl8JfCFJ00t4BHtVxeP4tSpJf8MdewxacjIqNlFl6lwoBqu/xq7ox2vJhjSW4qyjKLMjwQgXwoTtPQAU7L59NRHXYdqiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKbOT+7t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKbOT+7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3951C116C6;
	Mon, 26 Jan 2026 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769465413;
	bh=lodihZIwOH7y8b3E8Ho9EfF02kgAwa/HJDQ7h1hq2y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKbOT+7teEOWD+2RN2D3A8OwWK3mH7uL+mVvHPU3UpnFjM0CQT3iRJ6N2c7PutZ+V
	 tzoOWK1KQbyDxiiQ7e59iZVMnufh4JpoDWQPoNT6pUd7fUoqvSihrJk4Y2bc76dZv4
	 K1eM2pxyNTksLh8ZhZulqsMI63DE8cs7f7/W1WnPbU9OVzfAgbKPtg2rDYmqAWFEkl
	 iqockJ1MniFAGi+UtRgr/a9kE6VwuH0fy8w8ZPA769npkEm6W3g7GZ6WD8uyNb4D7X
	 J+HfGKBunqTd62YLAtoU07tGbZd5tFR3BnV9peY69MIJugjkZNH+Q8LK9f1wwvIyuy
	 +fHXKhadadw2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC78380A958;
	Mon, 26 Jan 2026 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] doc/qualification: Add PICS and howto for the SM
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176946540709.196436.16537529980820408787.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 22:10:07 +0000
References: <20260123164733.855824-1-frederic.danis@collabora.com>
In-Reply-To: <20260123164733.855824-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jan 2026 17:47:33 +0100 you wrote:
> ---
> v1->v2: Fix trailing whitespace
> 
>  doc/qualification/sm-pics.rst | 205 +++++++++
>  doc/qualification/sm-pts.rst  | 806 ++++++++++++++++++++++++++++++++++
>  2 files changed, 1011 insertions(+)
>  create mode 100644 doc/qualification/sm-pics.rst
>  create mode 100644 doc/qualification/sm-pts.rst

Here is the summary with links:
  - [BlueZ,v2] doc/qualification: Add PICS and howto for the SM qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=687c62a08ee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


