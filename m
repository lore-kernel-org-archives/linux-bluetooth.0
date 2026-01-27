Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527C14A91
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529750; cv=none; b=mgjxDngATgHNgVRiOp8d2zDGsDpXRYp3fquvtP79E0y1/ShzHCyuu3H70Kzke9h4XJASddhkGIyxzlb+SDiqlvx9PCCgMR8LnpQAPL5CMFdYFfzoplb4fzqPZi3FRq5Itq0U5iob0G1AjHwhNkG11hoxNjx4kzCBqa3Tig/AXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529750; c=relaxed/simple;
	bh=DPXl4dQqkmyCSRiY0jijbyVTnwmd+zomWsQn2jCY0QM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OSi0V7mqffbyI2SEhtyp9wnXWMZtjssjd3VQyd+L9yg0ONUoXjUzVbBu3T17Ohe1/RGUDNm+OJqxcrnWqHcz8Riu/MlVY2gRg6BybtKT8/wgE2S0rm/GuMz34a60Hfxd/kFK4CKz2wPGuTg7hHzFnM7XjCFFrjQc70h8pMrvP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=crsow8tC; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="crsow8tC"
Received: from github.com (hubbernetes-node-8b92465.va3-iad.github.net [10.48.201.35])
	by smtp.github.com (Postfix) with ESMTPA id C1FC73C149E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 08:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769529748;
	bh=3hzh3B7dBRYrVdpnVXggQ3bs804UkBKhLHE3DND2Zco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=crsow8tC0OXX3e1M4XprRNzgJdbOwigBNoB0jsGB1zEeaXB1r20o5MCuNLWCcTKfZ
	 0YCigha598Uhlf3LzTvlW7d7Ibz5HNCdx2ukGjX0NRhmrtWa20Xfq6VKuBMdN6H+Ao
	 pudWoj1PIlXaOP4CDH6B5tLiRDX434W9+/Oe3EQg=
Date: Tue, 27 Jan 2026 08:02:28 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047655/000000-7137d0@github.com>
Subject: [bluez/bluez] 7570e8: lib/uuid: Add RAS service and characteristic
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

  Branch: refs/heads/1047655
  Home:   https://github.com/bluez/bluez
  Commit: 7570e853d82d1c3fc469007624d024e040e6ea8f
      https://github.com/bluez/bluez/commit/7570e853d82d1c3fc469007624d024e040e6ea8f
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M lib/bluetooth/uuid.h

  Log Message:
  -----------
  lib/uuid: Add RAS service and characteristic UUIDs


  Commit: a68e56bf21d7ed8c2a8074235b8570c83b03fb5e
      https://github.com/bluez/bluez/commit/a68e56bf21d7ed8c2a8074235b8570c83b03fb5e
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


  Commit: 2f9e44554c7513b6bfcbde3a3588daf72a63e66b
      https://github.com/bluez/bluez/commit/2f9e44554c7513b6bfcbde3a3588daf72a63e66b
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


  Commit: fb32f6b4d35e978d7ef3d1c650d225406e1b3a9a
      https://github.com/bluez/bluez/commit/fb32f6b4d35e978d7ef3d1c650d225406e1b3a9a
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


  Commit: 7137d00b3ab75d35fd4889815d8129ae491cfebd
      https://github.com/bluez/bluez/commit/7137d00b3ab75d35fd4889815d8129ae491cfebd
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


Compare: https://github.com/bluez/bluez/compare/7570e853d82d%5E...7137d00b3ab7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
