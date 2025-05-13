Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5802BE0F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159185; cv=none; b=PFsT2yMQmSRk7JcaIaMy5efqewcdHhFKd0OqnwJhlESjQZMx6oBX4RFgb5pv86Mxu2S03eIkTxY7Hqj/Mkf7WT+bgD8U+i56Gd18zRo8WHJlwkmevfEKVP7uCcmw48AP+SUTruVW/dr/pg8JhO0eUDimTd2s9DpwQO1zhagwtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159185; c=relaxed/simple;
	bh=80f3qt+VLmJxIuEIfEG/Zq3gKwiNNhtRtrAuQe7yXT0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TC/zMk4GRA1Gw/huYTkRtN0+6uQG9j9BDeWxJudfjllRQcUP3860EGLmjk0D2qBPqYK5Q9/tcd6uvcu9QR5eSQSZb0mfHEIOsuShUA2Xggl7PbHmxn9EgTcR4zA7uE0ejFHq7DPxIc2IRLcbZfy21yXmFeWsu4kPTljH1LpXxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WPa/qZO9; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WPa/qZO9"
Received: from github.com (hubbernetes-node-7cbddb1.ac4-iad.github.net [10.52.160.21])
	by smtp.github.com (Postfix) with ESMTPA id 4C4E221414
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747159183;
	bh=xzbiHRrjejhjUlXIkZ+RyyZTg86QztfjvlX9cGazW90=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WPa/qZO9S7phz1ak2sTKPwwf6YGFgugvaLGmyRs3/5Uo6wLC1mSaaIdtP2bgdcgui
	 7mh7g+FMJs1f2OgnZza7hTfJ1OnyR0hJgKDWZogE+hl2af71S2T5jJDDXJNa21TmS6
	 TjcZeLx8OXP7nFS0n0m9ZSKmvB53MBdA3RN2eLiQ=
Date: Tue, 13 May 2025 10:59:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962526/000000-b4bd32@github.com>
Subject: [bluez/bluez] 70d281: monitor: Add definitions for FSU command and
 event
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

  Branch: refs/heads/962526
  Home:   https://github.com/bluez/bluez
  Commit: 70d281fb1350cf7c6d903a6bc6e5632652e78955
      https://github.com/bluez/bluez/commit/70d281fb1350cf7c6d903a6bc6e5632652e78955
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Add definitions for FSU command and event

This adds FSU command and event as defined in the Core 6.0
specification.


  Commit: b4bd3281429d9fcd14939c24a0aca5fd6721428f
      https://github.com/bluez/bluez/commit/b4bd3281429d9fcd14939c24a0aca5fd6721428f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for FSU command and event

This adds decoding for FSU command and event as defined in the Bluetooth
Core 6.0 specification:

$ tools/hcitool cmd 0x08 0x009d 0xff 0xff 0x00 0x00 0x00 0x00 0x01 0x03
< HCI Command: LE Frame Space Update (0x08|0x009d) plen 8
        Handle: 65535 Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Frame Space min: 0 us (0x0000)
        Frame Space max: 0 us (0x0000)
        PHYs: LE 1M (0x01)
        types: 0x03
          T_IFS_ACL_CP
          T_IFS_ACL_PC


Compare: https://github.com/bluez/bluez/compare/70d281fb1350%5E...b4bd3281429d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
