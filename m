Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1551403AE3
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536812; cv=none; b=LGnoLjMtlvHPjuYupWrwPUVSbazw8nHbzdgU6KR0ULOZVt+XSYT3hi/I3I0jcpgPgyVL1ZWleEMv9xTMN6nBVPMNulzZ95s/ZowiVssazUmd85k+Rswn454zD0cCgAKCYICMJm7OkAuOoYV5DwJ5s6VoaGOoGFFeslk/WaM1HT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536812; c=relaxed/simple;
	bh=IZCdJ02U/t6RDi++P/+GX1QX72fh4fBAoPIWPoJjnHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSwbs3ETCrOCZhXlI23G2EHobN+INL7aBegpXypcMF+PZLi+ZBAlLYWPYhPXSeMpsiAwUEqY+Vzh5MJIiUK3aE2yY9eEFnZDD+nDsuiBMWgb+J8pSP2m7wRDEIp+pRmkrlkuaEBKyJkNTM74/G7H3XBVPzfxi2X95f8F7unF9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVVaI8fG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVVaI8fG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F9A1F000E9;
	Mon, 15 Jun 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781536810;
	bh=cdBgMHs4lzoa+/O1bD6XBh/EwFSVrX4NsQrHsYLW/qI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MVVaI8fGSB4zrCtMrzBsfdR0ArCCyFKfFjm1NFvpyMRbnRRbOoQNRurytSh+qy4Ku
	 uN1CUvpz/tWfBXFf7WJl0l/Ea+GHGFtdwVuQsX8K2meNa6gQA0T2+omfAvXJ6w/8zI
	 BxCaOReZ1GxxoSW/H3SnAU6JlhT8oD2syyXZblexwn09ejTr+p7LQk7oEFwpF34dU1
	 udwg13Qi3BP6PNJ84zUChFXCU7PI6XabdJl4VSWdaoIDo4OOegqw/TLYIByJSdRxw2
	 lplkw5yJihzwG5SCoW4LwjFfszJPGkvc3EAIm3qyITcAbCefLvJPTR5h0NLrHo7wdv
	 DfurWdc2qUlXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199AF3811A64;
	Mon, 15 Jun 2026 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] media: use custom DBus timeouts only when remote
 side is waiting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178153680564.3644727.16191589724334422529.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:20:05 +0000
References: 
 <499a2bfcdd6ed488104bad57b285ddc9c7788f7e.1781436012.git.pav@iki.fi>
In-Reply-To: 
 <499a2bfcdd6ed488104bad57b285ddc9c7788f7e.1781436012.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 14:22:23 +0300 you wrote:
> Under high system load (VM instance on boot) it's observed the 3 sec
> timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
> Wireplumber, as these are set up immediately on startup together with
> any other setup (eg ALSA) that may need time.
> 
> There's no actual need for using a short custom timeout in BlueZ for
> this, as in this case there is no remote side that is waiting for a reply.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] media: use custom DBus timeouts only when remote side is waiting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd9eac15a27a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


