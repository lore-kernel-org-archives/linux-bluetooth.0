Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92B8F5B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497051; cv=none; b=D12hB+OzgyqZfWCRY8+s1Y0HG87HZdL8yn6hdWyAmeWGVkueRdI6LALuQ8OLC7WHtaVV1wSxyldmW4esyYCYYeseGGaPdh8/rIn1OseCVTWzURBz+VY9sxN7uVfumQt3y08pyE8h1cJMCldCdgvb91n6/sdnP3vt8qzOH2E44HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497051; c=relaxed/simple;
	bh=M5x4En6CkNFcd3QyjmdzgyndHLJlxO91+2rM6qkhvf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=X/oMBtNZbcfW4zjjHHsESxyks2iQESeir60RP8Ay3IFWIiqvh35u4xvLHxbMQpcoDQmDuE9MeQY2EFN8sc/CQRZv1C7Kn242s62CAaGq96tqyM/61+Dw6LKxpeJ/P6vFhM3bfhMsjzsDQ7IQr7iSURnRR0h1NR2826+hld2alXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SMTDFRKk; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SMTDFRKk"
Received: from github.com (hubbernetes-node-ebf7bfc.ac4-iad.github.net [10.52.221.79])
	by smtp.github.com (Postfix) with ESMTPA id 8ECDB2107E
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769497049;
	bh=yYnzRRxAjAM0jvCDzM38sjCvRAwJ0IEFz/xiyaj1YS0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SMTDFRKkeAKdVMPZBXiggyIdoxS5Z0Th5/+yLWETMP3JDErLN5fvDwdmYj8g6aqf6
	 Xx3tBKZP20XWDXi9qeaqrIeRu6tR7lgbBz67JUdTYzfAZ4WkceqI91IufhY5RqII36
	 3YNxSXf2cROxnu6ldDoetLo1QA6SJLTHzsen8UjU=
Date: Mon, 26 Jan 2026 22:57:29 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047390/000000-0d38da@github.com>
Subject: [bluez/bluez] cc3456: lib/uuid: Add RAS service and characteristic
 UUIDs
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

  Branch: refs/heads/1047390
  Home:   https://github.com/bluez/bluez
  Commit: cc3456832aabd197c53fd6595128be56455cf8b5
      https://github.com/bluez/bluez/commit/cc3456832aabd197c53fd6595128be56455cf8b5
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M lib/bluetooth/uuid.h

  Log Message:
  -----------
  lib/uuid: Add RAS service and characteristic UUIDs


  Commit: 4b3bb6c9a1fc5af364bd3013da637f6c17135aa4
      https://github.com/bluez/bluez/commit/4b3bb6c9a1fc5af364bd3013da637f6c17135aa4
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M monitor/att.c
    M src/shared/util.c

  Log Message:
  -----------
  monitor: Add support for Ranging Service (RAS)

Implement comprehensive decoding support for the Bluetooth Ranging
Service (RAS) in the ATT monitor, including:

- RAS Features characteristic (0x2c14) with feature bitfield decoding
- Real-time and On-demand Ranging Data characteristics (0x2c15, 0x2c16)
  with segmentation header, ranging header, and subevent header parsing
- RAS Control Point (0x2c17) with command opcodes:
  * Get Ranging Data
  * ACK Ranging Data
  * Retrieve Lost Ranging Data Segments
  * Abort Operation
  * Set Filter
- RAS Ranging Data Ready (0x2c18) and Data Overwritten (0x2c19)
  notification characteristics

Also add RAS service and characteristic UUIDs to the shared UUID table.

This enables btmon to properly decode and display RAS protocol
operations for debugging and analysis of Bluetooth ranging
implementations.


  Commit: 7e381f620dd2f92a570e36a07d29d9ee5073120a
      https://github.com/bluez/bluez/commit/7e381f620dd2f92a570e36a07d29d9ee5073120a
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M Makefile.am
    A src/shared/rap.c
    A src/shared/rap.h

  Log Message:
  -----------
  Implement the Bluetooth Ranging Profile GATT server and client support as specified by the Bluetooth SIG:

Add RAS service, characteristics, and descriptors to the local GATT DB
Implement server-side callbacks for RAS Features, Procedure Data,
Data Ready and Data Overwritten characteristics
Add client-side session handling, notification registration and
ready callbacks
Wire RAS attachment/detachment to ATT/GATT client and server


  Commit: 44e4a7be11efb603f53df6c9183f16d2e1c6f233
      https://github.com/bluez/bluez/commit/44e4a7be11efb603f53df6c9183f16d2e1c6f233
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M Makefile.am
    A unit/test-rap.c

  Log Message:
  -----------
  unit: Add test cases for Ranging Profile (RAP)

This adds unit test cases for the Ranging Profile (RAP)
 implementation, specifically testing the Ranging Service (RAS) server
 functionality.

The test suite includes:
- RAS/SR/SGGIT/SER/BV-01-C: Service discovery test
- RAS/SR/SGGIT/CHA/BV-01-C: Characteristic GGIT -RAS Features
- RAS/SR/SGGIT/CHA/BV-02-C: Characteristic GGIT -Real-time Ranging Data
- RAS/SR/SGGIT/CHA/BV-03-C: Characteristic GGIT -On-demand Ranging Data
- RAS/SR/SGGIT/CHA/BV-04-C: Characteristic GGIT -RAS Control Point

These tests verify GATT server behavior for the Ranging Service,
including service discovery, characteristic discovery.


  Commit: 0d38dac16faf6a7ff79759ec624c3b1f1ebdca27
      https://github.com/bluez/bluez/commit/0d38dac16faf6a7ff79759ec624c3b1f1ebdca27
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: Add Ranging Profile (RAP) implementation.

The profile is marked as experimental and requires D-Bus
experimental flag to be enabled.


Compare: https://github.com/bluez/bluez/compare/cc3456832aab%5E...0d38dac16faf

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
