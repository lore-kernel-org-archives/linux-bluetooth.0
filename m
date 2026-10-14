Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384F563FDD
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999145; cv=none; b=rwBBn+uU8ctHUOBdlNgrw9JwVYhR++U0GtPnDpN/kMZmCrK3i3LXLPtBlXWZUeWaohPYGvdl+aQoSDT/xMYTyCkZxFchRHKrc9asZItOclB2fBD167pQH34/A4yoo2wBYxq4JnTKFJZpi/lk97nubUVDsEt1anq9yd267oHkfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999145; c=relaxed/simple;
	bh=ZorqTUPmY1ZUlVVL1GUAqW+XgZCV9a3HpJLnbZmqu30=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=peOmG6pa82qPP8cMCSi285Zb7Jhn9KKoAvphzpSFyWkqsL5nk7zeB/4U5Krb5jUybjO5aK0ROPc7oZsf+Pe/4BxXviQsVXoJljdnbDoGH4ahikN3aNxr8Qv3iGR1+gdQRHoqgeMSBDX+7vHgUtpmUATI7LjmXHCbgruWLAkBHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ASD2UJbe; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ASD2UJbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791999140;
	bh=0LpXw6mL8d3o9rUL1dScYBw+lgLZ1VHF39q84bAwLv4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ASD2UJbe1TcxIxhZU5p1cfNrIbQLt629sxZGZ4h5q7jh5A0DSVLuJ1wA+rWmaewa4
	 Xzu8uMzAAtQcHwdiTg/7aWESTgSPi2nKFLXqQOsQtFe3pPG4X577mwRxva9pzySWSf
	 yUZpFZBT7wrjihbkO1IG8NDbkkOsEdKF6Whf1BaNEerWB9W24FHG0cTKNYkXM8Tjcq
	 CJWkMKlCTWGr+9SBJep06q/+YI6yEp6WPlmwdgx0Je8pjhX0dKNUoCblIbCXiY89C5
	 HdkH2qj/YLp2sX+gLDG2PiTZdlvd08ZYxj0i8mulyITANwX+iLm5f09x8mBSqt6SE2
	 cjQ5oKL/Kr1Qw==
Received: from github.com (hubbernetes-node-97ff741.ash1-iad.github.net [10.59.90.34])
	by smtp.github.com (Postfix) with ESMTPA id 36FF93601EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 10:32:20 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:32:20 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9dc7e4-dd9d5b@github.com>
Subject: [bluez/bluez] 02aa5e: monitor: Add Minimum Supported Connection
 Interval
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
  Commit: 02aa5ea219edb9d4c4bae700fd978de8da5d787a
      https://github.com/bluez/bluez/commit/02aa5ea219edb9d4c4bae700fd978de8da5d787a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add Minimum Supported Connection Interval

The LE Read Connection Interval response carries a
Minimum_Supported_Connection_Interval octet between the status and
Num_Groups, in units of 125 us with a range of 0x03 to 0x3C. Add it to
the structure and decode it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 8ebf7ffe7bc6ceb15d908073673f251ca3939df0
      https://github.com/bluez/bluez/commit/8ebf7ffe7bc6ceb15d908073673f251ca3939df0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add Minimum Supported Connection Interval

Fill the Minimum_Supported_Connection_Interval octet of the LE Read
Connection Interval response, reporting 1 ms, the same lower bound as
the interval group already returned.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 0a48b5ef5e3d55e3ce0cf1a462ff49c3f465f329
      https://github.com/bluez/bluez/commit/0a48b5ef5e3d55e3ce0cf1a462ff49c3f465f329
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: connect instead of pairing a bonded BAP device

The hosts are shared between tests, so a device bonded by an earlier one
is still bonded when a later one pairs it, and pairing it again fails
with AlreadyExists. cmd_pair is meant to connect it instead, but it
checks Paired, which is not set until the services are resolved, so it
can still issue the pairing:

  FAILED test/functional/test_bap.py::test_bass_past_transport_acquire
  AssertionError: Failed to pair: org.bluez.Error.AlreadyExists

Check Bonded, which is what the pairing is rejected for, and connect the
device instead when it is set.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: dd9d5ba1fa4f682b082b1275a8c38523d95a58fd
      https://github.com/bluez/bluez/commit/dd9d5ba1fa4f682b082b1275a8c38523d95a58fd
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-14 (Wed, 14 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add host-resolved RPA scan checks

Check unfiltered passive scanning for IRK peers on controllers without
LL Privacy, with auto-connect and background-report controls.

Assisted-by: OpenCode:gpt-6.1-sol


Compare: https://github.com/bluez/bluez/compare/9dc7e40962f1...dd9d5ba1fa4f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
