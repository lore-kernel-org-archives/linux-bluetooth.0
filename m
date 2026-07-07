Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D20313E2B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433426; cv=none; b=YRvaXev5Ctvo3GcWdsTHnKarHVheJ9weCIK9diDrbqgten9AS0DofOSNE0/sJK7pzW3PgDP3NN3bV4K66VApR4PVcUhLiNlbXTwTjrfwt/amQ+BKlzOFvR+XtLydW9fb3kj/fh7h7LvHifygytU9kby6fgt4eZYuZOyKfgig7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433426; c=relaxed/simple;
	bh=UVcnNwa9a0msL5WmcBiMfaMyDQCRhZtn5AmNgxCvo+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Af4G1TCC91FMz5k9EhTXTn8vALTn2kQfciEwei4AydTIWNbP2L0AtNYmF12g1cq+48olWaUmJKoNnEQn64EDtg76viGA9KWc4rzz4w0UoZb+VRKLM6Oiiu3XfGPEkiEwQP5kBbLS+bPZhIep4r8Snw8rdDH2pdN2+gqpW0KUCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6RLJNS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6RLJNS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F491F000E9;
	Tue,  7 Jul 2026 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433425;
	bh=NKhRDTfXbH8w37AxqPA+BaN1Z++OzQISv/P8nm4olCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R6RLJNS8nnP0lAPZiogbPpgiy2BxbTX8epi4GykLYpLXu16IHRB+5ucP+CgrKYeZU
	 Flzuyg2uKZ2MxpeuRKCxS5QErsFl8C2YlPitEIspTIn3tvdZrCWiHhqS50i0FNYWdp
	 QD/As1d1EqnQ5nyAggeoLJPNWeN+7LH9WbrYItkuaq9W/5XRgoRoxrCVzj8haIDAcC
	 6vbXDolOEwzlf+JiY1XBpA2fX0e1Ic2cgdZe3ZTuemLYlq8/ExDBw6OdoqX0P5gLr7
	 IobUJuUD+/KN+VC38flKDIja+0AQcap6uwG6aZQHecbIMjjRQj/RyCfyIDFo06RsW6
	 JpSLpLaX+emZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4A3811A41;
	Tue,  7 Jul 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: Fix crash on dev_disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178343340539.2008923.4431365556079081849.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 14:10:05 +0000
References: <20260702155037.9931-1-luiz.dentz@gmail.com>
In-Reply-To: <20260702155037.9931-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Jul 2026 11:50:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Commit 5d836f1c697c ("adapter: Fix failed bonding attempt after LE
> link disconnection") introduces a regression since it attempts to
> call device_is_connected after adapter_remove_connection which may
> free the device causing the following backtrace:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] adapter: Fix crash on dev_disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5bc6aa79e537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


