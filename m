Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789235;
	b=pz/oWS2WcNmjUvUfCbyiaQsrUsxy7y4ZArnvc/jTXWBw6jQUIk9wjxv/4YHo7MFpQEGf
	 VuSnieDyr07UBRgg0T2hfHEMinHzf68J8hgitoxKOzQZZzKFz/BJ7s+Zdg+4xYZKZLsS3
	 BF+4s14XpBziq4bhuhPwRZL2erpIquSdK+4UZM++xSsYeqdYCpI/YjU9enffwY+AExfjT
	 Ud+wSq7xQkQWeqOSoIXsoDzSUHXF1XMZm4qJLH07Q18A7yvnb1LcrOmn8JdqtO3YMbOqL
	 hApMGpRtOOcLoqnGq5yd3KF0EA1ixEwnCqAbsYFE/n9YSvb8L3+vFz+zLTv7dLjRsbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789235;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WezFqdvJ51fZMv8tdbZhyi0ZvZwzseOzl9pim14/ibA=;
	b=Y8babKiHDSZCVXZrDq5pTkmVZ8YiSXx2owxJSjM3QfkYKOHP89/AgLU9+VKaVErY6Eqo
	 bYa7pwTc5AeuLRP0pcsE9fsEVYd8ppy+M2eazawSetCS55Tiq5y142AZVshj5ze2XjiUk
	 2m5JQq2HoA3nFS9Z/pt21AnzmGari3KS5A1qFELeaojwgivKI05mEv0hKns8NBWpQ5q/c
	 FGJUyirhjB1DN2Um4tJBDlM3gv0ZbhdcWxzZKdtQM8qX9LUqvxbbUuzblgsSuzjTyeyFC
	 yJQiLWRogMBrRu59jvfYsqo9Ns9eIU5Ny3mtR78f/QF27Nn+TKppoDh6b62QjTUhV2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCPvHLaE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937C606A333
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCPvHLaE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C655E1F01825;
	Fri, 23 Oct 2026 21:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789234;
	bh=WezFqdvJ51fZMv8tdbZhyi0ZvZwzseOzl9pim14/ibA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LCPvHLaENyfAeT911uSEl0KzW6v50zMfRspnLIAbEVxAuCpjWVucx6UCbVJEzVf+s
	 rarFVV3H81vp2UYbcRVmjQ5rJCO5wQjz/OPhnz+htjLn8skH6LCo9TM1X25ML5hUeg
	 ebr8YPvs65Di51BGVSQHwgHqsc4i28qby+LtBaS+qmhq7OTNfNCMd9vPrX8q6he3ps
	 CBrQZMf3poS8RPT/d9GRICZzHJmAHfVOMLoRttIHapJ9gz3h2jhGlmQfGf9IKP3Khb
	 JtmNT8kYIJpjpL7ZdvV6XiHSB+ZKsRLe1fBKgLbBzMzWcWOIwWhXEIaBPvwVN2mzDt
	 o78hp0atOPhcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5C3391B157;
	Fri, 23 Oct 2026 21:00:34 +0000 (UTC)
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
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Allow COMPILE_TEST without
 ACPI
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923331.1268720.10547122704757097502.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:33 +0000
References: <20261022154621.3958803-1-luiz.dentz@gmail.com>
In-Reply-To: <20261022154621.3958803-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 11:46:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The driver only uses ACPI for the product reset method, so make that
> depend on CONFIG_ACPI and allow the driver with COMPILE_TEST, so it is
> build tested on architectures without ACPI as well, such as User Mode
> Linux. Without ACPI the reset method reports it is not supported, as it
> does when the device has no ACPI handle.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Allow COMPILE_TEST without ACPI
    https://git.kernel.org/bluetooth/bluetooth-next/c/eb9d9d401c84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


