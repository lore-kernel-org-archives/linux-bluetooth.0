Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029609;
	b=C+a7zH4huJtUz6z8bXuXf4o66hx8aW9jIrCOJf2ND4JN8WuM5d75/zzhjAKNAfXMp4hE
	 F5X/HoAfMLqR/cAjCIlDiher1LXtYgij7q+KLv+fnKEDkgt89P4IJ0WnCORAQR9bR2m3n
	 0co4R+E/+dyG/kTSjol1PqYOQjHx3VSnbahg1wCxkZylRpmDjmUxHDV9uuI4WbSujD1ON
	 dbnQA5KLW9Ns8xA/5QMsnWZToX2Ay+FPjDV6uoarGAV3X6cKo0n4rMMUMQTcWhLIoAcpz
	 RUqVThP9NKS3toR+iC+Xq0ITmDyHUh6VVy0IoH8++EtqzsQWvpex2bK9UP7BHgKanmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uLM97kHCgcj9AqP4hTNpcR/Aj4Vn0aD9NrC4YUsT+AI=;
	b=X3b7yz+j4P11kUFTjaSLMhUG5sbatyILDnRxo+BdllRJkXRUQCjqo4CcHzpanKM4qQ3e
	 WcAWnUJYFKjZshAwJDyS4wkAL5f2fAVgpuskAJKcDWpGmiAZPXv0viDQdMrVtBQF5GcKt
	 scGOvPWJT+KWTAg440FochNMyeDGCn3MDnF30S2dclJ8PFLP3qNt0RuIpYk6hBRFyejGC
	 AHDOD3q76qLhf6IVxnPBinGR0RROCK6oxdZredqwm83r1ghmrpiOruFbPMtsamBsxWHI/
	 nzESWiX78bUsiYxbY9eTV5pz8wWNDKI0vJPryd9DUszzym0RD3yTGAvOO+hk9LyLNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXXBSYS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CE606A33A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXXBSYS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8691F000C5;
	Wed, 18 Nov 2026 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029609;
	bh=uLM97kHCgcj9AqP4hTNpcR/Aj4Vn0aD9NrC4YUsT+AI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dXXBSYS6Ws4eSnr7Y4UFq2UgOFhPzmCCPQJ7NxFl804moUewR9oSOSBRmaCN/QxZU
	 bELDm6Y4k0Rk7XLV6Y1NS1y+1ryfPHjJngFz7X/cxFwDb5mPjN2oZg/ZKx/W1HPkkb
	 H8/zatmiOjo7s52eNSakCglBdHeJ4hpMyMwswqQeDT1tPALs1WuVVfdsv3UilVtLVk
	 rFfqkfGt0XiKdkSf1j+xtH11w0TsjeMt7ir8BGx7xP3tzR0zAYXqSyEnBEUEvBdtEa
	 ecqZCBx3jSlkVYKoUuCftiMZZULTBlk86skfuIyB1ymYo9KNe4KZKNyUmczBavfM6I
	 xkEPYtLhm6dag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B448E3808210;
	Wed, 18 Nov 2026 19:20:09 +0000 (UTC)
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
Subject: Re: [PATCH bluez v2 0/2] shared/gatt-client: Fix init when Service
 Changed lacks Indicate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502960827.2490531.11541569990427433195.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:08 +0000
References: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
In-Reply-To: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
To: =?utf-8?b?TWFyacOhbiBQb2zFpcOhayA8bWFyaWFucG9sdGFrQGdtYWlsLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Nov 2026 17:53:39 +0100 you wrote:
> Some devices, e.g. the Aqara Presence Sensor P2 in Matter commissioning
> mode, declare the Service Changed characteristic as Read | Notify only.
> The client initialization then fails because indications are requested
> explicitly, so no services are exported although ServicesResolved is
> set.
> 
> Patch 1 requests indications only when the characteristic supports
> them. Patch 2 adds unit tests for both cases.
> 
> [...]

Here is the summary with links:
  - [bluez,v2,1/2] shared/gatt-client: Fix init when Service Changed lacks Indicate
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f08061cb4d3
  - [bluez,v2,2/2] unit/test-gatt: Add Service Changed registration tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e12013a9bcb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


