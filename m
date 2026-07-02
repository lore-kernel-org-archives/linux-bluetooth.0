Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DC30E83A;
	Thu,  2 Jul 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008632; cv=none; b=YD3zBbjrttGJeziqM5eiXM9Nk2v4nE9ZJ1ywD6BFjxEGG4ZGOKG/MDA14KE+0ATF2NnSnMjZX4Sp8dxvDIhQdg+vy8ZH6HLC0zl3YdIgtYcboynrUa3IPmZJtpWp4sovHMo3+Hf+2v6Y7+gxNOXfgasgnNENmehSn27VEh3+9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008632; c=relaxed/simple;
	bh=34yQyaxdwvV5yWrmYDUnT6CfBDZNe24WUr/FkAp462Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oYIJqTztWfRmmXPV7koDb/TM6+AQKqkKH7iVarwB/b/Q5txmXk+BBgrb6zEqE/UvS3/+j2OcWeG8nwpjLuABXs+BGgiXuf2rRhYZxIclEw695ZwVBfplahExcL2MtObXXb1AeeS/ed2/JJQr/OrldQiUKYbjmvLYnHl3rCZ3RvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jooJxyAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jooJxyAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043C31F000E9;
	Thu,  2 Jul 2026 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008631;
	bh=3VGnMpm6JbpeOW5HtUuNJsj+OwTlLVkCEeQIEq2C45U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jooJxyALEGIYWfJRhtg/m//8YuZCI/dVN8WbSHIiz0MXwO3Fy81a2IkaaD0RSA/Ox
	 OGRaAh2SzuRJXcrJg5NDoIGSdaOv3tkOkxxQco2GR+0K3EQvli3O+T4jOsXebcbdHE
	 o4VzMbsdlvwH1NA3ZxaFm7RXcv2C/9q/kq3FvIXDZ4/j6LaxO8//D+xQzbh8Io6i4T
	 /kJpYUA6bQsNco4eBiBL9gLuHkpyVxy7ouz142RzVL6JIEGOR+UD8rsq85zaEPRMvS
	 VQBCkgnFc9AHhyEsA/CZtUwfy9qkLKTVUXpkRCl9bi8HFmeZ6p0oqpI3NYRSe9+2Cb
	 Slc1fA/yTQB4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A033930934;
	Thu,  2 Jul 2026 16:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: bpa10x: avoid OOB read of revision string
 in
 bpa10x_setup()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178300861363.1757978.14041194859481088379.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 16:10:13 +0000
References: <20260701160614.3160448-1-bestswngs@gmail.com>
In-Reply-To: <20260701160614.3160448-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Jul 2026 09:06:14 -0700 you wrote:
> bpa10x_setup() sends the vendor command 0xfc0e and passes the response
> to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
> skb->data + 1, without checking the length:
> 
> 	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
> 	hci_set_fw_info(hdev, "%s", skb->data + 1);
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6042a966e047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


