Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194210;
	b=kER8fZw+e3ftN1WS9bII+2rvc3blVhTbRnIGfyKQSw2DOeq5wLhQes2Ku8bYx1eGj/f6
	 U1EhirjFZoaOiOPCM38tEiyosb1XLwpveS2FMReslKgt9WEZRU0YHu88X007StWMDs6fy
	 qG2i33yMXoAm7IQpP7i03n9f65xwqsal3aYl5Iv7XrCO2u6TiX+S6OtNwihdAPB2TfxaH
	 meRsaxbZ5drPBzlSjgdZNkeF3wzvZO0vGS/S2mNyVJrsQcw6EqB0OiHiEjICMLNuO28OP
	 8PvY/iEY5doTzOYFMum9KA6uiakNSWdMBpG6FsornA6C8jWRCkmVa/OiEFSkV5CImYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/oSpqNkjlMkpjW/eur5qqXyua3ueYm8+FgaS+n7v+TM=;
	b=uXU1vMZnnADFXMCTUzMjN+u3P8+IFHEqdZ2eutNOzs3pqPIMCgiADaJIPidNNMES3QRS
	 MUgxeHhaHr/0uccHs2sPrAYrHpm3E06deD0sBGo5nuUfZEVRgUl+V+PprkrSAsCf6G7RA
	 BMr+1V16CLOPk+BR09wisrX3/GcGYH+1BWxfCn35PaazHeb0equ2duZJBt2RMJphebhg0
	 yWgsAUh/G/RMhEUUXNVJnWveUFGhsUMc2z0dV6Imyi4aizWZLD7Xt7PGRff3TVLPHyVhj
	 TirW8CU6MSJuaAbTntykNGhJDaZ3DYlbkTkbaU3exocJ6iouXK975WX3UhrB+3Ofbrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=De1yMr+p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2C606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=De1yMr+p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125451F031E0;
	Wed, 28 Oct 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194210;
	bh=/oSpqNkjlMkpjW/eur5qqXyua3ueYm8+FgaS+n7v+TM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=De1yMr+pp1s21dk9V5DzGZ9aOitqSfUujfKGfmvL+Ux059mgkCxImBZb9oBe5Be2L
	 8ECS2YCLqGj28ziTRKKoYe/Qx2MhRwB4LFJI+I/blddNRTWgO0BIH58i03QfSLGEC1
	 Eu5aNYoov15eZnzr4ARlFuBTiRy2H5OEIOb5UfWDPzWSD5zylEsjg/fKjmgjm1mexG
	 G/f965Y7SgrLXfvV24OSAhONnXJDFfaLTvXHs4PkenJZibH8N09JFl6eqnP/Il3qQn
	 kEqgK6ET6MShm4/aVJvDL77lzZSxai3iVA3n/pD1vl/e1hSQZhS8PGUx3S936LheAs
	 xIGeiv7TMVGbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 076563AAA6E8;
	Wed, 28 Oct 2026 13:30:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1 1/2] ranging: Issue CS Security Enable based on
 the
 ACL role
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179319420856.722681.14638147747357060653.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 13:30:08 +0000
References: <20261027140953.1854740-1-luiz.dentz@gmail.com>
In-Reply-To: <20261027140953.1854740-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Oct 2026 10:09:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> CS Security Enable was only sent when the CS Config Complete reported the
> local role as Initiator, and a CS Initiator that is the Peripheral of the
> ACL moved to CS_STATE_HOLD, dropping all further CS events.
> 
> The CS Security Start procedure is tied to the ACL role instead
> ([Vol 6] Part B, 5.1.23: "The Link Layer of the Central initiates the CS
> Security Start procedure", and [Vol 4] Part E, 7.8.133 disallows the
> command when the Controller is the Peripheral), so send it whenever the
> local device is the Central and wait for the event otherwise.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] ranging: Issue CS Security Enable based on the ACL role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7191f261b596
  - [BlueZ,v1,2/2] ranging: Fail CS Config Complete on role mismatch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f14b93eb37f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


