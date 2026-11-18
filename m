Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030212;
	b=Y9HFHkQe3/2bF2DHr7QbhNcVxUlAHjJT+a/p97jbK7ZHUhV8AJbhuFhQ0R9W8dgRCc14
	 xlQ8Pe81pDiiM9oelcu2xumT7+/WK2GeaJO6FjxPBtD1G1wqxCZdmugsCfAXZoMercYU/
	 uvATK2NO01kMYnVtOci79EMVzxUoXnmyRuKpDuvn6eyRP1UiTmMWBkvIdXnymwaQRnpcB
	 OWTWRzbBq9VAwP843qGszFSTykL/B8nNFL2dSd7dOcZhXufeJ7zqdN+zjY6ow4A6eZlPO
	 V6IyHsKxuusfA9ll5FYd2DgZeuzQHuusEoNkZPLrSyWYOU6REX+izwUh8cHTMna0Aog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=us6H7AY8xmnXl8rp2tu5lT/B80xW1rZ0SOao860B8wc=;
	b=uZZmJgH8Qb2C0qWDXMMME7ui6njCVLhER0RUwvgApf2ConvWdiHMSHBp15tPG1kIUbxy
	 dQKn3QvC+tGm0xvvlcEXQv6y+SwiJghsoifKfK19hIEiteOZjrIeooPdQBKv2UQKWvkDa
	 hKFPnN+RAdrxcdUOQ3XFpZeFIsmp+pYt3TgwXSIZB7/XGxuFwv7LjLSzmG+o9XMdTdz+g
	 hOHWuAgwax8zsZyf5OLzoHJhafoeG0tpm9003wOl+ER0wYo0Ula+5/N8FONVcQ9a73n3o
	 H6UQhaLncyX7mzG5Af7/2Yc1UpHogNqjJR4SBuFs+iZwDmQilsXUcaUC91wx4/nrXEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INHXsdfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA14606D35F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INHXsdfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7831F000C6;
	Wed, 18 Nov 2026 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030211;
	bh=us6H7AY8xmnXl8rp2tu5lT/B80xW1rZ0SOao860B8wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=INHXsdfIt9Hzab9K4F02Cxs0j6fT6aEHwrCvHr7hN/FbgOCs84Y7qbqS98qGsKQVJ
	 N2DNdkxq9B8OMuV1kZgVBmId797IVRVwa8NyVlytHTZXe9e4lLQtkydW6aXOOgqHh5
	 RZbJFa4sIY8gtiP1Tu4zSZHZgv7WNLs7fvCus5DzRHBRw/16xftRC2ubwmbubGXZ6o
	 4WeFtzqxIABhP3hchcT1Q1K7xd5LBzyL1W2jncHi9uh1b1EiRPTX+EtPADSfwT7y/Q
	 O7uejYbaL0lBbsLBi6jFXtblqHtQWE8RD+3tuYTWgv6Xe9+lScKdSIJZaGsD0vWU62
	 2UbwlY5utHG3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B33808210;
	Wed, 18 Nov 2026 19:30:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 00/20] obexd/pbap: Update PSE support from PBAP
 1.1
 to 1.2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179503021053.2495657.11417869722310175259.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:30:10 +0000
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 17:06:14 +0800 you wrote:
> This series updates the obexd PBAP Phone Book Server Equipment (PSE)
> from PBAP 1.1 to PBAP 1.2, following the PBAP 1.2.3 specification.
> 
> It adds PbapSupportedFeatures negotiation, Database Identifier and
> primary and secondary Folder Version Counter response parameters, and
> vCardSelector filtering for phonebook and vCard listing requests. It
> also advertises Contact Image Default Format and updates the SDP profile
> version to 0x0102.
> 
> [...]

Here is the summary with links:
  - [v3,01/20] obexd/pbap: Fix PRODID property name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04c4365a8bb5
  - [v3,02/20] doc: Fix PRODID property name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6785463d1cc
  - [v3,03/20] obexd/pbap: Fix crash counting vCards in dummy backend
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52b654072a9d
  - [v3,04/20] obexd/pbap: Fix Tracker contact grouping across requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=179888317fd9
  - [v3,05/20] obexd/pbap: Include directly bound Tracker telephone numbers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2951ac9b3c47
  - [v3,06/20] obexd/pbap: Reject listing without Name in telecom folder
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=38476a6a886b
  - [v3,07/20] obexd/pbap: Fix unselected PHOTO in dummy responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe2c1297f0eb
  - [v3,08/20] obexd/pbap: Refresh cache for each vCard listing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7e523a0af2f
  - [v3,09/20] obexd/pbap: Limit NewMissedCalls to mch responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aeb2256e53eb
  - [v3,10/20] obexd/pbap: Add NewMissedCalls to vCard listing responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=046d3cf54659
  - [v3,11/20] obexd/pbap: Separate vCard entry response handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e0547c013ce
  - [v3,12/20] obexd: Parse application parameters in CONNECT request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0cf90bcc36e6
  - [v3,13/20] obexd/pbap: Parse PbapSupportedFeatures in connect request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b819468a831b
  - [v3,14/20] obexd/pbap: Add persistent database identifier
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89c42c5984cc
  - [v3,15/20] obexd/pbap: Include database identifier in responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee514e934343
  - [v3,16/20] obexd/pbap: Add folder version counters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa572e711375
  - [v3,17/20] obexd/pbap: Include folder version counters in responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=115628cf1b26
  - [v3,18/20] obexd/pbap: Add vCardSelector support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f74aab9632e
  - [v3,19/20] obexd/pbap: Support Contact Image Default Format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cb17ee4014fa
  - [v3,20/20] profile: Update PBAP PSE version and features
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1adfe662efef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


