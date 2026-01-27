Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF6327C05
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538616; cv=none; b=G2BVtXzUp8vzE2o/Kf4cN2152nCcM5GPNVZzeKCLmxQuZ9dLwvvjtk/Rgr4gOMcj/zAYDzqwtue4qp6cqSS7jgyfu0bHBqELMBsEbbAgHN0loEC7o+Jqm+oZBJ67ocnSBKvdw61ZhKuFfNDMQ5JpF6K6pdrRHHf99MNYPGhP0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538616; c=relaxed/simple;
	bh=x6xL4RSgpDkXjQMcuSQBnGQlHvt6styjCMrpEnmzemI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLz6BXeBuy22ZU/HlMqU8HYSRNxzVkKe62Ko/t3klx7hJXOK7CzWAPkH6G2ztDRjJwy6VquEuohyhPd7hcq24UYLaBm8W28Mvq8ckuVkkokyUYmu07jqS6sMYry1SWnosoeoDGayWQIEDxoTR/IE1DChHJEItxwk6WxoYFZuGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7WFksqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7WFksqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2FAC116C6;
	Tue, 27 Jan 2026 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538615;
	bh=x6xL4RSgpDkXjQMcuSQBnGQlHvt6styjCMrpEnmzemI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z7WFksqUUnd8aK+AQYYNLpK/O+HntLZHyN2n8uH7FKji4aSCxcKeiG0CB2XrkAleH
	 Mx75S7yrnY+A77en/O8HAz6WmluMkG4L0jeSbm5Ce+9/Rf1gGZUZp2FdSNNDNDmt3k
	 EkcbnVmPyJjo0YT0ecxWICakDXTFuL0bjFVmvk94JHxRjekIbWkeMGMiPFWR91LZl3
	 vWLTzHeJd2ldyoybsaLf+9vf3O/fLjENXB4NpD5QmKS2TsT7tYXvAB2ExNyi+rpUKh
	 vqvhG3Rfj4mMrth3f+Ofs9NLpKFoJah0A0REaFZ6j0edUjlyo8cACeIl+jR9pibc2u
	 43GM3jm1IK7Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11943380AA58;
	Tue, 27 Jan 2026 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 01/13] doc/qualification: Add PICS and howto for
 the
 A2DP qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953860984.1352702.14631734897218360325.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:09 +0000
References: <20260127173841.153747-1-frederic.danis@collabora.com>
In-Reply-To: <20260127173841.153747-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:38:29 +0100 you wrote:
> ---
>  doc/qualification/a2dp-pics.rst | 904 ++++++++++++++++++++++++++++++++
>  doc/qualification/a2dp-pts.rst  | 273 ++++++++++
>  2 files changed, 1177 insertions(+)
>  create mode 100644 doc/qualification/a2dp-pics.rst
>  create mode 100644 doc/qualification/a2dp-pts.rst

Here is the summary with links:
  - [BlueZ,v2,01/13] doc/qualification: Add PICS and howto for the A2DP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=72e75617ab8e
  - [BlueZ,v2,02/13] doc/qualification: Add PICS and howto for the AVCTP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae788af205ad
  - [BlueZ,v2,03/13] doc/qualification: Add PICS and howto for the AVDTP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a54bee4668f4
  - [BlueZ,v2,04/13] doc/qualification: Add PICS and howto for the AVRCP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a6a1cc0c898
  - [BlueZ,v2,05/13] doc/qualification: Add PICS and howto for the GAVDP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4a38072ba45e
  - [BlueZ,v2,06/13] doc/qualification: Add PICS and howto for the HID qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4a8e19cf911
  - [BlueZ,v2,07/13] doc/qualification: Add PICS and howto for the RFComm qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04d67cea10f7
  - [BlueZ,v2,08/13] doc/qualification: Add PICS and howto for the ScPP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9621ab4d51c5
  - [BlueZ,v2,09/13] doc/qualification: Add PICS and howto for the SDP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=516b7adfa7a3
  - [BlueZ,v2,10/13] doc/qualification: Add PICS and howto for the SPP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=feecc7f60de8
  - [BlueZ,v2,11/13] doc/qualification: Add PICS and howto for the HoGP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=402d0c52ac40
  - [BlueZ,v2,12/13] doc/qualification: Add PICS and howto for the HSP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4b4db9702e6
  - [BlueZ,v2,13/13] doc/qualification: Add PICS and howto for the IOPT qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a3c0aa5fc106

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


