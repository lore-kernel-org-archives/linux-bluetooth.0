Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54784416867
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798072; cv=none; b=R9UfKAEz0K/Mmxt0DWe8AMNYDGrbvDLDnlwpxjJbYyVs89uuiQyt/py57yvO/ufXhU1TsJ1xID0x2/5u+7tHwYAhHUxV1R0u0nqjiE1Yu/WQxa8QgoorSWUxUhgwYiVFIJTDQUCu8PZwXDWPuCOOux2nOydlJZIMH6mrIfKwGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798072; c=relaxed/simple;
	bh=Pl6kdsvXODAkGx1w9Y51LA5Td+AHk0mq6zQb9YRZmQI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cH1J9EvOYyojl+erDGuJ0ZwrFwD4KdlgBhD7Sjq++eaUhAiwYh3qixdn+Q95k4SGn/aEI4m7yQPGRcwdRfSw0/N8fxHSaALEblqQERYDGOrr4lVcQtpVRD2Ss7y7ZCrlTSd8W4TNLhIgRQ06WN1DYp+Gl0gyVfKKbyuHtD4+jpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rhko3Z6Y; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rhko3Z6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784798070;
	bh=gu+vJdKUkaOxvAi9isuL233BHYpdHHNYatPiOcyl+G8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rhko3Z6YcNLLkKc1tQvNGY+zO2GC3X8ef3HYXA+wApNSiM+0oEevjeew7LrIrXAl9
	 MrVx7BG4kWzHUAlj+DbaNVXf2bjIP3I7R3ZJn/6D+YvP5W3IxRZmJIP45fSEcpMs61
	 pfQG6Ee3bME4wZVa5GmV0dbtzcyoEKKTARfgu864=
Received: from github.com (hubbernetes-node-e29704b.ash1-iad.github.net [10.56.206.39])
	by smtp.github.com (Postfix) with ESMTPA id 4BE348402F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 02:14:30 -0700 (PDT)
Date: Thu, 23 Jul 2026 02:14:30 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133053/000000-faa9d5@github.com>
Subject: [bluez/bluez] faa9d5: lib: Add bt_realloc
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

  Branch: refs/heads/1133053
  Home:   https://github.com/bluez/bluez
  Commit: faa9d5c52f9083c39c6bae7c3eef18de3b6910f9
      https://github.com/bluez/bluez/commit/faa9d5c52f9083c39c6bae7c3eef18de3b6910f9
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-07-23 (Thu, 23 Jul 2026)

  Changed paths:
    M lib/bluetooth/bluetooth.c
    M lib/bluetooth/bluetooth.h
    M lib/bluetooth/sdp.c
    M src/shared/ad.c
    M src/shared/bap.c

  Log Message:
  -----------
  lib: Add bt_realloc

Add a bt_realloc wrapper that takes a pointer-to-pointer and only updates
the original on success, so that a failed realloc cannot leak the
existing buffer or leave a NULL pointer for the caller to dereference.

shared/ad: use bt_realloc in bt_ad_add_data(),
           bt_ad_add_manufacturer_data() and  bt_ad_add_service_data().
shared/bap: use  bt_realloc in ascs_ase_rsp_add().
lib/sdp: use bt_realloc in sdp_service_attr_req(), sdp_process() and
        sdp_service_search_attr_req().



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
