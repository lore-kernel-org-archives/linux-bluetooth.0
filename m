Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679443DD520;
	Mon, 27 Jul 2026 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185442; cv=none; b=PI356mU/BkhHFhOGiXPsD4Bde8ppNl0yp1F2sN2DMig07fULcJ7YIb9sEt1eNNh+jg/Gvmun4AxLIniGYJmF6RnLRW05EW9IYU2UNiEXfwargoVHZG0gAL4xNd1xlFuxwyu/1dzFChLbucfHjj7vJWd8OoY8EPEDtrF2jb6BBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185442; c=relaxed/simple;
	bh=tIv5j3HPbxoZ+/YjKPjz6W2Jg+0U/6/qw+of6XfDp20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZTNK7zIdN974XUXjTjS6uwLkv8SL/oS8dO/F54mmEtEzztUPcilIhy5fWk921RvNPtYPBggXwkrQ520pueL8djc67pEs1m8xJhJ/TGe/P2PzjiqtIXXltB2WDKB5lBciCzW1rdBk+0XXpdOuKuLMEjUaVEDH3y8+7b62BU2qjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLeBCmI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLeBCmI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1080F1F000E9;
	Mon, 27 Jul 2026 20:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185441;
	bh=Ut9dSlTXno7XNiT7fFHojfPBGpOv29hxwXVDu0bgVZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jLeBCmI+JnndRlZQUDYlSxB72eRNbOlzrk+JPS+M8l8qjeqQrEfZaiFnVkJhPX1z7
	 geVxw93I/ulOb31brgWYHAJcpr+5nSVoaLysvRQ9ixbVRh6m3xxr37L+lzOCWPWDkf
	 4lx6gvFK8uh2/kyJ9Pl9K0HCxtzkuxgp1bdI/cwS5OHQ+uz2+DT7U4oCzDpW8rhEwi
	 J2i/MSA0grci/d38mpe37Pat//4ikQCbfsGyFpeoRIeSncXWz2RaZu3jWgrd2Xbq0D
	 bLRxwPvlKl/25n12OKn7+sQ4nVnXl9IRSjq1Z8nAc7tlyRbSW4y4lSjs6FQ1dwuw5x
	 RPYwXWPOc2FvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93914380664D;
	Mon, 27 Jul 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: use named initializers for acpi_device_id
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178518540639.1412337.3111585831256595939.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 20:50:06 +0000
References: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
To: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brgl@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jul 2026 16:51:50 +0100 you wrote:
> This series is converting lists that contain the acpi_device_id
> struct, which is defined in the include/linux/device-id/acpi.h
> to makes use of named initializers (which they do not use currently).
> This work is part of the on going effort in the kernel associated
> with device-ids [1]
> 
> The plan is to convert acpi_device_id::driver_data to have an anonymous
> union, similarly to what was introduced for PCI and I2C device ID tables.
> The goal is to increase type-safety (as most of the existing casts are gone),
> to improve readability and to make use intent a bit more clear:
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: use a named initializer for acpi_device_id
    https://git.kernel.org/bluetooth/bluetooth-next/c/cca1639df8fb
  - [2/2] Bluetooth: hci_intel: drop unused assignment of acpi_device_id::driver_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/1bbd8346bc3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


