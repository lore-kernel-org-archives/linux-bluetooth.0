Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09F33A9CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067068; cv=none; b=k4zIkiWw2XCdAPJOCrSL9vQ80zWOm60HVVcixpRuqQbj4PvlgkbOku6X4MdnOFMPpB+f6RjnActxAOTJDGNiQ9rFDlkaqJ/nLfJaWK9aoaMQWHXnV9A1VPFpqM1OC6wGoRcjgSfiX1DCNgen0nOtYqdh7ar3+taSJWMBdGIg6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067068; c=relaxed/simple;
	bh=xFYcnfhHib2eWiPxzPIwgWxKco3xXK1mQyRUGQ1dfSA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hw/llU3e3MLOvftLx37vKEBIWrGdq19/LFyfiDU8OOun/h4X93jZ6Pm5eQ5yWPXhooRF19LI9TFLEaYWlqVEBz5ZZvI6syMMTm2QOlVJZE/H2wNq+fvQkAjVqyPS+wKdSWzFi2IJVh1nl6Yg54fdw8SwhIWeP6RgRUTvZuWDMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F17zKPyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F17zKPyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C199BC4CEFB;
	Thu, 18 Dec 2025 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067066;
	bh=xFYcnfhHib2eWiPxzPIwgWxKco3xXK1mQyRUGQ1dfSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F17zKPyP1j/jVNdUdrso4qIWLyWH4TXbmJGj6Wde341ZaZWLQSqFhLsPyf2sOKsQY
	 risMjvk0GP6yyNfAUAZqUnsIBYs2/U2JXY+l5029DQc05aHxLgStGY/RnZSEKxeCVE
	 EfUISf8VsYoTt+meK4W18LoUhdnXp4Kv0K3opiErBa19aYkHyMXyNeyjkk8+lAlOIL
	 S2I4pVaUc1vzq7LquksuVR3cSy0EoQxOoPTWKZ79C/JxjNzoDNf4nn8J4y1uOnVraz
	 Z44MxE71AvvHnvCAvIpg7NBoEZE1Nnapi4QCPb1qAaJCydnMC6KXLVwIwl7A8rq2n+
	 ktqKy1qfE9r8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B67380A961;
	Thu, 18 Dec 2025 14:07:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: Fixes for BR/EDR connection idle timeout
 configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176606687602.2967474.11512539577544048481.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 14:07:56 +0000
References: <20251217162112.444181-1-ssorensen@roku.com>
In-Reply-To: <20251217162112.444181-1-ssorensen@roku.com>
To: =?utf-8?q?Stefan_S=C3=B8rensen_=3Cssorensen=40roku=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Dec 2025 17:21:09 +0100 you wrote:
> This series addresses issues with how Bluetooth BR/EDR connections handle
> idle timeouts (entering Sniff mode) and exposes the timeout value to
> userspace:
> 
> 1. Ensure the active mode timeout is correctly updated using
>    mod_delayed_work(), preventing the timer from being ignored if
>    already queued.
> 2. Apply the link policy to incoming ACL connections (previously only
>    applied to outgoing), ensuring incoming connections can also enter
>    idle modes.
> 3. Add idle_timeout to the configurable system parameters in the
>    Management interface. This allows userspace to control when the
>    Sniff mode is triggered, complementing the existing ability to
>    control the Sniff parameters themselves.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
    (no matching commit)
  - [v2,2/3] Bluetooth: hci_conn: Set link_policy on incoming ACL connections
    (no matching commit)
  - [v2,3/3] Bluetooth: mgmt: Add idle_timeout to configurable system parameters
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa10d5a2b8f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


