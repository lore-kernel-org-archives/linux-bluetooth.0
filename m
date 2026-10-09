Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71784FDE56
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575412; cv=none; b=uzKD1F7OeQn85rKziN7ruacG+3M7fX3qwjwNASBcOXcuACLGzD4yMSNrpvONuvZHve+bOfFTwKlaURwapZI16UxINmHfmgB5B56EjSiMD01PwL0k1Y6RLoaBoPrnLVJStixNsgPTLmhhHodZXSr0pJDASo1et8gEsnKrOkGr0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575412; c=relaxed/simple;
	bh=CXGszrT4W4zP344XhjphLYfRk/GgH7rU0UF3Lu1ojns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dk5mQMkrBqSO0ovia47QLHoz3DQfdtEj/OdlMAJUI9OcFy8kARwqjlQwzRaoQTrTGlS43mmnzglaPK6AZYddy8tQAp0LKA8ipTVcpyZKNWrZzDpeBHO2Ak2E0X0lBHRtZDK4LJKViWXNhePSx8+bhfk3Y/vxvFJvt9aiSFBI0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIeyfsDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIeyfsDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4448F1F000FF;
	Fri,  9 Oct 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791575407;
	bh=yTeCyulY7aLg+4lburNVJNOGe47/lrNJ/ne77OJccFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LIeyfsDQTIDRzZkY+QxeBFbBL09YorIxNUPBHjdBBKT5YGxvrAjJMqHAS8uZG4sZZ
	 3Je32vNJKiYZKyRsgSUrqFj9T19dCvv80QlbysltpWFfKeDuZlW/1IyYMkmvznWEBR
	 gqxSL6yEExBMfyD6DzFrmF+VwrdYczLYp6+9WZUaxNbn2BSv8Yi1UZ/VQ0hQ/FhCc2
	 Gu4vl21FmM0v7sy5uAC+waou7Vf81YgwmmwQeSFKJsRjnQxQRzCYTLWsYlXgh6gs2/
	 S7XfplJLDbFHwHdjk1JdINUWAh0iABYTsX0KcZz2ZUJ3J2bW7DyKjfFMzIreJSxCa5
	 P/3AXAa+xLGNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2E13926273;
	Fri,  9 Oct 2026 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] Bluetooth: btintel: Zero version data before
 parsing
 TLVs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179157540571.979491.7048149964326431480.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 19:50:05 +0000
References: <20261008140602.2623464-1-kiran.k@intel.com>
In-Reply-To: <20261008140602.2623464-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 19:36:01 +0530 you wrote:
> Firmware may omit optional TLVs, leaving their corresponding fields
> unset in the caller-supplied struct intel_version_tlv. Since the
> structure is typically stack-allocated and not cleared beforehand,
> fields for which no TLV is received retain uninitialized stack
> memory. This stale data can be logged via btintel_version_info_tlv()
> and copied back to the caller, leaking kernel stack contents.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: btintel: Zero version data before parsing TLVs
    https://git.kernel.org/bluetooth/bluetooth-next/c/21c8238e1b1d
  - [v4,2/2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


