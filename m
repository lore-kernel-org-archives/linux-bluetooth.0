Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BCF37DEA8;
	Wed,  3 Jun 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509008; cv=none; b=LKt7NCxOIqcT4YlSF4P+W4EcMPLEgeu1a2Iu4MBCsLN+i061awitV3D4YrlWiEuPjTZRrXrgTm3xsbsJZx6D/gZCnvZPTsKNJx9E/Hdwufa5Q8kYJAu+V/vxJo8kOb4YG4LkcSVssmjBD79GXYoyfrcUXTBTxydWhL6xg9S+ehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509008; c=relaxed/simple;
	bh=yZeOzTT+k0GTP4zLSG0a7LMbPh5Clhsi2/k9tsoOJdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbSk6v86KQ63gYYbypatXvcO21Sn5ZClk01UvCMq3HHEz3mF5/KIisAYy6/Yz5IfsH3kIl6Tf13HudG5Ox6Rc4cNZOsmBS9MUQ5GzFyHqpPi3+Orv00DO1eoxIUW5mle5CrVg0p7rSnIeJD9cVSAXSIyrUBtj0UPvzzdGVzD/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp18R9Pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp18R9Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC21F00893;
	Wed,  3 Jun 2026 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509006;
	bh=bQ8KmkMA7Rl0Vum4cczTtgsZHmSKL8icd/k4lmCavYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hp18R9PeDjPgdi/Fk6uB02Ul9NbVWWXXubLpGdKVRW/GNC7mtNlu0G1ccmxFJl/px
	 9S6pUdQHV+mKWsvjW60EIJLBEMi1eVoQTIqJYLzZi/j5t18PBGVGu6abl06va6mx/8
	 ANJAlKbf2JxPa9kkW0x9JmOr/yu/hy9cItaIVnvSR+9fbx+7JyiFz2EdGDzaPN4hnJ
	 WxmLGa7U6vPOp4IXPfrsgbbPQ2ec/C93Qey702FXY+oCFXgoraFiIMMU3FbzzUZHIj
	 2IUHNoSnqx48IT6ECnG/7fXPwMlH56EB6UrHOI6zqB5DJNv1qGrb5sBGLG+t3GXbOz
	 YzPRXm1aLBv0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EA39308BE;
	Wed,  3 Jun 2026 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: fix simultaneous discovery stuck
 in
 FINDING
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178050900789.1520440.5604013251973902506.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 17:50:07 +0000
References: <20260602070032.51248-1-liujiajia@kylinos.cn>
In-Reply-To: <20260602070032.51248-1-liujiajia@kylinos.cn>
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 liujia6264@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jun 2026 15:00:32 +0800 you wrote:
> When hci_inquiry_complete_evt is called between le_scan_disable and
> le_set_scan_enable_complete and no remote name needs to be resolved,
> the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> state. No one sets DISCOVERY_STOPPED in this process.
> 
> Add state check in le_set_scan_enable_complete and change state if
> the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell
> Vostro 13. Discovering disabled MGMT Event below is reported when
> running into the above condition.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad85ec7a145b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


