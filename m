Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8D2DA75A
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294991; cv=none; b=Fmh5mtQu7WIoLsATOKsbC+0LadFE1xaZGFikwuRZFYOZPIPOd3fPCwE1kYoARpNOuEZvg+QveDGxmJUQmVpFr6WclEYEbo58daHzKVB88QKDbaBgiSCyWC55nBuFkjgJU+S/dhMthlGota25W5nYRR4HJ08T7XM0TY9xPFDzeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294991; c=relaxed/simple;
	bh=v784HLFsrr5PL8cuM67Xs7LQyI7nD9uaVOm1W4M3uWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4SMs1i8+lChIYcqgUGJrAA+OP3JwjfeDtBVdZutrgviMKZzFJ3/kQa1zjlWFx2ZNinbQNlsiU51s4gpnoZWlF1XeR2S/qUyZ+Rc/GTLBAXVvYWPNxq7X/ga8rxsYWEWku1giI+4zsbyoon9Ad3npeSDfznz5jtVqGg80qAS0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oem/b83L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oem/b83L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE6FC4CEF5;
	Tue,  9 Dec 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765294990;
	bh=v784HLFsrr5PL8cuM67Xs7LQyI7nD9uaVOm1W4M3uWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oem/b83LpcWyyV4Um2O4/QvxHKz+KYX6mfS+NYALVnZ+Kk9CgCWSgPO+6QGsRr/3U
	 dOSNj0DWzk4QwHgkZiKTZexor9/Ae6BWZKskvo9VriGFH5Eje76C1pdKbb29QRSPKA
	 m8LJ2FomHuZ+Gn6bXDHcIOBgSsdMN8DZEKPiy8isxQMP+WWTqF30eU7kxi8UWKId6R
	 mfFpwaMjOBfrcobU+jMzzNQsN34DtYVq3AmARttfgwP1iSBX9HeeDHxV//iy8nW+Xo
	 7oxv/JZNBT5Yw2GW21qOXQibINTFXx+yTJUZbQZ5YREj2s/0YRROji0cQZ8JCt8Uet
	 0Pr8lF5raDNDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58093808200;
	Tue,  9 Dec 2025 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: show ISO timestamps and fix their handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176529480553.3991988.9413786417635977269.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 15:40:05 +0000
References: 
 <d86bbd8809c75dea5107ddd0f63f300d3e9c6423.1765030276.git.pav@iki.fi>
In-Reply-To: 
 <d86bbd8809c75dea5107ddd0f63f300d3e9c6423.1765030276.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Dec 2025 16:11:52 +0200 you wrote:
> Fix ISO packet size checks, taking timestamp presence into account.
> 
> Also display timestamp value if present.
> ---
>  monitor/packet.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ] monitor: show ISO timestamps and fix their handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=359390c60d9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


