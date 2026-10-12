Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453243A6F11
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841813; cv=none; b=GD6eIivJY3Evfra4H6K88EYzUw/Hz38/NraOOVilkwvr3lPuATtSD30nLxkllODh68+YxTnzTtG2Bzm6C4TCEF/MqeW0E/XtDZOKfsCj/czqOOg3HSwrdDanQKSnE53nXCWJuxRbuAbPfDfm+TiBjfZpJRMomypKpkro0VvBdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841813; c=relaxed/simple;
	bh=g6yoeZ+a9jM0RfQrPpNWG+eTF1rGLd6HP9qplUxdhjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TDMivfc8WY+Nt1QyBGrqdywSCCiPSAmTk1VYqMmmVWkwgyXb9z1krFlW8kTEC1Gek7fxmAZv4tLyfMtiJLwmcVlXFF9lwBNKR92aFi8MXzc2KBlohskq0KoTK5Bt5RhTkN2MEvWM5wgdLDsgduG2vHnVzHV8kgxPAyswB72dhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPUOE20B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPUOE20B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4266A1F008A2;
	Mon, 12 Oct 2026 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841808;
	bh=nu71JD2gXrx5QKKsexjl5eaOoDHLSnAUqE5B2FzS0Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XPUOE20BOfHzkBjRNBozE3+eCP331UFASACbgL4yMOD+qGXiJ+Y+5qH1ujn3qgENh
	 PiHYNegPygGxFuUTWpOqbmpEMtcIguXMhO+XN1KsSK3cOA46K9h5zdZkzlLBbIAuZv
	 jH9V0M3om9CsvoOJCUzsbhRBUP6MqtD29D1MBgA8u/303o/Tq5OKoA04Jf2ckhHaqt
	 CeCKZjfIZMEk9AW2B0VhZHd+QYYY9m10Fdh2YtFzkAT9LfzpN5OdqYwnFekTIeavoA
	 a8ahjX+whyzb9D90y8bJUFT3ix876rxdjogQlFaejtQ/rsyP82jldkpnB13Lv4sQY4
	 RUCD8ssQIiheA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2D539253C8;
	Mon, 12 Oct 2026 21:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] emulator: Free hooks in btdev_destroy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179184180676.4115061.4860406922959655412.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 21:50:06 +0000
References: <20261010031846.2842837-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261010031846.2842837-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 10 Oct 2026 05:18:46 +0200 you wrote:
> Hooks added with btdev_add_hook() are only freed by btdev_del_hook(),
> so a hook still installed when the device is destroyed is leaked. Five
> mgmt-tester cases leave one installed: "Add + Remove Device Nowait -
> Success" and the four "Adv. (non-)connectable & connected" cases on the
> LE emulator; one l2cap-tester case does too. They pass, but with ASan
> the tester exits with status 1 because LeakSanitizer reports, for
> mgmt-tester:
> 
> [...]

Here is the summary with links:
  - [BlueZ] emulator: Free hooks in btdev_destroy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8da7e648a9fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


