Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17491FAC4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749107752; cv=none; b=JjX1SXXreqqjQoZGOdRJwKz58EfbLumKgC3rPjDTL5Wb2s3vU8UPgMs3rG/fl+CgQO/mb6bk+pwuKDbBqFl+h5BhC1wMkFakJhhkTUS4VsooqghihnUNW56LMDVy+dw6qcS4MdXGRmc8pt+il5kYuCZU9ltbUdDSA9kZ7XJ75VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749107752; c=relaxed/simple;
	bh=VYZbeuE8Djb0Oyy/QaN5RiTeNJOkEkr7aIhfsiQrIIo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZKlehRuwXCblXnxtck/3TOSD/sERmpnGgIHOi0aQrYGUytkT84TeEFc+iDeHdByLRhkx09xMLiooHHJ8VMkhAQxxcuAxEXAJAKdoAaw03web7k1wUIchMqSbK0DsxXTV+N15kYt8wISSer9laXnbKqXAPK8t/mzu/4zI8lBmyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VZ6eMhwf; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VZ6eMhwf"
Received: from github.com (hubbernetes-node-e54cda0.ash1-iad.github.net [10.56.175.26])
	by smtp.github.com (Postfix) with ESMTPA id 9987B920C5D
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749107749;
	bh=fq5gBUq0IVBWCTYeH43WkhlMnWNE7Y4mdjMgzkh9sw4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VZ6eMhwfAuKKpVj71UdoKIMQ5FQqK27ttr/2QEbROYex8T20K5NKalmFKYOhAzvce
	 oKX9kyZHSyE8DimE89TxZt9fqx10lczlG9bJymyxOTl4eHyWWS40qnSxwu/weP6Gh6
	 4ZoYsUr4gjZ0of5AiqItJ45962EqQce8T8/BSx88=
Date: Thu, 05 Jun 2025 00:15:49 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968819/000000-5fa8c9@github.com>
Subject: [bluez/bluez] 5fa8c9: monitor: Add support for decoding Channel
 Sounding
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

  Branch: refs/heads/968819
  Home:   https://github.com/bluez/bluez
  Commit: 5fa8c9260666e79a241abf8b2fcb9ea8edcd6513
      https://github.com/bluez/bluez/commit/5fa8c9260666e79a241abf8b2fcb9ea8edcd6513
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for decoding Channel Sounding

Add initial support for decoding commands and events of Channel
Sounding, a new feature introduced in Bluetooth 6 specification.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
