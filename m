Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BA3D8903
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219816; cv=none; b=pYLiisTxPDEUtY7cqB2+T3L9mHIzYcwyuxusW8IboFf4TdO4SbpH6MCGOb6TlcGppFT51kw4Mr34kkAOja6AkaVtYV8z1IJMUyezIhSLslpcUeeWpsrrGO1tZRFyp3RWrfAfy1gvD0fbj6CHcZroVEwLv94+wU+vYoy9GfxznbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219816; c=relaxed/simple;
	bh=ccVc0aLpj6yjIblBCRZ7DIGN/qVDD+axXZpiSZ5lKl0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Hl/t1Laab7AMmS6Ht9WB8IZdgzHCBDnVi5wa1eUsfML1xohKC5XQA8BzbJlFT3fq09TnsTzYZCsFiGMbbLrvN5TNU1ja6fbTFTRqbQU/OBT5O+j5cec6vQDVLhMCF98icnsDgvewtV4gGsZ2pvnAq9d/kj3FQ4ZB5+mvYIkUxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g+XYSu8L; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g+XYSu8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787219814;
	bh=AmvAa+fWR5hX80Y9SlmGEVxha1UVoZUUaiUgTM0I1xs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g+XYSu8LRgxApVb6Hu73MKdzxtM1+3rO/nHmz8QCbzwL0zFBVO5qBFin/zzEOq/vQ
	 GTaHFlsa6/m4xbjOxxq3SL1AbceUGlb8CpCG0JRtFfeoB865us+7wBXfoVgb/Nh5DL
	 rDbkMAmdyWbu8yo+Nf0dyNIRBoCGp3RiTiOiW1eo=
Received: from github.com (hubbernetes-node-8b85f15.va3-iad.github.net [10.48.74.99])
	by smtp.github.com (Postfix) with ESMTPA id 7301B3403BF
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 02:56:54 -0700 (PDT)
Date: Thu, 20 Aug 2026 02:56:54 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148981/000000-88cb39@github.com>
Subject: [bluez/bluez] 88cb39: bluetooth.service: Fix ConfigurationDirectory
 warning
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

  Branch: refs/heads/1148981
  Home:   https://github.com/bluez/bluez
  Commit: 88cb39994075a97ad282b5769fe4c29411a6d38a
      https://github.com/bluez/bluez/commit/88cb39994075a97ad282b5769fe4c29411a6d38a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/bluetooth.service.in

  Log Message:
  -----------
  bluetooth.service: Fix ConfigurationDirectory warning

When running "systemctl start bluetooth.service" on some systems, this
error would appear:
systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)

ConfigurationDirectoryMode was mistakenly thought to help sandbox the
daemon, but the service configuration already sets ProtectSystem=strict
but "If [ProtectSystem is] set to "strict" the entire file system
hierarchy is mounted read-only", so bluetoothd can't write to
/etc/bluetooth anyway.

Fixes: 00cfb36e20e3 ("bluetooth.service: Set ConfigurationDirectoryMode")
Closes: https://github.com/bluez/bluez/issues/414



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
