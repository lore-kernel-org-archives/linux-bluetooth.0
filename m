Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95A2222A9
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531858; cv=none; b=VqGD3iE3i1agb8kTpzab+5kBvpIJZzYOkMA7dT2GcnP3LhGgQATeHGUCLc1oi91h8cG+CCGsHTubtAwF19CIrT2+SjzgT3JlRfJxr6YyJUTZVZrP5j8XQVF5F64L07PDaU+qLWStGjJkxXfccwlDwUtVqwlOj4F2dF2rcv5A334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531858; c=relaxed/simple;
	bh=UZ4txW4sKTGc/Ldsya9xVJyzFIMf3O1PsmfOttytJbY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t3Kj48zkhYNcpOFGnBnU61j26wkyxQJtF4X8CF3s2+Q+csma63o54UBMF1aDYuZRFKWGcZ15xEhstwbV1slWp4fvHZ1MxSE50RRgtgXNA+WjCLqtGKxrNDRsMYDw6ReGiMtEyj8ZPEVqG4dbk99SSI7GWhi447KrgGX9dup0IdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PkNZVMJi; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PkNZVMJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776531856;
	bh=BF1H1OTqXvAk6teFNgM8bR3IS+cn+u2TddR7mZ1q//I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PkNZVMJi2KTepmjAlOtiexibQ67PXTYY4QCqVskb7SFBOrThF+giFFuP/FaZUZP80
	 ce0EOIEaVewJODBRaoluREipQIZy+utroSqlSz6a3AvMTljiSWUOdx/H3xzxQpmLN2
	 I5azgdixK2FnuskRxwCBbE9M0jg28Id6KJiQR3d4=
Received: from github.com (hubbernetes-node-74200ef.ash1-iad.github.net [10.56.203.48])
	by smtp.github.com (Postfix) with ESMTPA id 5A9D9921096
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 10:04:16 -0700 (PDT)
Date: Sat, 18 Apr 2026 10:04:16 -0700
From: Bobberino <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082814/000000-68f99e@github.com>
Subject: [bluez/bluez] 5c66c0: adapter: add DisableDiscoveryOnConnect option
 for ...
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

  Branch: refs/heads/1082814
  Home:   https://github.com/bluez/bluez
  Commit: 5c66c091c37c1a360ad4e7dc46c1db337bd85c2d
      https://github.com/bluez/bluez/commit/5c66c091c37c1a360ad4e7dc46c1db337bd85c2d
  Author: StefanCondorache <condorachest@gmail.com>
  Date:   2026-04-18 (Sat, 18 Apr 2026)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: add DisableDiscoveryOnConnect option for combo chip coexistence

On systems with combo chips (shared Wi-Fi/Bluetooth antenna), background
LE scanning for auto-connect devices competes with active connections,
causing audio stuttering and Wi-Fi packet loss due to antenna
multiplexing via Packet Traffic Arbitration (PTA).

Add a DisableDiscoveryOnConnect boolean option to the [General] section
of main.conf. When enabled and an active connection exists, the option
suppresses adding devices to the kernel auto-connect list in
adapter_auto_connect_add() on kernels supporting KERNEL_CONN_CONTROL,
and gates trigger_passive_scanning() on older kernels.

The option defaults to false to preserve existing behavior.

Signed-off-by: StefanCondorache <condorachest@gmail.com>


  Commit: 68f99e7bf5dcf29b184e1f6700ee97515927582b
      https://github.com/bluez/bluez/commit/68f99e7bf5dcf29b184e1f6700ee97515927582b
  Author: StefanCondorache <condorachest@gmail.com>
  Date:   2026-04-18 (Sat, 18 Apr 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: remove connected device from kernel accept list on connect

When DisableDiscoveryOnConnect is enabled, remove the device from the
kernel accept list once it has successfully connected. This prevents
the kernel from continuing background LE scanning for a device that
is already connected, eliminating antenna contention on combo chips
with shared Wi-Fi/Bluetooth radios.

The device is re-added to the accept list upon disconnection to
restore auto-reconnect capability.

Signed-off-by: StefanCondorache <condorachest@gmail.com>


Compare: https://github.com/bluez/bluez/compare/5c66c091c37c%5E...68f99e7bf5dc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
