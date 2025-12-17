Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77230DD12;
	Wed, 17 Dec 2025 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008399; cv=none; b=eClCVJdGE5kNnpPnV4dAJ2xYwh2vtdw8h/45X7J/Iihx9BRd1msbdnvkWkgMK3SdvPQh+W3tM5dQvPWVCxOfnCe9MOD47gc1H4SD/8Uo+TeX+VG131hJUJ9odcO9oi3+OsqzJR2vsuICXLm/sUelYgQ0Ww3v0SJTtGpTFBKqI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008399; c=relaxed/simple;
	bh=NF9M8WHnyGb3kWeDhRhO3/fw8Rso6rB0i1i/hBCdxgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iB8hE4AW8xJgL7/8Y64IGV77uL0tJREDMMUes5liWacA8t+1EFpehK1q+h6v4JIV4B/3hRDse9y/CX0MLQ237ikXwQELhBY6BpuUmvbkkUBbT6A32+pV8CfpxbfCrbgsCzsSaBuRLEXS3IGZvVEfRyChKAZ6laXZFXZdiZwjbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbP5uXQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbP5uXQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95145C4CEF5;
	Wed, 17 Dec 2025 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766008398;
	bh=NF9M8WHnyGb3kWeDhRhO3/fw8Rso6rB0i1i/hBCdxgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sbP5uXQIhS62eTM7BNHIevnb/VLY3cIYiVShDl+7dLLAR9VtptJk5McxP5djJDavz
	 RaPESQohIP+Wg52JKGkw9e3yZLah6wo80cngL9cKH1pYW75A5nDrnOcSVx1/RVaDd7
	 iAzR+BSXhtaRdSvX9kmot9QKfu9Z8Nsx8nOfia0tI1G8iqTw8LjRgowlQrIyQNiiNn
	 lbYxFhkH6SEU5EKJtQQ41Os/y8TlMpJXNUEjyOTxK96XQZ8Hn6KU1iFCx5pHO/mn+R
	 HudyNoVWD0q5qJBBKw5MhuwU59HW9IXHgkr2expnTA5XamS92PPGTmxtVNpcz0k/hb
	 JgND1POAPSsdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B82EC3809A34;
	Wed, 17 Dec 2025 21:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_bcm4377: Use generic power management
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176600820854.2253459.7299265804546328634.git-patchwork-notify@kernel.org>
Date: Wed, 17 Dec 2025 21:50:08 +0000
References: <20251210232115.547729-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20251210232115.547729-1-vaibhavgupta40@gmail.com>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: sven@kernel.org, j@jannau.net, marcel@holtmann.org, luiz.dentz@gmail.com,
 neal@gompa.dev, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Dec 2025 23:21:09 +0000 you wrote:
> Switch to the generic PCI power management framework and remove legacy
> callbacks like .suspend() and .resume(). With the generic framework, the
> standard PCI related work like:
>         - pci_save/restore_state()
>         - pci_enable/disable_device()
>         - pci_set_power_state()
> is handled by the PCI core and this driver should implement only
> hci_bcm4377 specific operations in its respective callback functions.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_bcm4377: Use generic power management
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ad59c87f41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


