Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36C17FAB6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=NLXQbhCPmjqzOrcmadp0lz7L4c+bYp7aZcAsYQJKSDZnykUlqgykHAY9sDQIhCSgt/cXE/K5wHzQAUcflNENpu9+dpHIpBXF3tYHzaeEMZGJc+TPgOkC1tOHQj37ZDBJx1ALj2kaOW5qqDZ1j73ZoYeZAKO4puJLHH/uTWgoTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=3DnkE7GxIbJ6lXTmI8k59oyqUIfcMrtoVXImW+dOCdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iX8ifl85T9DL/q7W6jASD6mZtMsmR5v0ksmY6oJ2uQvi0SILwe6tPGsW6rVGuuDCV44AginxsSHGQjyCOnbzbYA+GMyOZGTWzULBNBPSoaFGPMjesSviQWWdRolxmRJEO1XAjtIXm3bQ9LucogcYC1YKfH7etvSRwPcqQJEvz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLY8NdIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLY8NdIA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8361FC2BD10;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=3DnkE7GxIbJ6lXTmI8k59oyqUIfcMrtoVXImW+dOCdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NLY8NdIAdnJEBg7Qlql5TIFdWaIsAnhjYTwcJnEV4utkGbFv8GBLR5FtNBxu/UMAK
	 4/wk/dzcf5L21zkktuLvVdq+4+X5ot3w74myAW5e/vronDTTa/1WdUN4u67KQCIzfZ
	 gTwZWSCc3hGZvmKWI8isi6CWJQsxlg/XWSNR3lko+RnJz83VJdBhO/u5XImwunXrGH
	 w1MHNkVezyD+Ka9zRZrpF6Tzl5PWFmXJWZfHRt5d9j+BivqoWTL4MoFWY9KeMb5SSr
	 nUCbCKXYga0Kalr6GndPO1JZCriYnaB5QuugqB3MDKCDVG75laAT6QJkEA+FQJhZaL
	 CthbWa4gdXMLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78415C43446;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/vcp: add NULL checks to
 foreach_vocs_service()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943348.18626.10927362074373630661.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702084907.26066-1-r.smirnov@omp.ru>
In-Reply-To: <20240702084907.26066-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 11:49:07 +0300 you wrote:
> Make foreach_vocs_service() safe for passing NULL pointers.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/vcp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] shared/vcp: add NULL checks to foreach_vocs_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=176cf2e12a28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


