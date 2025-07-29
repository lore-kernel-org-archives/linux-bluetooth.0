Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AC46447
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815849; cv=none; b=UJ4guusAWw8xl13K8iRTKZl9WIpcKJp+g5DtHAL3lz7euP3A8h1NQ8HII0u8jpOussrpDVmHKsK2YiqO/CYJnspCfT0g0YT8YRTQR9sn6+aO4KGHPt9AdezTyQgB2WCVCB+TePqE9+HRvZH+D72S62AIXaOC/CuH4LX2bEQe3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815849; c=relaxed/simple;
	bh=W0rKAa0qkYFqw1tnaw7d1FJHYBPJTqMKCt9TgExeUwg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eyRLjIsg8A78l1Nl/0n/i9BkQ9FR6Nr8jK0sVNmBwUS41BNbKTOnrP660v4OAbJIIqGdRZUY/ZAk0xCfOhM/DZI8wXZatxWUmFw2Cj+xVQgzmJDxhRoCj+oaJvf0dM/jkHoS8tchkloNKIhvYzTuTWoAnm4cchBNKU6G0fq6SEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fn3KUzmm; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fn3KUzmm"
Received: from github.com (hubbernetes-node-6d804b7.va3-iad.github.net [10.48.175.37])
	by smtp.github.com (Postfix) with ESMTPA id 9D56F4E53A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753815847;
	bh=EKgSUOtlD7ze6X7f/VpsVhKG8cW8Tzgrg+u3bcTL2uI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fn3KUzmmXh2VNTaGzdQmQcIRpQFmzPxmC5b7m165zl9lCX2yIiWSqcb0TAhpYWnjv
	 ZmM7lkYT3Ufj3cN3MNMb6WSrHqYbTOGR0EKMio+z2tOjIkOOhGLc9xTh/aCnht7d8X
	 7+5fcgET9NudZ0k4xoiVAQrk0e+9ORjioz6/Uq5I=
Date: Tue, 29 Jul 2025 12:04:07 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/986817/000000-6f89e9@github.com>
Subject: [bluez/bluez] 6f89e9: profiles/battery: handle reversed ordering of
 CCC ...
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

  Branch: refs/heads/986817
  Home:   https://github.com/bluez/bluez
  Commit: 6f89e9308eef4342944214a7d3ee1ff875aa3756
      https://github.com/bluez/bluez/commit/6f89e9308eef4342944214a7d3ee1ff875aa3756
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M profiles/battery/battery.c

  Log Message:
  -----------
  profiles/battery: handle reversed ordering of CCC and value

Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
This causes device to appear with 0% or missing battery percentage,
because batt->percentage is set on the ignored update so the initial
update is lost.

Fix by saving new initial value, if battery is not registered.  Also
downgrade warning to debug message.

Also check data length before parsing it.

Log (Sony Linkbuds S):

src/shared/att.c:can_read_data() (chan 0x7c31eea05c50) ATT PDU received: 0x1b
profiles/battery/battery.c:parse_battery_level() Battery Level updated: 87%
profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
profiles/battery/battery.c:batt_io_ccc_written_cb() Battery Level: notification enabled



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
