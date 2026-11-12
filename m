Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505810;
	b=y5tqGYefOWJSr+IUED25Nzgkm2Lav6XYvqELrzxyxZFpNj+7ZCT+jWh9E4uNhqe8KRMx
	 +diolB98N8HqWPphAonbG3yQ2jeEHVBvWfr58bWMRwTzWhh1gCkkmsqwJHVymxXuYdWo4
	 hbr3QqFRY2tMfWbK8ndc9MnR+7q84hdpC5od2igp0+jJi3ASOKt2pJ/kPob45rljRuOAk
	 GKnm9O+cBJk0dFrbbVuo6PoDFi6fEXH3L5oqqV+26r18+/AkkepUJFEc7PNwCspOXE2ex
	 I175WmOh1WRnHHDHd+dcK7C3pzkvznizksBa+966lq/AeXz8h3QFz2PNKltP99qr+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=m5GKxQ8PqLPp+hqlEzITev2GBalcccPFypUBkQBbQWc=;
	b=LfUkd+0hZWRVTDqFGnvwNapeMO6nFDbAvODg5G45Pjskugc6hLImwJJBc6I6VXR4BtJz
	 T0P70+i7t+P7z6rmwOlXeJRj/Gz0hBydJ9BcOrg5B9Ozt3yT2Yk1tFLwY/5PblYan2JYU
	 KKbl2yxzINqZQH17Oqh9hmIxT53NmkqB99H5uLvx8U4q4TMxIC55KeSgaBMXxCfvvvKVW
	 gvuY5N9M8SUVAKZaSUT5Q0lnQNOtPEZWjSTWcMs79hqcfry4Kz9ujK118T0BsL8uxeY8X
	 x/r0Ld26b2kIdKZqXLj6F2t7dnaDA+CtbKr1Cif4tYtF54niPEgTv2MuCZem97zRjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOHjOd3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23279606A331
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOHjOd3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE611F000C4;
	Thu, 12 Nov 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505809;
	bh=m5GKxQ8PqLPp+hqlEzITev2GBalcccPFypUBkQBbQWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UOHjOd3EudlWH/RNB6CToQC4vt5gtItpf6Vo8QAS5TMuc/Bs4aNlJh8lnmfpapuP0
	 1wXQySZ0E2K5/tcQw0bALkO4J/IzaIqLqqV5X1D7OiaQHrtUxYF0O4jMkYBfTtY/ID
	 +aMaVPQJ0flyCvc8ebhQAwAM546drk/GBOGjgIqV1Ju8um+4nnDbn5jsjIKASdB/V3
	 Y0498R4CM6fIS2I5K9BaXoVoQk0mqnJjfCz0z2uo8WVgeB3CrC/LTeLyQUUKucz0sg
	 gJNXtYRncI+AvoHk2CCNXOqTTmFIDmOQyJA0Cyd/dMAFM/rhTsIQjEUAtrqebKgqY7
	 V+rFiacHub+JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4340380AA78;
	Thu, 12 Nov 2026 17:50:09 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 0/5] shared: Use util_iov helpers in gatt-db,
 hog,
 asha and micp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179450580827.563116.10974231348534576330.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:50:08 +0000
References: <20261111203949.3874673-1-luiz.dentz@gmail.com>
In-Reply-To: <20261111203949.3874673-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:39:44 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This continues the conversion of the GATT code in src/shared to the
> util_iov_pull_* and util_iov_push_* helpers, so that the bounds check is
> part of the access, now for gatt-db and the HoG, ASHA and MICP profiles.
> 
> The conversions are meant to be behavior preserving and are covered by
> the existing unit tests (test-gatt, test-hog, test-micp). The existing
> code already checked the lengths in the HoG and ASHA readers, so no new
> tests were added for them.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] shared/gatt-db: Use util_iov helpers to build and parse values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c37508359cbe
  - [BlueZ,v2,2/5] shared/hog: Use util_iov helpers to parse characteristic values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=628a84f214e4
  - [BlueZ,v2,3/5] shared/asha: Use util_iov helpers to parse characteristic values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a848a36c8154
  - [BlueZ,v2,4/5] shared/micp: Fix reading Mute State from an empty notification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebc4876e895b
  - [BlueZ,v2,5/5] shared/micp: Use util_iov_pull_mem instead of a local helper
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1bd266143b3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


