Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503013;
	b=o0er3YTak/8H3dODL/mI6nV5snZ46womBXY6HmoLw5zBus5AIJrBYpi3MpkKIVQCBm7Z
	 t2Qt3vriPr0vRovLESu5NIu3EWiIoIHgCOagALdnW65I0nZmKYW8cC0erO0qm9ZS6p21t
	 99EkDExNFXfRqit1z8fbS6H30cwueZEyiiNqLwgeGDtFJ+7gDFskFoIoWcmcUBtaIYoXf
	 8tUqVCxW6nf5b8clpppEEA4qiHwRUrIoTGI/klozV3wu+YQdnAA8T4r8+1opDIByLkj8W
	 oSM7pc42C0jdVa4R3petYe8LJWPOLngqrQM9OxR+rbw0w94VlNkGeS0YCrvM8JZtkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503013;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=X5NobEqZhiQKigo+RBaLfmstMqsC3w3HOSAwUyy5Dqw=;
	b=Z/9vzBI0K/yNR002I1H9p3xjM/bYmFsT/sKUxI3YqvWbAKNpPPb5+wwxQZ9cmTQY9Ged
	 ht4E3VDf6bHjltx2W6wJiH/KoML42OfhFaT8R7aSbii9PkseNXt2RX7v95fD9FzC4bNBu
	 jXeITBQNNKem5W3vxIiyeomtsiHiVj3/iHr2mJv3M6Ea9MSEfL+hjWWaLEL396bOXynfU
	 eNr3/zAIAqxLOZVrSEJKzEMJBUsF2E9Aj93s8LHKoEzNwXFbVh9UkOy24ABf1q5WsWOOL
	 LYxS3yh+DKGOW0S0pag4w2OZTKxxwFG8OmtAtU8scBwcdby01NPR9hqkN+rrVIrFT7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAmQ8hpB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DD60A261D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAmQ8hpB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461CB1F000C4;
	Tue, 20 Oct 2026 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503013;
	bh=X5NobEqZhiQKigo+RBaLfmstMqsC3w3HOSAwUyy5Dqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FAmQ8hpBejEudrqIBjQEnc98ZQJ/SacSzEboXoc8SjlUyg9a0hkUYIX9OvZigWkPd
	 +i5nVW8V4EA1JTnH+jyPIGRGaiaO/wfZQjMPBv+kmidhVK8JFCM3cWrbsepS2OWRhE
	 xJD1xtPhwZEzRfn9GUJBpUH3dXKYZQbJccKVRxgj+PO005cl3ozxajYVRMde279hF1
	 N6/Fddw+Lq+97hK2WPLcymN89NqZ8sVcEB3grr4XvjdqFX3kuGCCDzuxdaWjxsV2kf
	 8ZlIEn/k66rF1Bfx94LgHxaH6L1WxoHukpy59jO9x/ZnjsGVt2VOPQRkTSirorPuCq
	 pviYaxPpoDvZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3D03808209;
	Tue, 20 Oct 2026 13:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] emulator: Avoid variable length array in send_cmd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179250301177.3738467.15349770626091050740.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 13:30:11 +0000
References: <20261018043911.1756937-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261018043911.1756937-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 18 Oct 2026 06:39:11 +0200 you wrote:
> Use newa() for the iovec array of send_cmd(), as shared/gatt-client
> does, instead of a variable length array.
> 
> This fixes the following warning:
> 
> emulator/btdev.c:479:29: warning: Variable length array is used.
> 
> [...]

Here is the summary with links:
  - [BlueZ] emulator: Avoid variable length array in send_cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7bc9684dc9e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


