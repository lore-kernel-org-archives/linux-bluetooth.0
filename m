Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FB42E8C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107881; cv=none; b=YvO+HbM3o93I0VHuZYwWV+AARtwRra7gmQfbOzvfESBRXriUXZafNtVOA4+6aCdi+QvIpE4e9QJsB7DrBUudi0T4YIkWTflaemJwUSJmyEn5La+2+tZQB1gBYX7//y51XSUJTtvnBlElG5iZpiE1M+7JLe61SkJ9mtHI/vjqEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107881; c=relaxed/simple;
	bh=JfyLvKVTlEJcNtbEhLktS4a99IYBtVvRJDm7c7f3Yr8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b/d9Iwy1WGyk35tzfejQPqqXfr9EdLgIKOiMNLg2Er0HCskGliYkx0S/WKq+4f/bKw41gOTtIn2B0Y78wfD4+oEf5mpql4w1pNFcTG2aRQm4j8Q7fFFeK9yFz6wqKL55qFQE5YzqUPQpVp7KcqoWc6fLxDsW9pE5pdflbwVUcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E1aTj7Nt; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E1aTj7Nt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784107875;
	bh=Ep9eftfhjCqM2KtdDqjioWWiHO+MJhtuMjgctQ8yhEw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E1aTj7NtRTeNZkKJDWJB2tHZGi6FDuHf7tSdIVg9NmzV4z+TV/VfSmWEAw194Ax+S
	 JZ+BSt/Clo7tUS/POobYIXu191nxhOuwfxMnz4iwWLqZEcT9u+laTgY3vWsvl1aw9v
	 bevxAJi4VUUZAeT+Ni+faXHz8vs67Mio6gDAWJKM=
Received: from github.com (hubbernetes-node-fab8ca9.ash1-iad.github.net [10.56.188.31])
	by smtp.github.com (Postfix) with ESMTPA id 4FCEA181294
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 02:31:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:31:15 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128002/000000-888d3d@github.com>
Subject: [bluez/bluez] dc1e49: doc/org.bluez.ChannelSounding1:Add Used by
 referen...
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

  Branch: refs/heads/1128002
  Home:   https://github.com/bluez/bluez
  Commit: dc1e49c1f617bd11179f52e721fe3cf57c5b4dcc
      https://github.com/bluez/bluez/commit/dc1e49c1f617bd11179f52e721fe3cf57c5b4dcc
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: 54f7de763aab3021e9742c74d6153bbcaa72c64e
      https://github.com/bluez/bluez/commit/54f7de763aab3021e9742c74d6153bbcaa72c64e
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M Makefile.tools
    A doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples


  Commit: 888d3d33c3bdabcd141fe456a9f1ae93f9926022
      https://github.com/bluez/bluez/commit/888d3d33c3bdabcd141fe456a9f1ae93f9926022
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    A client/scripts/cs-initiator.bt
    A client/scripts/cs-reflector.bt

  Log Message:
  -----------
  client: Add scripts to start cs Initiator/reflector

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector


Compare: https://github.com/bluez/bluez/compare/dc1e49c1f617%5E...888d3d33c3bd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
