Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D1EBFE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001802; cv=none; b=IqWIlv94gl1grW4Sk3lhxwvTAMI3CCHVH4ISztFk4+EWxWIv1asMPBaC0cVEmeA1D7fRVjI9T87CzaDhP8upndMthBJg6B180Z1VN4bHJ+v/gLiIJCh2pkx8ExDm29X1daWMkRlCUJgQIuQ9nbIxy5P62JV6OCkOEdOQngDC94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001802; c=relaxed/simple;
	bh=AdEmEZruW+YYJ528R/o6BRdZbtL3Qjdk6nY5o6huL3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLPzFANqHGhIk6PGvpccSNe94K+H47ZmqIAUHbEWOFHEtrS5T3yZC3rrCR1vu9OY42SDQdiIP4v3sh9CHfmTQcoB7/Ec32AHdam4fxSGSt4aSTyyQHtnwkTbiqyKtLrCHU77sSrl1TwAzc92XfPZ7ti2NjwsH+GG1xkDFaL3wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRct7pLv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRct7pLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF02C4CEE2;
	Wed, 26 Mar 2025 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001801;
	bh=AdEmEZruW+YYJ528R/o6BRdZbtL3Qjdk6nY5o6huL3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TRct7pLv1lnMXIGQmn7pjbfpKHg1LFYwd93/bS3gRVKIcZZx5yBxlSBvCXUz1HQxo
	 Ilx+7pgZWANVRKxfam41xOaF+nxIsULejH/x40tRbdRWCtTKlH6LAxK7gj1GjK/Gvj
	 DzqksIv60txhQ6tKBG7lIFdVKCjlHsUUy7n7HA9r99IykpZI3HR4mjru3bFVM84HH5
	 98NI3APg0s/AQ8WFQKN5oP6Cux/wD6jTZ1PEEYdzW83UJXbVOSCudL7zVOIeK1+09t
	 lp2DoLNCD+GRDFTeUXNlPKLN2Db5w4jyhALBKmHY05XZHe0TYJ/UUzX5FIenP6O+ei
	 2cMbePtdmUE8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4433810901;
	Wed, 26 Mar 2025 15:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] profiles/avdtp: Fix reply for bad media transport
 format
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174300183776.1347744.2623948531733485645.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 15:10:37 +0000
References: <20250326090712.171313-1-frederic.danis@collabora.com>
In-Reply-To: <20250326090712.171313-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Mar 2025 10:07:11 +0100 you wrote:
> Currently the avdtp_setconf_cmd() fails to check the capability length
> of the Media Transport Service Category, which should be 0, because
> caps_to_list() doesn't add it to the list of services as it should
> be bigger than packet boundary.
> 
> This commit adds an &err parameter to caps_to_list() and set the error
> to AVDTP_BAD_MEDIA_TRANSPORT_FORMAT if Media Transport capability as
> invalid length.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] profiles/avdtp: Fix reply for bad media transport format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2120e3ded06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


