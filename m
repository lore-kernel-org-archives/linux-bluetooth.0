Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22484BFE8C
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827500; cv=none; b=k8V5wTDoY/P92clFAT8sOLu5nr3EHOrEavenrHCRyU3K18Z0M0h26xJBrDmZWdsREVPt/RN9zeoOt4wVTMOK1fZZn1SHykOW87wi3nWyYLMA0E4qdyyg+Ddd5EIlrCHtxn7PfutUMT7bsTa5PeqqoYem1V4CNYESwKKVE24ecrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827500; c=relaxed/simple;
	bh=i2DCUxLwwxmNSQiWCHeHD/f4DPZP0EdGei+UqmShhec=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SbbJaqAFQv4g2OVBloKKxDaS/kZCrRZayqYXlyoAGj9/+P3liTsE4zbEV0LAc7DmE+Idmxd+oHgfWPob1e0gtqj3g58KsbWm8SbKvJuMdxoRRWvpYGiORS6O6Pnx75PYRRrCfpoijP47UI+J4S/ZhreW79oYbez6iEq4yF/5sMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=h6egiRQA; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="h6egiRQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791827497;
	bh=Oe76a6EkkPHIJZAoKM0jjZk4M37aAdO243+BvUeCny8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h6egiRQAckihTUDf3xG3EWCCoDF/13cNNllcEQubNY3Wsb60TaprKjAvg3u3ZRqAW
	 mXZZOVIWsLjag49sx/vr3P92Iv6J3HmpzcW0s+qgvt2fnyLCF+iy8bdEZpFzqXk1sZ
	 tYclR/OUWhnsY01tZMamPUCq6fAz9Pm9FhJgbaXc+uyR1r4V6QbZ0fRGsiY+GrsLfB
	 bpS6YT7eWVxOj2JW1cFfvTGMfySO41NS0DIBTBTauqMZ1O50zwt2s0rFX+OgNlXxdk
	 EaPklT/EQwEb1sQqkAn9ni3eBqRBLD9UepTUg9NdSJYlVwP+753GbPK5zt7k9WlsmF
	 eJ4Ay9NlT1C+Q==
Received: from github.com (hubbernetes-node-7f15023.ac4-iad.github.net [10.52.223.68])
	by smtp.github.com (Postfix) with ESMTPA id 032D6A0C85
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:51:37 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:51:37 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184010/000000-0887e7@github.com>
Subject: [bluez/bluez] 0887e7: test: functional: change the HoG connection
 rate f...
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

  Branch: refs/heads/1184010
  Home:   https://github.com/bluez/bluez
  Commit: 0887e798bee43488d067ef3209768b7b72685060
      https://github.com/bluez/bluez/commit/0887e798bee43488d067ef3209768b7b72685060
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M doc/functional-hog.rst
    M test/functional/test_hog.py

  Log Message:
  -----------
  test: functional: change the HoG connection rate from the HID device

As specified by the HIDS/HOGP SCI FIPD, the HID device initiates the
Connection Rate Update procedure once the HID host writes the mode to
the HID Control Point, so load the connection subrate on the HID device
instead of the HID host.

This requires the kernel to issue the LE Connection Rate Request as
peripheral.

Assisted-by: OpenCode:claude-opus-5.5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
