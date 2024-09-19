Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B63B1B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765829; cv=none; b=C83R32UWJH3rPfT62u9k+/3NYR5tWnYk9AYUZ/2Nu5gYAXNcxwk1MgYhJlPvWN9S22+GCjWSMCEpsCLTR+wSTnLsFWUBKzYIm8sYKOu2Kmc4Fre6r/NdTYjhpiES4PxEu0ufqbTNmYMso1B1n2dUCzEtLWt6IROQBfHoGfcm1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765829; c=relaxed/simple;
	bh=iROwuomd9iRCSHUCTZkqgkLacbRuXUKUOlT+8tRP9kQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jwt0+Oehyn80yyiqATNcWDF/aB5RRMFdlYu2QWDbLr+3Z99x/zmx8z/8O+/PmV+bNjUrHmp/JTLvBozIEQqdOcxHxTCFxNm9Zb1vrJ8nJkbDFY+lTM2aFSkqNQLlIOZ43aNA1xLguINE/P7xpqUvFHJSVsk14bt72Xo40zwRbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXGd+Us2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXGd+Us2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7FEC4CEC4;
	Thu, 19 Sep 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765829;
	bh=iROwuomd9iRCSHUCTZkqgkLacbRuXUKUOlT+8tRP9kQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FXGd+Us2OZvPLm2GyJMTlc7/J2t38FzfZQ4ebmaf5KOlESjH/4LKgXW12Erkon3wE
	 p75DtpZQPvBlOzfJKwQCi4DCg6nq9efv7/NeSIG52gnCHKDOIc+iYWOovsEGdJAFNR
	 U31fLJ1lET/uDFFh3N4JPF+NCNHcNsOJmSjtvPTwm6Dagwtwa7OmlxAIEf04BI9baF
	 1QHUXjceUPdAD4VeSKVN9q/Sj/n82Q2h9SA1ufaZsQ9B2nAJOvaVzXLcIvaOgt7s8X
	 F4QiskMnXMKAg2z0zt90tvTApaFA2hCnhugGS1veMISj3QEcHtujbc4amPkS9oGHrs
	 HUNjyxhjfjmYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3440F3809A80;
	Thu, 19 Sep 2024 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] adapter: Add (readwrite) Connectable property.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583103.1626973.15318463171112166927.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:31 +0000
References: <20240911145114.103340-1-vibhavp@gmail.com>
In-Reply-To: <20240911145114.103340-1-vibhavp@gmail.com>
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Sep 2024 20:21:12 +0530 you wrote:
> Hi,
> 
> This series adds the "Connectable" property to Adapter objects in BlueZ. This
> property is needed in order to implement the corresponding functionality for
> Wine[1][2]. However, to not break current behaviour, enabling Discoverable while
> Connectable is false will not result in an error.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] adapter: Add support for the Connectable property.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17f485f207e6
  - [BlueZ,2/2] org.bluez.Adapter: Add documentation for the Connectable property.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf6bfc3356ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


