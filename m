Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB943403F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918161; cv=none; b=gjanyraX/HbzMWZmzC4S6WfmuNZtBDb7ZD5QuTnKg0p9q+TawQZ9416yaLXcPN04fYJG0h5RDXNKknCTRo8vQfrYE99UbTO2NgEadLJERnPP3QUyZuhseItUAm+rqLG2lpU2bZXOsLV83PRjFZm6V8iJuKkwUkjbNiJbI9At5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918161; c=relaxed/simple;
	bh=JEPYiuuZKwEg+BkVHPiD3aO/iXc2NzKFQC3ipGksjWM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Suy0rKhgWsoDWNxeAVMBEN8vQW08FRI6YvzWz7/XCGHMhEkMzKt++3FY62J27sdueOIjnv2/QBMeUXaZUOAM1J6Gl8JhZkhLsxTL8KvamXKNBuQFvRavK5cS3RtZGsle5/jQqNnnQnyY3k1LUdK/0YFRronzXS4M4pgwLb6bj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=isJcuffi; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="isJcuffi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918159;
	bh=vhkF7bjO0DfyYn6+r4Hta2jACggy3/sVZoGgnAk1G4I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=isJcuffigIjcYYdJYQQmKKbMhegxHrnjWNs9XF3hhjeLFFgaFTTUD5BGY3U0JRDcL
	 drlVhVoOyxhxC9AAfVHV6h3HvC3YGhi/covhtzGwvBmxNwytfM8qENlEoQMKMNjW46
	 Goj+EGacADIEjtldRjKuWBxqMrgvw4HAo8NiffKw=
Received: from github.com (hubbernetes-node-b1ec7b6.va3-iad.github.net [10.48.177.35])
	by smtp.github.com (Postfix) with ESMTPA id A2730781248
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:19 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:19 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107612/000000-671363@github.com>
Subject: [bluez/bluez] 671363: hog: Fix starting encryption on some BLE
 remotes
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

  Branch: refs/heads/1107612
  Home:   https://github.com/bluez/bluez
  Commit: 671363a7c1e274bcbe475da9290f886a12229d61
      https://github.com/bluez/bluez/commit/671363a7c1e274bcbe475da9290f886a12229d61
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/input/hog.c

  Log Message:
  -----------
  hog: Fix starting encryption on some BLE remotes

When BLE remote doesn't reply with Insufficient Authentication Error
encryption is not started.

Good remote:
< ACL Data TX: Handle 64 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0021 Type: HID Information (0x2a4a)
> ACL Data RX: Handle 64 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x0000
        Error: Insufficient Authentication (0x05)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
        Random number: ...
        Encrypted diversifier: ...
        Long term key: ...

Bad remote:
< ACL Data TX: Handle 64 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x001e Type: HID Information (0x2a4a)
> ACL Data RX: Handle 64 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
