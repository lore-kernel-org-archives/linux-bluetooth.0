Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752033B95E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811463; cv=none; b=CVc7wLGoHKigd+aDyEenWILyPsZeg68VXz+/C9/fWFyHiF6+zTDSJsaqHaTvHhYioptIOPEuJ7kzzRt3I3SLHQqlOKW1Jgu1HYS/17qP82phIeeIHQ2u99YfKRz4gu/DzMC7gpDKpV41fzhISJIoqCUNZz+3mDkiiI4pJx7qxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811463; c=relaxed/simple;
	bh=oAZw8u6bbX6nn5ViCgtevYml3oWYQX2j9AKKRjnHZEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdshaZ6N4K9RvsSQAMp7vKfGuU21d4AK7c/P7LF8gY3tOxuzIGn0pcl2SbVtubr4oVsu1FH4e3YOqmBRujq9hQa4U+ApfMWdOQazAVV/U/Ng6I157y8O0IacEJ1rvWyL+eJtNhL2+/tHq2lveldVTgT4jtm2tvNi6EyGL2ZpgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRE6HpFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRE6HpFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03388C4CEF1;
	Wed,  7 Jan 2026 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767811462;
	bh=oAZw8u6bbX6nn5ViCgtevYml3oWYQX2j9AKKRjnHZEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRE6HpFhjAmFeg/uwyRSpmQYQ4CDaOCyt8PGRhlK1gVClzTRw5BSvW95a3dyB2CoK
	 J1PTRY6g2fXxBUFUpoDkV5/izbIXqQ58g0/kNEVYxNEMyXD0MLwSQYO163a+ChQ3M6
	 oJLNOcljuTgQYYCrGLSuQhxxAFTpvUPaqCY+aX+f2N+DyQ+fSqXrEG2p2nSOcbjjLR
	 V09DWJOv4FS/w0Ca3Wtx8Y8eEhbdAx4dLyQvcNyEFTuc/ksTBzWbT21w/ddlO4rPK0
	 B0658AY6qWYW9AqEVT95WZpqBrzAp2oYe8ozkQdWwXnujcgehKqFBAA8MVyrEzaaqe
	 NaHpPX7UH6GrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8153A40FD9;
	Wed,  7 Jan 2026 18:41:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] shared/shell: Don't init input for non-interactive
 shells
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176781125904.2867211.5094661689920998617.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 18:40:59 +0000
References: <20251219080633.394709-1-dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251219080633.394709-1-dmitry.baryshkov@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Dec 2025 10:06:32 +0200 you wrote:
> Only the interactive shell is supposed to read comments from the input
> file descriptor. Rework bt_attach_shell() in order to stop calling
> input_new() / io_new() in a non-interactive case.
> 
> Fixes #700
> ---
>  src/shared/shell.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [1/2] shared/shell: Don't init input for non-interactive shells
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e73bf582dae6
  - [2/2] shared/shell: make bt_attach_shell more obvious
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=38ac68e23909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


