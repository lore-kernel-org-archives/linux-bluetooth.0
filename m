Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B161155742
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657612; cv=none; b=KC83jiHYeewH6oPNsvh3tQuf4oA0On2tePtUO7MafzkDFFYTS2PU5zYY6DLmrZLXPjT2ac4FI+xkMsy6SZ43W833CCPXPH/Nuqtfr8NTx07u2CbxsU3qB6mYb9hhrom7oeGrex4/i+qXYP43t3V6FakO4C3PNDcoS2krOdcZgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657612; c=relaxed/simple;
	bh=HhiNT8WtJ5UnsV0LTfwpUvGlM+nI1sIoXZbOmQaskNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JiOD1lq2kJEfjzPilWM301eJrqQsWXRgq1ONjo7EZTSePRMs2SeKo5ZA6QE1rriO8dcGb9/IxlThNv7Iur3czGTGnEEC4TfPhYBYKo4E1Lz8VfApAaYsnHQswKKbCT0zx60iPyxM6RPk9aHp5XJodGmbfCBB52h+O/RX4Lk0iPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2jMZ10p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2jMZ10p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51C8C4CED3;
	Thu, 23 Jan 2025 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657611;
	bh=HhiNT8WtJ5UnsV0LTfwpUvGlM+nI1sIoXZbOmQaskNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z2jMZ10pdX54ob5jEG0IdMcqa6fPw/dvrJ/wwKlOSns+xI6+GSnFHwyjU9zAvRb/K
	 84RV3YJQ/mvgDXLaIpAoxuxObXskw35etEkLi4yJDMu2hjOOi8kWAjZ1cj/eWbZ8DI
	 hS2PsaCBcjemC/33Gju0LgNDhxcmM5/tLJ0q4d2QPqu8m7YqKmXBu2YS4cqaehBfHT
	 G+At9sjiA/qVknzs/elZVuLVhwb5XknTCv1BF3bTgtUtWD3N2NIJfl6umG2ByYOwd8
	 O4yI+6GaPKN3beTE3G+irNwtNzXVZsm6XZGYInaZHIlQO5EygvE6IIfx3PZzalwdXv
	 YGiHCr1C3e1pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B00E2380AA79;
	Thu, 23 Jan 2025 18:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] org.bluez.MediaTransport: Allow Volume property
 to follow profile range
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173765763651.1461938.8276338956088755748.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 18:40:36 +0000
References: <20250122211446.142626-1-luiz.dentz@gmail.com>
In-Reply-To: <20250122211446.142626-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jan 2025 16:14:45 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes the Volume property to follow the profile defined range.
> ---
>  doc/org.bluez.MediaTransport.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] org.bluez.MediaTransport: Allow Volume property to follow profile range
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43dbd5f7e64c
  - [BlueZ,v1,2/2] vcp: Fix using scaled values for volume
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d9a70206e38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


