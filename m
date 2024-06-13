Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275E5F876
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313651; cv=none; b=lpsnA+rYY04IhuZeW9hLAVWNTmjhp8eVqqnpBas+JBNWQHUQjWGRJwdRXbKaRmROStxJCXbV3NV9CqdvSD3xc4CqTfa6fRki8qNIws81Mf8SGfCR6VSdzua6E+xQNX8scdilk9cMC/6D2/OZqwZXNfl26/j8B3z+CFydPoqtMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313651; c=relaxed/simple;
	bh=1liEW4+KlBDVc7PQ2G4hfZcT6E/RHRcph54UvZ1dlaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dx1hoJTNHdw1eiAvuS4FYgeL49rdPSbGWfcDgHuE3i/e8tZDcjxZ9tB2us18vr4R/GldtqenKjeXsQnRgJvI0TRFWGGEkeSFwWHPfn2d5VewImi1mjhu2wm2HfVzf0y20Ozcw9zCcLlNidex8pNK0DX8nzOpRhgA2EWZIzr8t7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsskt3jh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsskt3jh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48462C32786;
	Thu, 13 Jun 2024 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718313651;
	bh=1liEW4+KlBDVc7PQ2G4hfZcT6E/RHRcph54UvZ1dlaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gsskt3jh+DB0T3Voo25GeebRt6l5KopFpGtKo0YtyTA/VimTS56Ru036Lz4kNJSMO
	 WQa2GjngGQxTqhQcBdcoCOcXW4YQADLKrD4Uw97KwRryu0xYsyi+mStEesRvKk0bWq
	 tyI3ECd1Nn88b9aBxzuYJVsRnfGspO3nBKzUuB2WdA90bI5kB4ZJIn8xfCLWVGwdRC
	 3oaImKm6btBxJkjdCaljG+vRNfGEbVX5m8y5OYjWs0JvocH2J4wEZljnljo9TFxN8x
	 SzPfIl0lZCP4YHBZ2UHky3TBkmfj1fpf6A3Quof0jEpP+uDuZC7VTNtdptxsuFKbrS
	 pS8w9ZyEOc6Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ED76C43612;
	Thu, 13 Jun 2024 21:20:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] device: Fix storing conn parameters without
 first attempting to use them
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171831365118.19058.3511430040776473148.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 21:20:51 +0000
References: <20240612191145.1379415-1-luiz.dentz@gmail.com>
In-Reply-To: <20240612191145.1379415-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Jun 2024 15:11:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some controller seems to have problems to use connections parameters
> that comes from PPCP as seem bellow, so instead of storing the
> parameters immediately this wait the MGMT_EV_NEW_CONN_PARAM to confirm
> the connection parameters are save to be stored:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] device: Fix storing conn parameters without first attempting to use them
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98676d410bde
  - [BlueZ,v1,2/2] gas: Fix default PPCP connection intervals
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b02371e2b15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


