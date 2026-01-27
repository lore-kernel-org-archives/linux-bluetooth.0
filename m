Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D8192B75
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538624; cv=none; b=qirabt46CXKWZ2OAeLSmq1OrzMieeOL1FX+mXrKePelQw6+prMJGhaqQztO5YtQrHld01txdh/Uk6eeZhPhh9JNO7+sxj9nNQyEuKgs9BozIATOrCZkJDjgU4fPPzPK7Vz4LI5ZEaCLG6Drf5hPFHE+BjWDBK3nBxx/3G21GrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538624; c=relaxed/simple;
	bh=0ptBtJN3+oeWKLGfPn76uB6sTCcs7PRZsgqxYJ1qIUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dzOOmUa5MI2qcs9ioMkI232IWRszKatCJSme1QR2SbSQuCjEJFVnuqE3Nv527i4PqvfDVN6YY1xfvS+3k6FctLw0Uc2AgLPDymVgbs9nx53DAdmUB/uvqqfMiN2M6dDQI0hTLJOggIFgzPhY1q0gbTB7Z9ugjnwCh/EoLf9rV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1rGZ2M3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1rGZ2M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274FCC116C6;
	Tue, 27 Jan 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538624;
	bh=0ptBtJN3+oeWKLGfPn76uB6sTCcs7PRZsgqxYJ1qIUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m1rGZ2M3qU+DOZ8HnTxgiRMxKaVi98RfuwtzO82L8A8t2vVrMYGjtevoHMykNC4VJ
	 GGB39/KTMCcuDDYNfjjbZ6b3gDnl9lQW5dgisqI5ENd06vP/1GvZqcMDt2VEsZh6DZ
	 /2OhQBY/dLF+rvB/t5W4ik4ptXQnaj3YZtR/PX95NZzjkOj4x7lkwGS96nV1gJ2wZc
	 C4h0LCJPQavfQGRzx0QnTN0V4IllpNczi3ZX1OZwwD1jqxCqOLJkttnAtKaYPgiqKG
	 d7FoiL4YmRylbvktU5FBHKW4SlwUwVyfjKwt5JbLzeZqVmk++hLGOdpYjMLQ2c0J0x
	 ppGvYw1OZscLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB6E380AA58;
	Tue, 27 Jan 2026 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the ScPP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953861809.1352702.12438250170705118672.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:18 +0000
References: <20260127171335.151361-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171335.151361-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:13:35 +0100 you wrote:
> ---
>  doc/qualification/scpp-pics.rst | 166 ++++++++++++++++++++++++++++++++
>  doc/qualification/scpp-pts.rst  |  31 ++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 doc/qualification/scpp-pics.rst
>  create mode 100644 doc/qualification/scpp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the ScPP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9621ab4d51c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


