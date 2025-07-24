Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8D27F005
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358485; cv=none; b=WUm7sKJl6MqVeBnC+CpTiYH/D3zjD1RW0dQ/THKel8rvnu6ien0K7nJs4owtVbUWbz3yqUtfZtN95tVk9iK1DxjhVuwCRA7Nd41w/ivnVgWxoAGeAkgNPBaAvv6CPbOMnaG8l9x1diJ3+j5x3xadoh61I1YFqhKc+brZB1pFjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358485; c=relaxed/simple;
	bh=cnHB5vIed0+t23sKCNEYuQJfsqGMcblxwVpk5ftH1T4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l5JV4fZgvytdnXlimr62qsiAbe68KezwxBEEu8ASEObaonBQF8Y/dDH3lmtZTFCySEtNM2AZ1aef5B/04NE73DQrUQs22B2Z91SmJzIZSd8Mk3KR2e8+fLGafPxAwxEIFyp1CdBE4vLaTjlDpbPQhIZ5JKC0ukFm13gBa794Owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aa5NVRZc; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aa5NVRZc"
Received: from github.com (hubbernetes-node-3d266b1.ash1-iad.github.net [10.56.181.34])
	by smtp.github.com (Postfix) with ESMTPA id 6A4CC600AE9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753358483;
	bh=YYMpdiai83h0wRJBM1pWPcAmSWd/vmi596/ZsUUDLvI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aa5NVRZcoDYiZVeYV83Yc1inm2n3G4tbMCTSYAhEM1OgvTFNc5VX65LyAXzhnJN+Q
	 x9niU8BeTS0UTj0Xj8g5JZEbVH/MYCQQvxnIJEHKnkHrTJEFmdHlOtCKXlbZxhbQ3l
	 2R43pDHTUokgfX2hqcNPyeyZyDzB/73RRVL/0DP0=
Date: Thu, 24 Jul 2025 05:01:23 -0700
From: kirankrishnappa-intel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985528/000000-3cc1f9@github.com>
Subject: [bluez/bluez] 3cc1f9: monitor/intel: Add decoding of cnvi core
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

  Branch: refs/heads/985528
  Home:   https://github.com/bluez/bluez
  Commit: 3cc1f92f043872e5b1201ecbaaa0c5bf0dbfdbcc
      https://github.com/bluez/bluez/commit/3cc1f92f043872e5b1201ecbaaa0c5bf0dbfdbcc
  Author: Kiran K <kiran.k@intel.com>
  Date:   2025-07-24 (Thu, 24 Jul 2025)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor/intel: Add decoding of cnvi core

Add decoding of cnvi core from Intel read version event.

sudo hcitool cmd 3f 05 ff

HCI traces:
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 122
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        CNVi TOP(16): 0x01080901
        CNVr TOP(17): 0x00002a10
        CNVi BT(18): cnvi (BlazarIW) cnvibt: (0x00223700)
        CNVr BT(19): 0x00313000
        CNVr OTP(21): 0x0344
	.....
	.....



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
