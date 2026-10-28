Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194212;
	b=3aqGZTDk/PULw73jhroKb7fpkyIKxjGEdXpLizUu8334RTjUO3qw5U5dyqz7GPGDLH5r
	 KT0+odHA4dUVEwrs2gx/RUfrV3dBxUpoAO1qv/PqZXhAUuOPeFW0QCkHuidqDT+GmZXET
	 ywKdIroqxoB649sNlOUzk+zr/gzz3GjhD49fz1mUUHqLEb6MCZiiwaMi4edHx4OH7E1X7
	 NZgw+5P+/4ddeN3rHGEdiRyVqxUh3Z9F1+emLm/nj5d14gut0Vq0NwZ1ldxuVin5rxhF+
	 HugMKz8v2CZxepionddxLKGbC56IVZkfBzj3kcazuU9tTI7SsaG3XYjDVZFI9SNyT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OkRIW0bn9o8i0Nxn9ADmm1uiItFfDK1zfUUmulayyj4=;
	b=32ZVrwHujns5cxvrYr1CwymBdmD3RGFnTk8dugSRmCx1yb8dCWPSz2JvIJ5IYD6xUVA9
	 +cp43mx/fJw5YLh1sqvMmoc+p/zs/YRtUCkypi12QjkbF3g6J2qDK4rm9wd/i2TL0sAn3
	 KcxX6MVVEaD626lQ90Nvkbfqs8C5ORvFF17X/gKgRjqu3Efpiwa0olAIY0zRB7mPJfcwD
	 KzSvhKXYPYreX3ro6YhJkFbczErria3KNXgoFzbEqtZqgz+3zma18cAHkuwIBpIQxvkTw
	 2QWutHSR0hpzW735txHQg7ZrhnW5JqeSqhtaQStxUOXlyVkNeC40NujgLxwgaDDhh+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMJ+SDNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE316606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMJ+SDNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C87A1F031E0;
	Wed, 28 Oct 2026 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194211;
	bh=OkRIW0bn9o8i0Nxn9ADmm1uiItFfDK1zfUUmulayyj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oMJ+SDNIV+iYKbSUAI834BpQYezpMdzTCyH0IIPztZ+4KkvFrZfz8QRSrOmb/eXFF
	 oCcx2LtkcEggzVUKpllb19L86JsjtNWrnCD2FvcizwRdrs3oGyFQyF74E+GwT78RH2
	 6kT1RbTUMnrO1PF0Mke0LOOp5mAtH0E2nLRTCYlTBPM/VhyeNKF51IyO9OUeohJVEk
	 SaP0g10OoYiBwp03DTOI3QDrNKX1DwnkPjoL4aGiOJqIChDsUM6ZnT29evs/b01/me
	 yt3407F+JOdhwxozvejMGLhxULGjIWES6ZAJr+YBoPOh+3vFM6J16vUtjQ3OfQMNyt
	 3bO4RDvuGrqog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814FE3AAA6E8;
	Wed, 28 Oct 2026 13:30:11 +0000 (UTC)
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
Subject: Re: [PATCH v1 0/2] obexd/pbap: Report NewMissedCalls for mch
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179319421006.722681.16109161230999323945.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 13:30:10 +0000
References: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Oct 2026 21:15:02 +0800 you wrote:
> The dummy phonebook backend always reports NewMissedCalls as zero.
> Patch 1 fixes the NewMissedCalls apparam encoding, which used the
> wrong width. Patch 2 makes the dummy backend count the mch vCards
> and report the real value.
> 
> Fixes PTS test PBAP/PSE/PBD/BV-05-C
> 
> [...]

Here is the summary with links:
  - [v1,1/2] obexd/pbap: Fix NewMissedCalls parameter size
    (no matching commit)
  - [v1,2/2] obexd/pbap: Report NewMissedCalls for mch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d987dbc0f081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


