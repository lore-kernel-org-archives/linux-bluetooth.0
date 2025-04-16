Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39747149C4D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835997; cv=none; b=Dipx0ynOzY0AlK0R8y8YBjPEc01mTNqz2mIu6sNO+iJSmiDBy/V/h9x9eIIyazECg6Texa3EdRI9sXTFsirBkaxkKCHb03cEun5Ky68k3p2qaguc4Vz1EMs1MO6RaeZmaUuBa2BtW+Fe/wIP4974E1lXMMph0Rkot5cdDVEEA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835997; c=relaxed/simple;
	bh=0GwN45L8TCO+bLgunNmeruX3wa+MudDxPOCjBUnAsYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oiYN/ocPK6q0FGQ0otrpTRl1N15Q0OzO9BWoD7gJXN1CmJyYhj0Pzqzao/83ngqXBMHRoBK93fkIaeKPynaDZULtgoVTTf/q4W0+vNcviwOhl7GGUXUwkfnq7r/PtnQwSt7OZaTWbpBB9nOdkqNUPWolhQDz2SOZiTfz/QU8RRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmNlb7Yo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmNlb7Yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC73C4CEE2;
	Wed, 16 Apr 2025 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744835996;
	bh=0GwN45L8TCO+bLgunNmeruX3wa+MudDxPOCjBUnAsYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MmNlb7YoDIRUCD7HcyO/BUtUzG4llSipm+5rVw/5eGBJlKZuj7mTAO3RnNHgq8vKF
	 PpXELKIPgeqhxtrTlEW5W4SKviF59ldOlR/t3UqWHtjqmxhkqiEkKuhJaC402jF0NY
	 SpapE/GSs9mh5b0+2xdCG+XENS+bmWFcfXUKq+GRHqf1OcyuWDXDH5dUrWiq4PrH+X
	 Lcjikb5HwDFk3aiXYgtv8gMOkAMjxaqBxnhnVm7ZtyIV81ndtClAC6yIZ7C9ykjfFa
	 eoCbYcrrJhRrgoY+VI3I/6oIoW3qaN/fikljjTfYhQfNAnFUebaMA/dFeaJkmRj5hP
	 faU1GuwRpFaHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2DC3822D59;
	Wed, 16 Apr 2025 20:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/4] Bluetooth: hci_conn: Fix not setting conn_timeout for
 Broadcast Receiver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174483603444.3492169.2517201578833514334.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 20:40:34 +0000
References: <20250416195526.1989143-1-luiz.dentz@gmail.com>
In-Reply-To: <20250416195526.1989143-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Apr 2025 15:55:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Broadcast Receiver requires creating PA sync but the command just
> generates a status so this makes use of __hci_cmd_sync_status_sk to wait
> for HCI_EV_LE_PA_SYNC_ESTABLISHED, also because of this chance it is not
> longer necessary to use a custom method to serialize the process of
> creating the PA sync since the cmd_work_sync itself ensures only one
> command would be pending which now awaits for
> HCI_EV_LE_PA_SYNC_ESTABLISHED before proceeding to next connection.
> 
> [...]

Here is the summary with links:
  - [v5,1/4] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
    https://git.kernel.org/bluetooth/bluetooth-next/c/58ddd115fe06
  - [v5,2/4] Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3b6a7cfa98c
  - [v5,3/4] Bluetooth: ISO: Fix not using SID from adv report
    https://git.kernel.org/bluetooth/bluetooth-next/c/8144831f8c8d
  - [v5,4/4] Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffd068349018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


