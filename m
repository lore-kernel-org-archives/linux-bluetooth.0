Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932952BEFEE
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793991; cv=none; b=XyFM1ynT21L5uXp6l8tR1kQ9N1TjYnF7zSlUdqd1mR9oeCfQhPcE/pU9f2g8GrK6WIHFGxlSTHDTXo07l5sTlkp3m4YMB2Grv8Y4E1+ZcSUDIPE++MlS246zfgqWVOz/tpdBreGHpxff1Bqs1ZfOwLe83nCBp6IrExSEn198Me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793991; c=relaxed/simple;
	bh=Xl9S3Kj7PLvhhJKyFVJnIwXpWYLIIzVbzcdFxyBH5vk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hxgl7tOBa5zE4cth1a/ZZ5OM+iT01e0hqRePkdH3UglGqZ6TG/SY4B+OK1BdJJKAXpTWbcjpKt0WbzKE3KZ/3sG90LhxjCSvuxhGioTa+DVJgEq5ANUrb2XGn2dOSVMSEsiyI+ovUa50Dn5C9UUKPPQEXYxS4lCARvwv2SW9KFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyXKP2EO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyXKP2EO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B157C4CEF5;
	Wed,  3 Dec 2025 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764793991;
	bh=Xl9S3Kj7PLvhhJKyFVJnIwXpWYLIIzVbzcdFxyBH5vk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyXKP2EOBGcp1A6nYIPOg0yvec6MWItejIeC2KFc+b8F+QoVDj/Na1Y5oXvlcgSpu
	 mfKP7MdSZsZM77mvvHESpvmLMfLx/9kxul7qVvd0aNtlKAWLwlg6GBePcS75FNLh1o
	 oe0qFDqNzpxptBg65xfRRFwfgBeFo+WHlh4jdjsaqECojXQ9eLIZT2ziyOSdwU6d0x
	 FgJL568cLqKRQjvY5n0oJgO9ExV+qDW76UviyAApkIIsAsdYOVIVeMguuKNALFqMId
	 7AZA2nMXHC1fYf0ZoKZEKClD4fNuz171YyZMPohkDonuuwEK8jx/ufSKndFiZ4+PE3
	 wYLdCtGeMbuIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A3D3AA943E;
	Wed,  3 Dec 2025 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v5 0/3] EDITME: cover title for bearer-impl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176479380981.65731.6429372924712911517.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 20:30:09 +0000
References: <20251125-bearer-impl-v5-0-ce1ce5ad19d9@amlogic.com>
In-Reply-To: <20251125-bearer-impl-v5-0-ce1ce5ad19d9@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Nov 2025 15:01:13 +0800 you wrote:
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v5:
> - Split adding bearer field to btd_profile into a standalone patch.
> - Link to v4: https://patch.msgid.link/20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com
> 
> Changes in v4:
> - Add a bearer field to btd_profile to indicate which bearer type the profile
> - belongs to, thus we can distinct the services per bearer.
> - Link to v3: https://patch.msgid.link/20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com
> 
> [...]

Here is the summary with links:
  - [bluez,v5,1/3] profiles: Add bearer field to btd_profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=930df108f301
  - [bluez,v5,2/3] bearer: Implement Connect/Disconnect methods
    (no matching commit)
  - [bluez,v5,3/3] client: Add shell cmd for bearer connect/disconnect
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


