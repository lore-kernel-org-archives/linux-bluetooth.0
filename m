Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4314B970
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260626; cv=none; b=KFcOyWP8GOcmEfZXlzDGLydFLfBMk2llppakuEL8CuCstso1L2ScB4V4dl/WbppmsplSe468CunMhMUwxa87hg79LdSxc+GciKTGSaoCmBWCgbHqtg6p6q4s1y8gIGZJgHVTs3Bigs25Y8dOghS3XfN9VvUzKIDHkmPGkJ8G2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260626; c=relaxed/simple;
	bh=YTZn1QJr8fFFAri1pc+DKRM0urh3hZoHwIMSgxqKWtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ag00iPISgZ/cLT+TmNXefkZOjFhB1JDqcrWB9heWB4cEbG9I/H2sLYj7kaEb+VPEEVOFWHQfmIQsw1mj1P9S8w8bQPRILTG2pyNlucsAp/xCAo/braGXyt1/hHkipiWF7xfYnjsgAj0FfDsVMx0o/ZrM+gBlRdpqmvH/C12N6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOxoIABi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOxoIABi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6897DC4CEC3;
	Fri, 18 Oct 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260625;
	bh=YTZn1QJr8fFFAri1pc+DKRM0urh3hZoHwIMSgxqKWtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nOxoIABiZ8zDw2YwgZA0M3R2Pa7HRJ+ctsk5V67+tiHP7mQ50jOnMaDNWCKu7flks
	 /lMQ24XoyFOs0Kf/f/XgygVDgHtdpeaHaii7p7yapZ9q2fazfrWhjvLQCTvLvGSO1p
	 Xue4T0UvhFlwvIM4UTspRl2HhXOBZ07dGNmVNrT6Yx5NFX4gYoMkZXdjLtzmGfDzSn
	 eZsHnuA3TKNfk+dvv5QGrsXMoEBKNlxjSupOLNco7tVeRyNdzJLoZ1bO9HtqxuiD3N
	 jZ6en7NM+BD9A8bh0i7kGnzRbSIcN62ZXHOUP7rXi4xZV+KkoMdrui9eT7q9+unVe1
	 M3YXqIVuuB7HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ABE3805CC0;
	Fri, 18 Oct 2024 14:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/shell: Fix not handling prompt with color
 properly
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172926063074.3127332.12356290516129793312.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 14:10:30 +0000
References: <20241017144002.941979-1-luiz.dentz@gmail.com>
In-Reply-To: <20241017144002.941979-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Oct 2024 10:40:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Colors use escape sequence that needs to be enveloped with
> RL_PROMPT_START_IGNORE (\001) and RL_PROMPT_END_IGNORE (\002) in order
> for readline to properly calculate the prompt length.
> 
> Fixes: https://github.com/bluez/bluez/issues/965
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/shell: Fix not handling prompt with color properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee6f3a837e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


