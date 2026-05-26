Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96841C2E2;
	Tue, 26 May 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817803; cv=none; b=NFzZ8RlsbDbaHpKZpiuLlqDTq8BaVFHiSHaMDWB9PYxqGVJmkAO4z19iejfUlBkEFt5tnR7QgHGu2zvq9Jfrvg/rnfGCkVv2fpE+x+N1KIY/Jtvwf4OEXEZek3ncFWxSoFmNTm9L9X03Qnb5tyTLJswBDzTo+U9BR3CsBU2ywxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817803; c=relaxed/simple;
	bh=XGFSEQhDwXrxZgqdWZ8ceKERX/OG3XD9thhlCQCZRlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRFhly86nMcm8VZo9TPK0QYMRhMCBu3CLWmODXrKI53SGMUcWE+TP5rQXt0nvMxtJx/kM94x718dFRWp4ruJMUxSq9GDOg3yV01tptbhhc/dBUsIK6pgM03iCJUcptHClYX0Jva6Vq0kCDyVG+uFi2HwaF8r99STpwZ3/D2zvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OReiT/is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OReiT/is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB07F1F00A3A;
	Tue, 26 May 2026 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817801;
	bh=ofiSIFlawvbPZkKbhhlXK/wxasri0S2zyxT0M0BCN7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OReiT/is5MEv2jieGCnlifxCebSBCT6sPzrIKE7QR55HOw1f5Pi5pW2HQ8Jy0qC+y
	 8echsBdA0/X6D4G4tR21enRvXZ5hoDkglZxapcp0ZmoeiLJUx4YCm3QbN+3CQDmCii
	 Db9slBkdVZSKcNljcvvgYm0g+1GHP4nF405cvoUtri3VQ232aNDAnKSophtqE1f6na
	 ifu2yk4Y5J9BbgcvdNnPDETUy+IkvcDu5agKz1TfFknWNfLb4wZSNO+4pDoTMZv1Vw
	 G9+Hr0Jjz6w+QnKMo+3Lb6KpqevFCKe4lsJEYGKYJEHd2AVS9ZUueZqPBtBp3M8MgO
	 0tvukts72pa0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9F380CEE6;
	Tue, 26 May 2026 17:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch
 and
 NVM loading
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981780738.3917724.11762317643649803180.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:07 +0000
References: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 May 2026 14:51:56 +0800 you wrote:
> When bt_en is pulled high by hardware, the host does not re-download
> the firmware after SSR. The controller loads the rampatch and NVM
> internally.
> 
> On HMT chip, the rampatch is ~264 KB and the NVM is ~9.4 KB. The
> loading process takes approximately 70 ms. The previous 50 ms delay is
> too short, causing the controller to not respond to the reset command
> sent by the host, which leads to BT initialization failure:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
    https://git.kernel.org/bluetooth/bluetooth-next/c/b74b39bc6d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


