Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0F32A3C9;
	Thu, 26 Mar 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549817; cv=none; b=U+UN+bJgSU1v7HUHzAqfVqLO3D5+ErITV+Sr4T3n3sTosw4gW1nEGbJFpEwZ++AUJC4tCza67En/e3jvah39UeN3DEkV3fkDjHI/8n60Yqc/3VZRzCVNaxciVt2KnIZNM43V+GNcUgoHONowjcGo3gr6aRlv3cojT3vFDHxmVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549817; c=relaxed/simple;
	bh=CJDBVW2U4sv2o01Vi6aiuuDTbjEI6aNrrdWDDPvO2J0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=domfVRy0JKNs8U+dAABfIGcuAYfrdm8ezQLX8rhtJe6ygbB2DbgXXZrytPXduFsN4oZcilbacRkk9vmy64jpeO+YXH00g0x7Q0Ttg10TXReg2fS7Pu3/YEWqOfNXt7DqFKL69A9MKFpKbXWMK8BtiXZmCrAWMAZ4c02E+C8PtZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNss0b0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNss0b0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C09C116C6;
	Thu, 26 Mar 2026 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549817;
	bh=CJDBVW2U4sv2o01Vi6aiuuDTbjEI6aNrrdWDDPvO2J0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNss0b0a88IKEk38Rul2kl1OfY6Zv0iQeZz3aJDoq7IqS4zHg3Zl/w4GzAW3XwW/C
	 w+/90mLOCdbDNJY6SWjcUVM9JhXiUoia1lm3rRMW1NMgA0H/kH8MAIGrHFtQkDJtnH
	 bKNkTXV0/C9GmILLdaQBl0XMf3UxnQiomJVxDZRzAE5HMV64Tm7UAVzRZYSb7rS6K7
	 ozIAJjVeqRclG33UpvlG6u576iCKvlotJLKYn7m1faSaqC6KCoXIu9jJjZKs+5JJQ3
	 KGxAKqcLhYIoNPPrhQ9tNGFXLxdRe8tw5c9IJD2XmJcMqvstFZsbaMSPz2V0OM/llH
	 1tBwwXX5Fmu3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2F39F2038;
	Thu, 26 Mar 2026 18:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: clamp SCO altsetting table indices
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177454980404.3124616.6009875334842591779.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 18:30:04 +0000
References: <20260325004245.42452-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260325004245.42452-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Mar 2026 08:42:45 +0800 you wrote:
> btusb_work() maps the number of active SCO links to USB alternate
> settings through a three-entry lookup table when CVSD traffic uses
> transparent voice settings. The lookup currently indexes alts[] with
> data->sco_num - 1 without first constraining sco_num to the number of
> available table entries.
> 
> While the table only defines alternate settings for up to three SCO
> links, data->sco_num comes from hci_conn_num() and is used directly.
> Cap the lookup to the last table entry before indexing it so the
> driver keeps selecting the highest supported alternate setting without
> reading past alts[].
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: clamp SCO altsetting table indices
    https://git.kernel.org/bluetooth/bluetooth-next/c/08a198361071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


