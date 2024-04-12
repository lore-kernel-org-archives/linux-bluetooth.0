Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67554145339
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933429; cv=none; b=AkR0mA5hzQ43tDLFvXVWKua05fw+zVzwo6ara/VbOS00DxFvLhp83Jpi7yKJQt60xduoMWhi3dfFguuFIcoKInSZUOMdzyAGoCToi2DFk0WVgf1aI+Ajc0WAdoLdgiR1ICxkRmgzCcDe+3Wg2iwXNI+248BFyIyygZj+Ka6q0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933429; c=relaxed/simple;
	bh=dJ1kBQo0vIhiGLGUWWyrw9rUCf0g3ZN2t0PTbYKuLPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+F8tKiwriBblqbo1ro4TZsi1+YnmkVcNGZEJyUJ87CrCsk9ujzx0l9bX8rf0DhI28zmVVvlQbOeI7juR9rygZ7GUzAKpU5BPvB/Cv6vZhBDYsgHTBnyI1Am5ASS5HbVOb28izAiIxk9NocaCBqnq6EB0oEOHF2wOXYBoMdgKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI8RCZ4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI8RCZ4t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07E7AC113CC;
	Fri, 12 Apr 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933429;
	bh=dJ1kBQo0vIhiGLGUWWyrw9rUCf0g3ZN2t0PTbYKuLPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XI8RCZ4tBQxWGFRAR+ZhRFqMd7P3/FtO9CKxi4Otb0WZDbEIYA83ATJ3vemKL1XEb
	 YIZbDzQPMcloSphyu+x6HrXeF8xQW7GditrcS8nf3WLSJvYaJsiZa2FWbwIMBXhxcj
	 4hC/J30v55HnDJC5ZIlxAhuGE2JIYEAM0tk0AxTj9yvY+psiDM6h1ShEIvOKqM+v5E
	 4RI95SE6Jq08TcTqFgFX6yKEOlqLKLl9z7cPDcrgVIYU3sHItaozu5TuV9/YiQPmZg
	 j8Li+oL7pFaaWBxCTgOLjL1S5uugvf1Ynmu32kOclqz6IwyUTt/HgZJOVq56THWJ2l
	 TJNGx/tDu2SNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F34B0DF7858;
	Fri, 12 Apr 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/4] shared/bap: Fix not updating location
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171293342899.19443.3273017720408697686.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 14:50:28 +0000
References: <20240411200305.183703-1-luiz.dentz@gmail.com>
In-Reply-To: <20240411200305.183703-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Apr 2024 16:03:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Fix not updating map.location when selecting.
> ---
>  src/shared/bap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/4] shared/bap: Fix not updating location
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be79cd19c5c5
  - [BlueZ,v4,2/4] shared/bap: Make bt_bap_select fallback in case of no channel allocation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7dcd064057f
  - [BlueZ,v4,3/4] shared/bap: Fix not resuming reading attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7db85520b76d
  - [BlueZ,v4,4/4] bap: Update properties of endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9be5d8018dd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


