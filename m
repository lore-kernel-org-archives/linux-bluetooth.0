Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF522171D
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111817; cv=none; b=sShp02L9swdbc4uF/JO3DcN3TTSqzSxatOj/bS3z7drgZqmFIcLC6n8fw6pSNtAvv6f29o2CEP7FoRO6AGR/XvIqWE3Fa3KAtzO2Nb6qrQT+xl//uy6s5qpqgwYAN4cfxhkXxPomTp+gRrrPzE13LfSWFL3Yeku7iew1Q5/AY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111817; c=relaxed/simple;
	bh=W2LZRG1NHpHhab/phM/lwFDbn+0XJupTojKBJsn6p8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEflm/pQWySKDLYvvX0AFvy+BkEVYalncaNZsuGvIx6eL26WQrmRwYmWMP0ziiVp4w3Kctog+mZXfVXS2SYMnlp9oynsDbRyGxA1XcgIqONcI82SqV006Rk0+WZtjtpHCzG5Qm6OeicbiwjbYPsl/OJuHtbyhCssEN7kwAXDChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyoQnA6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyoQnA6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520BC4CEEA;
	Mon, 16 Jun 2025 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111817;
	bh=W2LZRG1NHpHhab/phM/lwFDbn+0XJupTojKBJsn6p8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eyoQnA6EDEE5XsnXATuHjINpJpyQKKlc42oW+GTtLLiOttLtlpP4Q1hZH7VAj3BfU
	 0vXgq/hXfXAtOFDUzOqmyRJUfqXIkqbXqcSTTgKoNpcKLnebPraoqk++gmCRd3YqmB
	 8xYv6S/xEowU26PabN2IrYWeLaXggWKD2w14n0tlUMm8BVz8LXcWo+/WJy/CyafS/C
	 xdf9CEcxTWDUa6B16hV9laMyHXo2yRwp4e16eOl78PaulcieopKMxCCyuD5dx+PBSl
	 Y/5tSxM5OeBu+wLIw/S+3cMJLx5xUHg6IOZnKpG0WBOdNybG83sm1s1NHycPt583g2
	 B7dQNu7ofQT7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4938111D8;
	Mon, 16 Jun 2025 22:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] iso-tester: Fix crashing while attemping to
 access
 isodata
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175011184573.2530350.8678962230239090814.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:10:45 +0000
References: <20250616175511.2608985-1-luiz.dentz@gmail.com>
In-Reply-To: <20250616175511.2608985-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Jun 2025 13:55:11 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some tests may not set any isodata causing the following crash:
> 
> Invalid read of size 1
>    at 0x40067A8: setup_powered_callback (iso-tester.c:1691)
>    by 0x40232D5: request_complete (mgmt.c:306)
>    by 0x40242B3: can_read_data (mgmt.c:394)
>    by 0x4028529: watch_callback (io-glib.c:173)
>    by 0x493D87F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
>    by 0x49467A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
>    by 0x4946A4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.2)
>    by 0x402ABFD: mainloop_run (mainloop-glib.c:65)
>    by 0x402B1D4: mainloop_run_with_signal (mainloop-notify.c:196)
>    by 0x402A3F5: tester_run (tester.c:1076)
>    by 0x40050FE: main (iso-tester.c:4010)
>  Address 0xa8 is not stack'd, malloc'd or (recently) free'd
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] iso-tester: Fix crashing while attemping to access isodata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c20aa6c2ff1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


