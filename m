Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84720192B75
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538631; cv=none; b=NfEmkhidfG/VdCTUAeXW+UG5H+hgsSB6PsZ7KLvVVgy145eiC1q/E93iEeacZ/Twc855XsLzSFC3Lo+4JGSVicNGRbmydVIwNp/LqL0DsAsfrQSLX/jtohzm3uO9KuPrvCmcLr0/kyDxCW2Mqu9YW7yT9o2jNHw37dYunkpxSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538631; c=relaxed/simple;
	bh=TCme+yU2Isdy+m9peFMqHhePDuUuPab4z+bQxcKM1Os=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=thMFDuldHMtdXHdgm66kT4oWgfSw+C8f0tLEUpiom9rcWkSfmm5YZgQ4Nh3irNvVSxfNxze6vmuL/gbmkLrYyg47N7yeO8CGV9Qiyy1iYBduenQgVXfyicabd2+Ocrgpp0YW6Y4sN2kqgJzyanXkNa/9m1t1b1ONdAJzsncdXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkm29zVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkm29zVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A9BC116C6;
	Tue, 27 Jan 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538631;
	bh=TCme+yU2Isdy+m9peFMqHhePDuUuPab4z+bQxcKM1Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rkm29zVTORO+Fi1uAZF0nMEY9CraKPQkCO/Zk4TE9wIe0w6mEQmd8/FZnqvfLFV8f
	 Ss3FDBf6HfTlPspdIjmNO0iLyOWEwKygz6HAIn/qdk6QXP/rBRXQlYQQcBBNreC8qW
	 Iqh/PRbzSe+LFHkP8i6rVQrh06IwUn8/csVzPYJfDDTgqXIVTq4yU+lj+/yO7hMgRu
	 YTWmJ4qOiSQJRTfJxXP9h2AeO8vjCihwpxtsKuLlNmn6SGuOhbwCO+UD8GIc+Tkqne
	 10ooSYENlPny/0ah6IzKiu4mofeIIZeqNb1VK20VfLxmtaskyrR5LaC9ywSh8+K/0d
	 /P988EHb1WKug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB74380AA58;
	Tue, 27 Jan 2026 18:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the SPP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953862485.1352702.12781500863203754944.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:24 +0000
References: <20260127171455.151496-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171455.151496-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:14:55 +0100 you wrote:
> ---
>  doc/qualification/spp-pics.rst | 127 +++++++++++++++++++++++++++++++++
>  doc/qualification/spp-pts.rst  |  35 +++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 doc/qualification/spp-pics.rst
>  create mode 100644 doc/qualification/spp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the SPP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=feecc7f60de8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


