Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDB503BF0
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465693; cv=none; b=CWPrH2qsbTJ+Dbdmi1w8Sj/qKLB9NiaQ6xcuYC+oxffOvgdaRIAxeu7d+04FV67bpHanlpdf9WeoEcXtsyymWtCQm1B+2xY+pnfl/fVGrSuysMb2HRSbLjQu4AIm4Q6JBGOxkXg0hG/zy7c6GvMCqBhWrJjCJjvRBtTHgf+Tvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465693; c=relaxed/simple;
	bh=4hfZTpLPfM5c0LX4dQC4OUsDleo6Ubw3j+iHXI7ZWbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+lDf99r+shPLBsDOUqxGykFioQ6QsGgql27DerS9TvLsMiqnoJzMRAq/tCfBKHgxnrsUvx4pV1Xx4+pfN/fDmglIguh++679JQQTJ0nUAr1x96rZTAcmXz6fRSeemog5E/cbA4856jEbnuCzPZliXooBUr8Gmh0rId1AjLdswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqz68Dj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqz68Dj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBC41F00ADB;
	Thu,  3 Sep 2026 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465676;
	bh=pCKbocqKC/2iymjZ+Tcmx/XHmHEATUIgKK2qFi4MHrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vqz68Dj5c2L1yU2WPRqeQo29xmUpPrXZmROdnCEWQHNyJkrPjUIGRb5nV4/uPbURP
	 DKQwUgRZRLo9J9Svb6/Fop8Ovj/3ORxwlv15YblKlJgp0J3l5VdFxTpgjT/HNuLkvx
	 vETzl4PxVP7r+JKwNfOhyR3hQuaK6RH9FTu1orQofwlXhN7Bd3L7P3+Q/++0mZjNp1
	 i5IINN53RhDM9PgulA+8WQKyg11DrS7d81lu20k80VD2j3wZlM4uT9I0U8o8mdBDut
	 vvlIO46v3pAefZppXwstu5Vg7SkgpAn930w7NuwgKqTyP+5YYJU4CfalemNmQXk7uh
	 FQ6IvzJHyRmpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F85138119DE;
	Thu,  3 Sep 2026 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: btusb: Fix UAF of btusb_data by rx_work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561713.3994681.3764342442710024768.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:17 +0000
References: <20260902214620.44041-1-luiz.dentz@gmail.com>
In-Reply-To: <20260902214620.44041-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 17:46:18 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> btusb_close() and btusb_flush() cancel data->rx_work with the
> asynchronous cancel_delayed_work(), so if btusb_rx_work() is already
> running on another CPU it keeps running after the cancel returns.
> 
> btusb_disconnect() calls hci_unregister_dev(), which invokes
> btusb_close(), and then frees the btusb_data. A still running
> btusb_rx_work() then dereferences the freed data:
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btusb: Fix UAF of btusb_data by rx_work
    https://git.kernel.org/bluetooth/bluetooth-next/c/83a1797b2020
  - [v3,2/3] Bluetooth: Move H:4 reassembly into the Bluetooth core
    https://git.kernel.org/bluetooth/bluetooth-next/c/37521ec2f55f
  - [v3,3/3] Bluetooth: btusb: Add support for Bulk Serialization Mode
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee16dd607ff4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


