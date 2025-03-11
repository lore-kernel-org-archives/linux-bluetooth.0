Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DAF25DCFA
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708205; cv=none; b=eIBNmUlvvytIhnCcYXZGfgV51hUYeIDEyIk0UsjuUb3mdf3EKin8ywLimjuGUev+X6iAWKOaWZfSB/XxdS+gSW6eqGVTrqMswTgineNHEKeWJ9riFNbgPvQ1geZLfzM2Z3nF6o9LBQmVSJQMaH7OOkhYFVYhpB6H3nG53il0BF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708205; c=relaxed/simple;
	bh=vJR2+2lsYMbntd0fNhS8ll+Lbh9kNc4bt57Ktj7TTpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F2LBLAnEXFq1ZkVGlRTTjAP1DAPjJjZacystNctApyox8f1ciDyIpbBVSi3nrjkkKQO9bPcCR5cpPuOL8dm0XdKzXW+veERd3uIvAu2g/yh/S70TcJIqgwe2Zy3nsH4YriBFtw8u5GkzvT90UWbGPpwdUtDYk45v8hFL9v1yfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Fmakc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Fmakc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F575C4CEEA;
	Tue, 11 Mar 2025 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708204;
	bh=vJR2+2lsYMbntd0fNhS8ll+Lbh9kNc4bt57Ktj7TTpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q7Fmakc4ktKm3Faukw2fqJdLp2b3oTnY3qEesxaeQI+8FG4zNUFDEkjnb6BHtdl/j
	 cTyUq2zI8t0eqwnDStX7xZFXN1qIbZIKB+jmmKqAM1P58Ndh56DfE7Aicf5wPI1w6R
	 RTKOtSxM6RQ1hDWc57PMu1VaWOj9D8+LuG3eJU1gFz+Rswo08/SSQWX6O4yAv9MPpl
	 TaFZisRFm43xMqVtlinZc08vpNdXYiH2hNkg9COC349HdLbE70drwxyQTpxXcdVNVF
	 JUwLTsWK9zHsUdmU9VipRZomvXGOnL55wP+gKryOHvkHms+ixU0OIp+gbqdHjutqQy
	 +DNTwpS1R2RNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE1380AC1C;
	Tue, 11 Mar 2025 15:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] btdev: pass sent SCO data to bthost
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174170823823.132061.5179252333096990221.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 15:50:38 +0000
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
In-Reply-To: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Mar 2025 17:58:24 +0200 you wrote:
> Actually send SCO data to the linked connection, if any.
> ---
>  emulator/btdev.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Here is the summary with links:
  - [BlueZ,1/3] btdev: pass sent SCO data to bthost
    (no matching commit)
  - [BlueZ,2/3] bthost: add hooks receiving SCO connections and data
    (no matching commit)
  - [BlueZ,3/3] sco-tester: check sent SCO data is received at bthost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87d4f95dc312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


