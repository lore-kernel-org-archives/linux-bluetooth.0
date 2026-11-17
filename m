Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941412;
	b=qNBPbfNzgXT+11A7ruZZ4zuwGMlOtUwpx32eeqscs7eEFv1ygEFSRFORCGez+85UE4OV
	 K/L1988O7w8XBthtrnhFwAyh6t6kInXmoIT89Bb1r7xFW1XoHjVC4d+fS8lD62c4Khptu
	 J/Uahjuc5NygaMHalyN446CitJHxs91sNn8iUEkgtqatoK/Cl6Eek7fyK+a43iWcPDzv1
	 RHMQ2vg2fWhXXjorhmnPTbjf+fXKgqe9vaW9OxGTtUGEFIPlF8ht/dGbKqt8416At64o5
	 u6I9L8BW4YCJCHt5n2sALszi4Ec8CJR2QYp7tTTf79KLahwKZp14wwmCZXMvl7XgSKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=EHut089wnS/b4OXavmg2hTDdLbDx29zfzsq7IO+2Qpk=;
	b=Uo3q07iZhRY8wcrLYmmAVTUKg0AC/0Rsjz4/K9UQwOuoaj3SmVlhKjNUYh4OiT7LVB9n
	 mS5ZfGinyNafRKfqqXtZm7QB3FXXKC9xIoAcxhQuC+YKz+PNdeaVTFE8b9p/JbtkItmJT
	 uf+SZhR/NBnyu010QlGI4MsKL2AdcTib9smyNs63BkhPWlSCwTr9tOLMOe/CPnORSjPrx
	 HnP4BiBaRXPvDe80SwZciwIOInuWQ1LYW2mNZ3eI16jRgTqvr4+ymg42oyDtnPW8PEo5A
	 +K95a/g992O1dFeBrcmKhYv1o6XKDgw6ks9GQiPzP91Xk0e0wjFLmjg3HceSOlG45fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xws8CPdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69852606A887;
	Tue, 17 Nov 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xws8CPdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EF91F000C6;
	Tue, 17 Nov 2026 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941412;
	bh=EHut089wnS/b4OXavmg2hTDdLbDx29zfzsq7IO+2Qpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xws8CPdYhkVj0z/5HaONQfHOtEVAZt9Fheb2hv+VY4q+PLxuekPSSqrJnGxjMi3Uy
	 bSTZjUe6QTH/o5nraauAes6ZhCk0jLKeblpEsgmtz2omct/Z0xYKoiNwu9scJ8briL
	 ZFGkwc94Az1HmfeZdm+5HfQ/Ap6Jh3Ft09PtBrh7X3ghIOSLsuE6DUsU6AUf7u3OOU
	 i6Cxt/0Jem0pkAfeelSlbmL92fe4NDZvXGqqi0xk5vqBy99cAUlSRIUCUEb1US09sK
	 SlWNWDyH7D2Cstpcu8PmFMFMBeULOdB6chTq0uYzPoZ3OTOLdXS2mldULn0ZkwVd2a
	 LVHhzsauTgi5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A39E392B1C5;
	Tue, 17 Nov 2026 18:50:12 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: L2CAP: return LE credits from recvmsg under
 the
 conn lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494141077.761488.1132043002777278143.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:10 +0000
References: <20261117144938.82299-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261117144938.82299-1-ngocthang2710.1999@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stig@hornang.me, syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Nov 2026 21:49:37 +0700 you wrote:
> l2cap_chan_le_send_credits() allocates an ident from conn->tx_ida, sends
> L2CAP_LE_CREDITS and frees the ident right away, since the command has
> no response. The RX path frees idents in l2cap_put_ident() under
> conn->lock. That only works if the credits path holds conn->lock too,
> so that no response can be processed between the allocation and the
> free.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: return LE credits from recvmsg under the conn lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/5beb86f98c3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


