Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915B158A2E;
	Fri, 25 Oct 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870832; cv=none; b=JgxJj+AqOrqdXmDiVbc1Ct2EfHI9wzoXn7QhbpmwSJBkK18QlsfZsFVrcmjlfKX5Xb4tlovQGLr6Cj5GSedlszgJt5Mf9ZIhu6jbJDV0xhx4SCOctgb+N0BSa8s05hU5IIuIxHDwqMrpvuxGi/90aV1cSD9cgiar6o3FxExIH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870832; c=relaxed/simple;
	bh=rfDs7n0OMRo6BkZBWN6gBjPhf7jqv37K9pbAlMiZKas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCHBpeNeBfpWssGiba6I+47ZDxim+FAvIgrAimwoy9ruRuzRgYsMHi7vki3Rm/0SLJIp1nHQxJ/jwMaj2UPMuEejUofUduUnH3dW5RGsLsLA3iGS0lNAxgbVSyIE++Eppz5xrr8ted7ioUF7nhJLFFKhtYKEK5P7xcKp5LkQIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqP+nC6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqP+nC6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96828C4CEC3;
	Fri, 25 Oct 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729870831;
	bh=rfDs7n0OMRo6BkZBWN6gBjPhf7jqv37K9pbAlMiZKas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqP+nC6m/pmYqukKy0B+oYpTXvh2RUI9vRb3MX5u7akofNYu0Oj/f4J+z1GN988Ls
	 5wbKuJP/f/C5SpWvmYeZZbfCzSR9QOaat1mFD08mnmks2phfqO0s0UQET4j8hZ4/kp
	 3bygZ1ZfchoIE7WFhPU6EZyM1Dfy2HFd2240kTOJJhauEW3acFrK+D0rxPLJWipJt4
	 DyWXGi+Nd3XDR2riphWauexcgIaeDMObwZNXQMNptxMXt7lqBl257LZFRSS3MajqXq
	 JUr0gqmWlizye5Ho6NTQJw0kjmazUBfwxreNkkIN8sChkvTv8KN3q5oOsbuCt8Fh+H
	 M12e9goXnGR1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B002B3809A8A;
	Fri, 25 Oct 2024 15:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Replace deprecated PCI functions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172987083849.2948690.14161816452888127017.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 15:40:38 +0000
References: <20241024111509.141884-2-pstanner@redhat.com>
In-Reply-To: <20241024111509.141884-2-pstanner@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Oct 2024 13:15:10 +0200 you wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel_pcie: Replace deprecated PCI functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/1923b289c745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


