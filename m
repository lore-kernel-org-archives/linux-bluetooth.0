Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC301095B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234032; cv=none; b=YcHBaNsJcRkMGkTHIdV3ojAPsnDGI9ybstCkyi63cIizpB7wpOX28yBRidpyxRvKgs5GCzeRPTMhdUWh8Gf/c+be7zd+5CWqrnr0VpPOPCefWbx0hhpWg1Z2iq+rghuh8qFmkNrzIZnVdr+qYrHjeQk6gSGl2znBqOYd+IupaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234032; c=relaxed/simple;
	bh=VuVJDDP2qN/WsD8cADG0UFaMCCJ28hjCJAt5Qeh+Sxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJEaMxWU2y7tKqmgd4SafcKCqyBT5GaAIO98Qe5vXJftP9/L3UsMk5bJnFRjC8/wfdzsHU0VBX4Ov102MFmaO+xsloL7hAbeysNI1KoAx7pWsD1FhjM0wxH0QNz59lhIOi9+/RdgABEDGSn4zcJuQdiw5ObZ6TIhTDGDuB882Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHiRudx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHiRudx9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72D01C4AF08;
	Mon, 20 May 2024 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234032;
	bh=VuVJDDP2qN/WsD8cADG0UFaMCCJ28hjCJAt5Qeh+Sxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHiRudx931jx1/oEcEUgIh9yO+9g3usPJWcsNoasi3gkKnRiIlV2YUbwM2iawt1Zr
	 hE+TjiXKv3C9yJBuyiB2AL2LaiCgiUqUQbf2vYsPGBejCiEXJuSHdHDQiaJ3Qwid8r
	 Q5SvEFui7onzdxkNGuCq43zsxMM5QigLVhCuPBHKbY9/yAOZ1XV0Ox+QtaiQaQNemF
	 garbvZrB1OLSthH+/QoNEhVK8sQcrkKCZzF9O/fK4XpCIK3VYi5/pDIBt0h79YVoZx
	 jJ1QMrDa5W3UbNjAXx9i9Ybq36r/b3flva8kJIbCB2sHVnVrlyxkbtK63XX1XJLGl6
	 02jP6+ofwdQ3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 618BBCF21D8;
	Mon, 20 May 2024 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer
 information
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623403239.10216.12970057119968193365.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 19:40:32 +0000
References: <20240517095447.956132-1-kiran.k@intel.com>
In-Reply-To: <20240517095447.956132-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 May 2024 15:24:45 +0530 you wrote:
> Firmware sequencer (FSEQ) is a common code shared across Bluetooth
> and Wifi. Printing FSEQ will help to debug if there is any mismatch
> between Bluetooth and Wifi FSEQ.
> 
> Make 'btintel_print_fseq_info' public and use it in btintel_pcie.c.
> 
> dmesg:
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
    https://git.kernel.org/bluetooth/bluetooth-next/c/6197d390371e
  - [v3,2/3] Bluetooth: btintel_pcie: Fix irq leak
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb49bd050d31
  - [v3,3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity
    https://git.kernel.org/bluetooth/bluetooth-next/c/637579ef9271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


