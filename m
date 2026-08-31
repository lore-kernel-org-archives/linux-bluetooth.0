Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761D339370
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197465; cv=none; b=cq8Q1//PWXPZZSTXIw26ugjZHzFBDFfRwTmwhPTjlBT8htyiX9OgaPewLlIFVL4SIbNJY6DukCXJZRmELG5wSXxcp3OdlLvFumeZfSppb34ffOSbDXxP45n9Zm1lFGiDwKRb7XuPgyVGH7xGSGEo/Yiip7gxCTb2NAx3aklp068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197465; c=relaxed/simple;
	bh=X021/TUXVRrcu8rNeVZhiHkK5sGSPvz/z320n88kgGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQkdg8tTmThWxV9N7k90262c/bdBZzyvWNCOCc5ET3bVpe7UHztwQgQTCAokowlA/BvYAa9Ev+zE7EZ0g1MqY+YrAD5amuN+n4nyP7R2TUHlrs9sH6MlQMfpoYo0uToeLY90dwvcdmDyQ0Hsg3xAAzkR0qSMnWOHMvDbk2zdhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6A1VZeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6A1VZeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC91F000E9;
	Mon, 31 Aug 2026 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197463;
	bh=F7gXMOiXPzAs2nLSFZal5OYud1hbMd+O8wkBHEOCYyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E6A1VZeAh3Xu+iLCxHHeRpRhFje3Vp/ihBgGT60px99z8qjME/oxvOJ0zTOS7+Bo6
	 wYPMKH6oP2x1XCHjdn8CcArQIUuUcLaYcR0+1ZLmKX1GlAahShvfvH/gpxXFApi5Yp
	 eXTzk0uSYTX7nR2Gw2FPqdw5p0+BjPJgpd3uZevZ5koCToPxV4U0iPcAoSXkhl/rzN
	 hPNr0lE5YeU//kAp7Pjn4zrKx53e53Xod9+L3SH59s1eLfAHjRPvTsxH5z/S7A0+dz
	 eCnnqkdpAj21tb4n625dkAszJrunsXD9AhbjY0GjtReAPDKE0s53J4bFoBOQtII2fl
	 HWAUTms/nUx0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AD3924458;
	Mon, 31 Aug 2026 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] emulator: bthost: don't crash on ecred_conn_req
 with too many scid
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819740690.676143.15400942592099081045.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:30:06 +0000
References: 
 <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
In-Reply-To: 
 <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Aug 2026 01:47:58 +0300 you wrote:
> l2cap_ecred_conn_req() crashes if the request contains more SCID than
> specification allows (5).
> 
> Respond 0x000C - All connections refused – invalid parameters to such
> invalid requests.
> ---
>  emulator/bthost.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] emulator: bthost: don't crash on ecred_conn_req with too many scid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c53a16afa33d
  - [BlueZ,2/2] tools/l2cap-tester: add test for too many ECRED deferred sockets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b66bd5335d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


