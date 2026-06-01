Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC7364EA5;
	Mon,  1 Jun 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341004; cv=none; b=uBaKaVSSnV6tYYRpVaNJBoMcjBFHw54I2msy+H/fbMXa2VTV+RFelvFYgaLRJWqICcadCQ+c+TNpnIdLHRLLKSqW+Ni7bvrwrpnHAgw8WYmjwirTHDU0LnZjmQei5jtr3GnR8XTk65zW/dE7hyI6WfV/vVrA1Lt4NuCWjiUVyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341004; c=relaxed/simple;
	bh=4mTbPWtbXMA+Hm6QHY+n699R/X0Ek79GYR7L3HpIlE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZBcv/NJjnguBSeX6yp2G0/DCOQshrbtD5z7IxjlXORWN1/cACT20jJuKlpO0c6k4TJzsIilYXCiA88u/TqdjSxFXelw8Tyr3KnWx2bHZM1fHa9nimDPTOPRLnEvic/DXaAx7+bYXibqZwN1xZC519MHG/19GccUMqK8MAwr2vqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvLCVzus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvLCVzus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AC91F00893;
	Mon,  1 Jun 2026 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341003;
	bh=z26v2DaPN9zHzIgN3kwWr0iyk7uBm630pFoLMAhbVjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kvLCVzusPqjU+ir28Wmog5B12bOlkjOd14pmd4Jlxtny253Pa/fyyUcNPUBS/fDLs
	 pPNdwFFgfbsI/6WiI1XytuibaEnUg7RUq7ulo3Y3KSmgLnMJWbW5KASe1IHE5eaFnj
	 MaqGPWKnIkXmuwk5zP8ziwXptW5EPml1tRD5zs6qwFIgJbwoIPuyvB9blwHzTfJ7c2
	 ZIkFnbBltfLNpyQDLh1sdz/4O83nf/osSZd2ygDYvJO7Vdl8Ug/nNMOYNqpacF0o2H
	 OvLxfNlSLnvuYCTVkxCVrjD9DQfLx3dPqHDoXt0vNUZUe9IPSwIdvAzeadU9DpUED6
	 5eK+Vt43qUFZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16C8738119F4;
	Mon,  1 Jun 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: hci_qca: fix NULL pointer dereferences for
 non-serdev devices
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178034100604.57646.7464742328539604683.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 19:10:06 +0000
References: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
In-Reply-To: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 mengshi.wu@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
 quic_saluvala@quicinc.com, zijun_hu@icloud.com, luiz.von.dentz@intel.com,
 bartosz.golaszewski@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 01 Jun 2026 04:30:54 -0700 you wrote:
> When a QCA controller is attached via a non-serdev path (e.g. hci_uart
> line discipline), hu->serdev is NULL. A couple of code paths dereference
> it unconditionally, leading to NULL pointer dereferences.
> 
> This series fixes two such cases:
> 
>  - qca_setup() dereferences the result of
>    serdev_device_get_drvdata(hu->serdev).
>  - qca_dmp_hdr() dereferences hu->serdev->dev.driver->name.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device
    https://git.kernel.org/bluetooth/bluetooth-next/c/7bfdd3d9129c
  - [2/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device
    https://git.kernel.org/bluetooth/bluetooth-next/c/4fcae45539b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


