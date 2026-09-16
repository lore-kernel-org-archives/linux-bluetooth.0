Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762014B0E30
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583526; cv=none; b=XzKeFXzO+m59ae6pIGQCGzopB6mp0SZWq0GCTW6McrIi4DCgzhq2AHZf0DBYBsrTTGJlxuvd3mL+KFO2pqov3PlAE322pukotnxc9dsMzIRWVtEq0723QlgDANoJ5QiAZLZTS2/6NuWClUO2ByPxBMdw7R143pP1HcAtCPt2W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583526; c=relaxed/simple;
	bh=8mGfhfE81/bje3UEmZa7LrQdqn+3wezoArROfGNU75U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fl+uhlq+yzP6fIjx6diNSsS1a4uW0o1Lm1tybUYrE19w0D1eQuc7KRoXaChW3cF11eAb/zXQU2DWufPNPW+czRQQULN3bgXre87JgZ0e+orTdby4AUo22BtOnUv1kfhXKhKDXTrGKj1h3DeI1hMyMvGtNRYL93vZlenYoFNrUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhw3YXSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhw3YXSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506D01F0089B;
	Wed, 16 Sep 2026 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583474;
	bh=uGEVCii3BYxk8D+QV547v8bS6Y6V+EsK1ZCdD4nEOn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fhw3YXSqEP1e7SdRH1joRSLIv24Lc1z69mo4hhCvCwX4dFvUCznM+KPV6EC8IQpoO
	 iu8HXlmxTZOYFroCP05o/SzRUEI6qtv36OmmedIxBKIsYBvSEvZXvpG3Bmgkpy+6QE
	 xL2TufK+4zzjk16UEk4rb51M88mKs2cbNmeilzhKDR74vgEtW0azW25bFmc/8m2ahL
	 7SzTNRh3OzHo8KOCpydf10CNbrmsPlvd4RA4W423sQh57dHrzB27SiNL/vRcNTnRuj
	 lFeKf11l6Myd8QA95knu1ZsPc4nLscgx35mheh7FDKcBltK7Bkc26v882VuAoSAbCp
	 ghy+nPrRs5r3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BDC39E8A52;
	Wed, 16 Sep 2026 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/11] Cover a BAP stream to a coordinated set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958340812.3229304.13270316680740973228.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:30:08 +0000
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 17:15:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These add the functional test cases for a BAP unicast stereo stream to
> a coordinated set of two acceptors, one taking the left channel and one
> the right, which is what a pair of earbuds does, together with the
> fixes they turned out to need.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/11] shared/bass: add a ready callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=825c98da2a69
  - [BlueZ,v1,02/11] bass: wait for the session to be ready before pushing a source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6eb23703b473
  - [BlueZ,v1,03/11] test: functional: report what a test is waiting for
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=915926f516bc
  - [BlueZ,v1,04/11] test: functional: answer the notification registered by the victim
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1130406008a
  - [BlueZ,v1,05/11] doc: describe the BAP coordinated set test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8da79557195a
  - [BlueZ,v1,06/11] emulator: use the handle of the receiving side
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ff7deaf8c90
  - [BlueZ,v1,07/11] emulator: allow the maximum number of CIS of a CIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=526befeb949c
  - [BlueZ,v1,08/11] device: keep the long term key of both roles
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9251e630efdd
  - [BlueZ,v1,09/11] client: allow a capability with the auto agent
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f9cb900d471
  - [BlueZ,v1,10/11] test: functional: fail as soon as an operation fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12b85dddb26e
  - [BlueZ,v1,11/11] test: functional: add the BAP coordinated set tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1566fd5568b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


