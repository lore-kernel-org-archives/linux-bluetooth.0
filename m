Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C73BBC9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815824; cv=none; b=th5NkjqYQaMMir01SJrBEHoJ0rH+A27riq9bC27UZCM110fjDtSNYXjpfptuRx5wAmNR3hFPWmPlfcxntwjbWcOIdkpINo+RE3au0Yt1pDFqcdP8h9ObDJYHKgt+NKLvTKCUC1bJCU4qYwlg2Wnl9sbAPYU5u1p36jOqCu74hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815824; c=relaxed/simple;
	bh=8RYyf5p4nwC+svfA5jdFU25joTpS8F2edJYnQCphGB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=knsacE3M2V/d+A3Pcu9EirKS7I2Wwdxo+Dx3c986qs17r6RM0HuTumuveo4XanQQgl7luwTOJ6YcuYvRSjsuwNzaImPhTYRAvlPs7LvrYhZDEeqViVIlpjcafu7WKm2jW+XGnFncl9QvEJh33bDK7X8ruJxOfZjww2EGAy30Di8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK3ITK8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK3ITK8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A8EC4CECF;
	Tue,  5 Nov 2024 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815823;
	bh=8RYyf5p4nwC+svfA5jdFU25joTpS8F2edJYnQCphGB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sK3ITK8VQTmtBur1uirCypSxgX+PFkiBjyrq/gSFU+QxJvYi+7gb2+IM80t3L+f/e
	 R7MZ/OddKUgYp1zKWtH9bCBCdHHQ2kxiDjaXl1nTb/hZLuY487DLTo2AoBV+EW4/0E
	 CGuDxshKW1lEkdisvdfVoI6HiOFQaK6CxAZH48LNYQ/gcMjwNYAK51l3A40ZCmO53e
	 rCezcTqcT1r1szgWrxoj3rIKF7Yqxv5FMG8sV5/q2xY/jstkoOiCEOdFvuYGybtSpK
	 8HuwiIVeTNsRKkHclUBZCtr45Ew3DpntUQ5eV2FSRx1R1bDP7bXVKn5MKdwOH4PlzY
	 /aqwScAM/9ppw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF123809A80;
	Tue,  5 Nov 2024 14:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: ISO: Order PA/BIG sync commands
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173081583250.569661.8923194940419140058.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 14:10:32 +0000
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Nov 2024 10:23:35 +0200 you wrote:
> If the Host issues the HCI_LE_Periodic_Advertising_Create_Sync
> command while another is pending, the Controller shall return the
> error code Command Disallowed (0x0C) (Bluetooth Core spec 5.3,
> Vol 4, Part E, page 2493). The same applies for the HCI_LE_BIG_
> Create_Sync command (Bluetooth Core spec 5.3, Vol 4, Part E,
> page 2586).
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
    https://git.kernel.org/bluetooth/bluetooth-next/c/763c133ff07b
  - [2/4] Bluetooth: ISO: Fix matching parent socket for BIS slave
    https://git.kernel.org/bluetooth/bluetooth-next/c/b6ac0f1db378
  - [3/4] Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
    https://git.kernel.org/bluetooth/bluetooth-next/c/6243e598bc64
  - [4/4] Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff3fd60725a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


