Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD31CA81
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001626; cv=none; b=oSJil2tWwIvDYEN8lztd7UDFkiYX/WAUt9PHjDGqeNMKA560EuvkmilMacKoiG1FN39fPl07wLaFWAh7RCxssx5eXyUDc0wYa2BHx6/Hm9jK9JnNZmw7k4JB1+DkMrubELQaSbQ5FVWV739WopIR3CsgXlFmQ9hODOOhUsS/iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001626; c=relaxed/simple;
	bh=LFSKxEd8B3NiGGXq/9UsHJ1/rXf5e3v4hTa2hW1Hf3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ITbsV1RAGgnBM6IaN2spZ10CWzMbf2Aomw2l6nnB5DgHbCVZQxaGUfkh6f6+sSUnXG8j5g8PSPHQo/3IbQbrDnuBImoie6CmEdFDqma0gMM30ft1VMwbBMlgZUEwDqh/p82ocIjRLFFn6nkRoo5HMIhUHuPvjehbdDsqWCoPP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELruK3Bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELruK3Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 201C5C43390;
	Tue, 27 Feb 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709001626;
	bh=LFSKxEd8B3NiGGXq/9UsHJ1/rXf5e3v4hTa2hW1Hf3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ELruK3BkiZ0ZdJ+x9knGdKg8HgggnDyhk6LNbkYnjGlXqZMEyH4Egf7S3/0Uqk0vL
	 kuszmSBR9pIRHCIofL/b32C0orgst/ztc20o92I+XAIbdFP6f6CdZuYeYAFPq0aHpw
	 5T/sdM5HWp2Gp67Ms4NbOX+dWXqKkFJJ9O0++wp+APG7oCRmhKPRVUw7BpkVuFX8gH
	 QBl1BYUtmjOSCvq6lASdFn+TcHsnhrGsS8NIDRnlN2RAPVa+7NqGV73IPpAAEmmKhT
	 JDj+y4Q9vrKs3vWQ8BWvA68MjsV+/y4wrnUMLEP/sfrVh9xa85FkcRMvG5LImJ1NsV
	 GHeUr+YomHCnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05DF5D88FB0;
	Tue, 27 Feb 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cups: Use pkg-config to find cups backend dir
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170900162601.3237.750898026157743227.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 02:40:26 +0000
References: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: linux-bluetooth@vger.kernel.org, emil.l.velikov@gmail.com,
 joakim.tjernlund@infinera.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Feb 2024 19:35:50 +0100 you wrote:
> Some distributions(Gentoo) patch cups backend path to
> something else than libdir. Use pkg-config to find backend
> path for cups.
> 
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>  Makefile.tools | 3 ++-
>  configure.ac   | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - cups: Use pkg-config to find cups backend dir
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15032315f35c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


