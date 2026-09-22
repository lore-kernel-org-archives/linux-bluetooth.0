Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5099554090
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089282; cv=none; b=u7eyF8fWaAj7BvsK1qiJXhq/WM38S5KIuI/xGBaMsjL0MqPlEwf7gRzUZDRBEdX4WTGW2r/5cdE8bniM2MLAD1GaZGsW/WuTrL04kb/krSUJFteN+oERjAA/G0fXm/insM05zqKaH01K96F3ehddOrD7UAywmP2WBOn0WJCAVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089282; c=relaxed/simple;
	bh=vvo3M+oQyasOstHhlX21hyU252HO+79FJHxEUyjjGJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5VKMOttWfqxUjPUnA7+zym+ljf7AnaNmFMZBISD2sJ0GPVY7ot4W0crmTbPbdJyq8dOcQ0zXVO2zw8DFmiP7cuEBKFDiwaJpAXZKMk06qysi0eQPlU/o9I4K5Ri3TMQlGtKblJC97CDYB2ugtCZyi75poEDhx+xlSbX/7lDoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPvYVvMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPvYVvMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08A31F000FF;
	Tue, 22 Sep 2026 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089280;
	bh=yn7aVbY41Ibq0pui9j4NZSAnTGyDkuhXxPYplM813SU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CPvYVvMKH9GfGfAQV13pOAoNbN01iu5o2FokTjzX6pRJDMWo0CSMpVBbB6s6YG8x5
	 IN/nQQFFkcgQDmPYJ7Xr6i/2c1B7GRjaucVfffzbdr7eWh/DqXh45yfZ9oUZ1tPSkA
	 YX+22AjLNeZDM1BPNsmd/gU+1IGB8DTeBlUe8OVaMeSq6m21R6nfPewZuu+hlq7UYu
	 Qp+rsciWrq2eGpeK4Err8WpEJ6fDwid+mSuqZDCcYAjDZNVnX5rcrxoqW0C7wDQZRL
	 VXPif1oYYUNWZWo0tkum18KcZ4m6eT+WvUkMj/7uKj/Mqr0Mp/PxRbOxrAlujAAEPu
	 MkRUYljFUdBmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4B3811A4B;
	Tue, 22 Sep 2026 15:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: free the HCI ID if naming fails
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008921164.4126096.15229522129695848397.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:11 +0000
References: <179001656830.91284.12508704070539939097.idr-bug-55@gmail.com>
In-Reply-To: <179001656830.91284.12508704070539939097.idr-bug-55@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, lcy8047@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 03:49:28 +0900 you wrote:
> hci_register_dev() allocates an ID before calling dev_set_name().
> If naming fails, it returns without releasing that ID. The device has
> not been registered and hdev->id has not been assigned, so the normal
> unregister path cannot release it.
> 
> Free the allocated ID before returning the naming error.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: free the HCI ID if naming fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/7348abd83a3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


