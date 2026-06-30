Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BE2135C5;
	Tue, 30 Jun 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851571; cv=none; b=cHRGKYO9Pb+MLhoHfqCBRyf3+x0wYKThEMlfxuBeFXluarpExWmmonKUUrjc/FBmQdQ3E6sso0C3iFPTQzETOq7HDM4vDEDrjbV62kJL6BAA3nX76C9jWrHVV0ByFAZPyfJY95CuMt60uq9xBWz3HnUWvYUrb0M9qAJ3S1AK0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851571; c=relaxed/simple;
	bh=Yieu/SMxq5J0mC8kb9rgbzQUvx7C8Pf5wPUcwTx11dY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Il93frFlkU3bh6k6JcVpXxuKvGDiiifSREmhT+d7v1ibHCVhToEHqoCpVWdj/ucgYO+v64AUNM++pdrKnsCAn/vDwq+wp19jRM4aqNffZwgYZPBYYgXOJ/J3I7aGLJp+iEYtC5Efb0q074lqijEucQYD5sOFy5UkJDRNoI4/eQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UODlY8XX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UODlY8XX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED181F000E9;
	Tue, 30 Jun 2026 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851569;
	bh=1A1Noy8LRGtvZrlICTzO9rRKUHCfaLihrFNikt0V8C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UODlY8XX/WY4jhttC8cENg6ahMfkdnjFLT2WSqRYQS/f+a09Pv+8CGxtbDVlVGfwJ
	 NCo6SBrqQ1r+eRsSt+6Wg4umWbzkgTr/L9ihH1UFdQBdMeDFBeEv5ByH80Sw71E69T
	 p3CWfdYPZMCZuLOqjAxTQ+l22ITvliKoBtDJtHxAne+bbAVo3USUXMx1DFb3Eq3VHU
	 r3W0JdcxeMPiDcFS5+UNuiIhmp8RBWARiy80nIF75/A/KOPXN5zmPRgA14qtxpxGfE
	 AqYBDU00u8p//61y+1EJbOUTqBQVVd9k0yuayrKjF+POC3H95LqR5KeeJdxfVU0l2L
	 AWifVimadab4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD8393A951;
	Tue, 30 Jun 2026 20:32:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/12] Bluetooth: btusb/btqca/hci_sync: Clean up btusb
 and fix several bugs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285155338.267316.7362111098834622157.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:33 +0000
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, quic_rjliao@quicinc.com,
 brgl@kernel.org, ytkim@qca.qualcomm.com, quic_bgodavar@quicinc.com,
 mka@chromium.org, quic_tjiang@quicinc.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.von.dentz@intel.com, linux-arm-msm@vger.kernel.org,
 bartosz.golaszewski@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jun 2026 22:19:45 -0700 you wrote:
> This series cleans up btusb in preparation for adding a new chip,
> QCC2072, and fixes several pre-existing bugs found along the way.
> 
> Bug fixes:
> - qca_set_bdaddr() waited for HCI_EV_VENDOR, but the controller replies
>   with a Command Complete event.
> - btusb_set_bdaddr_wcn6855() sent the BD_ADDR without byte-swapping it.
> - btusb QCA populated devcoredump fields on devices where devcoredump is
>   not enabled.
> - BTUSB_IGNORE is a bitmask and must be tested with '&', not '=='.
> 
> [...]

Here is the summary with links:
  - [v2,01/12] Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
    https://git.kernel.org/bluetooth/bluetooth-next/c/1718f3a121dd
  - [v2,02/12] Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb9fed45d399
  - [v2,03/12] Bluetooth: btusb: Record matched usb_device_id into btusb_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/97138867591e
  - [v2,04/12] Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/0a7575521e2e
  - [v2,05/12] Bluetooth: btusb: QCA: move qca_dump out of struct btusb_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/bafbbfe43876
  - [v2,06/12] Bluetooth: hci_sync: Introduce __hci_reset_sync() for device drivers
    https://git.kernel.org/bluetooth/bluetooth-next/c/dc4d5e617358
  - [v2,07/12] Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ccd5c9a56dd
  - [v2,08/12] Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/738df2031c56
  - [v2,09/12] Bluetooth: hci_sync: Simplify hci_reset_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a16a8312f80f
  - [v2,10/12] Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()
    (no matching commit)
  - [v2,11/12] Bluetooth: btusb: Reduce a redundant assignment in btusb_probe()
    https://git.kernel.org/bluetooth/bluetooth-next/c/37ecdbcfd7cb
  - [v2,12/12] Bluetooth: btusb: Use & instead of == to test bitflag BTUSB_IGNORE
    https://git.kernel.org/bluetooth/bluetooth-next/c/5d490bc8bda1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


