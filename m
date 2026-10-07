Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD6287247;
	Wed,  7 Oct 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394220; cv=none; b=vFbtlgUyAONeKtc/ZgspnrZub6vVUx/t3laEJF66VM2J8oWSPQJMTvV+10CKEh+ghh9vDX9WMahfVaOocILATUjhm5p0MBkc1vAoW2n+u6AaYnxOyu1+kPPHekqAtB3pXqgv1UrJuPy1QGF9+MGCSY+DRrbC6p2Hdhnt40D5y/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394220; c=relaxed/simple;
	bh=m6ucJHmfwszGq29v35Xa4vszyDraHtDwgLbTUWHQqN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AB3s0Jq+Wl/FgEj+q+w51mKxCZwCKLTQmkJow1XtyYxijf7dKzClKoN1f4F+2fCT9vRjNd1VLXa1XA75uXTZRYU90iQrFPr0Sfnbdb8OmGGdlEkRz916pqmS/B72sADOCjbOAa/2nUE3cGt8u5NijJdUq/cCD8B4hbbrN/fm2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3DT95Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3DT95Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00761F00899;
	Wed,  7 Oct 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394216;
	bh=NHADbe2BnuO3kyZe93Uvj3PVT1JVZx+J5Y4dw5noRUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j3DT95Baqir4wRzXzh9peo2xIQ6j0auuok676zHbUug2JO8GSpFG9k4dRkpbTvUfe
	 aPROBGRMHqoT41F5QkMJVorlmxsY2FoYvoZd9tlKLXfzuON/pNpMYXyQ6/EdCCdIT2
	 noALn7N83ZJBOSQN0OaCowiOuBSETCUCCyjqc5Mot/tJOtmGWqtQ8YofESQTko7ffw
	 6WfFQ6TT2xQCHG+Coevii8sr5Z5hTlX5A+kG25D34FOEI+hoLA+umJ+tS0dLUu+eLX
	 VJUDQWgRxDf5vONVZuj5CVS2ZPuELIxUHLsFYer0Qb1WilQPC3ohd8LR6rCvXDDlzi
	 uU/lKDRgBOYtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43863808209;
	Wed,  7 Oct 2026 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: msft: Lock failed probe cleanup against
 feature
 readers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139421527.3628206.15092469243511428076.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:15 +0000
References: 
 <pm-bluetooth-objects-candidate-0233-v3-004a766561f1356a1b14@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0233-v3-004a766561f1356a1b14@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 22:41:57 +0800 you wrote:
> The MSFT data must remain allocated while msft_get_features() reads
> its features. read_adv_mon_features() protects that access with
> hdev->lock, but msft_do_open() clears hdev->msft_data and frees the
> object without that lock when read_supported_features() fails.
> 
> After a successful probe, the data survives a normal close. A later
> open can fail the probe while a management feature request is running.
> hci_mgmt_cmd() permits requests during HCI_INIT, and the opener's
> hdev->req_lock does not serialize the management reader:
> 
> [...]

Here is the summary with links:
  - Bluetooth: msft: Lock failed probe cleanup against feature readers
    https://git.kernel.org/bluetooth/bluetooth-next/c/9cb04e601a89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


