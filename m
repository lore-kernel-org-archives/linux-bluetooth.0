Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2221348
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966425; cv=none; b=Llws7ju4C7FmeJD+VsPCnmqIvIvec0/sLwgBHIZwOdkBPVT51zeKjX9GDAL3GDQQF2B6qKyaCNZhOtGM2DXOZVuSvwi+fEq5hDKakUEzLlXgoK3i/2RmsjiHE/oYgrGibJJuID/lUiBOd36yIlnui1isNf1oExTdsLPzJu3aDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966425; c=relaxed/simple;
	bh=x2trk/dHTg43pgjpzlHthSa5AKI9wJz7Z3eL4FugguA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/EhErgK8CHpsEhIC2ug+iyW6asNCY5ofxL8NlW3lyh0VvfXQXpeiI/f419Rd2PUTzf8AqVvII0wFGeyKXQHUFmxiINi9e2OcDofZMZKy+gRU/PfrgunZyNuzlXxJkHJ8iWotM9kVNfO9TgqbXUYAs0h44LSDO43adkjhMTQ+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtrXQHCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtrXQHCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506AC116B1;
	Mon, 20 Oct 2025 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760966424;
	bh=x2trk/dHTg43pgjpzlHthSa5AKI9wJz7Z3eL4FugguA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QtrXQHCd9hYG6uYdt28z6bgHbd7clCbLUIFXLca4V7ZhinKDpk8fsgMiy/0MArdMc
	 nGcfhvwkUeRbaZLq5Cik5YS7+HfJIf2PpAmsi+nlpJtLyjzplXGYTHxh0NhuIyo35B
	 iHgIIWay+F2nban03SsRWyeQiNYOohKfFc0+lyE36QWrP1QoCDvQC2jxqaYTQcsjWH
	 de5feOVQ9yuPlLBjx5cEhhWFKVeFzFuPymXmt1qwqnSVO3RQqqyy8yibXYW1WLHB6I
	 tMhhW/fqmbumMXr/ihUWNwYZqP3gekd6MUOspj46lw8pIBCB9j35Z648hLnw0VltJ3
	 XaNZ9UaU/Ch2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06F3A40FF4;
	Mon, 20 Oct 2025 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/uhid.c: Fix 32-bit integer truncation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176096640676.201781.10627457273791946085.git-patchwork-notify@kernel.org>
Date: Mon, 20 Oct 2025 13:20:06 +0000
References: <20251017015759.46326-1-andrew.smirnov@gmail.com>
In-Reply-To: <20251017015759.46326-1-andrew.smirnov@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Oct 2025 18:57:58 -0700 you wrote:
> Id paramter given to bt_uhid_set_report_reply() and
> bt_uhid_get_report_reply() corresponds to a 32-bit tag value passed to
> us from the kernel side of UHID. Specifying this parameter as uint8_t
> breaks the synchronization after 255 request and renders the attached
> BLE device inoperable.
> 
> Fixes: 92ed637ab2bc ("shared/uhid: Add dedicated functions for each UHID opcode")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/uhid.c: Fix 32-bit integer truncation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2d072641aa9
  - [BlueZ,2/2] hog-lib: Fix 32-bit integer truncation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=50487180813d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


