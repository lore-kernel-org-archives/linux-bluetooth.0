Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87426AC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236053; cv=none; b=Zw8PNb5eS8C2CJOQEwAIRd6wv7OkEMQd4gdRWPDDoeHCesKoItcWcy8L0i7pTUzY2emo6GKcjA4mmkqb9x+4KdHuv2g9nk2AcmEpywmD2LCySLgrfNMBfvh+gpe32ZkLm6lFuhxoy0fs22yqHEdePeW7fi2fuHC82IXpumF697k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236053; c=relaxed/simple;
	bh=wYATLZ8xUeyuXvy3kJ9rLfzEeB4JGLyVpNNwyfdBUis=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=htFuKP4XrH60JxujuGZUmbdAJgjwJnXkvTj5KNxex3ddlWj+uEEQZMZnvj1TV3bTOzZGVIpWdk+hT1ukd3bEbFdIQAcQEwXa49YeW0B7QUgZhUQCLtAN12LJWszUO1EjWWqialwmAB1NjT2KEmnk1N3t1VnOQnkh7YRIJqzbdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GEuTtN5S; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GEuTtN5S"
Received: from github.com (hubbernetes-node-280a920.ash1-iad.github.net [10.56.153.38])
	by smtp.github.com (Postfix) with ESMTPA id 382B9601185
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1716236051;
	bh=mN2R66lGUMUn0qWmsgqyc3xrg33RYDcfjTd3OyihaqQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GEuTtN5SQE3jVH2+NWhCfdN88bwCQOinGmX5mCqUd7l+jfTQJbXu3bDzqyFfeFISr
	 JtDlsHD9Cs4dtnz5IhuoYDaLfXkSMzwzni9lzA5p5lzM1qM+whNeoejt+KLDxMuI+j
	 tM50/jOgn4f64WLkOG5hI690wgm+SJ3ZHq7ClTSE=
Date: Mon, 20 May 2024 13:14:11 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/62d38d-a2438e@github.com>
Subject: [bluez/bluez] 25d3b6: device: Add btd_device_get_icon
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
  Commit: 25d3b629e4df3be30463750d46b843a78464983f
      https://github.com/bluez/bluez/commit/25d3b629e4df3be30463750d46b843a78464983f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-20 (Mon, 20 May 2024)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_get_icon

This adds btd_device_get_icon which can be used to retriev the icon
string of a device object.


  Commit: db383a5b4a8d5ce5ae26c33abeff0dfd56860d21
      https://github.com/bluez/bluez/commit/db383a5b4a8d5ce5ae26c33abeff0dfd56860d21
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-20 (Mon, 20 May 2024)

  Changed paths:
    M android/hidhost.c
    M profiles/input/hog-lib.c
    M profiles/input/hog-lib.h
    M profiles/input/hog.c

  Log Message:
  -----------
  hog-lib: Add force parameter to bt_hog_detach

This adds force parameter to bt_hog_detach which indicates if the
bt_uhid_destroy shall be called.


  Commit: e4f6c68f2a4dfbbdbc24379a5242564c65aa9ae2
      https://github.com/bluez/bluez/commit/e4f6c68f2a4dfbbdbc24379a5242564c65aa9ae2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-20 (Mon, 20 May 2024)

  Changed paths:
    M android/hidhost.c
    M profiles/input/device.c
    M profiles/input/hog-lib.c
    M profiles/input/hog-lib.h
    M profiles/input/hog.c
    M src/shared/uhid.c
    M src/shared/uhid.h
    M unit/test-hog.c
    M unit/test-uhid.c

  Log Message:
  -----------
  shared/uhid: Add special handling for non-keyboards

This adds special handling for non-keyboards so they are destroyed when
disconnected rather than keeping their device node around.

