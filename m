Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECB0393DDB;
	Fri, 10 Jul 2026 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714236; cv=none; b=B5S3ENT7p5TRvarN5GcIJp4RE0pf9MQMc/vUdKgg78X/dvS8eGUVlvWIxtCUMkt4HsgiOl6tmMc1m7AI83BilzXSwZ6uBiPHrBsuF5pyLMiZLsCLbCiNNkhLTVJGrLPhWO5Q06x5i+y5WSYmRWCKDti8PPL+DgpZZUP3/hB+dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714236; c=relaxed/simple;
	bh=5hS/lFtichyY25IOMMNO6IQI2NOsQSO+aFUW0SlFKZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QIqBNnPLXSYf89kvYYAEZij/wf2E0SnCry0xemWYEoGxiCmR3Z0bzkTk1R1YcGXRKv0uQe/pQDIIfPp7KWmAWlhq5l9tIT9uja5iSvDOusi+cdJqq2e4qq8S/5MiGGiZtWyGXwaACa0nE8zMIaLVA0msWlrENhPY8HhOdG3SQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFfGxrCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFfGxrCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B671F00A3D;
	Fri, 10 Jul 2026 20:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714232;
	bh=M44UXcQQRcF/84gd0t9fyGn2PrUZ0kOxcSElvzgxNo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CFfGxrCv3s7yINRD9D25e4EgHGuhEwP1+Ab9IiZ2Id6GjAYnji92phQONmXHpxKm9
	 v2i09Pb5vC7f3+nZNAbfaQaKUwKwyRdJdr072QBX0gOgBN3fP/cESrz/2wCHzP4Qsd
	 04f8AtmvcuaU/rCRBv4QDmFmlARTtO7UVU1dDx55rb1p8OKjH5DnKIcnL7C89Zq+U/
	 /1hS7ijTnZdk7DFLy8eY2EpTMt7lNGeBPOEx0jqNRiwYbFHfDnL6tRFKML7G4dKp1t
	 piKmyyDYzNlAgAYyrBV26uYa8TzNoF6ykWr+b+IUrT9eJx7Np37yja3ByI/ISO7MhI
	 Pyu5JCDR+rqKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D83924680;
	Fri, 10 Jul 2026 20:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] Bluetooth: fix hci_conn lookup RCU usage + holding
 refcounts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371420988.843459.3249429975264970198.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:09 +0000
References: <cover.1783671570.git.pav@iki.fi>
In-Reply-To: <cover.1783671570.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 11:23:39 +0300 you wrote:
> Resending parts of
> https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
> plus additional hci_conn_params usage fix.
> 
> v3
> - Copy params->flags in hci_le_pa_create_sync() to reduce number of
>   unlocks in branches.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: hci_sync: extend conn_hash lookup critical sections
    https://git.kernel.org/bluetooth/bluetooth-next/c/17f5bfb02164
  - [v3,2/4] Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/f3f75fd597f2
  - [v3,3/4] Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
    https://git.kernel.org/bluetooth/bluetooth-next/c/137501e0242f
  - [v3,4/4] Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups
    https://git.kernel.org/bluetooth/bluetooth-next/c/b755b4141c64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


