Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429607;
	b=q01j2hgVRJHkzHez+jsyaB5S1rP5hPUi41pyrnwZiLNDvbpxqTXfQ3Rc5R4mtqsCC9zM
	 GTGmJvmrjv1goQGwUuWxlZ8lUzdR5nWdvpNKcWETyytzw6MLo4fqXXkrJ5XXFzRTZmHdA
	 5XMQTlvwmN96o519NfNJfEaFppohLJrcXyU8xqhTXHbuWmO37YgdNUENLm1JAaql/pgbR
	 F+ms2yvND1cJMt3EEOKR3VjwvygIK3pK7xBoTB5opAtoc+z+G6SLfOWb7hZxWGuhGh1VK
	 qXWG2JsFAnGZGbWCJt2j9IFyURZ/suyBzvsl5J4qfHqj77oXPlhqDw7Pie1R49X+JJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rfDtcnl520iY6iQ5aNtpSZRI4NHUusM3/j50C3//NoM=;
	b=3r91KZ+o0SFYrkKr09wNlaAwR2EdeDUfOw/uiEqri9VLMnFcWAIS9iiXs5Y4BZqU787d
	 iVB/fSQIqybyu+iRpPclaa1KYeMP1dNTkSQghPrBNJW2LMCQQ2P91YPr2vfmN84MwVWQI
	 jpwXKAcmTyCk09OsNn5L1oJri83TNJvUd8KmQqBg00ZsoIQpPigvGupQ8+P838DrDj8Oe
	 JykZ8/g0GL5xEkZ4G8phVpvu4suY/Bh/yr8704ZJj5FQWBjThSVhKE6TPZPwqVr3WOX9W
	 rjoMJcrMyAZZNxMmIhY4dylz8szIoxQvwg7lIuS6jPpc07x+2p748rozbjg58xRnBKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGfqENrf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E606A33C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGfqENrf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694201F00A05;
	Wed, 11 Nov 2026 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429607;
	bh=rfDtcnl520iY6iQ5aNtpSZRI4NHUusM3/j50C3//NoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HGfqENrfrXLyxbbt8tS6gsv/p7zhcotTU2eaTdjnwZjp+pefhFl39HsZyaR4wuoFH
	 UJwUN+7gEHR9sowr2re9uQPUid8bP/mljd2UJB7KdN85GI+VFfDHqSPdWh8Z3Wr0nt
	 akS9AkbGRk5WS/CfUtXb1dZQsffwbDbLabfljIsWvORova+KuFYriLMuwfK19BX7Io
	 NwUVYlA9Cxh1PVPpt8YZqnpgymw1UW23W7OXxjwKdUEFQBrHlwV3IS1UlGMyDP2ICK
	 xQ25VW0GsEFYaqo5IdS85elV58eCBUJriDZ7kU/SeOCf+SSP8l+jdNpDGFpLnE1Xv1
	 VnLJICiGRCuEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E157391AF9E;
	Wed, 11 Nov 2026 20:40:07 +0000 (UTC)
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
Subject: Re: [PATCH v11 0/6] Bluetooth: Add support for HDT and EKS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442960617.1633182.3542940102993651686.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 20:40:06 +0000
References: <20261109171838.1592267-1-luiz.dentz@gmail.com>
In-Reply-To: <20261109171838.1592267-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Nov 2026 12:18:32 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for the LE High Data Throughput (HDT) PHY and the
> Encryption Key Schedule (EKS) introduced in Bluetooth Core 7.0:
> 
>  - HDT PHY selection for ACL, CIS and BIS, the v2/v3 HCI commands and
>    events that carry the HDT rates, and the LE Set HDT Default
>    Parameters command.
>  - ISO sockets take an extended, versioned QoS (struct bt_iso_qos_ext)
>    through the existing BT_ISO_QOS option, carrying the HDT rates per
>    direction; the legacy struct bt_iso_qos keeps working.
>  - LE Enable Encryption v2 with the MIC length, Encryption Change v3
>    and Key Refresh Complete v2.
>  - L2CAP and BT_SECURITY gain a MIC length requirement; connections
>    whose MIC is too short are refused with the MIC Length Too Short
>    result.
>  - EKS opportunistic encryption, enabled with a new MGMT system
>    configuration parameter.
> 
> [...]

Here is the summary with links:
  - [v11,1/6] Bluetooth: Add initial support for HDT PHY
    https://git.kernel.org/bluetooth/bluetooth-next/c/6833c8b542de
  - [v11,2/6] Bluetooth: ISO: Add extended QoS with the HDT rates
    https://git.kernel.org/bluetooth/bluetooth-next/c/d9b633525975
  - [v11,3/6] Bluetooth: Add initial support for EKS
    https://git.kernel.org/bluetooth/bluetooth-next/c/0c16445e4e73
  - [v11,4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
    https://git.kernel.org/bluetooth/bluetooth-next/c/daee0133436f
  - [v11,5/6] Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
    https://git.kernel.org/bluetooth/bluetooth-next/c/0a30ad831392
  - [v11,6/6] Bluetooth: Add EKS Opportunistic Encryption support
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9644a9257d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


