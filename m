Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D423FF1D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860192; cv=none; b=mHfP4SYIuQvHq0IHCKxGiY2jhjO78axPK64wh2S6m2R4lz4s//Zf1J3TE/rjXKwEV8l4aMPTq0egOK/0uETu6Fw9ILGNVRddLWmDMLBGV63WX+W5mB0qLgks0rWBackPmtmi7WkcxI26bnlyBGZrzvJXASfGb2C9WpD3UT6AWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860192; c=relaxed/simple;
	bh=UOhxkAutTnDZ6TaaSYY+uVT9JXAdA5JleIskw+o80Iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHJBIcuV7vnyQ2OxrmDbVztc+1JpzPqaOdp+yxUZaP2tXmr70BtlMj14C1uobq2ur/mB2eCJKaVmpqCsmkyV1irHfh8adyuLczDhF+y3IewNLn7u+S9LKBuA8LUHj75JKGhpta5G8SY6oL321eD9cWahWx2h+RDDpYtz1shWGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5t9Opri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5t9Opri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7029DC2BCB0;
	Fri, 15 May 2026 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860192;
	bh=UOhxkAutTnDZ6TaaSYY+uVT9JXAdA5JleIskw+o80Iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5t9Oprinefi/jrx1jN48CICI3VV94avKTwy9nkJ2CNNQd2VgPnkOzeFcad6+Nzrd
	 P8lgNOUPqW19Z4OedoMUhAFxlhBjcDaOH2cS1Jja995gmSXcgdZnw5oL90T1K+0Rn5
	 8WtdoxVT6hzLBsYBUEdJ3RfocyA/zmVrSCRvzrmH9/JDFwS3K0M6HtJyibEN9UKHiV
	 GHd/j6IrER3In8D0npdR2+M7p1uWVD0gFlLxDNN8GV5e9dGfF1gv+o7QziNE2yFnmw
	 WPgd7FEP44GxpV5J7DgWm765qIEkww1MpiwmHEzQwyq0G9TJe1YWKyJoneiXv/3XVN
	 EsjyL2FyUx40Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E63930998;
	Fri, 15 May 2026 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Fix incorrect MAC access
 programming
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177886020563.52984.12391876062820489757.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 15:50:05 +0000
References: <20260514190248.1275299-1-kiran.k@intel.com>
In-Reply-To: <20260514190248.1275299-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 May 2026 00:32:48 +0530 you wrote:
> btintel_pcie_get_mac_access() and btintel_pcie_release_mac_access()
> were programming STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ in addition to
> the MAC_ACCESS_REQ handshake. These bits are not part of the host
> MAC-access handshake on the supported parts; the driver was
> programming them incorrectly. Drop the writes so the register update
> contains only the bits the controller actually consumes.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Fix incorrect MAC access programming
    https://git.kernel.org/bluetooth/bluetooth-next/c/663fc68494ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


