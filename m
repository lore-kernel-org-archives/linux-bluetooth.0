Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3F415F33
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798070; cv=none; b=a6SAIem1FEqLB8L7gHxrRg8dmEPFEXEpJ0yZiQwhAGD6cTOtYNNViFUvznOhTtRqHSKPB9w74iemt/jFGuQas1xqKsctH3kdqWW3eCKJxw+Bl0FxCTfNlJrxu3k2j40SRET1lTaXquJqCtJDJPqFSyfabYqZC7Qkhe+MUz672Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798070; c=relaxed/simple;
	bh=5cobObo67litWc+XqKKJgaBWM1tCoVnCM4oPvqXQdgs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sx1fVUwzufWRStUlh4mfPQ/s53i7yNCC0SI8eEBpZKAXf82RKgPMphLbPUwJANF37I2dVfPc2/heGpDkRL4tQMEpPsdEzBCougjhSAKeJum+9CRAmjBGxlPz51k+Utd3F2mOU+1Rte9Qhf0UbO4GiHeYebxAHLwx6QyJ+6JwgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GwJdjxI9; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GwJdjxI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784798068;
	bh=cm3WV2SPNzuNAzo0QxjKVJjsraS29Wnj0QTAF3GuhcM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GwJdjxI9p+ou9SW7wK2Ww0u0fH4sLCovCbaqrlqJdB2WTuBu5pit4tNFTuOtci0Pc
	 SRxP/BtfQ84K60GgYseHdxy7nuN0Wo0CWk7C9MDFSsZpsdP9f2gxsZPlvU8r65KJIZ
	 5cpLiTd9TvGsFcoxG1bGjvjc6tTk7UvY9ip4j0Os=
Received: from github.com (hubbernetes-node-1ef4b52.ac4-iad.github.net [10.55.98.27])
	by smtp.github.com (Postfix) with ESMTPA id 0E0C03219BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 02:14:28 -0700 (PDT)
Date: Thu, 23 Jul 2026 02:14:28 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133038/000000-bf6289@github.com>
Subject: [bluez/bluez] bf6289: sdpd-request: Fix unchecked malloc
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

  Branch: refs/heads/1133038
  Home:   https://github.com/bluez/bluez
  Commit: bf62891924e0912af0135e5518fcf957b202d91c
      https://github.com/bluez/bluez/commit/bf62891924e0912af0135e5518fcf957b202d91c
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-07-23 (Thu, 23 Jul 2026)

  Changed paths:
    M lib/bluetooth/sdp.h
    M src/sdpd-request.c

  Log Message:
  -----------
  sdpd-request: Fix unchecked malloc

Fix unchecked malloc in request processing in service_search_attr_req()
and process_request().Also add SDP_INSUFFICIENT_RESOURCES (0x0006) which
is defined by the Bluetooth Core Specification but was missing from sdp.h.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
