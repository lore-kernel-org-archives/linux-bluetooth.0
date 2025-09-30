Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADB207A20
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251015; cv=none; b=q5O3mg8Nr4mwpxh0N5/JjHwxycMpcg2PiVCkBVG+e5DrxaLNX30QNgsYHCucj5KCFB3LsFd0XOUWil6nC9gbccZLiWQzo241XzbpjQHbLvXPFaSVHxGlGK1kmjLyNTq7unFYUA17VU5IZX3m/Kxm2Jbq5nRQStMXgpPzdjpQxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251015; c=relaxed/simple;
	bh=YNNIl1EBFL3PoZBEoUnIRkrsszNQOd76tRj1FoK1Jnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IRRbYMiMwzV8o/YAZOiWMS/FqgfUZIplIYXPsuC6QgKCqKFHDi9W5IUuYCdYTM8+r/k9awL9Z9jaSvhLfF+6m4LXDu89y2t5owAJDi4Em4P/AXteW9lNoZZ6lskfIIldJRd/mMJrWgDn7vGAei7PSFW5wHNDtBR9wjr6ydBsd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCNCKXyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCNCKXyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD6C4CEF0;
	Tue, 30 Sep 2025 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251013;
	bh=YNNIl1EBFL3PoZBEoUnIRkrsszNQOd76tRj1FoK1Jnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCNCKXyH2zRf7itzREO22oHUxDwzbDYi0AtAqEH0BPadSHsI9a+S2q4AG0zf+QziQ
	 e8rkVkwB4iS5uuJWclW/izwR43aChw2BiiyNVbYkq72ss7iVayukW2ZmBke4E6h9FH
	 XpqtaPUr1UEXDzIQm1dBohOs9A3Tz9JRvjWuO6YeTj4/V/ddz3rtWegHoF6X09fyib
	 KB5caiB2D7f/VzNlOCNRt+18Pscgau15F/mD/YTg3D5cPuqQmdM/HW44jnSrwS67p/
	 ri0uZkuY3HW4RjDWx6eWgpN34zy/fqNGRlFVQkxGf1EVebpCITKDBuKD2z6M82We7W
	 SCnhL59lbyHMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3939D0C1A;
	Tue, 30 Sep 2025 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: Fix typo in PreferredBearer property
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175925100675.2045788.17172654560277241197.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 16:50:06 +0000
References: <20250919084324.2799981-1-hadess@hadess.net>
In-Reply-To: <20250919084324.2799981-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Sep 2025 10:43:21 +0200 you wrote:
> ---
>  doc/org.bluez.Device.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] doc: Fix typo in PreferredBearer property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73dd85a18b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


