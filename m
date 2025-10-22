Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5772F363B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168565; cv=none; b=XJSYfybzieoqy+9x5Ev10oRpKEc9fK/YrWMW16wQ6j4o17Rbs1jY5ZGHximiaWafWjmussFGzdOsMgu7AZIVfp23GbroIOZWlfQ/iMoMtJGjEXG7/GYMlW9SytFhk3rqnsAdzHaveCNc4iiJDE87L6KxFYtdX4gVmqlc65dEe/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168565; c=relaxed/simple;
	bh=V0L5k7yTi2rStVdVDZ21sFwp4qi4citUq45gkXoLaOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tRmzqYlYrg7IpfHhkpGN9e7VCIrF8PQ0B0S/CbhoTPanPFyG09Q/sr9nFTjtToqpvzlcbcqMAGsL24Q/Jf1z3bKcSiTt5UG/0OiVTl1uQ6a03CT+XQVwiMbRGJx6K3oKbpGNxLtmpeyq/3g5TmBueeikewdz/VweX845DVMuQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3MuBGB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3MuBGB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64163C4CEE7;
	Wed, 22 Oct 2025 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761168565;
	bh=V0L5k7yTi2rStVdVDZ21sFwp4qi4citUq45gkXoLaOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U3MuBGB738Vxw+1g9iroKbuRCQ5i9rO6Cw6XiuVt2OKbGjMqYQc7Tcr5MTVZA0LIV
	 DzL8N8H7PZfBxlpaOJA7xIeM4qwW1fWvjhWB+WCpQP/o17KbFVtds5j9GnNeEOhyPb
	 u8WxOmoN6V8RVUVVrd3D7ADSCJywv6zybB32jeDbbMuywbgw7D16sPMcMuBqAc3ZiU
	 VkUOi8RbVgdMXMGQMvr05i2jwokyVTXSJ4HiE0caxI1DvbfTMHIObVY78OFerZmng5
	 llSKEz3LsVGiANX7jDq6nxO9Eml3EKwp4zGU1UcP9ajJpvly6Wb3DoUD7Rg8X1tdjF
	 +cY0cAA17e2WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCA3809A00;
	Wed, 22 Oct 2025 21:29:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Print data if LTV and data length don't
 match
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176116854599.2074360.7069013266980900306.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 21:29:05 +0000
References: <20251022180044.1471032-1-luiz.dentz@gmail.com>
In-Reply-To: <20251022180044.1471032-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Oct 2025 14:00:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If data length and LTV don't match this should be made visible so
> issues like the data coming as all zeros as bellow can be detected:
> 
> > HCI Event: LE Meta Event (0x3e) plen 50
>       LE Periodic Advertising Report (0x0f)
>         Sync handle: 64
>         TX power: 127 dbm (0x7f)
>         RSSI: -55 dBm (0xc9)
>         CTE Type: No Constant Tone Extension (0xff)
>         Data status: Complete
>         Data length: 0x2a
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Print data if LTV and data length don't match
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9faf1244a932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


