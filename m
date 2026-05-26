Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF1410D37
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817804; cv=none; b=VDWYGXDE9POfDjvz9o6C+JHSiRjr/+Ugm5ZNxB4LRwVs6lsW77k7ChIwnBN3pK0VPVLlXknsbLsqBLtPZ/UxXoDitaiqAre/WNQRXlz3SvGtFXxFmhFIvD7qBW5hwS2wcgX7NsRAy5AsWPOQXBTs26EdHHPgkGiQnZjSMrpiD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817804; c=relaxed/simple;
	bh=AD+gdfnK2ppL/PZliqWK4NbKVLpGvZEr7uhMh8EVCHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcmcUb6VmyCVqi7SJtDgzoP/lrX5jJ6NoPEC+9jj0CDvI50ZBdGqA/F30BjI3qpD5Jd3SIclTvofP09b/nk8Bve8YQDYO5Byi084/25z2LIpShubLHvxoJigqG1NvNz50dfMoHAkbiwE115sQ+p1NjPu55zFq65jmbtMj2Gkjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUtq8PcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUtq8PcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DB1F000E9;
	Tue, 26 May 2026 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817803;
	bh=6Opotk1wdpjIzaWIHkehGuIrkR/Q8I5kCiIZTavsfCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LUtq8PcHRqiDHUVXZ2I8uAkfew19VQSibaTlVFi4e6B030U2tP8TDceHCnBQYyR7L
	 5h5RyyVEXFE1SLu64lbJfjnphqc0t7ZPqM1XPcXMbVQHuLPYzyZ8OLGMjqpJlzqy8w
	 E1SFqF/NFMQIlxCa72++f2+sP5FSn8+MKh6O8kldCwBy/DxpY1pWd6IgJueMxHBDBU
	 sqeYm+J1xQ7vXhBkuFDXInYej6ZJGXSCcfsriw55xnY5lvwcXluOefb8Kv8aHtQ/8G
	 u8Kg3PA/9GqI1Q9gvjSzkVRvte25FECAwnu0YeuEEBBxnFgPHYqNF5OYPM8HjuV7v3
	 V/rOnUxidHLiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B8380CEE6;
	Tue, 26 May 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Add support for
 HCI_LE_Set_Host_Feature [v2]
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981780889.3917724.4877683146753954690.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:08 +0000
References: <20260526170341.3529825-1-luiz.dentz@gmail.com>
In-Reply-To: <20260526170341.3529825-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 13:03:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for using HCI_LE_Set_Host_Feature [v2] instead of v1
> if LL Extented Features is supported and the controller supports the
> command.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]
    https://git.kernel.org/bluetooth/bluetooth-next/c/ec9b9c3b31f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


