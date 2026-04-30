Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F2477E40
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575650; cv=none; b=pkeJYgWgO0mgULBnx+xwqL/7wevaAISM8EJ29KsAdyG6QNe8ffS6tST8KEKXb/nlu+nvnhPkwELuRDsCUrnf0yZah5hHL8hHt4+5LmdKBkni+OVflxVuxCLytLgeJchug/TFqnZRrA/EXdHRiz4ODQb6mPhsuSPsHYAxE6cFzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575650; c=relaxed/simple;
	bh=brFsSzKwQtT6fbXTW4gvrYRxWKQFDy4Rx689kb+YkVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=izXIzZ5LEXtTTJQfXLqTT9O48a6kgi39pnIlnkOKugU+mKVkySuM/Yk/NG1nSHFiAaJMF05IVO2CoehCau+PyJv9Ab182AoysBP4nZFqitFUUmrP+nDzKbnsaspxJCzexrVJc5Vqr5Fl7ND1IBAEns9APBZuW+X+bMBIDbgHACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnRPUw6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnRPUw6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D089C2BCB3;
	Thu, 30 Apr 2026 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777575650;
	bh=brFsSzKwQtT6fbXTW4gvrYRxWKQFDy4Rx689kb+YkVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lnRPUw6WNokYDhyWNMIoPiuVnK6dcWZqXLzvtqLOfSskgM9HqIOI6HJWhOMRVSPUt
	 +eI+zxWlWM16Pd1J7SLiXUaYYn3yDJwuPvnPeM2/Ojf1AOx2cpNLGQL3xnNQ3RzRXk
	 tavvI0e6Y1HOSkda3QZWNioIn1iwLsUssQnFQhb7Q6/A0BQToF0MXWp21CyFQcKU53
	 umYyEMbO56gpYarmqsOVL9TNcoZ7yjuRGOomL8ve15at8VlXxJ9dTZWFUhtY9KYJaT
	 2H8RblxzamxSnyoZGZqw0YuFAOGiqURnzb4OiB+1OaC85WrtRdujv+dVT6aEzQn2K0
	 Y3qInxUcjJhCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BD6380AA77;
	Thu, 30 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] gatt-client: Fix use-after-free caused by reentrant
 client
 teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177757560462.3164688.3337516240351476652.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 19:00:04 +0000
References: <20260429114806.2337081-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260429114806.2337081-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Apr 2026 19:48:06 +0800 you wrote:
> btd_gatt_client_service_removed() can be called reentrantly via
> bt_gatt_client_unref() after the services queue has already been freed,
> resulting in a use-after-free.
> 
> Reset client->ready to false before destroying the services queue to
> prevent reentrant calls from dereferencing freed memory.
> 
> [...]

Here is the summary with links:
  - [v1] gatt-client: Fix use-after-free caused by reentrant client teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d01616f0c276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


