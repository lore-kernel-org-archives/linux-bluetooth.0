Received: from o4.sgmail.github.com (o4.sgmail.github.com [192.254.112.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4728507D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260938; cv=none; b=rfYsnNYFJxey0SWwDOVoJ1moXJshkMLucoj4dHibm4f8I4Gpd8Dx7ndqBGnWJ2PjuIXiDOi1ye+//CXbTreoOjqonkPm4jOcunZxcL1lL3/3k4GJm3uPMgCnda9o2JQ/PcauurXKX7X3u0ASSLi60ahEnIH6rl3iS5KrUlt/lmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260938; c=relaxed/simple;
	bh=ew8i7E/e+Zsk7Krrh5xi4w3Z1w7trZRu89ewI2+YY7c=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=aRm7XOsV7SFSrfgqAKG6mpzJPbWPpMp6r+yDA68TIo60XaDRU7Ro2yqQVTL++X41GI6fUF6dIaDjEjQ45tI29oIeFU713I4KIr8DrrXxLP+HOiSAwW+g6vJ5m7ykWUpDICOxfxWKnlcPcG/t00Iwb6JUJhtGD0hi1AZT2ak0Jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EasCldZH; arc=none smtp.client-ip=192.254.112.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EasCldZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=S969mEXrSt3wwbsjR9CxhsL6NHV5irCTgvhBG3aTRQg=;
	b=EasCldZHE+y6a8sMIP5XPaeAtBHRVmPo7eBLeSi920+clqAyHH+OmxHQgSQpYxgxOJUV
	FjA6xZTHsIUifhJcWEJlYH3N2hdqJMcR3mqjGWkGj2LjEG6ro4L7Xe5+VpVwi92WfjdO6a
	GLu3XzbmC6cqNh/1gY12fu8Lw79aKxGBQ=
Received: by recvd-85b768ccf6-8jztn with SMTP id recvd-85b768ccf6-8jztn-1-6852DCC6-37
	2025-06-18 15:35:34.2471931 +0000 UTC m=+1205448.841066250
Received: from out-27.smtp.github.com (unknown)
	by geopod-ismtpd-7 (SG)
	with ESMTP id 7YHB9dJ9T8iRCHpdLQ7aJw
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 18 Jun 2025 15:35:34.239 +0000 (UTC)
Received: from github.com (hubbernetes-node-0cb1043.ash1-iad.github.net [10.56.212.96])
	by smtp.github.com (Postfix) with ESMTPA id C66E1600937
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 08:35:27 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:35:34 +0000 (UTC)
From: fdanis-oss <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/973494/000000-223814@github.com>
Subject: [bluez/bluez] 223814: device: Fix memory leak
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EkEW1ILLE7+TyiFtG2yqjE93HGga+mz2MoI5EtQ9frJ7vCSIJzT95OeHq1?=
 =?us-ascii?Q?dtSDtzXJma3sKP+2lS4z80FC7jtM3y6GirbBsm1?=
 =?us-ascii?Q?74381EB8wsWfBV32eEx2yFwvOuzJE3+3TTbKtXz?=
 =?us-ascii?Q?Pu2jLsKAdBt1ISOIBxHcuVewJvILNbhkqjGkPTR?=
 =?us-ascii?Q?ifdCVMY5OuBn5XUDCZETxLI0xdS7Af8cIRIXySG?=
 =?us-ascii?Q?ibdP8+=2FMu6UPXJNFTB4ZBtL0nRygHBNdN4HpIKO?= =?us-ascii?Q?b9xx?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/973494
  Home:   https://github.com/bluez/bluez
  Commit: 223814198364497e444fe1b49b81ae0c16137302
      https://github.com/bluez/bluez/commit/223814198364497e444fe1b49b81ae0=
c16137302
  Author: Fr=E9d=E9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-18 (Wed, 18 Jun 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix memory leak

This frees the LastUsedBearer string to avoid memory leak:

Direct leak of 12 byte(s) in 2 object(s) allocated from:
    #0 0x7ccf538fd9c7 in malloc ../../../../src/libsanitizer/asan/
						asan_malloc_linux.cpp:69
    #1 0x7ccf53665b09 in g_malloc (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x62b09)
    #2 0x7ccf53659b90  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x56b90)
    #3 0x7ccf53659cd4 in g_key_file_get_string (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x56cd4)
    #4 0x5c8c691f2811 in load_info src/device.c:4225



To unsubscribe from these emails, change your notification settings at http=
s://github.com/bluez/bluez/settings/notifications
