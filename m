Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D84199FBF
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097068; cv=none; b=UhqmhDzVnyekxYmkYZiaAiOEccB4XEBrjytohfpGduivkk+sh1FrKRwVdskROPkfhalmfQTlstobYheyLZxgPYUxMUWcxL0TYGrjg3q9F0kDJizd3YN8Gy4I58QBDkCKPcUi3Z4vodSDYkj11IMCfUuq1essqIJ03DmtcmbE3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097068; c=relaxed/simple;
	bh=6KWAbMU/eunGrkcg14dM8J5uaUgB7xIPR8X7JfCPSZ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bZOcwXIc89S+4mIBcZcPV98gdGrvPd0Wex7Ez2NjWrrdEyYUdp7ZzmnXR++OmXAEh4avpY81bwWWIKOqF3MT2ixWr/TAWmHv4OFVNNFHj8LL5LPYx/bPXkqATPeaV6r3/NZUGGgKn1rgAwTR6Dc4SVgrKWl0iaOpGnx32V8dIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QOFwJfgh; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QOFwJfgh"
Received: from github.com (hubbernetes-node-85dceb3.va3-iad.github.net [10.48.144.41])
	by smtp.github.com (Postfix) with ESMTPA id 0424C8C0943
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731097066;
	bh=ROMmqLukQrwNUKEx4G4JiV/nbmt2n5VfSYugkSnafaI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QOFwJfghYIHHyfXwZXmeJctluKd6rWSwhK51DB97ZKXXCoThRBUSpyP6Svme8iSxV
	 q9GA9yHLaLdTKZYOTDTOvd3fdoVobdNs4PWoDI/zfgczE/1MNt8UMETrPJoVQqD/NN
	 xsfXVDETtVsnaVRdnKgB8L4tUPTDFpW8WGk+Rv6k=
Date: Fri, 08 Nov 2024 12:17:45 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/aa118e-de1b3a@github.com>
Subject: [bluez/bluez] 34cfee: test-runner: Fix using removed options
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
  Commit: 34cfee7ed0186726079b537946f64cdfbbbed6f3
      https://github.com/bluez/bluez/commit/34cfee7ed0186726079b537946f64cdfbbbed6f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-08 (Fri, 08 Nov 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix using removed options

-no-acpi and -no-hpet are not longer available on most recent release
(e.g. fc41).


  Commit: de1b3a5ac3991f5cfb9278c2887c0be2b71dc58b
      https://github.com/bluez/bluez/commit/de1b3a5ac3991f5cfb9278c2887c0be2b71dc58b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-08 (Fri, 08 Nov 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix not marking AVRCP_EVENT_VOLUME_CHANGED as supported

If avrcp_volume_supported return true then AVRCP_EVENT_VOLUME_CHANGED
shall be marked as supported.

Fixes: https://github.com/bluez/bluez/issues/1007


Compare: https://github.com/bluez/bluez/compare/aa118e965b02...de1b3a5ac399

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
