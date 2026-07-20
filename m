Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7042900B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576439; cv=none; b=fv7/n3s4sNbs4+g2XwJMN1vxpTDwtHKv8Qzh+GDWnbEUCSh/BM30vI0aXxAmpUvPnqGy7SMJMU0Onsx0g3yTPL7b1RVgZPFa8XUpci3yAVHhQqE0/QLy+5sH8CfehgWhxawoYp6EYsitbNsiSVs2cM6KQDfFA24j5sCYy/v+5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576439; c=relaxed/simple;
	bh=CqRSb6jfUTxjno/5OkUaGCD1FUY+lDWvWMMQRK+a6dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=djuVGx64KJdfBVij4LuGVZEzRUCbNM7URyMzonzVPhUdcus3L14PBLXG9mbWqkebcpTqVnfeVVq79rDKxA1PEhUAEeDo7WSPep0DRhajl+JT+Xrs8OCZ8zjkfgQvA1DcWf69cwC7PtA625dD+OzD42EsVBTMe9uxPzMwGO2rdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbwOM4Jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbwOM4Jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF351F000E9;
	Mon, 20 Jul 2026 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576438;
	bh=Khacs8IKVmEUpIdyOju+vunqVQePKuGs32llirCHE4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kbwOM4Jb4DkeTH3WDkwnPDPw+k8f+5cp1z+d8p+MZTC+rN6K42Uvy0nxerywIFone
	 7nt0t4RypvazayXKRWw93JrIeLG3D3E0wDnP9pR6BCNcIW1jjnofSOWmksPc1tnBJS
	 G4eDqfy9NKoWdTVAOUdjrdqOD+ca5iRjFf/nfe7N9AHUBjq8BA6x7KZlvZYMNyD8BE
	 djrjPAMYSULUSGCxzsiUvcxkk74c2DqGU9GnBNIk3N4OCDinN3D3sZmvSMQUZbneSG
	 DQFYcrKONKYIbYPXuWm0ouJVvtV0Cz48wqV6Tok3a3QNtQc6KsjBSjfhiVA2jVuKOJ
	 7isrmMHOxlvLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AAE39244CA;
	Mon, 20 Jul 2026 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] adapter: restrict delta=0 RSSI to proximity filters
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457640838.4136385.15524893559590491183.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 19:40:08 +0000
References: <20260715091936.4137598-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260715091936.4137598-1-xiuzhuo.shang@oss.qualcomm.com>
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
 wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
 mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 17:19:36 +0800 you wrote:
> When a discovery filter is active (filtered_discovery=true), BlueZ
> unconditionally calls device_set_rssi_with_delta(..., delta=0),
> causing every BLE advertisement to emit a PropertiesChanged(RSSI)
> signal regardless of whether the RSSI value changed.
> 
> delta=0 is only needed when a client has expressed explicit proximity
> interest by setting an RSSI or pathloss threshold in its discovery
> filter. Filters that specify only transport type or UUIDs do not
> require per-packet RSSI precision; for those, the standard
> RSSI_THRESHOLD=8 rate-limiting is both correct and desirable.
> 
> [...]

Here is the summary with links:
  - adapter: restrict delta=0 RSSI to proximity filters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e004414a1751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


