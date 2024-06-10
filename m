Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EE14F9FE
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028212; cv=none; b=QSJOnHAMTuXviiyVmqAo+abDpsIXCpfnvVdkoAgkfPzbxsijng4OtuDZ8YpVv/muVti9auPsco+CzKeyBVRLkpzcX6G/YxPSWDAhr7ZNgXfi8wOJSpDNG6lCNsM2IRgVlWU5yvTTCk/2bZely47ymd3RJ6nrbyS5INQA9QWLwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028212; c=relaxed/simple;
	bh=GEQv4UG44dDdt2F27iv/wOFklHaBVypZ4qqj0tU/CcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwRgtc8zKysSbC2JeNs1JMoaau43QwhbGOtlVfk08nwU/w4RMSEUAvMhITywBMZX3fBDb4HVYXzUc8NureXl1YImYqx/x+/BmoNRx75IWlU1aq5D7Zr5KEIHEzqsnjkQsI2gznArjVag6fVaf4ZAcpdBFQs/VUrYBuE4ynPGDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xopg1P5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xopg1P5n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F05E9C4AF1C;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718028212;
	bh=GEQv4UG44dDdt2F27iv/wOFklHaBVypZ4qqj0tU/CcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xopg1P5nY4OgiQEgiqMrxHXSx+68Jqc4I7aP+eaMwx2QiDwHnw5Phrprgwkg9l4g4
	 lzRX8o+Xomv/CJO5rd0do4MhrxuymE+kB0MIccy88M1rXMRM6sWE7DQBxpxuMtMLT+
	 F1AqTaa7IlIWRL2aQZXo4Q71/M5u+2/+YHfukm5D0KWn1U6m7tXeKwcQW64sSufeu0
	 0rlUqJ9wlefHOWGp7StF96gj0ZOQpgalidWBAQdcwXYrwjnhR3ekuP4Rs/YsHIA9T4
	 /qpvEfov0GeFR4HIkDgoON3PkQyzRoMOgbP4gyRG5fDhC0to35w3thhU3tlYM8Vgu3
	 bHqXqwT4O2Trg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCE69C595C0;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: fix connection setup in l2cap_connect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171802821189.16143.4037295666100940791.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 14:03:31 +0000
References: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
In-Reply-To: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 der.timosch@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Jun 2024 18:06:20 +0300 you wrote:
> The amp_id argument of l2cap_connect() was removed in
> commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
> 
> It was always called with amp_id == 0, i.e. AMP_ID_BREDR == 0x00 (ie.
> non-AMP controller).  In the above commit, the code path for amp_id != 0
> was preserved, although it should have used the amp_id == 0 one.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: fix connection setup in l2cap_connect
    https://git.kernel.org/bluetooth/bluetooth-next/c/5fe0be8868aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


