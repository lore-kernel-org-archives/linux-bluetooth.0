Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E4EED8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510906; cv=none; b=JPGH7/fGTvM8pMkoN0blYVVN5vcgVapjFJYztic0O2S24KY6YRyZD96Eipe4wI+sPCdLe3EtnkKpGU2P1QRiDKzbkeTzN4uLplbZgtgZLrpeQ3dRoUumu77dUNz76NKs2giYd+g4ASQiULmDI1OnSrvcYyFXUmf1JaT9ozZAXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510906; c=relaxed/simple;
	bh=PKseTnxUMNcCD7okYmCN0ijQ0B66Y8nFUbBhTUhrHNk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hJ0knpiJjJX7kLFub6+ddSxTIdye6aOhb6yH7Z363l+4g1dYGKn6bYASqLO5ViGtAe1nPOywCxrIho00/RTPfONkkayML+mAG8jMzQYjB0SUdiQVteZzEWcMekb7RDBy1pcxkxObtLzC863i0U8dBnhaoGHF1JsteRQp5EI7z5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RysfO9jP; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RysfO9jP"
Received: from github.com (hubbernetes-node-a04e2f9.va3-iad.github.net [10.48.201.19])
	by smtp.github.com (Postfix) with ESMTPA id C259F3C0E2A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768510904;
	bh=IAxmp6AdG67MgNR6SwWFgcpGUif39CESBIDOjuqfzPM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RysfO9jPP9Cqx7FYiXY+h44pINS5PZElbkLxsFWWPBu+VTpPxoqlNgmJ1NUfIINBp
	 TRkgkECgJPebWhQ0du6XAbMGBK8RL33hzEVKx+CJLgKonCfyux6Ibq2SECRh8sqAnS
	 JusfESL49f/QWZzK5RbvpXZeYFD36nFc/L0nltJI=
Date: Thu, 15 Jan 2026 13:01:44 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043005/000000-e1a4fa@github.com>
Subject: [bluez/bluez] 143c00: shared/crypto: Add bt_crypto_rsi
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

  Branch: refs/heads/1043005
  Home:   https://github.com/bluez/bluez
  Commit: 143c005aee558cf5c1dd0570320af17253dd908d
      https://github.com/bluez/bluez/commit/143c005aee558cf5c1dd0570320af17253dd908d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/shared/crypto.c
    M src/shared/crypto.h

  Log Message:
  -----------
  shared/crypto: Add bt_crypto_rsi

This adds bt_cryptor_rsi which can be used to generate a Resolvable Set
Identifier as per CSIS spec:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/28085-CSIS-html5/out/en/index-en.html#UUID-4dc0c19a-2900-d43e-6ea5-e651151d3c3e


  Commit: 9bbd6c03ac3447781b41f6f44c6d0d24b5fec2f8
      https://github.com/bluez/bluez/commit/9bbd6c03ac3447781b41f6f44c6d0d24b5fec2f8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: fc2cc6d6365a0aa830d1bcc2cbe569ff6a0aef0c
      https://github.com/bluez/bluez/commit/fc2cc6d6365a0aa830d1bcc2cbe569ff6a0aef0c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/advtest.c

  Log Message:
  -----------
  advtest: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: e27379c177d3f4dc013d2aea8aee21908e8081b5
      https://github.com/bluez/bluez/commit/e27379c177d3f4dc013d2aea8aee21908e8081b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/device.c
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Make bt_ad_has_data return the data

This makes bt_ad_has_data return the data found rather then true of
false.


  Commit: fafa6f6735570ab20cd01bae86ee6519aa1fe9d7
      https://github.com/bluez/bluez/commit/fafa6f6735570ab20cd01bae86ee6519aa1fe9d7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix not verifying if RSI set is valid

The hash portion of the RSI can be verified if it was set properly.


  Commit: e1a4fafa984d6814fe7aa0c8a94d0ff39f5a7df5
      https://github.com/bluez/bluez/commit/e1a4fafa984d6814fe7aa0c8a94d0ff39f5a7df5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/advertising.c
    M tools/advtest.c

  Log Message:
  -----------
  advtest: Fix displaying RSI as a byte array rather then an address

RSI should be displayed as an address if the intention is to use big
endian format.


Compare: https://github.com/bluez/bluez/compare/143c005aee55%5E...e1a4fafa984d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
