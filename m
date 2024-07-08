Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A057CB1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454430; cv=none; b=hUqy45XKlIZrnGc2/ZZAXOjpvETVsoLW/mT9tIv+8hc6L8Dfd0ccRiBPZrL6WGBnDtmpAansqdrQjzPdf/NvSNzQBXGoJuI06oucLt6FH07puHfzQ7ZPbg5H42ylAP4QiwZ/UZcWObaN5N+ZKOZknOjftFZu3bTEqf1fSPssBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454430; c=relaxed/simple;
	bh=ZQOB+CGojPZOqgKCewSR8M6xvouhPxZ35elZV7PvufI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uHkMjil7LBLTRaT4dMPHenu2IKufjRX0CRlG4k3cZ6Sayf5vxdlvoiw65Y3t1LA1urmfIXyqtD8AkDuSBqxNxqGGvfpvjMrkOOBJgK8ZdmRaLgUjMb5rvUEGCyuNhARWPDuENG4pK9jTkBWbqdBW31RbOAQbQMPi3JgMr6qZ7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaNGWEvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaNGWEvD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35467C32786;
	Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454430;
	bh=ZQOB+CGojPZOqgKCewSR8M6xvouhPxZ35elZV7PvufI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaNGWEvDozSdLN7QkOxj5/aiUV7SD06gycA7AaaFPj80GmGM0rFpoAoxpxKgKA6d3
	 9Tsg0U2VaxJXfxSik9vpj7arvDB+Pg4i72v9TUoPE4d4URYhR6RAkmfhfWSVq/5SOF
	 TenCk6Zt14W8HuAWZuQ34rC0SZ3x7XuR7255/M/AyMfSDfaKIW81tEXKH/cjWL8an/
	 gw4iiOr5gyk4/yWx0kblPRbW0hgHgDSJSXzjfQ/YxBDbkP/Ii/dRmSDVbrWA43e0va
	 dY9zxvV3NQh8YdPSOCynUdHtQajcfLRyapV/8ASOXFLoM8JtJsajOzO/eYnSAxas6W
	 0BLWsXLVzd1Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2558BDF3715;
	Mon,  8 Jul 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when
 discoverable is off
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172045443014.21290.6030624814065789158.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 16:00:30 +0000
References: <20240708074454.5891-1-quic_prathm@quicinc.com>
In-Reply-To: <20240708074454.5891-1-quic_prathm@quicinc.com>
To: Prathibha Madugonde <quic_prathm@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de,
 luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 8 Jul 2024 13:14:54 +0530 you wrote:
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
> 
> Fix for GAP/DISC/NONM/BV-02-C
> As per GAP.TS.p44 test spec
> IUT does not contain General Discoverable mode and Limited Discoverable
> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> case, thus set BR/EDR not supported bit in the AD Type Flag when
> discoverable is off.
> 
> [...]

Here is the summary with links:
  - [BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42d43b28428f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


