Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C943CECA;
	Mon, 11 May 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517057; cv=none; b=qrCLZpTqKQS5XjJ0ILLH4qaaLs37CsI49O0tpXr+Az3FgOpAxy/iiylZEdw+evI6nTT6xojD10291rBKcYDeaLPMHeVRllPLqUzm121aXaF6z5N/NQYK7Y5/5iL77PKzpB3QlYshCCfN+w7P2psASvIQUcinE7y8t7dPlKfWOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517057; c=relaxed/simple;
	bh=TU8kdulPflsf04KhGhCSZ/o25soe3K9BuV8q+p9DzDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5371RdO0Hvc7hRysXw+8DNhi8z/XzXHVyzsVlBJWXAwz/K2WCrVzAB8I+rDU+tAN2wLfU5tmr3IXrdjFVRGZr9D2vDpLIFcCrxg3REQ4OYWFysHm9o/2R5Wpj+vIFlgIF7t+Lzxoqo3z2cU/qFqvdE+COyfvBprBaoHhtQ8YaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtsWHop0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtsWHop0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4FFC2BCC9;
	Mon, 11 May 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517057;
	bh=TU8kdulPflsf04KhGhCSZ/o25soe3K9BuV8q+p9DzDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JtsWHop0IwdhQEhNFeyqiAfH2nutm8Cl7quAqaTydRi1PK4tQ8ikHHKb/41RR7Pcz
	 MTb2VpPVxlaynQcIm3klbQ/r1Nim/W3VMe7unXRkDmY5ei/QaVpkqddYtgx8SHV02u
	 C7sebkvyXwFowuyZNS2t+QFYPic7I1VP1CMrcoIKb797HVlqUsf/5EZqevxHR/IRkP
	 W9tFMivTUHg7QEhR2QEJLo/juV8FzhyKiMgFwEhkJdoO0QZfiBnKDzIPlEGMGPYLX+
	 M+ycx6edJ9X/zkvGNzzD0kh0j4KscBZ61BGcoCaA5vZU1gTnY0X8R/O33yPWQiGSx9
	 w3BQtVTtFc+Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0973930781;
	Mon, 11 May 2026 16:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: ecred_reconfigure: send packed pdu,
 not stack pointer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177851700405.2324731.8694479011940333354.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 16:30:04 +0000
References: <20260511122641.437434-1-michael.bommarito@gmail.com>
In-Reply-To: <20260511122641.437434-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, gustavoars@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 08:26:41 -0400 you wrote:
> Commit 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
> warnings") converted the on-stack request PDU in l2cap_ecred_reconfigure()
> from an explicit packed struct to DEFINE_RAW_FLEX(), but did not adjust the
> size and source-pointer arguments to l2cap_send_cmd():
> 
>   -    struct {
>   -            struct l2cap_ecred_reconf_req req;
>   -            __le16 scid;
>   -    } pdu;
>   +    DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
>        ...
>        l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
>                       sizeof(pdu), &pdu);
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
    https://git.kernel.org/bluetooth/bluetooth-next/c/82b794a4b4df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


