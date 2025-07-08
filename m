Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9B21CC74
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002985; cv=none; b=E6pKTAlAKVqt8xsyKjAILN4xw2VqkMilj5OSVowaBMxhw4XhKzTyyr/ECp2DvfkykA8XH3whSZOH7GEtMNexCVFAfW3lxTNw678cEY0g2r7enuAXKmMQCZbXTzRFVT7tCjWTE19/lsXG2QfvBelENnX9lxt6OHVVYndow3bDbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002985; c=relaxed/simple;
	bh=uiCkGVWmcwa8Nkzf5DyXCooQsF7EI7/1KJRB7lvksJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WdN88xkSyeJHJGlaDSnjAxbq4tHSQbtIAH0Cy1kOFV07MfGkI+Yie53povMnWUvocDTIjKCm3gPLCteM80PF9yVeh41bShDNUhaVk1j6tHhqVa31Jm0jLhouE+JN2bllC5fb5LqJl5VEDZus7PZhvZtSPWiaQJUWczKNlTp8Q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeY/G9gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeY/G9gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B529C4CEED;
	Tue,  8 Jul 2025 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002985;
	bh=uiCkGVWmcwa8Nkzf5DyXCooQsF7EI7/1KJRB7lvksJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SeY/G9gq5rf576aHZJNo3JQjjnjisbqkR+dRVAEHshnkqwIKMSxltcnujR1OH/d+E
	 EMZP64WNNOkKwRZsgNA6HA+S0b4L+tEvEnQCu6Fogw2vL2S5e1vn/IR78rIc0uA4zB
	 RsbX4MSQAnJ2YdGKZT7ir2LxyGYsxNxorq8ABGbpIJ42TSjRWA0/CsXg/rJuYQysdW
	 pWj3FMHndcK5OwIhbAc/t8OtaWBQHewJwJU18xPy7wRDJfh4d+TbCXX6HtHN78XzB8
	 i1OkjZeGe+3tGAkpJVNoEei2u6RAofwxVGJBFnXZ2gV6B9ipq0hCH2wBgKqXjRIobX
	 IIPUxY+DVTl2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C3380DBEE;
	Tue,  8 Jul 2025 19:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 01/15] mesh: crypto: remove dead function
 declaration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175200300826.4179900.1130269204271239270.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 19:30:08 +0000
References: <20250708125947.11988-1-ceggers@arri.de>
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 8 Jul 2025 14:59:33 +0200 you wrote:
> The implementation of mesh_aes_ecb_one() has been removed in commit
> dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
> ---
>  mesh/crypto.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [BlueZ,01/15] mesh: crypto: remove dead function declaration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=441f0539a1f8
  - [BlueZ,02/15] mesh: crypto: remove unused function parameter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1b2647179c5
  - [BlueZ,03/15] mesh: friend: remove dead function declarations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d012a2f629c
  - [BlueZ,04/15] mesh: mesh-config: remove dead function prototype
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=797b330b9ff5
  - [BlueZ,05/15] mesh: mesh-io-mgmt: Fix NULL pointer dereference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=806aa9de2b42
  - [BlueZ,06/15] mesh: model: remove dead function prototype
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d40ed08f446e
  - [BlueZ,07/15] mesh: net: remove unused stuff
    (no matching commit)
  - [BlueZ,08/15] mesh: net: update comment
    (no matching commit)
  - [BlueZ,09/15] mesh: net: remove obsolete struct net_key
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d9afa114507
  - [BlueZ,10/15] mesh: net-keys: introduce BEACON_LEN_SNB, BEACON_LEN_MPB, BEACON_LEN_MAX
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0cb00fce1b3e
  - [BlueZ,11/15] mesh: net-keys: remove dead function prototype
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=41b4b531beb8
  - [BlueZ,12/15] mesh: node: remove dead function prototype
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ef0f297235d
  - [BlueZ,13/15] mesh: prov: cleanup header
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e29506315cc8
  - [BlueZ,14/15] mesh: remove unneeded casts to bool
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4e5a3a80a842
  - [BlueZ,15/15] mesh: use '0x1' rathen than 'true' for bit operations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a3824b4aac0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


