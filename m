Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AF3B8407
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602007; cv=none; b=gT3i8Akp74PfPpWPfgcVK1KQqwlH/j7f0ZXr9M2DGbXyEK0Wf/rK9GBfyb//Nt8Tgru845yh8lhUkh2sDesPBv4Mrcxa5k9XhNYbtDsnw01XssLJ1dtREZFEq6mwaFYWBBofV2LB0kjSM7dQNzX34uyj/82w/ClX0uE8e6crdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602007; c=relaxed/simple;
	bh=Y+sOVLWBsMsbOK58TwdD3S7dIj6rRYE56wv2l81A6Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l8cBGbBYIEnWNG3gA/Zu//rnmrLoUIrD1uHG74Dys4pmbutidQFAjVkvd0AvH30Wjen4ts478pAVwkZIC0UansKZNT3b1gcjbbfvBPni9nGj20+ebu+52l4x0iegbtBFk23l5rl1A0Z9HCK/s/U6nuEkNj9o5nFGaENB+h2Qf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OceWvVzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OceWvVzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472131F00893;
	Thu,  4 Jun 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602006;
	bh=hNd2JO6AbRZvY3WYh1QvNNDD8yi8JdWmgQGQ3MBuIxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OceWvVzgQJs+7HbUAbptdAaZX6J9i094SqLENBkFrZTaGw4v4yA63Aikc7GUOqtLn
	 F6L4FSo3Euu0jnzqJtfs96pQtG4w7q5Nmn9fA69WcMYkeKh6IrKg9WxbIQrgnTjRy2
	 zNCPdv8ZMuQQOBV5eoCrqxOUNhdLohzis1NEUlH0Htk8qsSJurowGID6fh0EJAKod6
	 I+5YPgSTlV+lzOCW9+5Ak9BVWaVOuXCTt/HoVW5uPab756HsyOUP/UyuiiVW90sJkK
	 cVeiOB+djH9XEIW980yZKsUF6i/7EsB5midW0OdzNhCNh9eAkXinXxOKclEQXTMkCZ
	 Y6BFbhGLrMTzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4F6B23930A1A;
	Thu,  4 Jun 2026 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] profiles/ranging: Read measured_freq_offset
 field-16
 bit as per Core Spec
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178060200686.2994037.2969505068362825008.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 19:40:06 +0000
References: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 15:32:33 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Fix in V2:
> Fixed compilation issue.
> 
> ---
>  profiles/ranging/rap_hci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42b2c543a70c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


