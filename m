Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9622D3752
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064525; cv=none; b=F/Y1euruVxFq2//1SzHjs5PHDNy8sk1j5TAkDVQw52EJJQPZTtCgmV5RJQe+fW6UqYC6LyDVyTmEI1+kIaJbjRUsONv6qRaLuxMPf3yeBC0GTV8MSLyle3HxPjEuHNSs3KSZMCn3QXqYbD3AJL6d+b0F1dpxoy/DEH2WyqemX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064525; c=relaxed/simple;
	bh=4MDtVIWgp+7uvxYWpqU5EoLUyjYQzF2kCYNaTXRW6lQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qs8NR98DZnM28aZ2iAidAUOnNHq0Gz5dGS7ILFq0X2Od/DADf21Y5xIsSFFLTnreczlCbuVr+v4wdwklvRbumLC77uwS5Opsl3KZGpoRPhlsnFoIJ95uRXtwbARKSKnyou+IumMGDMOm1Mjtwbrkr8wlr0iBDBno87JueibOBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VARqwU2o; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VARqwU2o"
Received: from github.com (hubbernetes-node-400e692.va3-iad.github.net [10.48.134.37])
	by smtp.github.com (Postfix) with ESMTPA id 6FF0E4E066F
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 16:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758064522;
	bh=naWDtI35xG5mpGBnnN7G8r9QS4jLCQB8nJFmF/WeU0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VARqwU2o+gsh5uVpnRxrGnuePelnE/ez/gMdwMJRK0EO97KY22Gm9pLVfZGyu+RTN
	 0pBohSPLY4uiCRov3rrj34v9utataHFWpQbk63+QWsgr4L9678e+erDPAoIH8tdGxx
	 RqILh/usCdg+kpjkBNTcy33Gwy6fvsKT2W8oG3KE=
Date: Tue, 16 Sep 2025 16:15:22 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1003112/000000-4d37bf@github.com>
Subject: [bluez/bluez] 4d37bf: transport: Fix build with VCP support disabled
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

  Branch: refs/heads/1003112
  Home:   https://github.com/bluez/bluez
  Commit: 4d37bf5e2c6dffeb821bb2bdea24666b28cad1b0
      https://github.com/bluez/bluez/commit/4d37bf5e2c6dffeb821bb2bdea24666b28cad1b0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-16 (Tue, 16 Sep 2025)

  Changed paths:
    M configure.ac
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix build with VCP support disabled

$ $ ./bootstrap-configure --enable-a2dp --enable-avrcp --enable-experimental --enable-asha --disable-vcp && make
[...]
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_set_volume':
profiles/audio/transport.c:2275:(.text.transport_bap_set_volume+0x11): undefined reference to `bt_audio_vcp_set_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_get_volume':
profiles/audio/transport.c:2266:(.text.transport_bap_get_volume+0x9): undefined reference to `bt_audio_vcp_get_volume'

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: af8266af13c8 ("audio: connect VCP profile client to MediaTransport")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
