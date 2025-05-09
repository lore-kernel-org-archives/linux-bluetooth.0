Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17E2356D8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807359; cv=none; b=iHlg/hWER7TCJzwHgMPZAvy/n4SgVCX7vcm2xo4wxhlE9LTZbMWYs0W6yFT6zzFL+2hj1Mikpu80pguuiwqMNRhHakFIbogVzGWs79hIClfuNujWueeFswDFvqb3I2yDd3x8bMZVN4bwQoTwWbFh8fIBbdf+TBhtzwMQYP2oTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807359; c=relaxed/simple;
	bh=b+C+2IsYdDg1La4lhHMXNdGWanoHqv07zp0TNI0JA64=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Lx1QgjXKPCITjJvJxlX+rSvl+Cpxq5jW3M6k3UZaM5lZgQwX8nkzSLsrUlNZjFWfglrNQPwO6EMuEcm0x0SCaVJk00mLEeSLIfK4mib0E8+C+xq53cc87p2vFPlka03t8wPwXAK6hktGvhWswnu5NHxZasCt1iXo3id0LTgNje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ccbyHP/x; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ccbyHP/x"
Received: from github.com (hubbernetes-node-f448109.va3-iad.github.net [10.48.170.38])
	by smtp.github.com (Postfix) with ESMTPA id D7BA08C0705
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746807356;
	bh=FWF10SnI6jE7nP2eCjisnYcBjt1tFRXUGvzKrTFvqaI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ccbyHP/xn4Ps2IAhL6IP3LmE4bHFFiAS4kU+ocC0sZMma1PTA8xTyE9B7F/cDrYBA
	 enV0mIgBcCQ4y88mNhKEOZ2TuQxqx01/Nk0aBhxQgmqqTKnUG7f9n6vtGqCrZtnPfK
	 QUvMDnje5dw+rkIwksV2+I3Y8/tTW6NHmHyu9cJM=
Date: Fri, 09 May 2025 09:15:56 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961436/000000-b0142a@github.com>
Subject: [bluez/bluez] b0142a: doc: Convert mgmt-api.txt to mgmt.rst
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

  Branch: refs/heads/961436
  Home:   https://github.com/bluez/bluez
  Commit: b0142a0fccfb6080dd92eadf2b2f4a7807fed790
      https://github.com/bluez/bluez/commit/b0142a0fccfb6080dd92eadf2b2f4a7807fed790
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-09 (Fri, 09 May 2025)

  Changed paths:
    M Makefile.am
    A doc/mgmt.rst

  Log Message:
  -----------
  doc: Convert mgmt-api.txt to mgmt.rst

This converts from pure text mgmt-api.txt to restructured markup
language and then use rst2man to generate a proper manpage (mgmt.7).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
