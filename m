Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33A6BB4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437027; cv=none; b=P76l9+0HuqxhesXbPVSlvivCabKVIhjNBHqPQfhEZWDvnuDtpqWPIF4na3PxH0Tu8ROZ/7DmkAJxh4g09W8PP/cKWqrp/KeiovoqjaQd6SrJRRcbqLJPuQ08f1BrNi8VN1eDKrpeFBpEvcwmtaT7fmPSElXyvrmsBHTSKoHD1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437027; c=relaxed/simple;
	bh=u3vkkNatfvX5mSUVKOA9r/DbdsfnMgkhN3HFZJ7hUkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nYa0jYePp3455mWRrr2aCrDDmReqhjf3+KzAanGy1spQa+LqiX7zgKX/47phRJhPQv5DlgThaP568TiVyMnDYRkRdFmXWxCD04G4RqQ43ciWvqdzPZCHZKnt+xsF2T3R2I69eT640YF1iWWteY/GS71/j8iKmUrpfLmF1UuQ1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQAAs7DD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQAAs7DD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D6BC43390;
	Tue, 20 Feb 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708437026;
	bh=u3vkkNatfvX5mSUVKOA9r/DbdsfnMgkhN3HFZJ7hUkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQAAs7DD7WKPjCObqgn8kxy0vd5OcRXBAIt6+GsDmxgB7vARZ72nCXd6wXhfoUHgR
	 Eshj314tqRQLKk7A+rJf586Dgm1x/H0uwqX+N3cMWWtvffrZV5mi0dKUqCkJcchFDq
	 yifEAqCKwXYy12s9o/GyA6FcnBQJBqmt9TWZdM6bA4M0tACiWeFZuDOSdoHW1QBIIS
	 2lL5AzO2G0FNZW90i498UuFD/xR2E6bPbqr+LquxFPwSwsy6AuyDFutJkLF+B8V1Vv
	 a8r/4CeWAow8LMVJSOR1B+UgvVzSieVhgJbvtNB2CozwE1PF6utvrNWD768LHD5kGB
	 iqr3u0WT9E9mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9AECD990CD;
	Tue, 20 Feb 2024 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] tools/rfcomm: reset ignored signals after fork
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170843702668.2909.16087966923019968932.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 13:50:26 +0000
References: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-bluetooth@vger.kernel.org, oss@ew.tq-group.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Feb 2024 09:39:53 +0100 you wrote:
> rfcomm sets SIGCHLD and SIGPIPE to SIG_IGN, which is inherited by child
> processes and preserved across execvp(). Many applications do not expect
> these signals to be ignored, causing all kinds of breakage (including the
> standard C system() function misbehaving on glibc and probably other
> libcs because waitpid() does not work when SIGCHLD is ignored).
> ---
>  tools/rfcomm.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] tools/rfcomm: reset ignored signals after fork
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=854dcb7c2bbd
  - [BlueZ,2/2] tools/rfcomm: _exit() on execvp() failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f79ccf6c429e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


