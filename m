Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1D1D8DFD
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816175; cv=none; b=sQyBIMVUu0pscRZev8JtBWq2G455/0ddpD/qZVQZ2yhCYNW2QJYYX7VXdu6qX5QZuyweeqdHVW5rT3iGWaVbqq1Q648VlF5MQnzfWoJhbEyhBorgLqNuflE4irQI1ZGmSEVhW2/eTe1yrKGZkQnLldOVa81DJOg6YKTiYw1C7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816175; c=relaxed/simple;
	bh=YBLF4vxMBUWZVzp1qWJFbTEdS3hUGJ5R7bVyxWZPl1M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KJ5+9PP+VNVS8GzLWXqYtIJ8nG12CZk3MDvTZCzcxHmO5gZGmNAK5r40nrz+7kFcRr7+lIuihR2Mbo2h/ey+v3/ppcpua7uClS7PDf5bFMq3ZfWJYupn7I2Q+febqBy2Z074NVY8vjtr7GElAbRcSUuEoboohT75DrLrtJN7Yfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DDEyJ4M0; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DDEyJ4M0"
Received: from github.com (hubbernetes-node-32a3aef.ac4-iad.github.net [10.52.140.32])
	by smtp.github.com (Postfix) with ESMTPA id 70840700C2F
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730816173;
	bh=1G5iOQp28eU2Dn0833OVfLlVQ2c9wK68JNuH1S0HZzo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DDEyJ4M0sos4HiDdTrpXC8a/lQ3jhUWsBP/NmwPiRvZoewGi0C63p9P5a2qKFjpda
	 D7ALCeUaqJXro1tZ7J2smSIfnKzqJMunD6DgJUU5L7+vOojuyuphJH+V5/bnMOjfZG
	 xPX+x8J9iec1WEuTXx3HL/46ym8iiTX1s86hVkd0=
Date: Tue, 05 Nov 2024 06:16:13 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9d69db-bae6c3@github.com>
Subject: [bluez/bluez] 30951c: btdev: Add support for syncing to multiple PA
 trains
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
  Commit: 30951c983ddcc97d82a8e824d6c7ab2b7a8353f3
      https://github.com/bluez/bluez/commit/30951c983ddcc97d82a8e824d6c7ab2b7a8353f3
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add support for syncing to multiple PA trains

This adds support for synchronizing to multiple PA trains.


  Commit: fb09ce5cfda1630136575ee5cc201390ab73068b
      https://github.com/bluez/bluez/commit/fb09ce5cfda1630136575ee5cc201390ab73068b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add support for syncing to multiple BIGs

This adds support for synchronizing to multiple BIGs.


  Commit: 1a55bac5595ca83c17d14bdcd55cca4d1936a6d3
      https://github.com/bluez/bluez/commit/1a55bac5595ca83c17d14bdcd55cca4d1936a6d3
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix memory leaks in iso_accept_cb

This fixes memory leaks that appear in iso_accept_cb because a new io
channel is allocated but never unreferenced at the end of the test.

=================================================================
==20460==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc7722bd in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2bd
    #3 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

Indirect leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc70016f in g_io_channel_init
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4916f)
    #3 0x7dcddc7722c8 in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2c8)
    #4 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

SUMMARY: AddressSanitizer: 126 byte(s) leaked in 2 allocation(s).


  Commit: b87c3767f5e042f64c02cb4a3d9460ec29bdd3f5
      https://github.com/bluez/bluez/commit/b87c3767f5e042f64c02cb4a3d9460ec29bdd3f5
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for Broadcast Receiver sync to 2 BIGs

This adds a new Broadcast Receiver test, for a Broadcast Sink
synchronizing to 2 Broadcasters.

ISO Broadcaster Receiver2 - Success


  Commit: bae6c32940d8958908f252b21d7594ba1e3fc638
      https://github.com/bluez/bluez/commit/bae6c32940d8958908f252b21d7594ba1e3fc638
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs

This adds a new Broadcast Receiver test, for a Broadcast Sink
synchronizing to 2 Broadcasters, using defer setup.

ISO Broadcaster Receiver2 Defer - Success


Compare: https://github.com/bluez/bluez/compare/9d69dba21f1e...bae6c32940d8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