Fixes: https://github.com/bluez/bluez/issues/848


  Commit: a2438e46f8129d8e08cfb00001a4b63f5616cdda
      https://github.com/bluez/bluez/commit/a2438e46f8129d8e08cfb00001a4b63f5616cdda
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-20 (Mon, 20 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Sink STR one BIS tests

4.14.2 Broadcast Audio Stream with One BIS - Sink (page 189):

    Test Purpose:
    Verify that a Broadcast Sink IUT can stream one BIS from a
    Broadcast Source. Verification is performed for each set of
    codec specific capabilities in turn.

    Test Case Configuration:
    BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]
    BAP/BSNK/STR/BV-02-C [BSNK, LC3 8_2]
    BAP/BSNK/STR/BV-03-C [BSNK, LC3 16_1]
    BAP/BSNK/STR/BV-04-C [BSNK, LC3 16_2]
    BAP/BSNK/STR/BV-05-C [BSNK, LC3 24_1]
    BAP/BSNK/STR/BV-06-C [BSNK, LC3 24_2]
    BAP/BSNK/STR/BV-07-C [BSNK, LC3 32_1]
    BAP/BSNK/STR/BV-08-C [BSNK, LC3 32_2]
    BAP/BSNK/STR/BV-09-C [BSNK, LC3 44.1_1]
    BAP/BSNK/STR/BV-10-C [BSNK, LC3 44.1_2]
    BAP/BSNK/STR/BV-11-C [BSNK, LC3 48_1]
    BAP/BSNK/STR/BV-12-C [BSNK, LC3 48_2]
    BAP/BSNK/STR/BV-13-C [BSNK, LC3 48_3]
    BAP/BSNK/STR/BV-14-C [BSNK, LC3 48_4]
    BAP/BSNK/STR/BV-15-C [BSNK, LC3 48_5]
    BAP/BSNK/STR/BV-16-C [BSNK, LC3 48_6]
    BAP/BSNK/STR/BV-17-C [BSNK, VS]

    Pass verdict:
    The IUT synchronizes to the Lower Tester (the Link Layer
    receives a BIS Data PDU). The host on the IUT receives an
    LE BIG Sync Established event.

    If the Codec ID is LC3, the IUT receives BIS Data PDUs on
    the broadcast Audio Stream containing encoded LC3 audio data
    formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT
    receives BIS Data PDUs on the broadcast Audio Stream.
    The parameters included in the Codec_Specific_Configuration
    data are as defined in TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV
    structure with the length, type, and value specified in
    Table 4.81.

Test Summary
------------
BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]                 Passed
BAP/BSNK/STR/BV-02-C [BSNK, LC3 8_2]                 Passed
BAP/BSNK/STR/BV-03-C [BSNK, LC3 16_1]                Passed
BAP/BSNK/STR/BV-04-C [BSNK, LC3 16_2]                Passed
BAP/BSNK/STR/BV-05-C [BSNK, LC3 24_1]                Passed
BAP/BSNK/STR/BV-06-C [BSNK, LC3 24_2]                Passed
BAP/BSNK/STR/BV-07-C [BSNK, LC3 32_1]                Passed
BAP/BSNK/STR/BV-08-C [BSNK, LC3 32_2]                Passed
BAP/BSNK/STR/BV-09-C [BSNK, LC3 44.1_1]              Passed
BAP/BSNK/STR/BV-10-C [BSNK, LC3 44.1_2]              Passed
BAP/BSNK/STR/BV-11-C [BSNK, LC3 48_1]                Passed
BAP/BSNK/STR/BV-12-C [BSNK, LC3 48_2]                Passed
BAP/BSNK/STR/BV-13-C [BSNK, LC3 48_3]                Passed
BAP/BSNK/STR/BV-14-C [BSNK, LC3 48_4]                Passed
BAP/BSNK/STR/BV-15-C [BSNK, LC3 48_5]                Passed
BAP/BSNK/STR/BV-16-C [BSNK, LC3 48_6]                Passed
BAP/BSNK/STR/BV-17-C [BSNK, VS]                      Passed


Compare: https://github.com/bluez/bluez/compare/62d38d6c9ef4...a2438e46f812

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
