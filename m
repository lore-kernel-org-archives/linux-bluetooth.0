Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20C313E2C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482192; cv=none; b=llN7mZEA1er8B7+wrYlCNrQrpCAGpCcRfkYvoEfyPOL1p5gNeHvdE/CVZoPfTWENYHISTVKdzd2QDPBojmggM5MO67s0MxB8oL9d4efsjTW6BFFGQ8ewUrWNy2yhJavSgyjxo8iv7eR9kJ8PZv9LYtTVkz2XFfW2dMi0h+b9HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482192; c=relaxed/simple;
	bh=WRHTtekaQSKV20zcgkb0/OFr81t5j7/8RszCXAg2oww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBF6yoHqhSnlWZc+62Sm4tjJkSQ2WbGESDQnhBZ+qtC0CXpNcSderj+dtIgg2pLO1JKxjBE6QYnI0Fnn422Pn807Iz38/YnNN5FPXPCi619tKSh/FSGehM6a9kQWsdZKyWaeYAcwSnZxWA+CFaQ8Z6c0tCsVa04cu2F2PKcvzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORPaFjUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORPaFjUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9ADC4CEF7;
	Thu, 11 Dec 2025 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765482192;
	bh=WRHTtekaQSKV20zcgkb0/OFr81t5j7/8RszCXAg2oww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ORPaFjUw+FIuB8rlcBCuuWKLziGj1bpxYNyvogPt+/slm2/fk16z2Fcy2gO+3nFE7
	 kkii9FOJvPe7sO+pMRJSAZvw/Rnva16ihaeTTmwnFVJEGbcaUbWQUFCPJU33uQL2E4
	 EK/Lkg+V02LTuOd3eWO3tJA+H29pyJ2tgOa5sQnHrYtfPzdzMkskSdDmcUieg9wUoG
	 AJoHNkloIDR6FcLy7E139lQmDxBki1szHBoGq5kPxwqUyV3zEN1ndLoltAXZPuh2y+
	 Fl4t4MV17aoL/nGCGQzdDKLCWs9EhDG+XdlWo0Fu+DFU4GEyKR7TEKERxmgCUQyK7K
	 HM3vqNJ135XVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B80B3809A86;
	Thu, 11 Dec 2025 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as
 supported PHYs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176548200603.1496376.6004235092516869198.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 19:40:06 +0000
References: <20251210205012.153919-1-luiz.dentz@gmail.com>
In-Reply-To: <20251210205012.153919-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Dec 2025 15:50:12 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> conn->le_{tx,rx}_phy is not actually a bitfield as it set by
> HCI_EV_LE_PHY_UPDATE_COMPLETE it is actually correspond to the current
> PHY in use not what is supported by the controller, so this introduces
> different fields (conn->le_{tx,rx}_def_phys) to track what PHYs are
> supported by the connection.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs
    https://git.kernel.org/bluetooth/bluetooth-next/c/305c1c5dd5f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


