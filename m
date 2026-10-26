Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050816;
	b=YkBs2+0tXalmKQG1TVZ7o/ZFhmKomhWK7LygxHbYbv+snYy6f/k7CD3MerVsAhfrtpXa
	 zdjl1qbTR6Og6yXabF6oJ1lhUt/6TgC7j+neOZzJDTDiuNF4zaCCHGUCt7wndfmJw7pdP
	 0bZnzeHaIYEUKm3LRV4QVc56UjAHpYd4KXSg4n24Di+u+xaJ94wwVL8xuGLy2MGh6HW23
	 /FAQj/lxtEDRGmxzoqBWNXW64hBJ1rXAGgQnPSHQ1oifS31VozXv+h2MkFrqN/cPoy7jd
	 U+bPC+q9MtjrfDf3tVb+lN/1GH5PfA6UXQ1/a16qE8KAmS0VYNfhOu6Zn/zL6guFIfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050816;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dfyCTBxwSXcLqG1PhzCBsU0Ea6fwU2hfCX/59xaZIPs=;
	b=1uD1/e1gv8Hpiyw7EUPEHuY77F5rx1rtJxloqoSOHSDN/YgXrymO6DXBFrwIol5xKU6F
	 sq3m3QILweTh45i0aX+t0rXmBce+Gcx6ICfu5D+8hQkioS4hHisE9NDMkVEAyRratxYtI
	 8zgRqDXYb5hDSbSScEBQxYOxC2Xnmf9IQKDsqMK55Y3A+yjO7xu8br5Wb7w7e0MEvzBaF
	 OK4tgCLto2c7XMNuPkJcros2L976j1ikxEoba8Tt1dFlqUKOZ2QADUuKO9l54NU2yuT4V
	 65oc9EwLTSUd/VYgt2YqJYOfpGWLK5F60cLszxyzKISV42MY+57v0z1yGnNWjTch75A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWxkidYQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49F606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWxkidYQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118D11F01825;
	Mon, 26 Oct 2026 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050816;
	bh=dfyCTBxwSXcLqG1PhzCBsU0Ea6fwU2hfCX/59xaZIPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OWxkidYQj66Rh0wYlRI7q7CFX/8Id9WKxFAZYzuXs3uC+bK8qwGaEH5VeGbhZyxaa
	 ZQP3zbN3oQhJ9CvKtAR8fqxSfs1cIpWEPGnTVp6HunXYjpOZMpI5m3KLw84aDB3xa+
	 JXLsQbCcXIAMR8pObiiJi/Sjz4tABOFdV0X+QSp0JB4azv4V9v2/cxKpNnbo619Igt
	 dsv0rk/1k/Q5Gl3gYjYrVY57kMsk8Ohbmf62ZD8WtvTSvwm6531zScx/fWTtqlJczQ
	 7ssLSzTs91nKTqzr9D0LE8hLrqEn5X5h0MdyGTg47EVb6DbNO2pArMggdNYsdy2Uwp
	 CnpSAJJECikVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 072353AA80E9;
	Mon, 26 Oct 2026 21:40:16 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] obexd: Improve handling unsupported MAP events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179305081456.3403508.17305582793778128018.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 21:40:14 +0000
References: <20261024115735.2403759-1-sadiq@sadiqpk.org>
In-Reply-To: <20261024115735.2403759-1-sadiq@sadiqpk.org>
To: Mohammed Sadiq <sadiq@sadiqpk.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Oct 2026 17:27:34 +0530 you wrote:
> As per the spec, unsupported events should be ignored. But since bluez
> used to notify all unsupported events over DBus, removing support for
> those will break DBus API and clients that may be depending on them.
> 
> But all unsupported events are being notified by replacing the
> original message object, as all map event types defaults to
> MAP_ET_NEW_MESSAGE if unsupported - As the event struct is allocated
> with g_new0().
> 
> [...]

Here is the summary with links:
  - [BlueZ] obexd: Improve handling unsupported MAP events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a1b156eda8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


