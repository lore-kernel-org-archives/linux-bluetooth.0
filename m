Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056A45D5C2
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746838; cv=none; b=t3dTvquwTdG15FsyaVzOzl3I1wSGXv5I31skgrxIqXdIyVzwfqlW+UwtFSmJpCgbtGyKvJwOsP8Uvg7Urkf6USlDcgH88yy3S/uulnwp/lOFY0CpaFE7I3yFZVkD32yFXBLwLVkSYLjYCKQtn/Vr6pUYvJFJZnZIoP0bhRxBF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746838; c=relaxed/simple;
	bh=5PyqyhXH+Be0JvaLZNbqcfzngxDRe7r+D2sG2MQ+lOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QX8B8HDljBkiiiW/x1erOBBVphuVZKofmbclts6RkGU7ONRDLJ5kYAIy2t/gD7fxgsKc4aAiQuB6yVySzQxnmbU5FuPXX0jPSScTjGr3ZUZeKIT2rMoSpnOze0RAU0J95DUkT8lXIWx1qFnneVqgd9MznPyaKY7Itv+5JlMYiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPUDdNYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPUDdNYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A200D1F00ACA;
	Wed, 22 Jul 2026 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784746836;
	bh=0jG4ltiFQ/44W0rsQgbD0cu0TwYCdOGvbMhWJumVv+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MPUDdNYVEzxb0cvjai+4nIlSJx2cF5/y6JwR6fGPIcqb+9B99vPj7O8uOgffu4QNd
	 IyPX/nWCR+vLjeUp5EvB95Oh1L3EYL1EQNemtwf1X8X4xHZGnmgyymiHdn2DhoVEZZ
	 wGQjY0Ao5YJw3IhlWPWduVYndZJH4z30QOhSQquXa6vGlc7pGTIQnMYcF4Km7L3YYk
	 a54ga8qhJex+0NWjM+WpiH7VoAMIriN9HsLGPFIeKYwemZuw08BRlF4WWVTnavoz+R
	 4yq9Si6arQIWvVLi2NETjB4TDFTpODoQQfBNEoDFOPsuzdREWLtzvPJ+j0EWMVaxet
	 5GTI43c2IW1lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9E8D2380CECF;
	Wed, 22 Jul 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/4] CS: Add create_context support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178474680540.1981212.6780340334510809765.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 19:00:05 +0000
References: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Jul 2026 19:04:59 +0530 you wrote:
> This series adds end-to-end support for the create_context parameter
> across the shared, profile, and bluetoothctl layers, allowing users to
> control the Create_Context behavior from bluetoothctl and propagating
> the setting down to the HCI command.
> 
> In addition, the series improves CS state handling by transitioning to
> CS_STATE_HOLD on HCI command transmission failures and non-zero command
> completion statuses, reserving CS_STATE_STOPPED for the expected
> procedure termination indicated by a Procedure Enable Complete event
> with state == 0x00.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/4] shared: Add create_context CS config parameter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=679b38459c0f
  - [BlueZ,v1,2/4] profiles: Add create_context param as part of CS Create Config cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=442008ec267b
  - [BlueZ,v1,3/4] client: Add create_context CS config parameter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1fd9b7de3be4
  - [BlueZ,v1,4/4] doc: Document create_context in bluetoothctl-cs.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89d477bb5494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


