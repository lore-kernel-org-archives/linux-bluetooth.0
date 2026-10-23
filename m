Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794016;
	b=fK6Wg0dG9u6eBHf2HP2QYKzh3nKicxHOjVSILzZ+5ZLXWfRH+C7QX9Wlfto3DeN247Y9
	 zvQ8gnjeD1WjVYL8yVGt0Y4gv3ff/tNQHBWUh9aTI5XzocQyoflFLK5klo5mraop50DGS
	 vRtTbOyjpvjn4B5COzkTX6126Kzsaf1dOOfMf3A8/ey7eZXE6LrCPKDsSQ8KLGdF7HYj0
	 z7VinBnhitIhmhUdiP+esgkf+bLgnHQnK2jNbt4z0zMtQdlmA2OI5z3TPoKM8I4MD15fN
	 W1YRffj/0rnm6d4PX/JNNgtdxPCSzI2ooe4lQ8pDYPv3CUjQxHR+YX50Rm891o44ZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4Ly8cQoxoPYBxWF88hOaZ8lpCaF+APRwR2uG7g/gOXQ=;
	b=v7ycB4NZMmYMfglN1EcvfBhWiv7fynR+CPfb32gDgZCdSX7J5c9LJRLBsr/VfVPOezkG
	 jRgJBsEiZyogScddz0CPMVNuPSCGS+3FFY/CW2GcQaXRnyDlWhhW9QLKaBHNXv4JZzn0z
	 2ShLNsWFT7DriANK51sbjyfEdOdpehlq55SBPXZkrQa9SAvV9oc+9IpD97eXMvI4Po/OD
	 zpK3XswaxAI5lpScfSrNpmxEtGwVQoAq5hIk469vxbDWBxH+kPGswa9H55JsagJHCiOdR
	 vAC9azPnhDYrxyCUwA7Jo49P3+uLy/Gu5UGhzaYmIWEakyoG2U+Kc3qnbXjXEJx7lQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPtdjyi7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E70606A322
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPtdjyi7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9FE1F01825;
	Fri, 23 Oct 2026 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794015;
	bh=4Ly8cQoxoPYBxWF88hOaZ8lpCaF+APRwR2uG7g/gOXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EPtdjyi7U8neVEVOlOmtOLGdM+MJyL4QzZaGsXEyhYyL4FFHUsxfyQf5tErOMtmUc
	 uDtn67uRLVSqDE5FEUiBLY//7/eghicNEpObK3eTAc/0RyRB8Nc9vSREruTPDok3K9
	 uQ7GlXeFsjnPpxRpDAXkCaTX4E6bB8DEbyqr4d8jqXxvbnjtMuExYksms9t/wkhKQ+
	 XiP2coIexYCC5cByipcUNpOsLkaBtZAELkPev+HImGYXLTthCOS+4MAIhgL9CZrKf/
	 TLK9H6VlUrSjaUwAcZDzBlGeIojoo2gDNTQIAuGlSo7MoIjk60jLIZeHnqo53jvIvI
	 l170WnVoUYNBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44772391B158;
	Fri, 23 Oct 2026 22:20:15 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] obexd: Handle message read status change events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279401388.1297354.3202289018145725539.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:20:13 +0000
References: <20261020035617.1089331-1-sadiq@sadiqpk.org>
In-Reply-To: <20261020035617.1089331-1-sadiq@sadiqpk.org>
To: Mohammed Sadiq <sadiq@sadiqpk.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Oct 2026 09:26:17 +0530 you wrote:
> obexd is advertised to support Extended Event Report 1.1.  But it was
> not handling "ReadStatusChanged" type which made those events being
> mismarked as MAP_ET_NEW_MESSAGE.  This resulted in existing message to
> be replaced by new message with only "Status" property set instead of
> updating the "Status" of the existing message.
> ---
>  obexd/client/map-event.h | 3 ++-
>  obexd/client/map.c       | 3 +++
>  obexd/client/mns.c       | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] obexd: Handle message read status change events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0580dad5655

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


