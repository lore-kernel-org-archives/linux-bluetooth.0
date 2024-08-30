Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946631B5820;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035429; cv=none; b=bu4EAXTLASn2UMnCbyabpl1pDaJR7x6a2Y2l7cllaCua98SDMKB9RrjdMvqn/AYAHdRVY1xAlYm6ZgOT/OCJSllClXfnRuEcSdlVVA8TEKf3VNi0WiWswRRdEkqt/2ULFlSyB+RjLf9OdSDBI6MgcLlOuXF0OlKOAcgRi53WH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035429; c=relaxed/simple;
	bh=bCs8J24OrCsuXi/AU51XMMjmTi4TErRq+PY+G1NjgNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/5XxCov1CzbgUXoyXEs4EsiOdvlcSJT3sSp99uPLCHk5+czaJ0+2xLBsFwXK89kGuNVMRgMtYj0i3ODFf9nu14YZcxoDUNJ5YzvPXDYaB28Fw80FB/ZkwOyWJNP6V2RspyY9ToneLnlPN9UoJ/0dHGkeJYKLnG7mmpyAQOw0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmkXB920; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmkXB920"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE7BC4CEC9;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035429;
	bh=bCs8J24OrCsuXi/AU51XMMjmTi4TErRq+PY+G1NjgNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VmkXB920mzE1Vc79BOe5gafEE59d5LkoZ62gFay51iasfkUH5qD5wrfbcGPO/gRM0
	 ioAhKuCVZjoh5qv/TLCgFwHcbBRFIDbxYkaqHRiu7T2t+OxlX5StWeewM4mRNl2TDj
	 j8mCclSHG6qUAN7+9w9ekxqIsu+3NpBTdiEE0dPwqAuxybgx72BvJWIESkMByr2xJt
	 09Zbk6Ae0n/BXPCsTC9SK14glNlxc1GSk2m1YZdyCYE+YD6GMQaimQ0r42sNFYSyHd
	 hXmePidKJiWvRns5Fvd7YRitqJYxU+WmUVKOYw2t19yq8Hizt4b2xrICqIbx/q52Le
	 /q6RKze7rCrdg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CD5B93809A83;
	Fri, 30 Aug 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btrtl: Set msft ext address filter quirk
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172503543083.2648350.2018898674342580580.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 16:30:30 +0000
References: <20240829034627.676529-1-hildawu@realtek.com>
In-Reply-To: <20240829034627.676529-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 11:46:27 +0800 you wrote:
> For tracking multiple devices concurrently with a condition.
> The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
> on RTL8852B controller.
> 
> The quirk setting is based on this commit.
> Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
> address filter")
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btrtl: Set msft ext address filter quirk
    https://git.kernel.org/bluetooth/bluetooth-next/c/e278dcc0a237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


