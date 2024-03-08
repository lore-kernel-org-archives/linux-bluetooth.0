Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065425753
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913030; cv=none; b=oOBR2GfXhHgyMjgpZwjXmOSZMnDP5A95c5EHqrSC6179lFZaeh5DNucCELz6NzSIpLrzz5oxv0G2cW67AzifIbSpp3eMp+KmEnc3W5PNg4XC1D7YfUaGQnE12RuupUjbT1uVUQTrYdZTlcpM45VLPJG45h6UvEKSyxYNSD+px0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913030; c=relaxed/simple;
	bh=Fjdgp4zTqQXnQHmKYbOl5GRwBd0ON5t4ZWgA4tZ/nR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FiiHmgkdtBECQt/MP3Wdmda6/HRrQCtyVpyrrgK4G+wl/qXmpkNSJ7vrKF8RTKlow+LfRE/AX77fZDn+7s1DoOKWHgqlzsvYUQVAUfQBJBD+JZBGKkx8u0TPTfBEX8bCCpdG07BrIe71AW98+/mwc8D9gWfddYKl9JS3s14qDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHAqiczx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHAqiczx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA509C433F1;
	Fri,  8 Mar 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709913029;
	bh=Fjdgp4zTqQXnQHmKYbOl5GRwBd0ON5t4ZWgA4tZ/nR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHAqiczxDluqmCwOS3LRNcqSx8QJwT5cESxs6UpBZwfuNzXXe4fBnRxVqVjwNhPVv
	 ZkTgQ/Z1UqRBswJO7cAWOs009BjH6+yZoMaqCYpy//4MeXIK0aUomsjPA/GaKi73j5
	 HeR7D1bkCk915nwj9j+joPYZNIr9xuVJ6U+kZOWBKnOdqfH3rucHvH74PkCLroiYxD
	 Uq3YU8x6bxhqfg65cF8VnzGQwPV6rtez1l7b4fwPwJs4UgnwToWW30EalSPxmOYqaL
	 vskTsrL9sgIESIpAQajTcNFCmdPrwj/Ic9LANVhSYIkd1iglmg7fMxYpvrklbdrlaN
	 Q1Ci8H6AI0jLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE664C59A4C;
	Fri,  8 Mar 2024 15:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Align broadcast sync_timeout with
 connection timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170991302976.6021.16677238444316935338.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 15:50:29 +0000
References: <20240307170110.4096559-1-luiz.dentz@gmail.com>
In-Reply-To: <20240307170110.4096559-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Mar 2024 12:01:10 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This aligns broadcast sync_timeout with existing connection timeouts
> which are 20 seconds long.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/42ed95de82c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


