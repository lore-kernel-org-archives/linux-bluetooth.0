Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426020;
	b=C91gUNppQakLgegyfX1c7y0Qkg+AqwhViWfrGC5nQAknq0ItsdBa5zH12ERZGkxpO1bX
	 +SqEubr/A11XKQTz+ttsNsMgo9vcua+rQ9A/1Vs9LTTGhWCFaO+WH0hgWSjSRs5r3nAON
	 YwASF4lVd8TSY91GLPW779SeBfWeMMF5pIaJDXIVnx8aCcp1JJ0ROkAGGJ+mDdoAeklJO
	 b/wi8KSoJcMnF8RzJZPM0GfNdEuw/EANq+fMDbIdQxo/5bBsn9UQbEGQaxB8Lrw0dqPW7
	 fWRyOBdRl7cfbpWMx0TYX586P/nP+Z6CZZr3lu9U7ioaP7qBxDC/ucdSKQZHlY4jJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426020;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6HWQUpM3PjW8+BhL116w3GjQjvGNhoMy2Dx/tVTVrDk=;
	b=jik8pD5v6IqACAsopJihP+TejXYTbn0PlPDeN6x8c0fpb4agiltB0LjF8fYk5OdEjCGm
	 mGLdUoRFP/VlMOSqtQhlz+RowtU6wpzL/H8UYi0UCTvyUz/IoYqITuCYSOizRSw4DKqY7
	 jZ13xxbL6rUoSqQnYp4HciGUy+3VveulGOu3SdHWh29BWwcmg3IlcR1E5Vj2CC2BeixDd
	 7S9hWQ7tpKKFJrio7j8rGlO1ZGrU+M/Zn1TfllcvaSH0JTPP706lbkI/lDduNZrLjX9O/
	 wQ/LAIJNWXwW9Ol8+2Ff498PXR0OtbL3mU3EFhNB67fuqvdRBCa8uHh8kgwcd0Bddpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hJPq/ZFh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F5606A334;
	Wed, 11 Nov 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJPq/ZFh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63E01F00A05;
	Wed, 11 Nov 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426020;
	bh=6HWQUpM3PjW8+BhL116w3GjQjvGNhoMy2Dx/tVTVrDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hJPq/ZFhM5A2mQhaliriYcks2OFyKkFI3KDY17+DL4ys/X3o6mEx8JuSxcsg8g/VB
	 FxnoAIUWchI9BGiaChl89VpQTW/NXpTOxkUIwu4LSZ/THK46BTxbjDfwSVVnrpMDYR
	 rGzLqMS2jgjJWzGfU48dbeSp/O1CgXkzNHOGaxX9Uv6g7QYnyq7q6W5siHEBzOoPiw
	 /XliB9j5i+3fTwujeLL8CLlfXZ3EOUEHB2kBVCIdTpVszdz1Qg6HY7KMot3UO/lCzS
	 tDOTI8iuTL2eZwHpTCmdZlKPxx7CLfkfH/DeknfbR1d/GiQRJzi/+wIZeGdLyUTo5B
	 U4Io/xBcrKAFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B26838003BF;
	Wed, 11 Nov 2026 19:40:20 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 19:40:19 +0000
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
In-Reply-To: <20261111094557.443481-1-frederic.mahe@cirad.fr>
To: =?utf-8?b?RnLDqWTDqXJpYyBNYWjDqSA8ZnJlZGVyaWMubWFoZUBjaXJhZC5mcj4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@kernel.org, anarsoul@gmail.com,
 alistair@alistair23.me, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, troy.mitchell@linux.spacemit.com,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 10:45:55 +0100 you wrote:
> The BPI-F3 (SpacemiT K1) carries an RTL8852BS Wi-Fi + Bluetooth module.
> Wi-Fi (SDIO) has no upstream driver, but Bluetooth on UART works with
> the existing hci_h5/btrtl code and linux-firmware's rtl8852bs files.
> 
> Patch 1 documents the compatible, with rtl8822cs-bt as fallback, so no
> driver change is needed. Patch 2 enables it on the BPI-F3.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
    https://git.kernel.org/bluetooth/bluetooth-next/c/c21f8cff7503
  - [v2,2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
    https://git.kernel.org/bluetooth/bluetooth-next/c/df348a0d065c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


