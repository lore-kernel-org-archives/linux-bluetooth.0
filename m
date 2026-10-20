Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520412;
	b=LSgvrraAcQccn/CNqmSlaAALdQfj0KZcW7CriYqX97GHUTUAkB2iPwfGbyYqb0TeI/jm
	 iJmxD0OSSxvQvKEbfdW4uacD61LKIhR2l006r7FS1upTORev5v/2OJA7XdW2mKvH+0F6p
	 Jr3+GeD9iqMH0/G7ETDttneyWG4IfDmom1qyKuYI3b4tov1KBZ31L4UeYDWAs/DJJ9cM+
	 3bkJdbnksWOQxMjGqBYKIt9V9KmQaGRCzet7uY1Ao8AOAn0jc1jB8NpQLh/RxSRanMgeR
	 KZ/f6AHZODaRAFCAQjemjncLHv3rGthPYbDA2RAh6GhJe6Auhin/4NR7PmUe3vHadRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7oMEYSj1AX5ECO2yJA62McxivgnzkTxG7lto+Y9bIAs=;
	b=2h/IGOSa0ZDtLed532U7qjkXeM7zrO+Uq72kYxk8xt/qK+Qe3Fh/PBOZcsGUUuHOZIPb
	 46jT5/0q9TrjzIr5UIQ+/tblPpwK+7WlRr4qBQ7d6hFqzDY6WFu+HhiNewKWj980CcHCP
	 h5B8GON1D5vlMMO0wpho6QPtp5QiRXqf8YZCL/cm3w/s+sJaIsrXXFs2zG9f3fxTrtlEN
	 DLAGyUzMj0t5+3XcamrlYSoeKfeh9pfP2Z7gkq3as7m4S5twEWJeiobZUZITFYzQSVzf1
	 4vAETIn/iDOFX/5q5PU2lHksT7+HkdKLRCfIH1o+9alezNnTSdwK93vq8t+ZKuS136Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I/PBpC2K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CE60A261B;
	Tue, 20 Oct 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/PBpC2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8C41F000CD;
	Tue, 20 Oct 2026 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520412;
	bh=7oMEYSj1AX5ECO2yJA62McxivgnzkTxG7lto+Y9bIAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I/PBpC2KW4T+bFibxainUDViU6unPSnk4wS4sVSWG814URBQEHQ1k30BcTVIMPFCW
	 gdLG1TFCrhG8zOCP9CuNq3XmHfFkJ4eE4FICUZrtAfiHDBtBzBtAmz2R39q0WbtXpi
	 37pbEGGSlZtA4gpAtirAAOPuOI+21k8Ik11q8w/hi/k4H7EYFjapEyjoYtXAQZFIeg
	 NN+rETnCTVRrsgcke/7i6Di0pc9XSQWVo4+hIoGnf+PZGIvxcUZgJnPWUUPZR16sjD
	 9Uj/FfAitkQSpm5xfxfaUBbhz6cZA1F0nA8oCT5+51V8UgqP6Q5j2rWCvhpp4sjDJh
	 WwmV9XSJ5ahsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7753E3808209;
	Tue, 20 Oct 2026 18:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize IRK before
 publication
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179252041102.143064.3010303850825539804.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 18:20:11 +0000
References: <20261019111611.491779-1-18983559317@163.com>
In-Reply-To: <20261019111611.491779-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Oct 2026 19:16:11 +0800 you wrote:
> hci_add_irk() initializes the identity address and address type of a newly
> allocated IRK, publishes it on hdev->identity_resolving_keys, and only then
> initializes its value and RPA.  RCU readers such as hci_find_irk_by_rpa()
> and the debugfs identity_resolving_keys_show() can traverse the new entry
> during that window and see a zero or partially initialized IRK.
> 
> The race is reachable by racing an IRK addition with another CPU resolving
> or dumping IRKs.  In particular, userspace can issue MGMT_OP_LOAD_IRKS
> while another process reads the corresponding debugfs file or triggers RPA
> resolution.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Initialize IRK before publication
    https://git.kernel.org/bluetooth/bluetooth-next/c/7404cfafe3e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


