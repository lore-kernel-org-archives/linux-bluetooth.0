Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D23D9020;
	Tue, 13 Oct 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901209; cv=none; b=YFBKPsqe0PbpvQ7XTsTvxQKN5Vkt8qJ1tBqv95c146HP1Tb06XmpTKTi8o7qFZ4LeTZLR4IiWeAQkJhIn++5I2cc+bUnmjzLqEO+UYxt4wXgoFfRmZQbtyGiLXHmLPl8vAVSRUCT3O0Dwrp9gZ3r79Ge4U6pl0CzEz94NdsC29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901209; c=relaxed/simple;
	bh=krNkNAYk6OrMPS1E8y7v4O2y9Ty7QxiryrSc2Tyzmbw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMS+qx9C05DxxCZ7XyNmCG/pvZAPiE9jXN+zs6asNfFOqVm2enOY8bl2GHBzcUDp3SCIN1bXnEB5B3Djcx5f1Yw6+2vSd63HJ1susSsfrRbQkzzBLAYJzk95BhOdL2B7KfIkDJOy5NKK9N0WS6YYLBLncm4u/8emeLxHgw6qOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZtWdydG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZtWdydG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1C1F000FF;
	Tue, 13 Oct 2026 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901208;
	bh=PWsVnopiDZDXeGRelZ8hFAZkKBfArRx2EIYIb35waFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OZtWdydGl1df9qsDrgBisdB8Kf70gou8MgF/EvPqzEeHOWAbWTLL6aUUq03YgUEsC
	 Q1NhcdQ71Aj7TlGqXam+ePk054UCriUNamqDCiR+Sld7+uTNMunlqUE3yE28NyoicM
	 dlkC2gl4SxoTRCrz2Xsrf0Cy3C7woDnRrhiw3CDvUbTEFO1OVYhOgh/zd4YiGuCAj6
	 E7UbL+0jZPZtHyRkVgpNvPK1WmunXPKXJEqFf+0FlQ1+XCahkHihFz9RMHgVjRNm6w
	 I64Ym0sxjEqopI0Z7rJRgHYZnFnSo2D0oFX4LA6lt7MSStG0GC5Lo+310xEDmaSdn5
	 l/835BR0e4/Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F162439D237D;
	Tue, 13 Oct 2026 14:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MSFT: Serialize handle map cleanup with
 event
 processing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179190120661.334087.7472120913013005982.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 14:20:06 +0000
References: 
 <pm-bluetooth-objects-candidate-0242-v8-0aec1bf7c46970eda23e@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0242-v8-0aec1bf7c46970eda23e@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 mcchou@chromium.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Oct 2026 10:48:06 +0800 you wrote:
> MSFT monitor handle mappings must remain valid while vendor events look
> up and use them under hdev->lock. msft_do_close() removes and frees the
> mappings without that lock.
> 
> hci_dev_close_sync() clears HCI_UP and drains the RX workqueue before
> MSFT cleanup. However, a transport callback that already passed
> hci_recv_frame()'s state check can queue a vendor event after the drain
> returns, if no earlier shutdown callback has quiesced reception. The
> driver close callback runs after MSFT cleanup, so event processing can
> overlap the unlocked removal. msft_monitor_device_evt() can then
> traverse freed list entries or read handle_data->mgmt_handle after it is
> freed.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MSFT: Serialize handle map cleanup with event processing
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b72281125b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


