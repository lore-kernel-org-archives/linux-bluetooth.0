Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD20289E06
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619418; cv=none; b=KDMgp1iplcCYNwIbNTF6UNDssTb3MJDRvDVyQuXbGGzZfWGlR7OejCFrjoYWsPse2DMJzcGB5F7rcyT8CjrtNmU5bkMTS6Lu8p7NIzHsIyvtFtV6ppXdKYFErykQDxnLDF5Pqk0UM/b97GAE2MeDsAxsiY4mlHVKHLn15Xju6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619418; c=relaxed/simple;
	bh=PqWmiJN9or0VcWa3M9kFvl6q+8CtzhfgxLILFwy3A1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RW1sxdwsKfW8dKxovHS2VIav7UTk5F2iiQ0K5Ox6Yr9h4nNJ1OckU9yHOieIE1fCQo46qhbIvhVFTv43pmS/kbgOul9zXnFVmppn3jjBnCxK45udt1eZVzqKc4+2X5YR3jkXEQJi+9tuptYlvX4AsAlxMWGyFZ5/SNQXhkoy68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3HV/2eI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3HV/2eI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4470DC19423;
	Fri, 27 Mar 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774619418;
	bh=PqWmiJN9or0VcWa3M9kFvl6q+8CtzhfgxLILFwy3A1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R3HV/2eIwhhV5QWXmgBDKURCUKC/b1yKEpB7S3ImxQWA29MOFVVDfKk1YrbGQJKiD
	 y6/EYpIxc9kI5si3Dw8PngEQ7QEqocvVXqyfcAx6MvAfTAnY/IpBG+6iGAUyPzH084
	 m/+rb8RvOaKv0l+Fva45SW9usdChYw6mrZi4A6Msk6XzvdbSMMs3c+G9szZtrEPTbf
	 8LYJdhINBQZ8oXJLtysRXUaiFfoxiOQRcXCTKPFMCF5wxZoMdHUDwrJgvSbRSikEHf
	 dVCVWb7sPqPTMteZkqBeXZweDC2UuqMqaDt8NwH2gSwlY85kcdNYVfGnVGs+T2tUt3
	 rePg2FHCwF3hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8E3930231;
	Fri, 27 Mar 2026 13:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Document bidirectional (Source+Sink) ASE
 flow
 in LE Audio
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177461940429.3494631.8643684211947461060.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 13:50:04 +0000
References: <20260326220634.923877-1-luiz.dentz@gmail.com>
In-Reply-To: <20260326220634.923877-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 18:06:32 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add a subsection under ASCS explaining that multiple ASEs with
> different directions (Source + Sink) on the same connection is the
> standard bidirectional/conversational configuration.  Document the
> direction indicators (Receiver Start Ready for Source ASEs only),
> a typical setup sequence, and a note that this is normal behavior.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] doc: Document bidirectional (Source+Sink) ASE flow in LE Audio
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8ea1d0da24ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


