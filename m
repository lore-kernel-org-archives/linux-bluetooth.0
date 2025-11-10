Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651B2DC76A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806039; cv=none; b=lOloQHo6pLE4aQZxXbupgT9ixFrRvrXCG99JjAMd2QvlnUidk3pyZhx2knG7FjuQr+7D2TfklbN8enDHyGZ5+pJcxe8gHwaaSrELQGIaoH/YnFCtDa3PuVtDDKGHz5GlwAydAcg17x7GRDyU665mYzZ4dmBv5KweXbPCf/m86k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806039; c=relaxed/simple;
	bh=3DVvINC+PAv4jwANwjZmAqxLtqXk+njUhNIWOQsbimM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NT7pySclmVNPS73ZWQOQVrMs84iemQjlkeIpxQ0YdijSwVgPEUIsiCrwaaFXsxJE4n4ybVxB03hFYtio7HrbdGOn7W0k5w8xkhe8zjd9AZsuJnoRhYb5yEtnPQIKhcrP00dwhK0qu15aJ8Eid6bM1l62e2YTv0MrIFjB9dlMMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdEnDb3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdEnDb3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB1C4CEF5;
	Mon, 10 Nov 2025 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762806038;
	bh=3DVvINC+PAv4jwANwjZmAqxLtqXk+njUhNIWOQsbimM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HdEnDb3FlAb1XJxesUTkyt8bgibBCTEye/cEJ9lVPlikp4Di7xIar7YCeRfp0aqsQ
	 DYHMDMgnVdY84ltxl2tHDdutDzRajIixZ91Cgpm0iBfCHC38OBi7RKl8mD1YE/GmtU
	 ZhUqOF26HkGdJ0mlJDbhrSP58oxxPbb5k321Tpm8/ewKI5rC/MrwlyzqxoJuAiKlDu
	 SX5rLo3agLHGn4FCLVNpE/uT3ewQHuw5egUwKOhlxq41k2C/xEDxB6zjmpAA5cC3+l
	 R8qy1PP/kX+cjXhi2YqppRnjhV4SYTabxvcredW5pJSWDcE8exGzhTq+aMhSrrlHwU
	 Rrcq987I7KKHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A9D380CEF8;
	Mon, 10 Nov 2025 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/5] emulator: Generate PA Sync Lost
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280600899.2762084.1628504979014825049.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:20:08 +0000
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Nov 2025 15:18:23 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to generate a PA Sync Lost whenever a PA is disabled and
> there is a remote synced to it.
> ---
>  emulator/btdev.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v3,1/5] emulator: Generate PA Sync Lost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca70a0b7d58a
  - [BlueZ,v3,2/5] bthost: Add support for terminating a BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d9b71705bc40
  - [BlueZ,v3,3/5] iso-tester: Add tests for checking proper handling of Sync Lost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2c17c9929b62
  - [BlueZ,v3,4/5] bass: Fix not cleaning up delegator properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1302116ea4b6
  - [BlueZ,v3,5/5] btio: Fix endless loop if accept return -EBADFD
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=51197aac2338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


