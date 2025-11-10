Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEE2E7F05
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806042; cv=none; b=KFDlvY4cwWhNtzCb08L7al91ppAEj0O+xfRvx7czWk6ZQl3KGOY4XAiQzhNvZ8KIkCUXAGfeCsE906gKvVcuZjtODHgBDoLd/DMWUEqowjnQN6DDl/l0QwRGsLIsGqUUCzeve06Sg/XNVSW1yEkJRi6N9wsieP4DAyhB4NomemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806042; c=relaxed/simple;
	bh=8f7XgQm5JdKcoAOuFHlBNwOP9YzEAu6bjz2StQR1KyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cyGgy+KBxlCC5ZAztcQN9NaRF+ogxSj+PTF6//DRv2K0f29+pQX/PuhSiSSdMChUC3/gGnlA+WUoC1m1ppgYBhFCz0H5e4GRPeB4PMQF2V2/okthpDLxKrH+NLLQOiNxsZhU7evR+lrXlT0CEu2Ptm6W9tXOp+jAm7TajJRyojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/qYa2uS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/qYa2uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD7C113D0;
	Mon, 10 Nov 2025 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762806042;
	bh=8f7XgQm5JdKcoAOuFHlBNwOP9YzEAu6bjz2StQR1KyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/qYa2uSApAv5tecW39UAqJwHHUR+DvXa8sEkfMZ2RcPv8LCuAXS/t0a16V4N6EqX
	 2ktkF1ait8dWWg2ONhHMRvbAqbOmzCc4XO1Hn6qxtNbINil9QhEALgYod/sW5yAKS5
	 NbJLf/BBwmbMXrizFO2kS+9UyZ5dYYbbPZpKuDCXh6+u6oMlV9AsOnCMT02Xfr54zX
	 WXeMrFnYzWAo9EXSDXRfHBAZ9bQFtObR90ZPDStYUrN897lxQZIyv2XemZAI6ElAcw
	 aPrzhLcanBcYr2cxKJQOrVrThpuvIHDP+s1agfB9RzpR/JLkw/XyWpDUGspfA+Pce6
	 yoU7R/YaD3W7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC1F380CEF8;
	Mon, 10 Nov 2025 20:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix keeping PAC caps <-> metadata
 correspondence
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280601274.2762084.1037274205341699427.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:20:12 +0000
References: 
 <ca208acb9133b0bae7b2134313a05d68036e6ef9.1762691320.git.pav@iki.fi>
In-Reply-To: 
 <ca208acb9133b0bae7b2134313a05d68036e6ef9.1762691320.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Nov 2025 14:32:26 +0200 you wrote:
> In PACS, Metadata is associated with a specific PAC.  bap_pac_merge()
> mixes up metadatas from different PACs if some PAC has no metadata.
> 
> Fix caps<->metadata correspondence by explicitly storing 0-length entry,
> instead of skipping it altogether, if metadata (or caps) is missing.
> ---
>  src/shared/bap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/bap: fix keeping PAC caps <-> metadata correspondence
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7b0f2355bb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


