Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723415;
	b=JBIEXPL/hqlZb6LPPi2MxBhG1rEk3hDnu83f2UYEklLxxAoPvWMw2gVfR6VGTrik5nRr
	 i8OQkaeUexNxJcGORgKmCOzflo6JRGdgTj/80EW43XHu9EBUuRonzbH17GFBsz2Y0K1RU
	 fvsE3gRnAqQPRLMKXK6ujacKEZtGrKpw+Jsm9eAcXUcCSFuSvMAuS1IED5ylLPXlHKN2s
	 EE/OPCsirOZJeNqfkQv6daQNFZJi2fDmk1zVivYb6mVi+R18+SZ+SvKMHze2N6cnsJwGl
	 woEcQyE5WvpDKObFwVPS92DImF2EgIQ6A0Lkx/qJVXEyH1+H/gv4RXcITspLLCxpZGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=i+1YFgGeIU0fBFYY7xLgg0jArnhMLsiEmW/k+VX7ZAo=;
	b=LZTT+5yOmzJKps0iCjSYpXQm26GArLtVTRL543vglJOF5dNrt65cYiOqvEAS+JnYLTb0
	 /TXIIVI3AU17GGFpsw08Es9FK4LvkBN1MYQ9EoYNdGa+8E1x+uWDc27fltUeAgIdjXLyi
	 39abRltqjjDi9CviHDHjGgUDPUzxPqWn3kne/h6yKwpyMaXa/v9ksKO2v3JWsmlDqq0Zk
	 atvMViv9Y+T16HjYrOqsHz4rP0HMDl7oKViq8F86DxLd3KLwv4iF8/x2pqiKsxEAQh8NA
	 OnPm5s/KTHU3ZZszrx+jHpQMWmOFz+GzYnlnx+zOcdctavxVYDACL3Fo5kksbbMs7wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDiuCDRc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F74606A338
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDiuCDRc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C1D1F00A1B;
	Tue,  3 Nov 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723414;
	bh=i+1YFgGeIU0fBFYY7xLgg0jArnhMLsiEmW/k+VX7ZAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDiuCDRc1AOWBJumB1PkI7Wr7Ea1dZrIo0TpXzzNg1Mh1PEtWdtnYwwlGGDqgdJ7f
	 PMVNncVUhdYrg0waeqNq08CnWm7Yv7zl5p7WazHW/v/IVYE5bIUMneZMALZjCJ22zw
	 kcbOgKQ9wKop0tlILB3FGMB4GFpbEkqxCztIBcHqRUGOzsaTEaEzPujN51DaPeKFnd
	 53EdRmB1owMmniPv8Z0XI7lxR2OWMKA9HX41XPD6vnroxupzgCIClYpzfgFu7Q75kG
	 uK3ptOSrRv0wC64/57W+y6v6DtuyOgvc7/cSF3GdufVGflYax0kqyavOTPjaz8Sr3t
	 nMsryBkOmfe/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D281391AFF6;
	Tue,  3 Nov 2026 16:30:14 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/5] Add LE connection parameters to
 org.bluez.Bearer.LE1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179372341304.1736455.11988052173742240524.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 16:30:13 +0000
References: <20261103072749.50979-1-kevin@simpleble.org>
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 23:27:44 -0800 you wrote:
> Applications have no way to know the parameters of an LE connection:
> the interval, peripheral latency and supervision timeout. They decide
> how fast data can move and how quickly a lost link is noticed, so
> applications that need them end up reading them from HCI traffic.
> 
> This adds Interval, Latency, SupervisionTimeout and Subrate properties
> to org.bluez.Bearer.LE1, filled from the MGMT Connection Subrate event,
> which bluetoothd already registers but only logs. With "Bluetooth: MGMT:
> Send Connection Subrate on LE connection and update", now in
> bluetooth-next, the kernel sends that event when an LE connection is
> established and after each LE Connection Update, not only on LE
> Connection Rate Change.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] doc/mgmt: Document Connection Subrate for LE connections and updates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4382352a3214
  - [BlueZ,2/5] org.bluez.Bearer: Add connection parameter properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=65cfa00be28b
  - [BlueZ,3/5] bearer: Add connection parameter properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cbac1283b7d9
  - [BlueZ,4/5] client: Print LE connection parameters in info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e89e98a4b76
  - [BlueZ,5/5] test: functional: add bearer connection parameter tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aaf8f96f42d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


