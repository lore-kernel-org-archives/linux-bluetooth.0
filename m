Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C927FB2D
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423382; cv=none; b=nSSEf1/5yjhplyt6dzTOGO/MznThUbiyWlT97s+bHw0xbZG9TxDzEB0nWNuneODDkFSE+2DAL/5ueAVw5ut+FKNYyC8hsZp2AxaAptLL924ELqmDjnJJNKfh7DwdfKZh0kKu1BmleS934D1WFvb+MbRXJc4CyuSvlonjRuZ7uKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423382; c=relaxed/simple;
	bh=6WbkfyP3DpXqZYVaJKvVENuCe7gMwSrOjuIj/vZoLpc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lfn5IL4KV9PQ+eHKPple6bmICYvXs24vjarPJwuIjKl1JuPf/QlOA0TlVNGWWa5RhwUqyoZz5Yv8OJsBN692PR5bvFKhgAQBLUyQuwcd74vui5RCI67g8JniVsQNGFoGVXeS/rZBqICycosWRLD5ya22+9/WtT0PG/FD3+b6Ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dCYdsT/I; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dCYdsT/I"
Received: from github.com (hubbernetes-node-501fe52.ash1-iad.github.net [10.56.166.32])
	by smtp.github.com (Postfix) with ESMTPA id 4861F920794
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747423380;
	bh=5LXhoSv6ASivz5nXpC9Z9mqvunZYBOMv70P724k3ILg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dCYdsT/I34TMXzvGvL1l3FSYdVklZaNc/KvqQx+5YWEuQSThHbB3uhmrEfjFnKXkG
	 P5uDZ4G5U1pS4SO+9AnS2MAWYUSnoLklSNYAJgmsFJMq1VGwQK2LFH7BEVxoGZrExP
	 oBpF18BFPmaUBH2TkfOfqlsT9xmXV9d9F27NFm0k=
Date: Fri, 16 May 2025 12:23:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963746/000000-c4c314@github.com>
Subject: [bluez/bluez] 544138: avdtp: Fix setting in_use flag for local seps
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

  Branch: refs/heads/963746
  Home:   https://github.com/bluez/bluez
  Commit: 5441383c657676d6a67c629b166778bed220316f
      https://github.com/bluez/bluez/commit/5441383c657676d6a67c629b166778bed220316f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Fix setting in_use flag for local seps

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.


  Commit: c4c314de11b951e63d20aa10211a57db1361065b
      https://github.com/bluez/bluez/commit/c4c314de11b951e63d20aa10211a57db1361065b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  a2dp: Fix a2dp_sep mapping to a single stream

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064
Fixes: https://github.com/bluez/bluez/issues/597


Compare: https://github.com/bluez/bluez/compare/5441383c6576%5E...c4c314de11b9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
