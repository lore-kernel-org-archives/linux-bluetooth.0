Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEE193459;
	Wed, 10 Jul 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620631; cv=none; b=ZuJnTBUhc4HSgIMyjoFSWNi0FaeFoSkG+0YWhyKoI4gqovAnRDUsluipkQYNRDFFULt1Z0uo+lZoRqV1RoUhiFNRDZE7qpnRT+4hHERHBNUAbwtpZiCzRp9RTTQANNVcGdKciHXjB3So7uMoeutMqhoVgfRsbF0zKux4XrFNTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620631; c=relaxed/simple;
	bh=2eKmmnMtBeoN42PJzxHkZzXIdXnivrGPQNFR3kqUCgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h5GxOmpnGxxCHMuGcrVtXF4d3H7QuN8zg4JdzxSyB6PoCYnW5YW66afatcVCFMx/MWqm6icsk07VcQBDzJ7t4BiRlgFBLeLtjyus9on+yMoSHPyNWgv2QpHoyQd2x/F934cMydpetnnje0YqzP+rO8N3VW3yaV9lEe5DSDtmhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZKZG5Ar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZKZG5Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66818C32781;
	Wed, 10 Jul 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720620631;
	bh=2eKmmnMtBeoN42PJzxHkZzXIdXnivrGPQNFR3kqUCgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KZKZG5Ar4HsSko0GDS7NrAmFQyToKD64BQSuf+r+sQAG5hMJ0JyWOWuem/3fzSB5w
	 r08ktdzzNGyLIgBDOtW35vkJhAYY1MpHES7X4PqKasLy8tXz2Baqi2Ui//3GY2ZhRY
	 KvG+vcO+tr/vpmkUxZlrkW7oXdgaUbjZrS9T9Fk8/Uc9am0K6jVv2K0Vt9FbZFba2d
	 IBGA+ywwWbU/pDkjbvORx4pLol5IxQZPslxylE8/fbc5o2D5UG7MlEMfcXiAdia0cl
	 sm9oNSnRSX7+Iq6aMs6CMAng2GmtRUQ59LXG0/udJDL0rz+dlIKe6KdW54cZ3uUNTC
	 unuPrID4eHBNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 552C0C433E9;
	Wed, 10 Jul 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Fix warnings for suspend and resume
 functions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062063134.6722.14353003118029390627.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:10:31 +0000
References: <20240710123426.935122-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240710123426.935122-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jul 2024 18:04:26 +0530 you wrote:
> This fixes the warnings 'nxp_serdev_resume' and 'nxp_serdev_suspend'
> defined but not used.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com/
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/d752881e4cd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


