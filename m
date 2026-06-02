Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EE3FC5C3
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421405; cv=none; b=Ti+i5EKGRPav1GXWAT+huY8iPWhAjKMicGeB4KFQXAi/pVbaRW9ewdVebweuxUS6o5oiIXHfyvKXP36icYnMd9hz43gGOrYVtMDI3dgvrnjyplGP10Kd71PvMMsriEliGCFjadUn6ObuOLy8RwpkWFWkngfGU5N4SXaChnRihYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421405; c=relaxed/simple;
	bh=Al7mB7SqFYYVu+9mS6cGDYWWre4WeHGvUSNAcHECIKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BbtB3XoANX5nLhfWAzdq/1izp8UD4aTlUW+LuNPw/4Qj/uQuuDm4NCR8mR9+lAvGR2Fgyp23lgsg6dRr/i4vqAll5kdmmyHXCz0ipaW3CG4eApPY7fguPaw+0HhR3Jfqcv04zNtZJF5fQcb3ks8CMZKVu6wCb0e1vLE7agzWvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOpPX5vV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOpPX5vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEED21F0089B;
	Tue,  2 Jun 2026 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421404;
	bh=+9tB5tl7gat9eL/CJ6hEhd4ifnTDz+ZMhSQF9WsKBNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YOpPX5vVZou7TpErUbl7xuVVo+qlKF27Huj6m+Xmst+JgbsHrqA8afD+hPOP7VKyu
	 sNc53UqRPoFiudzP3ZwnB+GENDtBv/01EPe+fUsZEcvF5m/nFkX5b+6YPcH3nkepXG
	 DxKprdl7tdb0p5pbDdeJvQ6bXnLALto6HFx7tn/q/uDK3YxGFSaVZv7q96Mofz5B2i
	 7jVxDG7pG1wcDdmM4d+KhBVRCH00TZtmgUHCD5icoF2EbmbXga2rva5/IDf/lJi72q
	 SXVVnUPOAt3KSBq06N39JHxqo4QQEUVBc5rbULQpWUqoRURsAdwDfKoVnibBEasw/N
	 OE6kedFBCZmwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199663811A6B;
	Tue,  2 Jun 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] client/btpclient: Fix GAP unpair command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178042140556.969144.3241776766056523976.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 17:30:05 +0000
References: <20260519085016.188744-1-frederic.danis@collabora.com>
In-Reply-To: <20260519085016.188744-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 May 2026 10:50:15 +0200 you wrote:
> Fix unpair_reply() because the device is no more available on
> RemoveDevice reply.
> ---
>  client/btpclient/gap.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] client/btpclient: Fix GAP unpair command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=96a51d53ccf3
  - [BlueZ,v2,2/2] client/btpclient: Don't remove all devices on GAP Reset command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07b6fc156348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


