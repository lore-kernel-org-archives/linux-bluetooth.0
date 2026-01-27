Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A723ABA7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536818; cv=none; b=Fi/L3XmYJX5gE1/23YDdK6iEXb1rD2qmgGWVF0nEL2bV8A/Q1Wg+si5ayc6St9n360vVtSxclgDaGlsSV+h5PUXPSnOohvQGPQwcMdtWfqsgdRB/c6xHOctaxYX9zAr6PSMVI9+ap6WXjd0YULpeYFBDcn/quQ7g/CmpDMyKOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536818; c=relaxed/simple;
	bh=p8rnwgGg9hi/hF6hEBK4XRwFvIlzb4NmbmA+M7J1wzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUAjq7pH3A8wGiq38aVJ09dD2woIk3YiGqZVT5W2WKvZk3tUyYXRLRJMffaf24azj9Lg3WFGDWM5XPDc71n5ajU4tt7WzBMC94TOeTUg16iIk0TLAbG/RM3+wc6MQzQ0ER/ToePu5NUJXFTGVRG4If6kVouGug1CQXCQp38K2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om7iBLld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om7iBLld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF7C116C6;
	Tue, 27 Jan 2026 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536818;
	bh=p8rnwgGg9hi/hF6hEBK4XRwFvIlzb4NmbmA+M7J1wzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Om7iBLldY1T9S5cMDaPChBAtAowGyEVrL4SGbgpaxis5Ya4fvXjGxL6F0+ZlNZkiQ
	 +uYxf0X2MnDqUMhaCbyWwZeFJf+EobUtWIF/Z9vediFDlIaRfNHUUKv8fQbTCnNnrx
	 0YDlb/xjO4sj730SLm+ceGeziDe7F2kdv8mO+mMSk0ztVspTrnujvS7DNeOyVA31RZ
	 f+F1YbwpVe9GelwbzNuX4JoroxL45pl/eP7W/puuvl0inwiVq4gz3jcLVGlS+TPcjN
	 CimKCW0EqsZ6xNd8xE6kmotgaerzIDRL8gsAEhkKSheAI+FhzGCuKaF92k2w/mpgv1
	 8TpHoEYntnEvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC2C380AA58;
	Tue, 27 Jan 2026 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Add support for Ranging Service (RAS)
 Implement comprehensive decoding support for the Bluetooth Ranging Service
 (RAS) in the ATT monitor, including:
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953681214.1341664.13917228621298588851.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:00:12 +0000
References: <20260123110944.532088-1-prathibha.madugonde@oss.qualcomm.com>
In-Reply-To: <20260123110944.532088-1-prathibha.madugonde@oss.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jan 2026 16:39:44 +0530 you wrote:
> - RAS Features characteristic (0x2c14) with feature bitfield decoding
> - Real-time and On-demand Ranging Data characteristics (0x2c15, 0x2c16)
>   with segmentation header, ranging header, and subevent header parsing
> - RAS Control Point (0x2c17) with command opcodes:
>   * Get Ranging Data
>   * ACK Ranging Data
>   * Retrieve Lost Ranging Data Segments
>   * Abort Operation
>   * Set Filter
> - RAS Ranging Data Ready (0x2c18) and Data Overwritten (0x2c19)
>   notification characteristics
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Add support for Ranging Service (RAS) Implement comprehensive decoding support for the Bluetooth Ranging Service (RAS) in the ATT monitor, including:
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=daaf5177720a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


