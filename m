Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93C3947B5;
	Thu, 10 Sep 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073470; cv=none; b=E9PKY5G1HY32V8WAqmKUYPT9mxtmaNRnaOFc1p655ZGdtNzMRiUoeJc8bekEvt/BGEUQBxZP4XOlQ3zKKdYYRbk5qT8zRyU2YtyxGZykO/4dZmAV7ksIQPDadC1qa2z5q8WX/cmGLQ/mPmtIvedCZkHjabbvW8PzDXoYGWbUJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073470; c=relaxed/simple;
	bh=GOV8pi3ng1uTcCCKLvtrz44ygl1qWYv6aUlLbwfZM14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teSaSdUjQL9Wz4LLoeb/zqq6uwxx/q/006EAIxqUn94sg8NAoM8PTrnfwuI3eSrcwsi9zxMDzAZYgL4EGxcHUVWPdn05UxriYt3x++Y6t57BIB8TQgJtTbBJvgokjgf6vE8u8hrQ5cIeIkV5xgATRS0aRvEq5nykL4iaEdmO1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRfBSYSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRfBSYSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8800F1F00893;
	Thu, 10 Sep 2026 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073469;
	bh=LIggGXtr+dSA/WuJLno7RJor+Nn51IigS4DV2OURrZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QRfBSYSoNCkJ+KjQGn7IomlbueGTYhTaNolvIXdoyUoHY5IQcDtCza+QtoEBBXlpW
	 Zxy+FxRmDhEMTXNAa0sHg1Yi31XJVQKtd1P+FMoZlsw4FRu3dJn1W1timzaKbcLOsF
	 pK7kE0TyGwzWrHbZ2sgvlCWadXhVERsSsrcptP1kQXXDe0HsqfW2e/caq7PFctN6o/
	 h5SzCg0JCoxfITQD08/WME5gqOStslFoteapvjtxP9SgLVHO2lYMEWOtv/jWv/xV4E
	 CIOb4nZBCn3gLuSBzixF+u+fm9BgcJok20zup6kCZQ5EDHopIlgZsZn3SoUkQTiXeQ
	 fEXsD7JgoB11w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B2380DBDC;
	Thu, 10 Sep 2026 20:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: Do not write to the serial port after
 it
 is closed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178907340663.2075844.14300677494257499736.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 20:50:06 +0000
References: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 iabdelka@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 14:54:25 +0200 you wrote:
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> 
> hci_uart_close() closes the serdev port if HCI_QUIRK_NON_PERSISTENT_SETUP
> is set (for example, for the WCN399x family). A failed hci_dev_open_sync()
> following a successful qca_setup() calls hdev->close() but not
> hdev->shutdown(), so the port is closed while power->vregs_on is left true.
> qca_serdev_remove() then passes its power->vregs_on test and calls
> qca_power_off(), which writes to the closed port unconditionally.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: Do not write to the serial port after it is closed
    https://git.kernel.org/bluetooth/bluetooth-next/c/6691666bb4b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


