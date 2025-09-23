Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B86238C08
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637809; cv=none; b=FnH8mHhENOYtuJ2M5K7rTFN47oRGop2PSg/Plp+nEnpAAIN4zDl299A66jXHWLNeZp1csE6k2ic7dl3ckfQeYwfEtwC8XwVvtwcPS23slGeIDGc/wAi6J3cJmLo3vpWaqw93rqCJpAau16UnYwZ1pqliwsXS7Hnl1sOkimC8wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637809; c=relaxed/simple;
	bh=7SFbN/YfjgMDxtl+n4afbtmznx0IK5PsGKRR9slRUrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfoL3alAuCgAAnzF8AdmmmCL/ymLoc9LYw+vpeTNp7HorQPw0fsmd3Ha0NzsLC2AiNS6ZyAXXMMCqdl9ZitNZvD5oytp+Lyb2GzV9qjMJDjbaiNkhLMVPZ3acdf9S1Pbz7iSmQ7zZ1pWL6voe+aVFzom48gEOQNzxSGZ5BivpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c85ek8EP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c85ek8EP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184CAC4CEF5;
	Tue, 23 Sep 2025 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637809;
	bh=7SFbN/YfjgMDxtl+n4afbtmznx0IK5PsGKRR9slRUrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c85ek8EPAo84aPzn8h9xlm2lbu3cGVs4YNW3O8KjQzFKK1ltJgvNUaiotMUtEnSV6
	 a1bKxFhNsn/ZVSB09eEC4pOnxUVBKktmGWzYIr3Jc6/bkukvw/1bQWfDKwtukkNjL7
	 O4ZICnsvQG+xGi7t5sjNKDJURTNhbEgDQq9A0ZJuG+U4hOg7Ry4pNG1fe1Ys3eCcEq
	 12cS5WfWJ5Ftqy6YfXtTnc+uZOO9u1r25H8CRw6GuR+4kuNZGIEe5gci1+dwnCwNlT
	 HG9YcETxz+AovfCRjeXvxkcA9YngMj4YiSWIDZq6ofOYXowXSfs04VG/Tys56zhDtJ
	 BJ9AzZY7khKJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAE39D0C20;
	Tue, 23 Sep 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix using random address for
 BIG/PA
 advertisements
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175863780625.1447851.15087320797406593527.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 14:30:06 +0000
References: <20250919163005.2278059-1-luiz.dentz@gmail.com>
In-Reply-To: <20250919163005.2278059-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Sep 2025 12:30:05 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When creating an advertisement for BIG the address shall not be
> non-resolvable since in case of acting as BASS/Broadcast Assistant the
> address must be the same as the connection in order to use the PAST
> method and even when PAST/BASS are not in the picture a PA can still be
> synchronized thus the same argument as to connectable advertisements
> still stand.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements
    https://git.kernel.org/bluetooth/bluetooth-next/c/cf9eb0b9f620

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


