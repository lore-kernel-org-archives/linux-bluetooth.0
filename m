Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65D47CC6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851575; cv=none; b=P2Cgqy7H09HnflQpn6iyQpElHrK8kjGEv1oZEuihxZ2HV5IEjb6caWkd7yFukTdXNPZAXLDHgBhFaCllhkDpMumIt/mUY61bTevobwBG0X3TSWch6HB8J9pCRzXgQUjxUOzOSg8Z2omqWAG6PbaOO+7fxCsKWfUMbePOWxRikhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851575; c=relaxed/simple;
	bh=bSOdne6DDfGam9FJ/k+QENgDYKm070QtTgLWKkTEtHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dhk2gu+35LzSsoPWpqftZkdIChuICWJxsp9BsazqxhWUAAoX7L+UgfPWEaTR9BUnbEOuBmh3OPPLkGC9lF2NBpoFcY18PY4YOHbme7nIcU/Td5rp7pDC4wmr8NsXZhIc9goaZOD/g3IleCmaD2I26b3+p0subTLAjtvl1fNNU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFDRkKyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFDRkKyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3412C1F000E9;
	Tue, 30 Jun 2026 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851574;
	bh=k4g4aUyj48oLGRcLax3lAAPR7tIx6jKFeCIcf6Cug/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MFDRkKyPlC3PhjAlUJnaRHGyfMBTp4/Nhm/658NRBsZElWphsmwtaOPgKMMuTUfoO
	 yzOBv+BZxpzFhez6qCtomfUV5hf04eXLa4JeaVm8uCs4f++LsN5GIUTQcA/t/YyfyW
	 ToPxl95XuHriFB28eqPvFUzHvIjVMH4xHe2mrvCuQnDlgrRvOJnCmaAb2Vb7p+/Kn5
	 C72VccSAhTldKczBgd/7fbNWC26aTsJ62lARiDelhyaIvJ6P4xETkbRtH7hxOrPZV3
	 KxnhyCs7qsBVPSUzWKW52gsdww2ODKezxV+HkO65b6CuEckFL+3qL3/aVAQvPtGRBF
	 Yo6K9LkqzOjMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A51393A951;
	Tue, 30 Jun 2026 20:32:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Refactor FLR to use
 device_reprobe()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285155788.267316.541382714111705819.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:37 +0000
References: <20260630165919.102803-1-kiran.k@intel.com>
In-Reply-To: <20260630165919.102803-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Jun 2026 22:29:19 +0530 you wrote:
> The FLR branch in btintel_pcie_reset_work() open-coded the entire
> re-init sequence: btintel_pcie_release_hdev() (hci_unregister_dev +
> hci_free_dev), pci_try_reset_function(), enable_interrupts /
> config_msix / enable_bt / reset_ia / start_rx, then
> btintel_pcie_setup_hdev() (hci_alloc_dev_priv + hci_register_dev).
> Every probe() init step had to be kept in sync with this second
> copy in the reset path, and any failure mid-sequence left state to
> unwind by hand.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()
    https://git.kernel.org/bluetooth/bluetooth-next/c/603b91aeb20a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


