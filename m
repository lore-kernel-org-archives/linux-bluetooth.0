Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52598325491
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536817; cv=none; b=uzFs4mbDMJxAvDIAQnpZY8eyIda0tdEi20slKU3KK17IYTuWxJ9PaY+rHZnkN/bf/+paogXrmXpxFh91GvrrVOrFty1AgGLApess3GBltZotIDIvr8rSGEP1z37SKqi9h5SYnJpyb6mMqfG9dxSQlI8X0mU/1SUHvttLdFzbj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536817; c=relaxed/simple;
	bh=u5czasgaZoMtAaQlHZKJhP2ISeWPwPM3x4VNZp6z+Zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQ6RcL556UF3AE4D2xtZYqe7u6KduRAut7IKv/74/oSCAevlkbthAETVfCOciHHSMyV3E7GnT7Hj6UXkihG1PDnslbflxLCnJyTZprpcIRWZMDzGCYAdF380KO88sFa4zd53D66nHsgXMMOL03wQabSxUxwQp5310SZltKv7F0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpVImrXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpVImrXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AEAC116C6;
	Tue, 27 Jan 2026 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536816;
	bh=u5czasgaZoMtAaQlHZKJhP2ISeWPwPM3x4VNZp6z+Zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZpVImrXpigF5mEPUMTd2OpPU7bH4tLE3GcY/0B+W13599KlJ+eOnV/rvAk/OgAfg+
	 O4aHkcoIKqM7o4Z/5aWc9C5Mpew394vddOe5hjYaoo/6IaEjIF8ksVAdmm9tWD4Qwe
	 adrytrI1YCI1hV9H9x4rOl8/AETJPBJauOzMFIkLPFlXL/CGAeBy/as/lVAR6zsKSE
	 fi9HIRvUVinepls84h95XrRgx/LoYflMRCAV+YTocUD4EoK3qaTNPNd3yFpJiF4+hq
	 56bNTz0S2ZJSVHTTirR/uTQGQbpBXlosMqnclRQpwHcm5csB+2qww4VRdRt/nj86vY
	 CLIzTi1OaD5AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 118F6380AA58;
	Tue, 27 Jan 2026 18:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/5] Add Bluetooth Ranging Service (RAS) support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953681054.1341664.5970715811258440421.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:00:10 +0000
References: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
In-Reply-To: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 23:18:51 +0530 you wrote:
> The series must be applied as a whole, as later patches depend on
> infrastructure introduced by earlier ones. It includes UUID
> definitions, monitor support, the GATT server/client implementation,
> and unit tests.
> 
> The Ranging Profile is marked as experimental and requires the D-Bus
> experimental flag to be enabled.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/5] lib/uuid: Add RAS service and characteristic UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92482d569345
  - [BlueZ,v5,2/5] monitor: Add support for Ranging Service (RAS)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=daaf5177720a
  - [BlueZ,v5,3/5] Implement the Bluetooth Ranging Profile GATT server and client support as specified by the Bluetooth SIG:
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5606307c77ff
  - [BlueZ,v5,4/5] unit: Add test cases for Ranging Profile (RAP)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6e773879171
  - [BlueZ,v5,5/5] profiles: Add Ranging Profile (RAP) implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4e43a6283736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


