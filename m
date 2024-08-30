Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B04B5C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033026; cv=none; b=sS5HdpYAxsStltQFn92yU1ylfaGiSfTKOo2/StPButcehhrjTwmxWaVgZGtgL+zGHrKg0WfMdEG79IyY++KH1lPDPzOgCy3w1cl4dQJmOWprWS9qhmvB7AklgpJ/uOkUbLwwfypql9pTCuLeLfFTiS5iUve8HS9H6MOkE3TN10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033026; c=relaxed/simple;
	bh=mFxfiGujPOUQPRPUMA/qqgT4ei0KnVKoDcp/1uQ+vTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVFTNkAL826F2clYqNlsl1Cyk3HALItw2Lvcwq+NYtp+66AbGt1J9CVA2FnqgUpPpz5BoPXma6cKhd+7ERJHem+IKDLaEFEgCLO8FOZN0QCNSUDPDQJdQsfpg/dWEwgfYJl32RNiGqKHh0hY+06uTcnuWn1dNxHy5YXwtFj2UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny33iI7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny33iI7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B77C4CEC7;
	Fri, 30 Aug 2024 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033025;
	bh=mFxfiGujPOUQPRPUMA/qqgT4ei0KnVKoDcp/1uQ+vTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ny33iI7Par/KCpjJhLnGXuLc4553nMtb0cw260SjGd8PU/vcfX1KPOLcP8NFMK0fx
	 9yGqB4i3ed21sWcyKR/nfyXLJpUmNYSR+ylBkbJgfmqcKdcWgwDlcR5VOzGvIoZMXL
	 49q8fgkftEcWvGqU0Aw8Fyxf7548jba+lNSq0ZBcUbcETf1E8ZulxJib4HqIC2qyQ0
	 lf5gK6ulEXGwnLLebFTN3jS+8puQFCnF9PJI3fZ9fe/EYQoi4d2b8CfCarKh59qDwJ
	 c4w5i60KRk7IM5v70/lbsz7wC1UqVgvba6EPb5J3h7ckwcMVOGunqLwvVsTDnpkY2x
	 YYt/FxhYYbFGA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9FEB13809A81;
	Fri, 30 Aug 2024 15:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] device: Fix Pair method not setting auto_connect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172503302664.2636711.5053786022621407408.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 15:50:26 +0000
References: <20240829201803.1103129-1-luiz.dentz@gmail.com>
In-Reply-To: <20240829201803.1103129-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 16:18:03 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Due to commit 507ba12483c3 ("profile: Remove probe_on_discover")
> disable_auto_connect may be set when a service is probed but the device
> is still temporary which is normally the result of service being
> discovered over advertisement rather than connection.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] device: Fix Pair method not setting auto_connect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=394675782078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


