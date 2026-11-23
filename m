Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461014;
	b=xNlP+YjAXr6UZ/2eHC5N7gS3uiFs6d1dXOxwvFhB0oMYSHjCFHfUNzebgiEmqfH2VqfF
	 3mz6NHS0iHNQRDRmz5oPn4edLxtgcaGYAu9J8oq5Lbr1JdmCZxgB8VRvcLUao4pVcxDjL
	 zHw5z/RjT05Jel0SvhosiMefIaC2fh7ngXD+WTdEYEuu6XKyShXpcuGalyyKAR+tmLsbj
	 yZf7hiVrBAqxwN53V/K0e74fmosjr3FhjGkT3qfqJGOo25PxPBzMJuLhPn2NnBHPnEoM5
	 zjvu2qzX+Lkzydr3ft9hLPARBVzPqNRmLfAigWYVk2JmssFUYkYcFT6tpJVAFlwVt7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461014;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=42sdJtNW33NjnO9cdZqsVc2vMjW7WZI8+hzv0orbEpw=;
	b=phl7LXUjqzW5wxploCbOGlqbomWF8aqjccTrUxjcnfBSAcku4TeS41JxFDNOBHjXMhgv
	 vjx8ZhUVYOYOvJLwYcUYghB50y2gKA3C0rEJEfqL0d0J4iVX+ZeIqUmiIYTGQXldHDLZ8
	 QmFTpD7awjq44bGhGvctP3vkSJtBesHZ8aTWc6LWzYRCLAC+VCBQo29n++/vmVNimgUF1
	 9AgLBrZMZXmlBGgHOY+t3EX4YBA2Sdksu01+JBDB9mhPgQ8LiSAFVFFXLHZeV8Zo/CSJJ
	 2ur/TtzP4LPJmh9PmF0Dk2yK2+4ybpNHH4crnoo7VgyerPujEzxnAmTMCXLGvtwI0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqGvHStm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772A606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqGvHStm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D61F00ADE;
	Mon, 23 Nov 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461013;
	bh=42sdJtNW33NjnO9cdZqsVc2vMjW7WZI8+hzv0orbEpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LqGvHStmG7NxpcETy80QOaWTZjxnIVZBNxYwOwn3RNPkjLbBsHYnZq2n4930CvZFA
	 UsXWrBu7HRAGDFhaM5IPtX9nyAhw0WzCNo6DPaEqW6KLPCifbpYTSbedHWxZSH+hEn
	 YXwqFW17FLBPUEC6Le+faJCv8vQN6u80ps5pakwEaUTNcEZIE5zUHADOmUMPhNl2GX
	 u/9UD5kNKZ1ck/5j/AJZCsGAO6A6HeClfee/uK2i6iADWVAIkS4w8uLvIHq/KrVQmx
	 VVsB/pER94RimjD+4HikhI5UaHFEbCFta3b+HMYoPgmGWiORFmy9tX+oiV7kInyoE4
	 0LtK64//vgQow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4434392EE35;
	Mon, 23 Nov 2026 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Sync to an RPA broadcaster without
 its
 IRK
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101227.3063022.4751899348080563501.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:12 +0000
References: <20261122201333.2853192-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201333.2853192-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 21:13:33 +0100 you wrote:
> hci_le_pa_create_sync() waits for an extended advertising report of the
> broadcaster to learn its SID, and while HCI_PA_SYNC is set the passive
> scan filters on an accept list that holds only the broadcaster's
> address. hci_update_accept_list_sync() then enables address resolution
> as for any other accept list. A broadcaster that advertises from an RPA
> nobody has the IRK for cannot be resolved, and a Synaptics controller
> drops its reports at that point instead of matching the address as it
> is against the accept list. No report reaches the host, and the PA sync
> times out although the broadcaster is in range.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Sync to an RPA broadcaster without its IRK
    https://git.kernel.org/bluetooth/bluetooth-next/c/02466e0aeba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


