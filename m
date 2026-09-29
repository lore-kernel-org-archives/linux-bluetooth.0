Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2803AF664
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715015; cv=none; b=RpBIjkI3/o6Xt9SCg+bAUIrkQOeUda9q9HTmFKhfl8symwpUUL3hyrjkf0fChsXHLw6Y7F4bpkgWb1tYeiJeK8Y+4/MBZInle25QUGIRMMg4vyRY5xTVEL6AidzLeKUDulRC/oo4AuSntAc0bhmJ1Klah3l4OnMon7O8aZZef9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715015; c=relaxed/simple;
	bh=eTF+3JcRBNXIPMfDEG20qXXVBFKCZjyd3KMlajG40Ko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QlVedMzW7EiUg4wHSssGgWlAP9pfLamCOq+bkeHEfOWH8jXaF65Z3OfwIDDz4fQYXtTvnCR2AgVuAOGHexa5yicFQSNBQ6oFByGIyM2NwBjRV16xKtJ65dGNg78dxcvK0AspVFkNbQL/KvJeAmAuHfjp7LmJRsN+p8pRTyG7QCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2pbmCzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2pbmCzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC8E1F000FF;
	Tue, 29 Sep 2026 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715013;
	bh=ptGMteto6VZNwAt4hYYUVlWCU9HqUMX4Dvxf7hLUyKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a2pbmCzZtMdL7UNZ50OB06efhx/4oohd8MZCUvlHK/uYYbwjZ7D8lQOM6T+x1OXe3
	 HsDqsz7Ou3k89JSnx4dhxxNcLs3mU7PuDx4yD1BJuxlIXjynKg6Kte3xgcNPI/GcTS
	 HjAt/Tr6f6ZVnq65jkXyYgf46XC8DNJbMndBhS9FNqd4+TkUlEhiEJ7allgCliMOfN
	 izDmupXbHHm/FQCPoieglIhxI+p3O/OGEh0On+wTkSHzBDCqJPU3FYoQ1V8ZcrKLSa
	 A3pkziCogDo1lKFu2NB0Xyf3x1tHx1EQ/heuRt0vQU6e1593y1e5Hr8Q0hozj/zzC1
	 +v/SYOXWBsH3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B443E39D237E;
	Tue, 29 Sep 2026 20:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 00/23] Add HoG functional tests and shared/hog
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179071501227.1114983.10858413604380295983.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 20:50:12 +0000
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Sep 2026 16:00:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds functional tests for HID over GATT (HoG), with bluetoothctl
> registering a HID Service acting as a keyboard, with and without
> Shorter Connection Interval (SCI) support, using the new
> client/scripts/hog-device*.bt scripts, and the HID host:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,01/23] shared/gatt-client: Fix calling destroy after unregistering notify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=65f8a8b60a70
  - [BlueZ,v6,02/23] client/gatt: Fix setting descriptor value from scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f14171908901
  - [BlueZ,v6,03/23] client/mgmt: Print Connection Subrate event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e96e1d7e6db8
  - [BlueZ,v6,04/23] emulator: Default to the latest BR/EDR+LE version
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b304a7dd2ac
  - [BlueZ,v6,05/23] client/scripts: Add HoG device scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2604ba5035cd
  - [BlueZ,v6,06/23] doc: Add functional-hog documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b68fecf0599
  - [BlueZ,v6,07/23] test: functional: add HoG tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7a2a63a02d6
  - [BlueZ,v6,08/23] test: functional: limit the workers by the memory available
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=044404ccbf91
  - [BlueZ,v6,09/23] client/agent: Fix crash on Cancel with no pending request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67a794ff4048
  - [BlueZ,v6,10/23] shared/uhid: Fix size of Get Report reply with a Report ID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dc2eb1394f4f
  - [BlueZ,v6,11/23] shared/uhid: Keep reading when an event is not available
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4efaf7ed188b
  - [BlueZ,v6,12/23] shared/tester: Allow expecting a PDU with no response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7104e632672b
  - [BlueZ,v6,13/23] shared/gatt-client: Fix calling idle callbacks again while notifying
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=326a0000ac02
  - [BlueZ,v6,14/23] shared/gatt-client: Add bt_gatt_client_is_idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06053830b71c
  - [BlueZ,v6,15/23] shared/hog: Add initial implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2f56f58b8b7
  - [BlueZ,v6,16/23] unit/test-hog: Use shared/hog
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7af5798ddb42
  - [BlueZ,v6,17/23] test: functional: change the HoG SCI mode with the HID Control Point
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2f53b034348
  - [BlueZ,v6,18/23] input/hog: Use shared/hog
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=96f1201f5ac2
  - [BlueZ,v6,19/23] doc: Add CONFIG_HIDRAW to the tester kernel config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb69738a1206
  - [BlueZ,v6,20/23] unit/test-uhid: Add Get Report tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ed0b991aa5b2
  - [BlueZ,v6,21/23] device: Use bt_att instead of GAttrib
    (no matching commit)
  - [BlueZ,v6,22/23] attrib: Remove GAttrib and gatttool
    (no matching commit)
  - [BlueZ,v6,23/23] attrib: Remove directory
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dbc6102ccdee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


