Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3627603B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354394; cv=none; b=D6//l9RKWSK+jw0W3ueqvPDqbQgvSefb0wJfBM/AHlmhQ6dP0ASp8+kGTO9hpmwaFtwRMYZeWCKCZwWr1oHtRWukVx5MKQP3ER+qvX/eHFmUWA4IaEoxyrQ/jHxEwQyJVcX0nuVOQIORy1VUQGq4111ffpBXXjxifSlNelfP5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354394; c=relaxed/simple;
	bh=YVPz3trWY/a8yajnIAkpfT6rFNvi+M5MK0tDta2x7mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MFwXaDTMNfUelOfcGPzPtaauKWX2y7gil9/Tpo15tsK7XxCor2zP3EHNdv/KjL0+FhX7RianGtdmJGNKfM+2TT+04UT+vAHUkfFn64o773Q6Ytd/jhvi2QeD4VNAu2w2mTXRetri9ivNY/8gpvTvbNXLb/q7on80WYDRhoOgvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs6cBYGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs6cBYGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F032C4CEE9;
	Tue, 27 May 2025 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748354394;
	bh=YVPz3trWY/a8yajnIAkpfT6rFNvi+M5MK0tDta2x7mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zs6cBYGTemKpymkidPelVKEcGWik+XqfvW4LHaU2YmiO8a9Oj1aY9/inTC46jD4ca
	 g1hDCqHK9WbOl37/rVIqk5q8uGGbFyO36dU4QYTwGqhOoaeIaXeiEisqWiL8x/KZKk
	 +OzuTJ44PPX4ZD1q9SA/A+7abNJ3P6fvgPcnlg7dNVuTKnqBx25zDRPYE6Zo2XxcOO
	 nhk0rhymsXGcWRvL/RauXwyEdQ49GB4J/LTvTvLNfFI+oMp83qeo+L3Q64b8sSELWJ
	 2osLHL3dhtuEjB12SMCmaLYTqgfqDMMrwwT1UU1x8hdvWbKJPtDLjs5Zj3G5GnhFex
	 VVzOpp5KwbPbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC65380AAE2;
	Tue, 27 May 2025 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio/player: Update track duration if previously set
 to 0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174835442873.1648375.14550329073126582058.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 14:00:28 +0000
References: <20250527064615.125970-1-frederic.danis@collabora.com>
In-Reply-To: <20250527064615.125970-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 May 2025 08:46:15 +0200 you wrote:
> Sometimes some stacks may set the track duration to 0 in GetItemAttributes
> before updating it in GetPlayStatus.
> 
> Currently the track duration is updated only if it has never been set
> before. To fix the issue this also checks that the current value is
> not 0.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/player: Update track duration if previously set to 0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bcababe6050d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


