Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE462D47E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536883; cv=none; b=flOS+sKhfiCS3Fnn6TUf5wWLu5Ytj94I0lCtOJhe/CjEa1k+3J0gcjzZO4qT65PAqb8HQ6dJEqBOdxkes7G4ngFjfRE2noqOvtQplvK7FeizKBulrSzUL0JJskpu+Onw5jn1uLd0Ie6Sl3qp4v+hoD7a9G0txAqnZVF/vvLnNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536883; c=relaxed/simple;
	bh=Bp89nLmAefYlf0qo7p7RWiqx0/aCEkrMeYd3RvYKQSo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G07hczCsaDzQwT8J7HhNtjIegJzLF/ZkskwT9UX+AHehZxqyhWDj63NkwM8SOfRTPMWkRWOwCuGgnMwZfkyRixBQ8/avWDohLydsOh971o2cvztdFe5/n45KZXzaSsP0igGVunpk1gBp1SfTla+XFgwCbyA4Q+J9GTnWTLIFlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aQQhq9Xx; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aQQhq9Xx"
Received: from github.com (hubbernetes-node-c24e7eb.ac4-iad.github.net [10.52.200.80])
	by smtp.github.com (Postfix) with ESMTPA id 4537240092A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536881;
	bh=jO2xF/S6fEuGRVSYsRy9+eaQgiVMXN0SHmU0nufPaHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aQQhq9XxHR9RqNar/WXUwomsmqG5237ecofGpoehiqh9AnTxCe9Epm/xyRjhX+L7l
	 ZB7E4SnBqLLbNHcETCdqXFlqfP36g8Bk817udrdbw6fGnM//vt6iAfmAllZK6A+xxu
	 4Cp8pafAj3MlGzreb1JJm3MZyeQcIgJDq843LD2M=
Date: Tue, 27 Jan 2026 10:01:21 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2d5afe-4e43a6@github.com>
Subject: [bluez/bluez] 92482d: lib/uuid: Add RAS service and characteristic
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 92482d569345ea56b516ac0149acbf2ef921392b
      https://github.com/bluez/bluez/commit/92482d569345ea56b516ac0149acbf2ef921392b
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M lib/bluetooth/uuid.h

  Log Message:
  -----------
  lib/uuid: Add RAS service and characteristic UUIDs


  Commit: daaf5177720a256dcc5d2d81df127f508e416341
      https://github.com/bluez/bluez/commit/daaf5177720a256dcc5d2d81df127f508e416341
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


  Commit: 5606307c77ffd8d26d010a0cda4e3fc97d8b90cf
      https://github.com/bluez/bluez/commit/5606307c77ffd8d26d010a0cda4e3fc97d8b90cf
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    M Makefile.am
    A src/shared/rap.c
    A src/shared/rap.h

  Log Message:
  -----------
  shared: Add initial RAP implementation

Add RAS service, characteristics, and descriptors to the local GATT DB
Implement server-side callbacks for RAS Features, Procedure Data,
Data Ready and Data Overwritten characteristics
Add client-side session handling, notification registration and
ready callbacks
Wire RAS attachment/detachment to ATT/GATT client and server


  Commit: f6e7738791714d19cced4c81caa68477e54febd8
      https://github.com/bluez/bluez/commit/f6e7738791714d19cced4c81caa68477e54febd8
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


  Commit: 4e43a6283736abcb12440ba34c8a1d3b23825f64
      https://github.com/bluez/bluez/commit/4e43a6283736abcb12440ba34c8a1d3b23825f64
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


Compare: https://github.com/bluez/bluez/compare/2d5afe34bb05...4e43a6283736

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
