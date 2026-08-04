Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4B476693
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869487; cv=none; b=BXHVqcoAjm8q01qwqDIDL9/CEJEhsrYsorZerNq27Bf3Zy7b6b7vQ3yrq67ZOr8FFw2YSvqVBLw2kLSANWcPyd8Wt8mxmva5tEgxumG59YE6UpGhJ2YmBke2R0d4XBEiwt6JIdKRrLTvh9HarJ4VLUs26ljxikVd4s5xhJpkjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869487; c=relaxed/simple;
	bh=PDBPXEOUxinMQ6xACcIO2cRSMSp4BMqBElCszvKN5vw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tQftvV5F8eYnpxdxVPzbFMDe2/b4IxcicRlpzK+pfKVJecIe6XccWoqglh+2TxWKKUx4Uswyagl2QCAndwwOEdOQKChRTQckahDZO2ar79ZeLI67pw23tVwYhHI43qGkw1aHuSfR8CH5WUotknnM4UDzO1/x3H3/B6DpiyX91Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AcVTskz2; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AcVTskz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785869470;
	bh=pWE7WpCF2rNIjcVnzWMLVbO8Heyg5cLPiGuK7OWn/Jw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AcVTskz2kH2XxblUfNnv336uwOQ4GZuS1LhflEYuO4chFvoO6PauQmBWb/kKN7Te5
	 Seh53Z9wgWKM0fWtzLPcIWmnY4tX2UFw1QTfn6YqYDlVlc7KncW+eAEJNsPc+gLzT/
	 3kO75cvF8X9f2TF1MLWsJoBKzUWxM3CF8Bt+t68w=
Received: from github.com (hubbernetes-node-d3cca06.va3-iad.github.net [10.48.75.103])
	by smtp.github.com (Postfix) with ESMTPA id 9BDC0180637
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:51:10 -0700 (PDT)
Date: Tue, 04 Aug 2026 11:51:10 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e45128-690c16@github.com>
Subject: [bluez/bluez] e0d2a5: monitor: Decode Intel DDC LE extended features
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
  Commit: e0d2a5bfe1625ab18d88b066953948c0df07b7ae
      https://github.com/bluez/bluez/commit/e0d2a5bfe1625ab18d88b066953948c0df07b7ae
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


  Commit: 690c16df606733626a0a7d6bc2b83a3244d4ced1
      https://github.com/bluez/bluez/commit/690c16df606733626a0a7d6bc2b83a3244d4ced1
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit/test-rap: Add PTS tests for CS

RAS/SR/SGGIT/CHA/BV-05-C - Verifies the Ranging Data Ready characteristic
exists in the GATT database with exactly the Indicate property
RAS/SR/SGGIT/CHA/BV-06-C - Same characteristic-existence/property check,
for an IUT configured to support both Indicate and Notify
RAS/SR/SGGIT/CHA/BV-07-C - Same check, for an IUT supporting Indicate
and Read on Ranging Data Ready
RAS/SR/SGGIT/CHA/BV-08-C - Same check, for an IUT supporting all three
Indicate, Notify, and Read
RAS/SR/SGGIT/CHA/BV-09-C - Verifies the Ranging Data Overwritten char
exists with exactly the Indicate
RAS/SR/SGGIT/CHA/BV-10-C - Same check, for Indicate and Notify support
RAS/SR/SGGIT/CHA/BV-11-C - Same check, for Indicate and Read support
RAS/SR/SGGIT/CHA/BV-12-C - Same check, for Indicate, Notify and Read
support

RAP/REQ/CGGIT/SER/BV-01-C - Verifies the IUT correctly discovers Ranging
service
RAP/REQ/CGGIT/CHA/BV-01-C - Verifies the IUT discovers RAS Features
characteristic and currently identifies Read property
RAP/REQ/CGGIT/CHA/BV-02-C - Verifies the IUT discovers the Real-time
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-03-C - Verifies the IUT discovers the On-Demand
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-04-C - Verifies the IUT discovers the RAS Control
point characteristic with Write Without Response and Indicate properties
RAP/REQ/CGGIT/CHA/BV-05-C - Verifies the IUT discovers the Ranging Data
Ready characteristic with Notify, Indicate, and Read properties
RAP/REQ/CGGIT/CHA/BV-06-C - Verifies the IUT discovers the Ranging Data
Overwritten characteristic with Notify, Indicate, and Read properties


Compare: https://github.com/bluez/bluez/compare/e45128f029ce...690c16df6067

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
