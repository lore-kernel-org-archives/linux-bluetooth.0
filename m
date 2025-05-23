Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6C1CB518
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010887; cv=none; b=o05u2Wp9WIqsiezMbiixWjHa4+krwJuS/veMDfS5gcsyCRnr/O8fXgz3UtLRAb173xZIhLSsvdhmmlmh/fz18nS+VG78/zmBASn9LCTq31hsg1DwR7st2md29KhexenAt+O8aWP7l52xly/mGdFj4tHmWokgXGb9d+w5rsoo3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010887; c=relaxed/simple;
	bh=Gs7ctD9W4lhQwLn/zypWqB1ysG8Ne8RDGIGDfRAb3z4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CyoIDb+zsVrI6sKnZv/lpkOTC4nBI9XSdV4eg8qq2bpV0k0S2wOx/cK9fb39YLhgG10zS78e5yoxfhc/NkgXgxbXuwtEchlylm10pAMRMKBCpBlct9avXSwV7utmCrxGtYE8GAOqRl6DzoAczbuoN4bpfpxTKRe1r5nwn58g+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hi9mOejE; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hi9mOejE"
Received: from github.com (hubbernetes-node-05fbcf7.ac4-iad.github.net [10.52.135.36])
	by smtp.github.com (Postfix) with ESMTPA id ADD6B640930
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748010884;
	bh=LdIAHdJFW0dQb9e+Yi4eMslRlAc81DyKCWgalOlVMeM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hi9mOejEO54TaIRkmRazwto6Sb9msCEMKc8VVAnC6nLoApy9hzOo98I0APonv+QYq
	 p6VrVH0BWZKeHJl6dgHMeS0r8XT8S102HTwDgs/LURGGfxVtmDhabmxTIyrL2ufQ5A
	 tobpsso4bWL80TTcdyNLo6jdCLcp9ihFEZ4tWyU0=
Date: Fri, 23 May 2025 07:34:44 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965873/000000-2b0e76@github.com>
Subject: [bluez/bluez] 429bd3: org.bluez.Adapter: Add AutoConnect to
 SetDiscovery...
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

  Branch: refs/heads/965873
  Home:   https://github.com/bluez/bluez
  Commit: 429bd39f5a4ff0d2bbf66eea244a1f1898c306b0
      https://github.com/bluez/bluez/commit/429bd39f5a4ff0d2bbf66eea244a1f1898c306b0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter

This adds AutoConnect filter option to SetDiscoveryFilter which can be
used by application to automatically connect devices found matching a
pattern.


  Commit: d58b1887c71c9e4d5d89fbfd5fedacfce7d91d4d
      https://github.com/bluez/bluez/commit/d58b1887c71c9e4d5d89fbfd5fedacfce7d91d4d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  adapter: Implement SetFilterPolicy AutoConnect filter

This implements AutoConnect filter option in SetFilterPolicy method
according to its documentation.


  Commit: 8b676f6c89dc617cba5f5106b37b4f3fa500ba5c
      https://github.com/bluez/bluez/commit/8b676f6c89dc617cba5f5106b37b4f3fa500ba5c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add scan.auto-connect command

[bluetoothctl]> scan.auto-connect --help
Set/Get auto-connect filter
Usage:
	 auto-connect [on/off]


  Commit: 2b0e7615825ee550289658bfd0597e09c465c47c
      https://github.com/bluez/bluez/commit/2b0e7615825ee550289658bfd0597e09c465c47c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/bluetoothctl-scan.rst

  Log Message:
  -----------
  bluetoothctl-scan: Add documentation for auto-connect command

This adds documentation for auto-connect command.


Compare: https://github.com/bluez/bluez/compare/429bd39f5a4f%5E...2b0e7615825e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
