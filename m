Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1E43B6C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449628; cv=none; b=iTVZnhwKkBaLoEXao2zVmdTtRIHZa/OOMbuPOov2jkpfluES4vxQNBVEBB0eWArobDKP520fnIWNlgi5GzjFjour8WrlV6i2u/4L0jHdgk4oS/eDKWHYtdnfh+PN3Z6L4FeuIgl3N/AO9A4xsUrdp0OiaBf1sAZ/urQQVCNUM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449628; c=relaxed/simple;
	bh=V7pRGSlaehb1hsu91OQmGhdqypsNO53wPcY2lzRvKWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQtfdPLk8KKS6KKe8N+RdJGIT31+4WH7JsczPsrY4gpImNRhiIVInEKITeJuUhGGJylFDbDqXuFTEy7wjFjmsuvSyZoujfk+fmgX5f2b8fIfUi6oEU1sSbEpovkHpSz8rJI7vpo1/oPF2kHg7pkYxlkMIPWomTH2mB+YMLv98aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4eag4Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4eag4Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903731F00A3A;
	Tue,  7 Jul 2026 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783449627;
	bh=ZV2H0KjK7nrXfm5+tszezxLA+h0fZsb8hPRhd8puEHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h4eag4Zakw0nObYowPA7367lHTbSAv8m1SF15FC2fWk831ZvocTBTyeE2+WZ63Iqk
	 xs3BINfw6D3UFkfRQ31GYjsYlnd771Hxyq9cOusGMUsw4GDY4Wl8dHIkTxdhHkZCPW
	 ddHLka71ZO7X2nn1PzZieOnvRPFzHlgUBhWX5m1cSL3UPOsoPPOsVkYXKivYE6ROhy
	 p2B8BV9mVOfXihNYnwsAjWrIh24ogk6MHTFOXwbDQAdDVw1n+VfG14vIK3p9gObsvA
	 hxqn1Qmlrlr8SK3fGPl7R/MBxcj0CzO2mfthLjLTqFCmuF2F+8DgiZQhVY8mSlFUgb
	 lsUxw/dVeMkeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B6A39253F9;
	Tue,  7 Jul 2026 18:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH 0/4] ASCS: Add validation for PTS SPE test cases
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344960712.2123016.7528712745342505195.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 18:40:07 +0000
References: <20260702130907.49942-1-raghavendra.rao@collabora.com>
In-Reply-To: <20260702130907.49942-1-raghavendra.rao@collabora.com>
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Jul 2026 18:39:03 +0530 you wrote:
> This series is required to make PTS tests ASCS/SR/SPE/BI-01-C and
> ASCS/SR/SPE/BI-07-C to ASCS/SR/SPE/BI-10-C pass.
> 
> raghavendra (4):
>   shared/bap: Validate codec configuration parameters
>   shared/bap: Validate unicast QoS configuration
>   shared/bap: Handle ASCS control point protocol errors
>   unit/bap: Add invalid ASCS control point tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] shared/bap: Validate codec configuration parameters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f283c8e0ab3
  - [BlueZ,2/4] shared/bap: Validate unicast QoS configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c1c679ec304
  - [BlueZ,3/4] shared/bap: Handle ASCS control point protocol errors
    (no matching commit)
  - [BlueZ,4/4] unit/bap: Add invalid ASCS control point tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


