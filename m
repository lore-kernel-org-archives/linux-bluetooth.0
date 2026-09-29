Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD83B05B8
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715017; cv=none; b=sK4bXyq0qvOvgGvvFbPJvwfW+IWnTCuphypbzfIP8B2VlkdsWFFBURXT57jn15zCk4NMjbo970vEsxFtzL45TrhnqOXhZ7YsG4iKY8fb5ZSLD9IACGMlVyVLDXozbEiwteuX4/N0d9r+aebSk5SgPHZ4KAdvCqPyjUvVsix12BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715017; c=relaxed/simple;
	bh=L+FUefABbd2ZXTB4vxqZw7p2oNR7wB800eNiGwlGzFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dxmvw2tCsGIB7jlDvKWjPqM5zpJPQxmtzsvTUlwVJu1ifo+Eo/uU+zTCNeh6mDxnPpI9edmL4mTBMupNLdp73/lDSeP3G6+wPrnUUW1H/rd+sjmZbUEiilbmkshOl2PU0gxzu1Y07fXjCxy9Xr9K92azZrHhqXYI0TI9ztLayZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNHrYAcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNHrYAcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE01F00893;
	Tue, 29 Sep 2026 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715015;
	bh=Y4TRTf3PMyAqvF71/SbKvPba5kDUmB0Q7js3jXyQS3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TNHrYAcXJ6VvQyBe2mheSt8dEiRQpbum0O2fU2vPAFVXE3enbuW/9ODIZl+E7jUZw
	 e4g38akW4GU5esfVAgUsDpamNY9CyiQ77mAovhqkH3+097Oe5OowSq8xgmlvDaD/ww
	 gMn+5Eu3TtmY9lgTjIHNJjwXmw19IYUDSXNZ1IUMbx9x+75P9cxzB5IO5il6OVFnko
	 TioQuH9aW0EYenvDHcsyebLSMJp4y+IXrNnkJenfeFAm4JTQ0pLNyP6i4MYL65ip++
	 ImrRzmggvRaB5E/TrFBPS+F16N3BKk6WXqFdwxnfREfmKaAmm9eYDBza4CuI3//l5V
	 ZabaJodmNepqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2A239D237E;
	Tue, 29 Sep 2026 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/9] Add HID over GATT functional tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179071501377.1114983.2390179061802293430.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 20:50:13 +0000
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Sep 2026 11:46:22 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds functional tests for HID over GATT (HoG), with bluetoothctl
> registering a HID Service acting as a keyboard, with and without
> Shorter Connection Interval (SCI) support, using the new
> client/scripts/hog-device*.bt scripts, and the HID host:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/9] shared/gatt-client: Fix calling destroy after unregistering notify
    (no matching commit)
  - [BlueZ,v3,2/9] attrib: Fix unregistering notifications registered with bt_gatt_client
    (no matching commit)
  - [BlueZ,v3,3/9] client/gatt: Fix setting descriptor value from scripts
    (no matching commit)
  - [BlueZ,v3,4/9] client/mgmt: Print Connection Subrate event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e96e1d7e6db8
  - [BlueZ,v3,5/9] emulator: Default to the latest BR/EDR+LE version
    (no matching commit)
  - [BlueZ,v3,6/9] client/scripts: Add HoG device scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2604ba5035cd
  - [BlueZ,v3,7/9] doc: Add functional-hog documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b68fecf0599
  - [BlueZ,v3,8/9] test: functional: add HoG tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7a2a63a02d6
  - [BlueZ,v3,9/9] test: functional: limit the workers by the memory available
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


