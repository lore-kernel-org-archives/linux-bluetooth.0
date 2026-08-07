Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FD4746C9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120254; cv=none; b=DRykHqWVbeA29uMLtjEg9fxDvZwqgUcmnGZ2JPT5aPOZBEFLOi5vFYCdFD+YNG9sLvxAV8ZAwaePVVRqNyLTVnsGCHA6o4eVuRi39oubUxJsBENd0mM6pO7T+G5XGpzlTsVCFBM7KRkVVaHXUV0BpEaXBRPelj9XkqBfLKISmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120254; c=relaxed/simple;
	bh=hSA4j/8difqV2AYiPCZdkp3xBH+HUB0KuGSnmdsr76s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YybFA69jWXKFiWohMYwoLWnJv4bkd6zGsm0AG8ol3RyU/wl8TYF27tPvfgLaTX4AmDQEg+tv4Uoc+6C2GO7Fvc8CTrd4O+vVvj27g/wmzFTebRRu9T1Gy9mhg6ZFCLv+p2TN4KM52TxAifUvtesXMLsCqoKwo5dRbz2P98z9rHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqRAoBvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqRAoBvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DF11F00A3A;
	Fri,  7 Aug 2026 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120253;
	bh=2NqSS19K5+KsNO8UV8pNH26Ak3nfVHfPVuPuIHAugZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JqRAoBvo/yUYNNX+nNW0CJsFIpzWhOKgb2tiNGexhhN/XthJFk8OImnHIf1soI3+e
	 9yY9tKkBApW/wNGsiJH10iZugnKYCrf2LTcUGBpePceCS69plOAjIdDw3YGiyamcFQ
	 f7duL7f0Kb1IjAroSaySHoAiU6OrlaZDqRzEtqDUZSe00oU6LleqF3VF24Y+rgb9rT
	 3MUaIB0dybQ6AnqRGLoOCiLhuYTL511z6v43lTBE6nqgv3FvKFltEHdI6kSEYvPDY/
	 XiGHYGXnDxCh5zXnwKwiDCfU71FgVsmLI5I88U2aFRvfN83dE06oSBcU8lC7fS/Sj3
	 l+bridgFANYjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19796380CEE3;
	Fri,  7 Aug 2026 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Disable legacy instance's ext adv
 before
 setup snapshot
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021163.1887768.9268794228090241757.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:11 +0000
References: <20260804201051.484885-1-muhammad.saheed.iam@gmail.com>
In-Reply-To: <20260804201051.484885-1-muhammad.saheed.iam@gmail.com>
To: Muhammad Saheed <muhammad.saheed.iam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Aug 2026 01:40:51 +0530 you wrote:
> hci_setup_ext_adv_instance_sync(...) only disabled
> HCI_OP_LE_SET_EXT_ADV_ENABLE before setup snapshot in case of non-legacy
> instances (instance > 0) and never disabled the same for legacy instance
> (instance == 0). This would lead to failure in setting ext adv params
> with HCI_ERROR_COMMAND_DISALLOWED (0x0c) error like below, when toggling
> the discoverable/connectable property of a controller with advertising
> enabled.
> ```
> $ btmgmt advertising off
> hci0 Set Advertising complete, settings: powered ssp br/edr le
>   secure-conn wide-band-speech cis-central cis-peripheral
> $ btmgmt connectable on
> hci0 Set Connectable complete, settings: powered connectable ssp br/edr
>   le secure-conn wide-band-speech cis-central cis-peripheral
> $ btmgmt connectable off
> hci0 Set Connectable complete, settings: powered ssp br/edr le
>   secure-conn wide-band-speech cis-central cis-peripheral
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d4711f5ad1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


