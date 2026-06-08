Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017C3C3C0E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948190; cv=none; b=T3xsbUBMBrZ5C7/OGRSCKVTZo6VHQKYgXdzAJ81rB6wb9FxGnY5tTxNU3TSRCH2pfjAYpL53dcrun16da5K5Wxx1IgvX8vWz8H4Kw2MumUlgCgmnqFWSUJINRubNgU+qYYs/Lv4N/EQeZp+AAeDqnTJtx2O5VG1FXPou6DMqOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948190; c=relaxed/simple;
	bh=t6+hB8LTvEpWB6p2Qn52PfwUHSff7dgx++RCwICAJ3E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Go1ub+KtXqzFOzd9SCAEEYIFCmEl2KicESCin0hztwBFRCv3UIKGKsgQcdmNrSDpHx3KasIVYDqscdx4OwoAj9AGXbZ8C/URcaVtNaDOksM9UMWhIQJ1o5504aS1gG+7qywkI7j6pGsTfjMe/vFv1zY75mrmnJzqyNL6IvVH/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZtAmRfCS; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZtAmRfCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780948188;
	bh=IRP/P1FZqVFQUZkHtt6bJjtOLhXNQabQTParD9VArXk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZtAmRfCSl9xxzLGYxFNfAMjpkpamyc1pS9IC5csfyBWLHlhOncXykgGJg0AwYckrX
	 +ah39Gk+ClUbT01/SroVld9U/jHv0fxw7f85FFHvpHwFQr5tFa7TE0XnN16WidfYvB
	 vcphcxZ+zf0/7ZjboK271Q1Tmw3yq22olQ6TGyC8=
Received: from github.com (hubbernetes-node-4165f34.ac4-iad.github.net [10.52.81.30])
	by smtp.github.com (Postfix) with ESMTPA id 47E45A0A5E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:49:48 -0700 (PDT)
Date: Mon, 08 Jun 2026 12:49:48 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7a0c8e-622a46@github.com>
Subject: [bluez/bluez] 60437c: avdtp: Fix GET_CONFIGURATION cmd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 60437c06560e46d211aaf99620cc9510dfd8081f
      https://github.com/bluez/bluez/commit/60437c06560e46d211aaf99620cc9=
510dfd8081f
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix GET_CONFIGURATION cmd

This fixes AVDTP/SNK/ACP/SIG/SMG/BV-12-C


  Commit: 7c1c90f7b6d0f653c581878a039e2d02362f33f5
      https://github.com/bluez/bluez/commit/7c1c90f7b6d0f653c581878a039e2=
d02362f33f5
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix error handling for AVDTP_OPEN cmd

We have to return BAD_STATE when local SEP is available instead of
BAD_ACP_SEID.

This fixes: AVDTP/SNK/ACP/SIG/SMG/BI-26-C


  Commit: 2c4ed7bfd3b3cade7abdec655702c554259cf8c0
      https://github.com/bluez/bluez/commit/2c4ed7bfd3b3cade7abdec655702c=
554259cf8c0
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  bap: Fix ASE control point properties

WriteWithoutResponse is mandatory as per ASCS 1.0.


  Commit: 7ca747652dc44ecf1fa0336cc7570737f07a23f6
      https://github.com/bluez/bluez/commit/7ca747652dc44ecf1fa0336cc7570=
737f07a23f6
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix auth_retry timeout not being removed on reconnect

timeout_remove() was called with 0 instead of the actual timer ID
because auth_retry_id was zeroed before the call.


  Commit: 279c4ac70c77d88e1947cef98cdabc288d2430d3
      https://github.com/bluez/bluez/commit/279c4ac70c77d88e1947cef98cdab=
c288d2430d3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix cache update on device remove

If there's no other group than the one explicitly removed the length
returned by g_key_file_to_data() will be 0 and currently nothing
will be changed in the device cache file.

If there's nothing to write, remove the device cache file.


  Commit: 56835e9061de1eca24b8d2395ed6d1ae35d8361b
      https://github.com/bluez/bluez/commit/56835e9061de1eca24b8d2395ed6d=
1ae35d8361b
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/input/server.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Refactor device_discover_services function

After refactoring we can reuse function once more in function
void device_bonding_complete(...)


  Commit: 415955bb70baa17a82fa107e5fa34c501c6a006b
      https://github.com/bluez/bluez/commit/415955bb70baa17a82fa107e5fa34=
c501c6a006b
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Rename start_discovery function

Rename it to start_discovery_cb to indicate that it is callback function
from timer.


  Commit: 622a46ebcd72a511219d51366352d4cf6a46dbba
      https://github.com/bluez/bluez/commit/622a46ebcd72a511219d51366352d=
4cf6a46dbba
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix returning discovery error for Device.Pair

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.


Compare: https://github.com/bluez/bluez/compare/7a0c8ebf91e6...622a46ebcd=
72

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
