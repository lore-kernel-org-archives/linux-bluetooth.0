Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B02BE7C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513416; cv=none; b=cpNkLcdIHewUtiF/IF4ISjEf3YeLhzg+Mn8aUkh30MpRf21bPRDLwLQufoJrPcrK6ByKF3lSNDCocdtXnqIV4Uavn0AmHpNWXZy7lZE5Q+ghkdu+yKcGEVgYxgzZ6JtqRea6PRgd5DL6DOP8uSU77NsIdMGtJMZ9feQfrjQCUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513416; c=relaxed/simple;
	bh=D38FCHXbad3SpBAE32hNCgmeRQ+y2bP+HOkF/znyqPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/iN8k5hBWZGbUNK572axXtjG3SnKyWOSNxL7OpbwslQNOQIpu3XuKNlvU9uwjqJdtx8TjRIp3ZhTriCp53ot8RL8R8eiMYXgaVtdiOrUZoTAb4egkT7E6KtLOXsNUpDId9FITs06Is+83FZ/Td3/Mm+ejRarC5Ojj0nOIYbmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp5RYD1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp5RYD1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21FAC116D0;
	Thu, 15 Jan 2026 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513415;
	bh=D38FCHXbad3SpBAE32hNCgmeRQ+y2bP+HOkF/znyqPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gp5RYD1Az5FjxuR887JuAC/9giHtgwA5138nBlhXUfv+8/ykvFcTDs4RaEIXVClxc
	 7S6LnVGuiZ86kWHoE7XuZ1kEpSfCUvn1jkc1KNZEyogTflK0yL0L3uEnv/dCyo9l+U
	 H7s3Dn3oywzw/ujEUXAo9w1VeDr+r4kzAEKp3kErc9FV98OaNutg6CHKymiQkooDOK
	 gk4t/AhWgJSQJ63IrWViblbvAdQ4/wLqUTforg4bv1zEk5YnPwhUmDlxSLdeD1f3Uq
	 +I4v4bjlYIYKrklyx5h+DgJs7R319hgD0y1hbCRbLjMeZQgqPC376Fz1c0QIEvqtoj
	 Nkm4vpdfQcUrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E8C9A380AA42;
	Thu, 15 Jan 2026 21:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/hfp: Add function to get multiparty call
 status
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176851320779.4178208.3244529374824613467.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 21:40:07 +0000
References: <20251224144545.211533-1-frederic.danis@collabora.com>
In-Reply-To: <20251224144545.211533-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Dec 2025 15:45:44 +0100 you wrote:
> ---
>  src/shared/hfp.c | 20 ++++++++++++++++++++
>  src/shared/hfp.h |  1 +
>  2 files changed, 21 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] shared/hfp: Add function to get multiparty call status
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=22eca40e5ceb
  - [BlueZ,2/2] audio/hfp-hf: Update multiparty status on call creation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e50b9353ff7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


