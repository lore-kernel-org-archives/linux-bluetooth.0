Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A139B48D;
	Mon, 18 May 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140995; cv=none; b=CbMGgynN6FmEaMO0TvmjcJXOM4z3ryDbaY9cjbUyGxzSVCjaeNPV6lY5iisTs8omm7wKdkhMdIAzbuuJGwHQEjNkvIQjGbVyGy50RGty6Dz+AumwT+M2rn1FCukoqP3+85JgjLXOM0oX/U0uwB8PB4QiQO+Utzh613S4uwvuKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140995; c=relaxed/simple;
	bh=dxE/wHDHm0uklJ+g3gxfB3IAjx6KLmzsRTxNLF3NZuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZHEWalZeRvx3BHAXmviPZ5RFsM5XKD2fFg1S56eywvp4Juzk3wMvZG2Db4t1dfOSb6fgBdEr9XJAiJR+E7TY2sY5SsTl+UiroVnMDk992proNziQINMlcBNaIiJs9QeHqlRwb3OIn9vB68aJ5KeXT+/0Rr9hEInigdmam6QKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DszE0QZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DszE0QZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DD9C2BCB7;
	Mon, 18 May 2026 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779140994;
	bh=dxE/wHDHm0uklJ+g3gxfB3IAjx6KLmzsRTxNLF3NZuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DszE0QZgtTKjWBcXjymHDKXEDVyZdtMcP+zmA6bZC4bukfgWdsd3Dnlgt1xJlUFCg
	 sedZdLwlsKjSa1+EBX8tmGdWRUm/Pez+WVNqooZbdiHUOeZ8pUrE4ycM7zckY2/IsL
	 JYvTyNCUX4NGHss99o8T+AfqBH8bTiJF2Poy0Olp/xNwKXBmr65aiCyGMVH+orJs8Q
	 lhZPlD+NtwnvfVo7IwHdPyQ44lzWglhJkZMOwXjt25173onSxW4/5FukqIPyqYDsqW
	 HuDIpo0mDn/qdQk2pdBtg/u2AQ8uTF/j5QpfG0KEp0wIVcZwQFySN2Lpo+UDo+sTeA
	 ui1BMbmT1b9pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569763930CB1;
	Mon, 18 May 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177914100613.1984363.1176300915940293179.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 21:50:06 +0000
References: <20260515143819.1157807-1-michael.bommarito@gmail.com>
In-Reply-To: <20260515143819.1157807-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, danielwinkler@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 May 2026 10:38:19 -0400 you wrote:
> MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
> with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
> then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
> cp->data, but it never checks that those bytes are part of the mgmt
> command payload.
> 
> A short command can therefore make add_ext_adv_data() pass an
> out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
> the command buffer are addressable, they can also be copied into the
> advertising instance as scan response data, where the caller can read
> them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
> CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
> slab-out-of-bounds read.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: validate Add Extended Advertising Data length
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f5b6b4b198e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


