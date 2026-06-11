Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA63466B5D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203808; cv=none; b=UuLDAAxN4br+C90bcyfcHvFcSNO30wmsNbVCfMZGCgjSFq3IpVXjXeNVa29qSOM7swZVwnqbnaha7PEO6Ty5b090V6rMTkzqdMOn8ixws9C/BjUtzbXLUF5yDNfpyG/4r4q25pnUeGSx0V1OPMdPk7bUTU/gxOLwPQJI5mcj1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203808; c=relaxed/simple;
	bh=MQX5nRqkCEWwr5uiq7g0nWYY/8eIWlb8BwEfWaPaRr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mPJ7N1LRYXXT/XYrTHsoOb4BxzmMwS0a12dg6HMZ6lKiGmL2hjFPNwbqTwY+eFvbT8J9o/K4zdd6gyoU7K8z6y2idOzgRM36HioGQXGLMrzes9O1g8gZbUI8wngcxQsdxO1uxrdMkw2qVT3lSOetfHyKWvRJrr/OHVNe0q3Ldqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Jvpr5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Jvpr5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946311F000E9;
	Thu, 11 Jun 2026 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781203807;
	bh=B8FGsQxy6m8PVYvX8sfsrJNjLfi2Jr8yvEtSHEXDQkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z/Jvpr5Z1+SseyCU6WcgjF1XBDjFmg7QqzCZnEio1Lio+xRQ077AaLeVJHD34/onZ
	 cLvGd+FetQSmeROry/pVv0q874tNQkYziBghlFRBmO3vOkw+93SBhG0k/A3SC3EXpk
	 1Z4aB35SRhjAhsYl1v2XzshiD2dekqcghk2/kmoW4Xy4H1nQ9k8AMTptxAR696ZQWB
	 ifgl3L2ZoNKNrO7fQB235MrXsnvzVCSk/7h9H887Q9Z+VBLCXUQFOeLmXuuLa8e6MJ
	 5UmJKVcEvK+MbDgZ3H4C2qzm4zl7Yg81LCaZevllBpaDgILIndIvTtQU/ajC19YpRH
	 Rp+s8Y3PzwKwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EB3930F8F;
	Thu, 11 Jun 2026 18:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] profiles/audio/bass: Use BASS_Modify_Source
 when
 assistant is active
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120380489.316377.5584335188823871722.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 18:50:04 +0000
References: <20260611172235.92930-1-luiz.dentz@gmail.com>
In-Reply-To: <20260611172235.92930-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Jun 2026 13:22:32 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When a MediaAssistant is already active (streaming), a subsequent Push
> should send Modify Source with PA_SYNC_NO_SYNC and bis_sync=0 to
> remove the broadcast source, rather than adding a duplicate source.
> 
> Split push() into push_add_src() and push_mod_src() helpers. The push
> dispatcher checks the assistant state: ACTIVE non-local assistants and
> LOCAL assistants with a tracked source entry both route to
> push_mod_src, while all others proceed with push_add_src.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea6b63562d9d
  - [BlueZ,v1,2/4] profiles/audio/bass: Handle PA_SYNC_NO_SYNC in handle_mod_src_req
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=590aae8b6950
  - [BlueZ,v1,3/4] profiles/audio/bass: Fix delegator reprobing after disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b0c20727569
  - [BlueZ,v1,4/4] doc: Document Push behavior when MediaAssistant is active
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40f2e34b3739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


