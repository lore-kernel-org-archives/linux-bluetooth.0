Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4F345CCD
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069803; cv=none; b=X6MbeMcvauSWn769hMmzKWOD6PVypJkeRR6mCwfoUTjpaVyHc9f72PYmpjw+gJhER9IBXHJhgoXv/8FQaJgaUZ/NCEwhA08pkC6/yfbb6xk2oERFe/rIe1XeOvTClhimt9gXaJZHCgjzL02lfj9GhDFpwktLlChwxUktwt7ABBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069803; c=relaxed/simple;
	bh=y8a/2f3qig+Y/bogDVtx+J1zMtxGTTB7GD9rWnWxl34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tpbntNvH7Bdt/nAis637/yjxBBCRRcuPLjPBCXsOEW8hcXdWwayBq7xlIQ99kLkBfqFb3vlCbEZa0zGsUvB+HN8jMnAPa1i7VepjTn52a09mImpZHc2sU9BYCi9jNifGXkdO0hX/oadRMSjHSWpEKgX7iNJ0uTfAEnbXhZbDjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sny3OKnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sny3OKnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC731F00893;
	Fri, 29 May 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069802;
	bh=cpVyk+/RaICMYssB1qgFEhpsD7zURzK4UcblXLiI6Gk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sny3OKnQ8wC4JKytv3o1NooKrEYHfWdxyVMiyWrRje+AxaqCcrYiVUr4M42zVN8Cf
	 1/40LibXh9y8Gv3Ul70PIaOY9OPU50BnQKDDd+j1pDDO/4xm3YdXLOrB74m1Km2NUR
	 8N6V7fgwtPsh3uGtn7soa3xGJN4CN+vef5e0j0myDC/OOUh3TPFUR4V6W4s1jn99O4
	 eRllvIJ6iI8RfLe1Ns1tJTxToueF1KDOEKIwntgh19s01vI+PN+Yz07SQvm6q0SNC0
	 ERouYV3ItF5V6W7ObUbFEVEU33xWhiwdtuxKs6ATOqYZrZgqVMQbk2/eIZaArdv7AZ
	 7mTXeebfaUfFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B563930193;
	Fri, 29 May 2026 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over
 MTUsig
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178006980639.1863338.949491085848343135.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 15:50:06 +0000
References: <20260521144518.1361335-1-michael.bommarito@gmail.com>
In-Reply-To: <20260521144518.1361335-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 10:45:17 -0400 you wrote:
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing. In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
    https://git.kernel.org/bluetooth/bluetooth-next/c/a6273f046450

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


