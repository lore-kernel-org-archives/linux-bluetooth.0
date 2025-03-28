Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10B14D70E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196406; cv=none; b=T0eJl2LcS3e/Wl2dRFDt36YqUr0XDUBhERzpBYWs35jpU/liVVnJJWc+H94UnFNhQlqbC6a3wds5fYbMWm9Jz7+xBqzt6Hm4b7HJe/SX3Ph9gvFD0QBRl9BP2xgfR+EtNHd8VNl9aI7s3hJpj8vZcmioMV8orzZ3g9Gt+pc8dhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196406; c=relaxed/simple;
	bh=XvTF6VKxjqjTam8HovwiaMQHybFPf5sO5N1EAvN/Lao=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uNkiM1OVWPjGJVyAbRS91i76Z/rzew9OUlJT9sbYWW6+KcqO9uOeXyjCKS993pFeR3kbGm4/mUkRrZUnEQNy6dOa51XyNaoTEs8w5TRu24z2cttGAZedkRDrcgECp0l+TVYRg6pdd8sryXoQK/GRFJPLgmIvF3zLT5txrkj25TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aR1ND3/C; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aR1ND3/C"
Received: from github.com (hubbernetes-node-398b48c.ac4-iad.github.net [10.52.133.33])
	by smtp.github.com (Postfix) with ESMTPA id D52976404E5
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743196403;
	bh=YDn96BO9VdvY2JnhwXrFudNapgIFInliOtOkw9ntRzg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aR1ND3/Ckjsuo2Z+8yEKeGbv9ZSWU4m2k82+2kZ+FHtk1ndim6b4DwX05MxZxavBu
	 zt2h0UleQlH35d8rkYKPi46v/j8YJdl1AtieYC3grfWBjz8g8yzWzBnxtlNUEiphsE
	 YIEMsZiaZYgIa8YmZ+poskLhW/Ty2YyHm6soUOkM=
Date: Fri, 28 Mar 2025 14:13:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/78aabd-d9430c@github.com>
Subject: [bluez/bluez] d9430c: client/player: Add support for setting BIS ID
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d9430c0635bc36177d521d62a51f0d2a4e8c0fbb
      https://github.com/bluez/bluez/commit/d9430c0635bc36177d521d62a51f0d2a4e8c0fbb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-28 (Fri, 28 Mar 2025)

  Changed paths:
    M client/player.c
    M client/scripts/broadcast-source.bt

  Log Message:
  -----------
  client/player: Add support for setting BIS ID

This adds support for setting BIS ID in addition to BIG ID:

[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] BIS (auto/value):



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
