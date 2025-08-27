Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0DEEBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321799; cv=none; b=odi/NNBVYsKMIzKoET9PsVYlmT3gGgTZBcjf79JbGUjg/YECFCgFvO3cwip4TWM9Hgwo52kp7rc98kp7yTFdjtpb+sY/AAEoVt6kSjrS6tHJQEj4vH2xr+dU238F5h7XFJNyMx0v0i0kwb5HGi1Cqec0uMPhW8t40SN1RIoLM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321799; c=relaxed/simple;
	bh=11+Gna1sx38cgWb+tLR1xfC5U0SUkbA659FA0vwAZGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXfI0L1qKGudGMltdGYK20U8AEvsEEQBhOCFV8EXaPRfpRt1hHNyNIaN464C0/TyJ6iThsoYuOWo8GDTWOrbxMpyZs3nxy52HJjc1ylL0Tn7VNm6WB9b5rJGEmevkribyCPV3okGNrNeOG9vYo17ppZNgGXm4xljn7wRb3ksBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNexrs7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNexrs7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF78C4CEEB;
	Wed, 27 Aug 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321799;
	bh=11+Gna1sx38cgWb+tLR1xfC5U0SUkbA659FA0vwAZGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NNexrs7pNvvf9EnEx7mRamvUu392a6HTBcaKBS/UUTZVJNyFkacVIywoIGXzuybMw
	 AyogSNI6514mx4zlEkRrknXl3RZdRRs/TZyuHnc+mkxIP/ftsASm7tJAwatPxmHhNW
	 cKJCagWRctOcOMDLk7mTVuirHVba2l+FdCNgucf19JR/p3FUogK/LOdb8vHU7GEL4p
	 xiSYI2z9VEPFpIHY1BIxAy/htziOu3LIlihKEn28ulbNnn9acu22hKJmE7U8eCBNEl
	 h9WKwARhrrktt9s81KtJG/kI6iXE3KV726Z4qx6c/oYoFMj27poISYZm2/JCR55Ezf
	 ByiVwoD/4o5ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF96383BF76;
	Wed, 27 Aug 2025 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] Bluetooth: hci_core: Convert instances of BT_DBG
 to
 bt_dev_dbg
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175632180650.807633.13290662952621368833.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 19:10:06 +0000
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Aug 2025 16:47:46 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This converts instances of BT_DBG to bt_dev_dbg when logging to a
> specific hci_dev this is preferable since it does prints the name by
> default.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/8] Bluetooth: hci_core: Convert instances of BT_DBG to bt_dev_dbg
    (no matching commit)
  - [v2,2/8] Bluetooth: hci_conn: Convert instances of BT_DBG to bt_dev_dbg
    (no matching commit)
  - [v2,3/8] Bluetooth: hci_event: Convert instances of BT_DBG to bt_dev_dbg
    (no matching commit)
  - [v2,4/8] Bluetooth: hci_sock: Convert instances of BT_DBG to bt_dev_dbg
    (no matching commit)
  - [v2,5/8] Bluetooth: hci_sync: Convert instances of BT_DBG to bt_dev_dbg
    (no matching commit)
  - [v2,6/8] Bluetooth: hci: Add hci_conn_set_state
    (no matching commit)
  - [v2,7/8] Bluetooth: hci_conn: Add bt_conn_dbg
    (no matching commit)
  - [v2,8/8] Bluetooth: Add function and line information to bt_dbg
    https://git.kernel.org/bluetooth/bluetooth-next/c/e845c8526165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


