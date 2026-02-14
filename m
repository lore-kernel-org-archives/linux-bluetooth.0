Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33B2F3C10
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083995; cv=none; b=QgC+j+k21YUekXNN2mBLcFslOSST/K9jUV3fgOceKnIpkIYtlrbRz4lO9Yn8ovsU8j1JA8iTnVT/QbmjxoiV6xWvsZzUrzsmT/BqQb0D2GDA3rspxSiYmZFnU3W8whvIRrJt3z0McrCAMKLCqnsWOedBsdCzouxC2qtAfxWavAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083995; c=relaxed/simple;
	bh=zhHqXB2q6lJ2Lp0ojLZXsJIjUPCJQHR3XbstMKVM8nc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S8rxB+bLSR2zFSmn/GF7ppFi+IPM9ya3nZGA+uexID/J5GW9nsdpx2Yy3jQ/D/ioL4aJnYDSfOspEMG6TlClvXTmnth64l1AdapZgSnL88qwJKFieTyO/1uxoSV7UsTjPbjQGr3o2Hyw/vsQaHIMFvhEMWkXltQyYHPVebvMNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KG3CGOy3; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KG3CGOy3"
Received: from github.com (hubbernetes-node-1905bfb.va3-iad.github.net [10.48.164.11])
	by smtp.github.com (Postfix) with ESMTPA id 83C824E0121
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771083993;
	bh=xeD5DBsBKUXZDbdU1ef0BRjNSCUkduoOIh6kAIOTMxk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KG3CGOy3Bulcm3fnbhTuKW9Cchnr29lFwZRo0QlRG1uSNl/rFjM2Ch9p3rb31iEJZ
	 Lf0gWTvtDByRREPCTUcXvLAHv7qsY9FiGLoOJJ8QUI32k4feBrWMaVFirgDB3xQL14
	 zkWLzpYcoQgOhBtV7p+ldWjFeecha5K5BomrkEyo=
Date: Sat, 14 Feb 2026 07:46:33 -0800
From: Sarveshwar Bajaj <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054177/000000-f14317@github.com>
Subject: [bluez/bluez] f14317: bap: Fix use-after-free in broadcast sink
 cleanup
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

  Branch: refs/heads/1054177
  Home:   https://github.com/bluez/bluez
  Commit: f14317b8223f951e20a16b864d89fa67bddd116b
      https://github.com/bluez/bluez/commit/f14317b8223f951e20a16b864d89fa67bddd116b
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2026-02-14 (Sat, 14 Feb 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use-after-free in broadcast sink cleanup

bap_data_free() was calling bt_bap_detach() before destroying
bcast_snks queue. bt_bap_detach() frees all streams but broadcast
sink setups in bcast_snks queue were still holding pointers to these
streams. When queue_destroy() calls setup_free() as its destructor,
it attempts to access these already-freed stream pointers, causing
a use-after-free.

Fix this by destroying the bcast_snks queue before calling
bt_bap_detach() and ensuring stream references are released
while the streams are still valid.

Used safe cleanup pattern to avoid nested queue operations during
destruction as setup_free()may attempt to remove items from queue
being destroyed.

Crash trace:
  AddressSanitizer: heap-use-after-free
  #0 bt_bap_stream_unlock src/shared/bap.c:6384
  #1 setup_free profiles/audio/bap.c:1123
  #2 queue_destroy src/shared/queue.c:60
  #3 bap_data_free profiles/audio/bap.c:210

https://github.com/bluez/bluez/issues/1866



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
