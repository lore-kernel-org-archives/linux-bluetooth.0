Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A446AA8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438074; cv=none; b=TnRxyEd2mYKzKEvkm4mv+pnyG53K/g0S3PVlTl0xM/o3EO49gHs4yrYRSlzRya/iwb+HlFwWJhJ2cA7OPr/Dg5v9t1yivVJokvnI24vT4zWllFz4pyBPdaeUfQ530Z2R3/ludiBWxyYUBFfsgiH3+qxgSfrQsKyzj8Pm72K2cTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438074; c=relaxed/simple;
	bh=JpJa/7I93G0FgS9hqQhS7/3Vc6gL+KuE3nTzAV0CE2Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AEzExwzksIMHGvqFhhSTOQYAl+KNpcKC9hpckkAn/9vJw2dmYiCvmvXhZP4c4Gy8J6AkBmr2+pmbINXCU2FUceUjLEzMu3AYw3lJB0GHta6ajdgaSN85CH558DQ/eE1S40tgHqL1uhHgnVDFzLcqp9deX/yPvW+1MwffcOnojKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JVuPtaFt; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JVuPtaFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785438060;
	bh=Uvs6AMfdVkxmQNEc0qB1+mhFf5a/mz055kMWAGwOLjU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JVuPtaFtjqlyeoDZXD90IqRAH5NEljNpeEbVqu8CNOiB9dqzGrNUJaGrCX/6zv2Mz
	 r/qcX96NLTwb2FdJbXGVvUSGg/Ok6hxRdNUAyzJvtJIg16q5sqlhM01cP5hk/xyi5Y
	 WKH9sEQOCQ7ZWPBV7Ge1guEs2xVj+7u0uVFP5Rpc=
Received: from github.com (hubbernetes-node-a984dd9.ac4-iad.github.net [10.55.98.37])
	by smtp.github.com (Postfix) with ESMTPA id 5A114406D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:01:00 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:01:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137629/000000-032ea0@github.com>
Subject: [bluez/bluez] 032ea0: monitor: Decode Intel DDC LE extended features
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

  Branch: refs/heads/1137629
  Home:   https://github.com/bluez/bluez
  Commit: 032ea05b41638c34a105bc2665fb495ec25faa82
      https://github.com/bluez/bluez/commit/032ea05b41638c34a105bc2665fb495ec25faa82
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor: Decode Intel DDC LE extended features

The Intel DDC Config Write command (0x3f|0x008b) can carry identifier
0x031f which holds the 248 octet LE extended features array, using the
same layout as LE Read All Local Features: page 0 is 8 octets followed
by 10 pages of 24 octets each.

Decode it with the existing LE feature tables instead of dumping raw
hex, and make the parameter loop stop on truncated/padded entries.

Example, setting only the SCI bits on page 1 (bits 8 and 9):

  hcitool cmd 0x3F 0x008B 0xFA 0x1F 0x03 \
      0xFF 0xF9 0x01 0x3F 0xBE 0x00 0x00 0x80 \
      0x00 0x03 0x00 0x00 ... (padding up to 248 octets)

  < HCI Command: Intel DDC Config Write (0x3f|0x008b) plen 251
          Identifier: 0x031f
          Features[0/0][8]:
          ff f9 01 3f be 00 00 80                          ...?....
            LE Encryption
            Connection Parameter Request Procedure
            ...
            LL Extended Feature Set
          Features[1/0][8]:
          00 03 00 00 00 00 00 00                          ........
            Shorter Connection Intervals
            Shorter Connection Intervals (Host Support)
          Features[1/1][8]:
          00 00 00 00 00 00 00 00                          ........
          ...



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
