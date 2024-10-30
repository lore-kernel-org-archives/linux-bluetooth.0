Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0471BD9F4;
	Wed, 30 Oct 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313025; cv=none; b=OdMi6xqbpnLLucWS0CMaQllOSIT5x24D4vxBFgh2aC4ngxIREfoHo0BSFh18B88s4gv9Q42Ry85+iZkD0FC+CakI7/iG3erRz5jvZaKXbCe9so0oCEnp9fcyDMzPf1f/hvLSjOBdc6uDRfMM4HK4x3+t/zHi8MUchdzTj4hJkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313025; c=relaxed/simple;
	bh=5dhRFS3XnB+S3QVFTb8wGy1KKoP3Le/rBZZgA4M1pvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElmcF6d24FTHuPTGuJxZTX8VqZJg1NuHp2W8xP8ejIcsdbAPGumX21ffpz4+bxSszqxmycoxkc/6Vo3y36IJfwQ4d6b0ANaW+MHBaTYCjyctQFfFwd1s3jZE38UjLBV8Pl6t4Q382FblsLlmM7JG06qv/317QHLoSocIOSlKC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+n+fQPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+n+fQPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5173C4CECE;
	Wed, 30 Oct 2024 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730313024;
	bh=5dhRFS3XnB+S3QVFTb8wGy1KKoP3Le/rBZZgA4M1pvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+n+fQPFbR4tUtKOYDE1sQRCqMBf5pD02fonwDqCH1iSmewlkM413VDlD3swiwZWF
	 8ei7l/C/i+zyFzGwYyYwWtOaC4oFPobSsNPEo9bNN1CQromp977jquxKWVHw6jwOgC
	 vYq0c78Wvu24H3dSIh1vqDGmcArUsaK+4+IB9arTEWFr+nifnnPsDpnQ8zEwGPkW1K
	 7RkvZtu0bi1s8mdPs/R0Tl91odnRyaEvCSZo4LYmsaafFNI2isYMeeqzQ/hQNtzDJO
	 cZnzH8zC2x4b/ch02gK1IJED7WRO+EYv0nfwkOw9uS1F6Wgod80iIk1isNn54oboqI
	 I05+aJD9C5/Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB4380AC22;
	Wed, 30 Oct 2024 18:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci: fix null-ptr-deref in
 hci_read_supported_codecs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173031303250.1428768.6665281054491873346.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 18:30:32 +0000
References: <20241029194505.2094645-2-iam@sung-woo.kim>
In-Reply-To: <20241029194505.2094645-2-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: luiz.dentz@gmail.com, daveti@purdue.edu, benquike@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Oct 2024 19:44:41 +0000 you wrote:
> Fix __hci_cmd_sync_sk() to return not NULL for unknown opcodes.
> 
> __hci_cmd_sync_sk() returns NULL if a command returns a status event.
> However, it also returns NULL where an opcode doesn't exist in the
> hci_cc table because hci_cmd_complete_evt() assumes status = skb->data[0]
> for unknown opcodes.
> This leads to null-ptr-deref in cmd_sync for HCI_OP_READ_LOCAL_CODECS as
> there is no hci_cc for HCI_OP_READ_LOCAL_CODECS, which always assumes
> status = skb->data[0].
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
    https://git.kernel.org/bluetooth/bluetooth-next/c/af524ed29eee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


