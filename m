Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AF41A558
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214033; cv=none; b=XUrb0hd08r+dWkI3SJ2Lun7W0orjyfG4NqVq2+VUS03o29L2iAgrJ5ne7TT5qm109flGVDD1zlKsjiTZgUibC5Hl9hR59T2xywJmn7K84A9iM8ZS+VRMqPd8kup9E+e3hCBWICmsFTE1z+jZxYbrZld/gExwDUg0uOjkuLrd9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214033; c=relaxed/simple;
	bh=vOCniFeI6uG202mNyRJFTsh2QXWebXosQZ5YxlBFewI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cogDu9/FhWzUrIWfvfHIqIVLw0UltcrEgkyAMQEfxxBO1+CVHYko/DJA/XTqCF2DhTH9XDG1FdOOS1i9OP84B6s5i8/ipBT0bjfpNHH9Jve7J2KlP0LKFzqMbI/RLyOxpFgoweLFMYMYNHaqOreq1ZC8QBxVY4ZyF5FxrX2Aylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyO1Shj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyO1Shj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33361F00A3A;
	Thu, 16 Jul 2026 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214032;
	bh=85v5DGl4eKFoaTHusO1J2kXiesQ742unMNqvV3lhmeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fyO1Shj2V7btFKHq5cmM4PjyXx9tR9zgH/AtV/8bY/1jJ9FyrnO6DNY7qAJQw+Kdh
	 UI7KfJ0K1KKbZe4SfiJPI6Gnt+3vl+Fn5Ovzrgv37dD/oAucifI6XUcihlfE3LWRis
	 lsOPPJfYNQFYyy3kdctIC+7rv4Cy1+huilMKYIqHga9y16bweq3eep26zXFNirr96p
	 RkTaXu1WKjRMw/iFyJrVWSVVxTXTUnuxgKE8TgTP90Lxj6PPIth3TnHck+oqQQvpWk
	 Ag8OmDUDNd3P7lHhC1dThItzVTJKc016s0+ZaHc0nbyexLwNgzU1Asw5pucf5Ran2G
	 tBBdFb3yOpiSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A4D3808205;
	Thu, 16 Jul 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Fix build error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178421400513.855463.13112359622405296446.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 15:00:05 +0000
References: <20260715170747.1933443-1-luiz.dentz@gmail.com>
In-Reply-To: <20260715170747.1933443-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 13:07:47 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following error:
> 
>    36 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    37 |       __bos (__s), __fmt, __va_arg_pack ());
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Fix build error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae5d5a1e3032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


