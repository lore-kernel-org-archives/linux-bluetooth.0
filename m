Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A64332EC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259291; cv=none; b=HRYT7bX6XEIaCO0AwEm0oZc0P2sNfysP83478KD3s/ierrU+5z8G3Wcp1t0dFiHJLw1MI5WqD7S3UWvrK+of6+2bEgcELRe4r8GQeH5qdOHJTjUA0UbfBu0F8TkXPbxhDUn+feeNItPyAXShRfIIo7ASBk6kXpVaydZFx2cdRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259291; c=relaxed/simple;
	bh=EE8J6LzI4G/7gtTVZYLGuPtsMVtRtgRF/zvlb1CajRo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SC05ARuQFv8CVMoSYAgmoAvH7CUqyYNUnHHpDjugX6H22feWG0l7CFSrQt4b6MokpIWyyObNr7Ihx2v/xNpOkU+hIlgB28rrCde+0hfgFFwV7c3jNWidEDnX+Ffd0aNmLTvTROTAc+GXnGm0DkjpjT/+Mak5Cgc26+MxC3FDIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Cgqp+9qn; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Cgqp+9qn"
Received: from github.com (hubbernetes-node-b799553.ash1-iad.github.net [10.56.14.57])
	by smtp.github.com (Postfix) with ESMTPA id 2601C6002C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771259289;
	bh=N5d54M/nxXMzdU978m3VK1E1dB1xEwHh64kx+sm5vOk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cgqp+9qn83USCU328QlNGTfqf3YR4cNnYXZgHcX0GcJGHFtOGikQ3RZeGBYxX85Ef
	 YAlQLmcMvyYZ/EsmBglRpqbrHu7KcMnB85uMhVr1EfvYLt7mqxgynorWXKzUA6dTzK
	 msMagmXdE4CenqhJucJ7TKKATtzzSceT2kg6S8fM=
Date: Mon, 16 Feb 2026 08:28:08 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054617/000000-25a493@github.com>
Subject: [bluez/bluez] 25a493: a2dp: connect source profile after sink
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

  Branch: refs/heads/1054617
  Home:   https://github.com/bluez/bluez
  Commit: 25a493547bd3450af0acf80e64a6c9622bda8c76
      https://github.com/bluez/bluez/commit/25a493547bd3450af0acf80e64a6c9622bda8c76
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: connect source profile after sink

Since cdcd845f87ee the order in which profiles with the same priority
are connected is the same order as btd_profile_register() is called,
instead of being the opposite order.  When initiating connections, we
want to prefer a2dp-sink profile over a2dp-source, as connecting both at
the same time does not work currently.

Add .after_services to specify the order.

Fixes: https://github.com/bluez/bluez/issues/1898



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
