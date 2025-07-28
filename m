Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D853274B5E
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727989; cv=none; b=NLLdOPCAy61Vd6TsTor7/lf6ixTulO3soinTU9QIHTGeChIqMme1NyQIL7T9++LBWIR2N7nZFMTut0c1u5svDZv9fuMGqZ5u1/5SjVnMMxhnLXZZI5nWuwFFT5DUP6wDA0Lm8fnL+QfEF2pfuaNEAWVCTftTS1XLqyl7PTvwKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727989; c=relaxed/simple;
	bh=/q7W09tIXeIg3RuQAh6Kngbbq/5bYMMI8MEXZa46doM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X1c5609zM2ETaNTHpDlmp4Yr9K42cf3Naz8QzhqAzLPUWnTl5r6Fo+8bBTeNSuphtxM/IZ3zVwf9uguIxqXtLhwcG6iXzj3z57ORLA5PM87D1cd1la3MX6ZvHx9OhCdmHu9MMq/ngVOSrhT1azfnvoVr9eRJu4qsr86vC0ahHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiiEeicD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiiEeicD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23919C4CEE7;
	Mon, 28 Jul 2025 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727989;
	bh=/q7W09tIXeIg3RuQAh6Kngbbq/5bYMMI8MEXZa46doM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qiiEeicDWmfUYNF+PryO/PF5Scm1Bj04nc6rdm1VS1QsszFX050NhWsuBo1eNNoTr
	 2MwbDG/xxhszCxVclrNrIjmkeNw75NwJekMj7CJsglg4pHbzdOkcMdiJoMSrvekSsb
	 mTPrkwjvJjFpotcz6kt2rjn/uauu08ULLa6teSv6XWw+wYXyEpUwqxvtX4r3pqygOf
	 5iZlfyxrtlEjsYo535PtsE1gUcKgIbUgh012sKmwENbCI2DfQ6DqDmBja5KBYL0CD5
	 YQsgv7fk7WqLiM9SGEt+BmZLKM5y+08v4vgNyCdfcGCHn3Iuft8WfXg25Tt/yeSMBM
	 Mx5vY/8o2IlsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB024383BF5F;
	Mon, 28 Jul 2025 18:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: btintel_pcie: Add Bluetooth
 core/platform
 as commnents
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175372800576.807848.10424329858902826241.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 18:40:05 +0000
References: <20250728090554.1425120-1-kiran.k@intel.com>
In-Reply-To: <20250728090554.1425120-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Jul 2025 14:35:53 +0530 you wrote:
> Add Bluetooth CNVi core and platform names to the PCI device table for
> each device ID as a comment.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
>     - Update commit message
>     - Include reviewer name in commit message
>     - Include the complete platform name in the comment
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as commnents
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca4d74a68c46
  - [v2,2/2] Bluetooth: btintel_pcie: Add support for device
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


