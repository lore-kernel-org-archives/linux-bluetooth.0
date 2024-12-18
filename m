Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA21BEF60
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532815; cv=none; b=H7h3TYKxSeF1+ty6/ZTKwOp9gqRLwlyswiCCv6oAbVUH8WcP0IaNeMK3Jm2KM0kW87nSuVhzXypuI5p8V6hkbCjs/4JwkmfO0irzuf55E84QIqg5V3TSSqDvDTJeC0MJTMwMrHtD4jucEZ8+I5AuL4Rp4ai4Clbrikc0/nrZyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532815; c=relaxed/simple;
	bh=XyliEA8MAm4NdtI7RgjpeCf9nu951WYhy/9nhSCYc+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d63aJRoopMaUAgavmLx6hTkysg34261qcDuqJKJggpOMYOJBhL1Au2NZrTQRQtQko74qYOjGaMyIysoKAwBz5CIbORcUJ+/hGKAMxoYJwIoOIYY5M5EBmGT9Dh7pCQhv2ZxbqYsgWhmc2RoMg5v8/FXlFeXnj9ptZXOT4JjIGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5svVOZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5svVOZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D656CC4CECD;
	Wed, 18 Dec 2024 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734532813;
	bh=XyliEA8MAm4NdtI7RgjpeCf9nu951WYhy/9nhSCYc+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e5svVOZJ+KZTSGO8TUQs5p//xvDFrfNXM4RT/NXh6DWF2olMG4bh8LZVb31Wr4LZG
	 ivyZUw+RVSXeJ5CLnKqaRoSI06CD2m1LihPfyIAe5XN3SMJU95QFT2Lf1OmclJ/+U4
	 ptKELl9b2M/LidUCvKovqIhdtsorY3Ut6Y/zsctLy4Z/iJMEveV/Tb3KaFmIDdRktE
	 yiAqqejdLX6fiSas4v466DKQ4fvupmhXbdGOWv2CDRp4fEMOtDuMLDJHVNvQCmMipR
	 C3c1QKnEQ2Fl1vgXy0R34XLS4Qk83uRzAIfvZdaNijQajGKMT/MM7bG7NmoL5CxohB
	 RkfFeqc5NmINw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D873805DB1;
	Wed, 18 Dec 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] client: Add command wake
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173453283126.1631723.7819448687372201714.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 14:40:31 +0000
References: <20241217181334.3243011-1-luiz.dentz@gmail.com>
In-Reply-To: <20241217181334.3243011-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Dec 2024 13:13:33 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds command wake which can be used to set WakeAllowed property:
> 
> [bluetoothctl]> wake XX:XX:XX:XX:XX:XX off
> [bluetoothctl]> Changing wake off succeeded
> [bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: no
> [bluetoothctl]> wake XX:XX:XX:XX:XX:XX on
> [bluetoothctl]> Changing wake on succeeded
> [bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: yes
> [bluetoothctl]> wake XX:XX:XX:XX:XX:XX
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] client: Add command wake
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c0fb6c067e48
  - [BlueZ,v1,2/2] device: Fix not being able to set WakeAllowed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dfb1ffdc95a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


