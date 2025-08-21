Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9B30EF9B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797399; cv=none; b=aEdo/Ax9tQcufWQqJL7SLeT+ePzcNBAxLgGVe71BAo5GCBMs+xA6NYG9XQanB+Y6ZuueU+sPoElUsin69pV2a0QT1QMPta2gpc2RRd4vVl36+WFHB/T2vs9TjRh+wWSzLHivSFDKZDyrt8QfnqLKR6s/wiDcRBby1TyrI1iPkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797399; c=relaxed/simple;
	bh=ksOcF4oZL2o1UR01zqlfkDNGqmOxb5x3rhrFopQn28w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pwHEGqzPPSN8EvoB0018bOb3azEcHZCMV//EX2DvoIk3RnGSdQeU+vIzE1yaciS81G/xcoj6RfvgT96X++rpD1472uHH0qfjfYEKshH74LUFiAJii9aLWMGOS7TE9L9k8tPrjDumifyumfaWZ0CnDCR6ZDUDhKTTvBKe4TP+Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWgtFfUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWgtFfUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEFDC4CEF4;
	Thu, 21 Aug 2025 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797398;
	bh=ksOcF4oZL2o1UR01zqlfkDNGqmOxb5x3rhrFopQn28w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jWgtFfUyPlnHWp/25AWNrqPP/MHUtHCkRIxaM39enp399e928B5OnnbvtW7lU7sRq
	 aTH13ePaq3jHb74EfKez2dYEjK21hvpbr0agIWX9snXECxSogOHb2B3n5gj6OGg3Jr
	 prabbJqk8pcux6Zc9So79VRP1AOoq7XBpTLIEmXBRIltl2PYzkk3YL3tR6UyWVSDO8
	 Y+PgRZYP12Uo7D/s6Kx1MW4lysMw7x+UaSmVJ1bKpZ7+EkH7xpoyEsnZCD5qbgqp1u
	 /UlmJ4fO6rD+g4ZDJGLhctr9a0ga2XM4lvWOtVRgmrXgC10XlztnmvuXzF+Nw1S82J
	 zlFpUk0Y5mkPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0563B383BF56;
	Thu, 21 Aug 2025 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] monitor: Add support for -K/--kernel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175579740774.1124304.7205768533091122877.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 17:30:07 +0000
References: <20250821135031.2033789-1-luiz.dentz@gmail.com>
In-Reply-To: <20250821135031.2033789-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Aug 2025 09:50:31 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for -K/--kernel that open /proc/kmsg and attempts
> to print messages starting with 'Kernel:':
> 
> > monitor/btmon -K
> = Note: Kernel: BNEP (Ethernet Emulation) ver 1.3
> = Note: Kernel: BNEP filters: protocol multicast
> = Note: Kernel: BNEP socket layer initialized
> = Note: Kernel: MGMT ver 1.23
> = Note: Kernel: RFCOMM TTY layer initialized
> = Note: Kernel: RFCOMM socket layer initialized
> = Note: Kernel: RFCOMM ver 1.11
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] monitor: Add support for -K/--kernel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=90a490569cb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


