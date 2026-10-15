Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE64D09E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066108; cv=none; b=EncQIh3v17EBR5oJ54tA3Wy3DldOMH7R9hE3tD/FEb0Yw/VgQ6S6cbVzHwAcrPGvzwXA9nuZ69AwhZ9AwhO8LfHSRN/VPmEm2SRT5gs00Jnxe8fPzLbfwPA4bTU3s2TYDvnVgJAeQ389M6J7uSVJhX/9GI/Iy4dspAlgUnyfu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066108; c=relaxed/simple;
	bh=crZqenCywOsZUh9EtSpPT6G9rYfOxkrnYzBynvwYowU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AvfDuGfLcIld4b7CYKk0pREu5aF3r9wQK3Ju8ggcdThwYNHdxfVH8LnFcrOwTynvQ7SPx8kloq7n1Oa9pwhJ/nNePybHwtgjT9oklednArJFxkW1G/Ojh4n+4txorRb99SSsO+3TZxV/H9ODuDQI73LtdYsSWwc7cyIapyOhxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=YjWlqZyb; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="YjWlqZyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1792066106;
	bh=Jc7l61THgUmlANuni7dv2bTE24YRwZMxkOU/xztgXXA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YjWlqZybSnWGoQajhKy0B9LDe2AIisYKW9A+W/ObeeW6p/MqzusiQoQWe1etZ67dg
	 S5vt97aNM/eri9mYsnzwLk66k5TfgAANJOnGB2ISvYAlxOliWVxz3tjbgALp+IeuyX
	 wDhbYA9retVp1eFvboBlJi7bmdkoEIEvxSZ0HLUBPfq9pSQtGkEZozjUXT0zaxcn0t
	 SqnYHDLiWVfw++YoaXPsJMqNFIRtMJXcpSBC8YL7hEIkdyZwguWVtcKrNOeRBdw2iO
	 gkhdDBW5Fa5vd/s9A5QROhxsTLDpinPyfTZE2zB4+zu4TM57ZP1QGwMJrLQNh845Q6
	 jXQHEWc/REPcg==
Received: from github.com (hubbernetes-node-f50ce8d.va3-iad.github.net [10.48.67.60])
	by smtp.github.com (Postfix) with ESMTPA id 9DFE54107A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:08:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 05:08:26 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1186303/000000-7a1d81@github.com>
Subject: [bluez/bluez] 7a1d81: hci: add ext adv interface
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

  Branch: refs/heads/1186303
  Home:   https://github.com/bluez/bluez
  Commit: 7a1d810756615f7af3b079b1951c0704e1722ab0
      https://github.com/bluez/bluez/commit/7a1d810756615f7af3b079b1951c0704e1722ab0
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-10-15 (Thu, 15 Oct 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M lib/bluetooth/hci.h
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  hci: add ext adv interface

Wrap extended advertising HCI command interfaces.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
