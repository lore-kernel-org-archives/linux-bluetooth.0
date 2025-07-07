Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957B288506
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899692; cv=none; b=Z//gUggE5IMHLMVezWu2Mi4ijukSdfOd/zzyZJFyVf6NGznMUO3tacpCUdTrVHoEtjW6ogEmQMr7CG91gbBgLg9p+Km725s2RZ7zhXMt3kp3C7uMV37jPZ6TyUWH95Hb8c+88vIvaux7WqfxUDRrjL3esOixZf4lAou/Xuqm+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899692; c=relaxed/simple;
	bh=AHw4F8jwgFPmRWRgTiL/+thFVimPm9XIno5ixXiHp/Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dpXN+m60KJ9oyjPPw/c3YhSAp4OyoqS5d44nXa7uaEHpbAOewyHCHrvVsLapq7yJYBi+F13rkDxurDhZOy3+PPbgP7EO7URPuvZEOzcYi/sd8QBGLqCAXiDUUSCT7oLCJ6zYnz/ZZ11OLnXr/Im0SyPxiEu/8XGor5n82dlTnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l+XsngQg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l+XsngQg"
Received: from github.com (hubbernetes-node-a4b776d.va3-iad.github.net [10.48.124.78])
	by smtp.github.com (Postfix) with ESMTPA id 267D18C09F9
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751899690;
	bh=/cc1tS1DxlnJjjbFzskh5Gq309PI3y2JJKidOzGqkjI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l+XsngQgxQf4qgbKsIoI2SwXL4YXAinHEtgQwkPGVmN86hChIOXTnashPnmqIfBt9
	 V5WxupiTsVhbcvn2JbWQF7G7nht1/EefVcU7/8b4GFQdL7rlrGCrd5W5Pgdofl8grl
	 6aMYGdVc21IIQV0Ye7xxS9Rx+QbaXmX+ONWdtcyE=
Date: Mon, 07 Jul 2025 07:48:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/655421-168377@github.com>
Subject: [bluez/bluez] 168377: shared/bap: Add stream state check in
 stream_disable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 168377c0c8e8d36ba291e3cef5fe5185d7ef0be2
      https://github.com/bluez/bluez/commit/168377c0c8e8d36ba291e3cef5fe5185d7ef0be2
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add stream state check in stream_disable

Add BT_BAP_STREAM_STATE_CONFIG state check so that stream_disable() is
a no-op when the stream is in CONFIG state. This prevents unexpected state
transitions or redundant operations during cleanup.

Error trace:
bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream 0x1f9fc20 io disconnected
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: releasing -> config
bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20 state 1
bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed() stream 0x1f9fc20: releasing(6) -> config(1)
...
bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: config -> qos



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
