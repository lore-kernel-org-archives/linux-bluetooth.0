Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9973AE1AF
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789505; cv=none; b=hraCg2fVlyG/LA7YFFjenie/fCi+yAOc5c/N1oxS2MMDRa1JyLRu7qyHSfTOsVVp7jKCdTVknc2QHVINDVk7JaxG8o8e0HomSjPGCqLQB6hluQpkd+MwtLUzoL1jGPE/nB5zafSBKZbCow/aCvRBnSov6GPu3eU22TC30pELVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789505; c=relaxed/simple;
	bh=uZ8iUoaXisiv1vIZdrgil1qXPQafPvK7mpveNaip7ZI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SZeVkEia70YvlSRuBTMhqJeOc93QKm+jTr6ymx0+63qKLMBflB3/nFI1LIQsaI5vOGORQA0kXlHLa+Wqsz4w5kcq+y/cZUp/tikSBTUKdZAqbN1VoDnF/dgHbojRAcjXIB/i2yi2zdXOkMG2Zy54NTOanbNc9OpYHVcrZUY3+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=inKSkr1W; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="inKSkr1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785789503;
	bh=4Q6WrkhlJkmt6SCasrTx2g13lwGHbDYyoONN5erLE7g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=inKSkr1WVW+OrVDnuSBRoFo0FNLKYBTo4ueX67G2lEkWCBC1P0S5kFPAt7ZcBq8wU
	 UefNCfRM24JZBDN+PTd/uWwEwn5zZS8h1RXFl8NPT5pdQa8s3r3YJgG1rQpNHudFyd
	 +GIRq0xg/tzoQSgwQs/h6qBOwWXGaJ8aHX1lzOKU=
Received: from github.com (hubbernetes-node-ad6df1d.ac4-iad.github.net [10.52.166.28])
	by smtp.github.com (Postfix) with ESMTPA id 6591D780A0E
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 13:38:23 -0700 (PDT)
Date: Mon, 03 Aug 2026 13:38:23 -0700
From: Jan-Michael Brummer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1139642/000000-d768b7@github.com>
Subject: [bluez/bluez] d768b7: Add cover art support
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

  Branch: refs/heads/1139642
  Home:   https://github.com/bluez/bluez
  Commit: d768b73fad7be8ec4593d5d11751599306674e82
      https://github.com/bluez/bluez/commit/d768b73fad7be8ec4593d5d11751599306674e82
  Author: Jan-Michael Brummer <jan.brummer@tabos.org>
  Date:   2026-08-03 (Mon, 03 Aug 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-bip.c
    A profiles/audio/avrcp-bip.h
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M src/bluetooth.service.in

  Log Message:
  -----------
  Add cover art support

Add bluetooth cover art support based on the existing code.
Tested with VW head unit and Fairphone 5.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
