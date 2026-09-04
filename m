Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1209511E9F;
	Fri,  4 Sep 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541043; cv=none; b=hFR7OjHFQfjal7/rxuAMGVaJCjbBPzcNLl1LP3XG2cWcB1+nJhhnKKNBAbrXiUH7lS6joSaOdzgK0TUZoef9v2GuIouSzn9FlsznwGE6i8HuPKrjUV5CtBLEnfoS2Af7twdwuD3EFnvjFDlLq1QjYDQCwm2o4rBtu+F9QJ4uzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541043; c=relaxed/simple;
	bh=9eWZ18ETnXiE6aPCgsOC0h7aeDJErP5kVVYE1Q+dlwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oIRn3orKJE36XPWItzNaOckJzkLXvpU/llPFcDxgsjulYDfOh1g+zaYBBFFcEviP5Zt1RS+pfOBPiMn95ZWZCvSFNZkX6mB2oHiiiWzCSR5WaO8hphimfrmc3f4neyNMBJ4f8H+y62i3i3Auh9wvqum5djNG0lmYz98sZsplJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiz0RnTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiz0RnTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9411B1F00A3D;
	Fri,  4 Sep 2026 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541041;
	bh=8Cv96At1b7sOzcDlwlKcPQFtKvTqVWfo1Wxeflc4TRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kiz0RnTMRlbSOzlNrzrcSwNaxe1rxVvsNOc7lH/oorO7areXfO2tRxAPmrAJ7/wW7
	 Paq+wEOgKP416rRzZmalbwgCjBmY8FGLDCmtMtWNvIIEn24B8H/+/ZxUiHJyAgZCu6
	 clslvYYPlY+XAxzxr4kIeqgJI1wWUzsyQn/vbOFbgZayaAs6ToQpcwYFW/MV00ECwN
	 ABiDrSJYrbmWYwOTuL1ooKxqjohRBK6I3IERHp/5vH4dNCTesMV228+vRwr2C4VJuL
	 NRRktFKk07ZFl+YZDo6OdN96lGo+lX5mi1dF8QO8ZtbGBSgoGfoLc8pu06HojFZxQA
	 RoRH/2cWo60rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939393924A50;
	Fri,  4 Sep 2026 16:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Add support for the Synaptics BCM4384 Bluetooth
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854098213.344939.2442318143633247201.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:22 +0000
References: <20260903121824.3080796-1-Andy.Chang@synaptics.com>
In-Reply-To: <20260903121824.3080796-1-Andy.Chang@synaptics.com>
To: Andy Chang <Andy.Chang@synaptics.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 20:18:22 +0800 you wrote:
> The first patch adds the BCM4384 Device Tree compatible string.
> 
> The second patch adds the controller support to the Broadcom
> Bluetooth driver
> 
> Changes in v4:
>  - Patch 1: Rephrase commit message to be OS-agnostic regarding firmware
>    selection as suggested by Linus Walleij.
>  - Patch 2: Add test log into commit message.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
    https://git.kernel.org/bluetooth/bluetooth-next/c/29d82dcf7273
  - [v4,2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
    https://git.kernel.org/bluetooth/bluetooth-next/c/9aa9447804c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


