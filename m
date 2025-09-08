Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA182E1C54
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367931; cv=none; b=aPyYYoJcmCMp3T9jNvgelU6gxYuqCEy57hQOoQ0DuSAO+9UWWeL4GArW2Bk92UCWdVzm5lkt0sV3jUloNypaW4YOCRkssWx59/KS0djKUvUvv5P54cU1v/F+WGKYtizFcBDWxM1pCS4lEFCcX1yqfHKCaMtfU7mAEYbOohT/09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367931; c=relaxed/simple;
	bh=eHRGNoGX2KNk3NzL5DjQjfMt0zmpuR+4nEw6w7dyON4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m5xPnOXgx6+iODTGs8AS6h5+lE1JymT0XYG+g0QOJgiQxD34YdbAZoah9OeQTUQ2h8ZpJydK9DTN8+PoApqnAQ8muYaS/ct8trIWO+4XlvHTvPu8mx315CyT9LkB679Jivc9z26g6b4vYKjMJ6vefNlk1rd7u6/1c6S02X9QAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VpXJis9Q; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VpXJis9Q"
Received: from github.com (hubbernetes-node-de061c5.va3-iad.github.net [10.48.177.34])
	by smtp.github.com (Postfix) with ESMTPA id 1C3ABE044F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757367929;
	bh=22Oqs2H0YVXcEJW9DKhn4DNkQkw8Hrj/vQM99CgQXpA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VpXJis9Q+GS6FnFH2KPs8DO7a2F2JcN0S1ZWGed1w8o9qLbU3oexbF/iWUoQdk+VW
	 23vpvp7jzI7Ys+9ruIhnqe7a4+egRUTC+G1kdoZHDNOGXLX6IwA32MSWKosprGzX1o
	 2ICU0ImDQtGTtIqBq1P/0SsNN7xw3P5CCViGieUQ=
Date: Mon, 08 Sep 2025 14:45:29 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1000203/000000-be5fb9@github.com>
Subject: [bluez/bluez] be5fb9: main.conf: Add FilterDiscoverable option
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

  Branch: refs/heads/1000203
  Home:   https://github.com/bluez/bluez
  Commit: be5fb93e06e8ae6078af34974e315570293cffed
      https://github.com/bluez/bluez/commit/be5fb93e06e8ae6078af34974e315570293cffed
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-08 (Mon, 08 Sep 2025)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add FilterDiscoverable option

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
