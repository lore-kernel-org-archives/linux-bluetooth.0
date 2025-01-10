Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6330212D7F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525670; cv=none; b=sT+CJkthTO37CA5AXvcv2cuQIiZhVXpocce5EBZWIgHoHEpnk8d1p64oe2nY2+nH7tAjMsCa0sC+s2D86IXjioc+SU5qNTAl7NPdG+0wpUQMxQ4oe4wT5lQ6fHhehdnuFW118LHNRlwOSGZsxClnnOWd67R9M8WeSbjiZJ/k6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525670; c=relaxed/simple;
	bh=QP3IS2vYlWKkUdFKHkINl8SZ8pXF87dtsTstAIZ4O9w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GyFsADQOES2eoM3eB0lnQW8Z+pLDoG/gsWhSP7K44+bItQSrdKFHiuheb6Vx5ArwZMeGlH5cFgEkME9h3UryFM1X1RLPWc9e7yWDMaXHB0176rYl/dZhCWZQRCHj34JYoAp9MgQ3kDH+odDOyx5+i4ZY6P8y29eUe1OP1BV/6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FyBvbZud; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FyBvbZud"
Received: from github.com (hubbernetes-node-c43a1b9.ash1-iad.github.net [10.56.150.23])
	by smtp.github.com (Postfix) with ESMTPA id B48AD9210D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1736525667;
	bh=gu1wdIxrLjezj84rEezYOTo4EgfJSb6PfXRrMmRA1+A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FyBvbZud1I9j7PDPP3PZmi7K+CqwOcl6UjufNnglKCbH44FR4an3flpWUJG2AMgrL
	 cfwXAPunk4iErKyv+M01AOeXanpBUus6g0i9NlYM38CM0ZZcD936Zl7TvQrDIthegi
	 C1Mfq/mJXkIUPeL1Tznr6AWS2Zu5G0dEOgFp6B24=
Date: Fri, 10 Jan 2025 08:14:27 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/036041-2762df@github.com>
Subject: [bluez/bluez] 1e1c31: build: Fix --disable-avrcp
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
  Commit: 1e1c311243b190586b5a7ee93bec711b163de7de
      https://github.com/bluez/bluez/commit/1e1c311243b190586b5a7ee93bec711b163de7de
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-09 (Thu, 09 Jan 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  build: Fix --disable-avrcp

This fixes --disable-avrcp causing build errors.

Fixes: https://github.com/bluez/bluez/issues/1061


  Commit: 4f288bd961fcda569875e335406386e571327b20
      https://github.com/bluez/bluez/commit/4f288bd961fcda569875e335406386e571327b20
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-09 (Thu, 09 Jan 2025)

  Changed paths:
    M configure.ac
    M profiles/audio/transport.c

  Log Message:
  -----------
  build: Fix --disable-a2dp

This fixes --disable-a2dp causing build errors:

/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_init':
/bluez/profiles/audio/transport.c:1742:(.text.transport_a2dp_snk_init+0x49): undefined reference to `source_add_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_destroy':
/bluez/profiles/audio/transport.c:1578:(.text.transport_a2dp_src_destroy+0x14): undefined reference to `avdtp_unref'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_src_destroy':
/bluez/profiles/audio/transport.c:1588:(.text.transport_a2dp_src_destroy+0x29): undefined reference to `sink_remove_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_get_stream':
/bluez/profiles/audio/transport.c:397:(.text.transport_a2dp_get_stream+0x1a): undefined reference to `a2dp_sep_get_stream'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_cancel':
/bluez/profiles/audio/transport.c:586:(.text.transport_a2dp_cancel+0xc): undefined reference to `a2dp_cancel'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_remove_owner':
/bluez/profiles/audio/transport.c:602:(.text.transport_a2dp_remove_owner+0x34): undefined reference to `a2dp_cancel'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_src_init':
/bluez/profiles/audio/transport.c:1725:(.text.transport_a2dp_src_init+0x49): undefined reference to `sink_add_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_destroy':
/bluez/profiles/audio/transport.c:1578:(.text.transport_a2dp_snk_destroy+0x14): undefined reference to `avdtp_unref'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_destroy':
/bluez/profiles/audio/transport.c:1598:(.text.transport_a2dp_snk_destroy+0x29): undefined reference to `source_remove_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_suspend':
/bluez/profiles/audio/transport.c:438:(.text.transport_a2dp_suspend+0x79): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: /bluez/profiles/audio/transport.c:433:(.text.transport_a2dp_suspend+0x5a): undefined reference to `a2dp_suspend'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `a2dp_suspend_complete':
/bluez/profiles/audio/transport.c:415:(.text.a2dp_suspend_complete+0x47): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_resume':
/bluez/profiles/audio/transport.c:555:(.text.transport_a2dp_resume+0x4d): undefined reference to `a2dp_sep_lock'
/usr/bin/ld: /bluez/profiles/audio/transport.c:550:(.text.transport_a2dp_resume+0x76): undefined reference to `a2dp_resume'
/usr/bin/ld: /bluez/profiles/audio/transport.c:558:(.text.transport_a2dp_resume+0xa2): undefined reference to `a2dp_resume'
/usr/bin/ld: /bluez/profiles/audio/transport.c:544:(.text.transport_a2dp_resume+0xd5): undefined reference to `a2dp_avdtp_get'
/usr/bin/ld: /bluez/profiles/audio/transport.c:561:(.text.transport_a2dp_resume+0xf8): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_get_stream':
/bluez/profiles/audio/transport.c:397:(.text.a2dp_resume_complete+0x82): undefined reference to `a2dp_sep_get_stream'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `a2dp_resume_complete':
/bluez/profiles/audio/transport.c:508:(.text.a2dp_resume_complete+0xcc): undefined reference to `avdtp_stream_get_transport'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_set_delay':
/bluez/profiles/audio/transport.c:659:(.text.transport_a2dp_snk_set_delay+0x95): undefined reference to `a2dp_avdtp_get'
/usr/bin/ld: /bluez/profiles/audio/transport.c:676:(.text.transport_a2dp_snk_set_delay+0x52): undefined reference to `avdtp_delay_report'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `delay_reporting_exists':
/bluez/profiles/audio/transport.c:1000:(.text.delay_reporting_exists+0x19): undefined reference to `avdtp_stream_has_delay_reporting'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6378: src/bluetoothd] Error 1
make: *** [Makefile:4696: all] Error 2


  Commit: 2762dffb062e7c73e94f9655b36ad9c078aebd29
      https://github.com/bluez/bluez/commit/2762dffb062e7c73e94f9655b36ad9c078aebd29
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-10 (Fri, 10 Jan 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio/transport: Make include of avrcp.h conditional

This makes the include of avrcp.h conditional to HAVE_AVRCP.


Compare: https://github.com/bluez/bluez/compare/036041136f10...2762dffb062e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
