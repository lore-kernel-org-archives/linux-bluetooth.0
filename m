Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793413;
	b=X68b7vCyFUQQvMpr7oPPMGM1sFFsy3cjpZDAq525QwGs7/AouzYZGOhfBjMV+hZnXTDp
	 IVvCHSokbSwdps7qeV4MGYHjfGw2OU151Q1K/Cxn3E9ngv55PRzPmyCoyPQQpaX+qIYQY
	 6Pa0aLbzAyvoKHJHeGwZoisSQpQpdG0CEXNnQNeIicIY9zuVkUnacZG7Gyr6PwaqltQES
	 2+1avpAnBj4saZuK8VbpQLida9cIJgR1M5FfDfB6ep3zADFHvZfzilKLTPma1V+ZVUiKe
	 3KQAtXwL8OnkkmDlVegyc3uWAMzK9BYw74J4s1kAw4iFZIvV9KLTJYzRRYp4TMtYSSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1mCqzzxWjMqDLySJJYwOwUosu8W8pSpFwSVp2R8njlg=;
	b=0bc9gIfCbPXpkQdufwUdd6obcCGSOsWSqNyWRhpze+o9BcmBffILebUb8SZUM7gGm3Vd
	 AOqHwENFqo9WU6q09A2YiHb4DG4oiUc7+/0AQuIUm45f4Bv2rNopa9cdlhMnLEkXEJ3da
	 6fPveLORwuW06UDX8E7Leoa271YZVIehzwY6hy4DfPYDiI8M1fN9bV+CVioiWTOBVJceb
	 pwCNLAiT+6qveG8wKkY+JO4uLTrmg5neXOLIHPBIw1mldoupVAMpjLoDupN62NpCaSj5G
	 8QUo/Xj5nbUu9Cw8iB5IGISaky84bkwCq2XC6Ms26o3F2qRprl+mZ9zSkdtQtNJNdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGABpSKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6A606A320;
	Fri, 23 Oct 2026 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGABpSKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893311F031E1;
	Fri, 23 Oct 2026 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793412;
	bh=1mCqzzxWjMqDLySJJYwOwUosu8W8pSpFwSVp2R8njlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dGABpSKPZXwVN8md7NweVLdckETbZ2Ef8Z+44/cJuijCtGN+KEQG4VkcoPE8n9h/0
	 6zoAZVw+BtWLCt6JmAPVQ6NgM6kJe2AYmT0pNKOrpt1kbk08bZPARaTBttkoewsYLf
	 v36CrtFjuH/pTLsyV1UVaaYS+djeu13YqdMV8KdoVZyeN4Ov04U/S4RqxDDo9b3F1N
	 Os7VK9CGUv5CkwAUktn62mGVRL3kKvzGDUPY77GhzmTFCZ7s0umUNd8ztRaYuIP0Ub
	 Jo2CrcwIR/CmqhFfxV0hFyFmRbbTPwwhPpmJRK1JhDtXqC8Tg9mvaTDvlrUa6Yw3sD
	 NYFxpfA0A7NMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 81505391B158;
	Fri, 23 Oct 2026 22:10:12 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: MGMT: Return RFKILLED for Set Powered on a
 blocked
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279341105.1294506.2700531975523429266.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:10:11 +0000
References: <20261021065833.120347-1-tooangel@tooangel.de>
In-Reply-To: <20261021065833.120347-1-tooangel@tooangel.de>
To: Tobias Wilken <tooangel@tooangel.de>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Oct 2026 08:58:33 +0200 you wrote:
> Since MGMT_OP_SET_POWERED runs through hci_cmd_sync, powering on a
> controller that is blocked by rfkill fails with -ERFKILL from
> hci_dev_open_sync(), and mgmt_set_powered_complete() reports it with
> mgmt_status(err). mgmt_errno_status() has no case for -ERFKILL, so
> userspace gets MGMT_STATUS_FAILED instead of MGMT_STATUS_RFKILLED.
> 
> Before that conversion, power on went through hci_power_on(), whose
> error path mgmt_set_powered_failed() still maps -ERFKILL to
> MGMT_STATUS_RFKILLED. bluetoothd relies on that status: for
> RFKILLED it sets the adapter PowerState to "off-blocked" and returns
> org.bluez.Error.Blocked for the Powered property, for any other status
> it returns org.bluez.Error.Failed.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller
    https://git.kernel.org/bluetooth/bluetooth-next/c/65683fbed5c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


