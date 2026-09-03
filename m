Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E9503BC8
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465676; cv=none; b=m6bEUHmVhVK8qFCBfg6q08hv1z/0Tup5K0+M2r1AnAlxg+kCZ/ibTmK+a8k9Gro3YR9JFE/MdgAPqedzUrYPpuL/xReaNbwZb/EVeBhkWS8/lh54vFdCqNi7TRtJOakqQ84RmitNFwu3FAZ/ScKxIPjHT5gEGkhKKX/33TU8rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465676; c=relaxed/simple;
	bh=A9SfJvieCkU1SlD51YXIqKi3OEw3BkJ4D535bkq14OE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+segQuIHHMYKbt+33J4BPklxw/Q2+SUIrpWfXM1orneYMvcltZ9oKL79Pp4Ceuqks5lmiIGxVNAZxFXggW0GQOmuNrGru++IQfi54ZZ3IZwEGFuGnL759J8LfWYM9ipnrMl4KEObvIzW3AQKzt4fQLwhMfwin1MiNAyI9QAKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHP6uGYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHP6uGYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96B1F00A3D;
	Thu,  3 Sep 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465670;
	bh=zruMG89aLfsO+oGm9T2lySHRDO+39NRjXL/dUvFJ3eU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BHP6uGYMAKjIY3RWyW0ly0AsQc1Ytqe9XnlqwXaRRyU6bnyM2HGe03bDMtZzoX2Vc
	 usm1OyW5Vt38H8GjNfP0Kav9Yxo2JZBE7wvQrb/WNtAex+QB/+KSDiL1Zw/VDbaR12
	 TNWk4KuNvgVnvEUGhohpIqDoZ2S2GseRtlA/J0VeXy2dxA/Li9F9xRhgPpdg9HB3a8
	 tKxT8HpVvukl4EZ697k1SGmv/tNLSxA3DCTKOYwlodtdENsmW/m81QtG3MQIDYcGs9
	 xcMqHuE5JjUw5GKte+5hLHV2UHc1f4OHrwVLXOTmM0rV2AEJZvla5Z+CghfbLfBVvX
	 AvGj5fiGGoS9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9386B38119DE;
	Thu,  3 Sep 2026 20:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: btintel_pcie: validate packet_len
 before
 skb_put_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561113.3994681.3604409237210142858.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:11 +0000
References: <20260903145102.54675-1-kiran.k@intel.com>
In-Reply-To: <20260903145102.54675-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 20:21:01 +0530 you wrote:
> btintel_pcie_submit_rx_work() reads packet_len from rfh_hdr without
> checking if it exceeds the RX buffer size. An oversized packet_len
> can lead to an out-of-bounds read in skb_put_data().
> 
> Validate packet_len to ensure it is non-zero and does not exceed
> BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr), logging an error when
> invalid.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btintel_pcie: validate packet_len before skb_put_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/de8d29ede6f3
  - [v2,2/2] Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one
    https://git.kernel.org/bluetooth/bluetooth-next/c/a8bfcece8b49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


