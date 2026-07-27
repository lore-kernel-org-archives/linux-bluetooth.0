Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A13CB57B;
	Mon, 27 Jul 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178858; cv=none; b=GTcEWz6W+OmvGNx8oOdVs7NrEn57f/itjN8wG8UnRUXlbUmqJFszIgfTaz6BxbEgbEKpELr4Kl2F4/qkADEtbEg8OSNpZKxcqRf9PwqLuoNxnjiuhmbz2nztL7rd9kA4MCd+muTPy8KKAhhRc+U9LBRMrJzCe5hTFM3G7lgCP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178858; c=relaxed/simple;
	bh=3nkWMY4p+z1ZxllxtJucljDoR2ZoLqP9OzLyLSZA6Jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l14CwXYVsW88gZOjMa4zPaw2nkpvvtEUuoUtgFaQ75kCsf6cAQ506Cl1eL5IaORBGb9qz2fn3qtu66xg5y5SSStcrvt2a1Y8jwEGAnfUvA8Pq0UaQNOxt298tvIn3CNSG4ydl2bnWFU8MnF7W9KCB0Be+DB3ICoZSAjwuQBDfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX+2/D+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX+2/D+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED861F00A3E;
	Mon, 27 Jul 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785178843;
	bh=ewsjKQuuR6TnRFmPkr+zQLRzhvPxhg4Vh9teneUKg4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GX+2/D+UoKlXmgSlhwlV0bFtVv8R21CT8Vh5nL5dTJ7Q07CgWA68QBFAitSLOYGU+
	 9OOTck8YVytut4RMYTGG2WDXUp4X5fzYn0xTqfrGbduHJFX8pV/opsgH1R4wbzEP0o
	 6yvEl3x3Zramk8/9TVbTxZn4+i5LYi7TaamXeT5UayuSRfTa5hwlZDcYXECBtPuyC8
	 +4OyIzOOwldVQcC2CCd8NZfNEOos2qBQyMl3l9dECkqkemEzStFbUyxd4yrtTdc95y
	 bvqmCY7bEqykmvxrG4yLtHXdi8uVrYGiMRbk5Dg2x6Vku5t86PZJnF0x0jfMFbJlqp
	 fcYZbYksA8gKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0828380AAFE;
	Mon, 27 Jul 2026 19:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/7] Bluetooth: hci_conn: hold conn reference in
 abort_conn_sync()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178517880851.1372023.12829411898419783534.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 19:00:08 +0000
References: 
 <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
In-Reply-To: 
 <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, oss@fourdim.xyz, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 Jun 2026 15:12:32 +0300 you wrote:
> There is theoretical UAF if the conn is freed while the hci_sync task is
> running.
> 
> Hold refcount to avoid that.
> 
> Fixes: 227a0cdf4a02 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - [v3,1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3bf1394e8868
  - [v3,2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
    https://git.kernel.org/bluetooth/bluetooth-next/c/69a694ebe97f
  - [v3,3/7] Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
    (no matching commit)
  - [v3,4/7] Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/cddfec3618d0
  - [v3,5/7] Bluetooth: hci_sync: hold conn in hci_past_sync() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c5f5c6be878
  - [v3,6/7] Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/423e5fc465eb
  - [v3,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/73b6871b261f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


