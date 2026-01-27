Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993633D6C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508881; cv=none; b=tanXKGf/gMgq00h6kolGnXOtMO7aDRvTpABfZxNO5BUnFg0cUFJ/DdC22fpcORqgTQEDKUGqrXsMIULmFV6Xr2Bhb/NlFPLMhGSVPBbyoUsUdKYq3zLaFdYz/vulBZY2XUPvl4I/aOfamKhED+j+qKNM6cdaqY69s5COvzlQzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508881; c=relaxed/simple;
	bh=WENpnx0WY/ShnY0C90iQtsOnMmvNh2kL0DeLlIzpYQs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=poD2Vx3FGpH+Q832FZXnx3m0gNvGjfG9g/f/7qTI5Be7zNMkdF6tPVB9zyZZ8KoR/nxjZgXWwHjOqJ3DdJEt12nYNStx70erfZIVelF8UqMNrrK2dMIKcCnXfmkiu62Kw6VcAopYusX9SjnAFMjwbwYdntqUGCq04DJqR3AtZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EoeGuc6b; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EoeGuc6b"
Received: from github.com (hubbernetes-node-36d147a.va3-iad.github.net [10.48.163.10])
	by smtp.github.com (Postfix) with ESMTPA id 4A2B94E08E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769508879;
	bh=CvXKld+/Kj/zORTtvbj/ax0AhLvuP9j+xsRELE0hCAo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EoeGuc6bi5ksZtxPIIlMxaf9FgKbY9Zxse7jSK3RbxWiZvAGzvEsVNRCEXsSHmZc5
	 61QLrrTO4XWU1cJvDeV/8ituT8k9OXlywq4TZJSpCOnEUp2+Kvy8SQYX+HdbRTsWMG
	 tGINc3TXPXgtXijhUSYL4YnF0eOYK5B+z9h0cvuM=
Date: Tue, 27 Jan 2026 02:14:39 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047491/000000-9f639c@github.com>
Subject: [bluez/bluez] 1e93e5: lib/uuid: Add RAS service and characteristic
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

  Branch: refs/heads/1047491
  Home:   https://github.com/bluez/bluez
  Commit: 1e93e57b741d8cc91b2b59e4f89aa74199743ab1
      https://github.com/bluez/bluez/commit/1e93e57b741d8cc91b2b59e4f89aa74199743ab1
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M lib/bluetooth/uuid.h

  Log Message:
  -----------
  lib/uuid: Add RAS service and characteristic UUIDs


  Commit: f14fc9e28df761dc877bd32d46730ce2952e32e9
      https://github.com/bluez/bluez/commit/f14fc9e28df761dc877bd32d46730ce2952e32e9
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


  Commit: 89a68f91bee1d9c3745028d3dec0a1f6bdbc0b7e
      https://github.com/bluez/bluez/commit/89a68f91bee1d9c3745028d3dec0a1f6bdbc0b7e
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


  Commit: e1249554cb9229598f44dce1a90c9fb13c266500
      https://github.com/bluez/bluez/commit/e1249554cb9229598f44dce1a90c9fb13c266500
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


  Commit: 9f639c15b4d5d16689fcb856ae32e4c600376023
      https://github.com/bluez/bluez/commit/9f639c15b4d5d16689fcb856ae32e4c600376023
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: Add Ranging Profile (RAP) implementation

The profile is marked as experimental and requires D-Bus
experimental flag to be enabled.


Compare: https://github.com/bluez/bluez/compare/1e93e57b741d%5E...9f639c15b4d5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
