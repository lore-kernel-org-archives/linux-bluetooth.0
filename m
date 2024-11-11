Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6425777
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338259; cv=none; b=F/9Tf7rBJNihskyNNtpntDoWkHOYMLfvap9jfEUcg/OtViuP0aQ6BwVhU7jen7Mem7CUIFZjJMj4yYPngT+YIBzxxd1LGKr1JDMtXT45/uOM5eWK+WunJutL7Io5VEyKwsPi/FPcQF8RR7Z7whcmfb7LPin5kTwy5vgk4JnbFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338259; c=relaxed/simple;
	bh=4Qcn95Yhdv8twHfjVVTUwbCj0QnsHfHEhqdYNsOH7i0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pWMzBc47Vkk06eF4F77dpnWqTrsQU5fmUXCj0FuPy7ZlFlo6zqQkG0+r0lh4UV2X8IlfsCHdx0AP1GYYjkIVBo7RXYXSH3l9nEaKr/QOXI9m+Yj/G0y+wiOd+9aE7SKIo2yaINT+rwLCRq6KANdJPzDXNeDlwAMQQjQ6B0kbqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BR7zn78W; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BR7zn78W"
Received: from github.com (hubbernetes-node-66b26a4.ac4-iad.github.net [10.52.142.27])
	by smtp.github.com (Postfix) with ESMTPA id D390C5E08A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 07:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731338256;
	bh=FYlWKTV/yEvmnFgA7KhSrZMWBDWdajmYUb7vpXQ8udU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BR7zn78WneKN4Z27oPPeLxXluIHCsZ5FsAVO7K3Rjt7DZyP3ZBBu6IUfcQHzjo9rz
	 zn+Fp3wj6xq8Z1YrRa8EfhJ838SehEPk5i+Dh6PDYEAm5e3p64c0zCr1Gsqi4D0nTR
	 LHFNTsTO0Gpwod9CWgRi2wJXOIVufv8TBQdKslpM=
Date: Mon, 11 Nov 2024 07:17:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/de1b3a-f0302d@github.com>
Subject: [bluez/bluez] 774ad9: transport: fix AVRCP volume in reconfigured
 transp...
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
  Commit: 774ad9fdd96a522f944a1d09fe374f6a88e61807
      https://github.com/bluez/bluez/commit/774ad9fdd96a522f944a1d09fe374f6a88e61807
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-11-11 (Mon, 11 Nov 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: fix AVRCP volume in reconfigured transports

We no longer reconnect AVRCP session on AVDTP transport reconfiguration.
This breaks AVRCP volume after reconfiguration, since there's no volume
update event incoming.

Fix by keeping track of the latest volume in btd_device volume.  It was
introduced to track volume changes that arrive when there are no
transports/players, but we should track all volume changes otherwise the
value can be out of date when we want to use it.

Fixes: 469a75ae182a ("sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle")


  Commit: 639fb80032cd7eb4d59e4a71e5235c647edf2af5
      https://github.com/bluez/bluez/commit/639fb80032cd7eb4d59e4a71e5235c647edf2af5
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-11-11 (Mon, 11 Nov 2024)

  Changed paths:
    M obexd/plugins/pbap.c

  Log Message:
  -----------
  obex: Add Newmissedcalls tag in PBAP GET response

This fix is required for passing below PTS testcases:

1. PBAP/PSE/PBD/BV-05-C
2. PBAP/PSE/PBD/BV-17-C
3. PBAP/PSE/PBB/BV-11-C

Even if the new missed calls value is zero, send it in GET response.
As per the PBAP spec, it is mandatory to include Newmissedcalls
tag in response incase of object name is 'mch.vcf' or 'cch.vcf'.
It will be better to include it in all GET response.


  Commit: 486aeafd87bc23bb7969671b06ceaafc124dea84
      https://github.com/bluez/bluez/commit/486aeafd87bc23bb7969671b06ceaafc124dea84
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-11-11 (Mon, 11 Nov 2024)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  obex: Check for supported features bit value for legacy server

This fix is required for below PTS testcase:

1. PBAP/PCE/SSM/BV-10-C
Description - Verify that the PCE does not share its
PbapSupportedFeatures bits with a legacy server.

Incase of legacy server, check for 'supported features bit'
uint_32_t value instead of directly checking the pointer
holding the attribute.
As pointer 'data' won't be null as PbapSupportedFeatures
attribute is present in SDP record but it's value is zero.


  Commit: b22bbf873f819ceef4d50feabcebe907f309c68a
      https://github.com/bluez/bluez/commit/b22bbf873f819ceef4d50feabcebe907f309c68a
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-11-11 (Mon, 11 Nov 2024)

  Changed paths:
    M obexd/plugins/pbap.c

  Log Message:
  -----------
  obex: Fix the PBAP GET request in PTS testing

This change is required for passing below PTS testcases:
1. PBAP/PSE/PBD/BV-02-C
2. PBAP/PSE/PBD/BV-03-C
3. PBAP/PSE/PBD/BI-01-C
4. PBAP/PSE/PBD/BV-13-C
5. PBAP/PSE/PBD/BV-14-C
6. PBAP/PSE/PBD/BV-17-C

PTS sends all the GET phonebook requests without extra params.
Therefore, the PBAP server is rejecting the requests with a
'Bad Request' response.
So append 'maxlistcount' as default param in GET request to
avoid testcase failure.


  Commit: f0302d90a1db2b2b504819bba61f99681f3bdb72
      https://github.com/bluez/bluez/commit/f0302d90a1db2b2b504819bba61f99681f3bdb72
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-11-11 (Mon, 11 Nov 2024)

  Changed paths:
    M doc/supported-features.txt
    M src/profile.c

  Log Message:
  -----------
  obex: Update the FTP version to 1.3 in SDP record

This change is required in below PTS testcase:
1. FTP/SR/SGSIT/ATTR/BV-02-C
Attribute GSIT - Bluetooth Profile Descriptor List

Current FTP version 1.2 is being deprecated and withdrawn
from BT Sig, so it is mandatory to update the version to 1.3.

No additional changes are needed for supporting the new version.


Compare: https://github.com/bluez/bluez/compare/de1b3a5ac399...f0302d90a1db

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
