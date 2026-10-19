Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422609;
	b=tG8VoBFObGOY8E3NR9aY5DFmXedYGNLMjrTBIENzu+u9K17YQ5uqhR6xpkEuI4c/z/2H
	 OxTuBIOYkJ6m3mRKEP3t/xo8Fj1XWZbQTxBNupzCwVniBLmmFd9jDKGtC+1LigZpYLKxh
	 jk5Hes3pux8SzmGtQRIhv70u8KQPgzj0ZgLQ0DNE2a5AczE4xEO2W7v4hzvOrgudsbQuu
	 2UUIFjvGQD18sD2yiRQ3nn3HmvBXySfJLN8parABwBhepijiP4aTPFZIKxjkQPh4BertD
	 /E5Nda++dbrrXDAYE/eM1rNvobuEjOzCOJR1vKS3DO9BHOo1s6OlRop+u113aw6PYbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=C2Fl+9VX9kusd3ElsXihmTd7vyfOMPR9tkZ862j4eI0=;
	b=GH7woqHmZ+U98zHL26Zvw/XsBh5uQX03+iR1ZQ+2DxuRqOIKVcfijwr7NICCOlYgv2Ft
	 a3rm+t9dMvAb5Uetr8hBkP34ZHcH7CEDetiT/922fWvf1qnuwlpQxEvF18NPdTHEIo+uR
	 wkxSoyhqG0mCrVqX7R+vPlaUps9eN/osAD5jEMvxroTHvbxXxpcDSOIPsYOV14bvRn9sA
	 Y266pJy6adVWG0b6Ds/0GrYO86MMZjwYciaMMg0vp1/wrTdOztKKaqcHRfrHBSv6qtUVT
	 xwxiQ5xgUUjM8NHcaURZDUftIGJYn+ILu6Do5+EgHPmbD5nwrATMmV3NJnjOo08M5wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqTEyFVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD76088291
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqTEyFVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1FD1F000C4;
	Mon, 19 Oct 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422608;
	bh=C2Fl+9VX9kusd3ElsXihmTd7vyfOMPR9tkZ862j4eI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JqTEyFVqio+BqhmtDLZKEo26M5b0oNtBSUwCBh1ArYjOdNSDODYpJB0CD4PQKKAak
	 PAA18QEfQev2+GAOT4UHUAGZANfloCzS8OoyECLUvfSV0vlvOf7urEwXMu0d1uOih3
	 bRsxuUVid41flgx/zuLC/nNYc5Stre9+Y90XaLMklLIVoQn3DJf/4E+AS09862Xlp3
	 wxUid+YdKuTo3TP1gXJrArdY01HUdhpiKdTC4Gq55i8sY5Wn1Ls3TZ3yhCDPa/Gfv+
	 EyBEtxLBYQspoySMNpVurIz7hehUn5XqYenRpBxp0MmwMZWMi52z2jRxKZR2ItUf4K
	 K5DNwKWgsswdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445A3811A71;
	Mon, 19 Oct 2026 15:10:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ RESEND] monitor: Fix legacy SCAN_RSP PDU type names
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179242260727.2707801.480049428181551124.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:10:07 +0000
References: <20261019041009.9720-1-kevin@simpleble.org>
In-Reply-To: <20261019041009.9720-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 18 Oct 2026 21:10:09 -0700 you wrote:
> The names of the two legacy scan response event types are swapped. A
> scan response keeps the properties of the advertisement it answers, so
> 0x1b, which has the connectable bit set, is the response to ADV_IND and
> 0x1a is the response to ADV_SCAN_IND, as listed in Core Specification
> Vol 4, Part E, 7.7.65.13, Table 7.1.
> 
> Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
> Assisted-by: Claude:claude-opus-5.5
> 
> [...]

Here is the summary with links:
  - [BlueZ,RESEND] monitor: Fix legacy SCAN_RSP PDU type names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e348529cf4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


