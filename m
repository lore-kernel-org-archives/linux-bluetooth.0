Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262615530C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517583; cv=none; b=Q5xqZLIbTn0E/7C2GLybraDU91Yxf2mKrFSc4dqCAoSMfSDmevliGwXBuGynv+641uW/ul9UBA7U+ZdX0TMyCePCB4fOLwqYVp4O3KA4lv+bANAP6y8yj59rHhOj3PR0LPrMfLYa8+z0ILQ2Qyq5qQy5L0gjuNc52u1kDoNfiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517583; c=relaxed/simple;
	bh=NBAfMoqyHtE2sX10u8WfOnsNzVTsrKx0LTsa/+G+ZZc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VVAozmbJS/EhjKmdNPXeyEZexZHh1kelPyVZZ+/495HT5e8ebW71r8VVykVD53lzVRTpo/k0jxxb6tvfh3CTf2ig0Z2ZOeHomS7+QNZA/5sT78z03SNyHbCnWFVdb52N5DnZW3ZyMJScvRvs+DAPTJ1u/+xeVhVKrhAlIPHfugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WH1SbiEO; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WH1SbiEO"
Received: from github.com (hubbernetes-node-fd612dd.ash1-iad.github.net [10.56.155.23])
	by smtp.github.com (Postfix) with ESMTPA id C7279921182
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768517581;
	bh=rQz1qOTwMPlsRXnYXuqpmuYBcDvy7sucazievEhP3JQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WH1SbiEOWBVPnVsaXgXHXurZm919gN4dUvgOxLirO1fnAEbXMbPoO9/tv/4koZg3z
	 rqg1d4H3Xv8HTkBwCjaMb4Q3BqlOejc5fNH9O6RxEbV1/qgeYIkeQetEnX3y7n24aP
	 JnQ24lRBtzq02r75KVWdRqTe7voQqyGZ6p0xBHX0=
Date: Thu, 15 Jan 2026 14:53:01 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fe7094-62fdc1@github.com>
Subject: [bluez/bluez] 07bd0d: shared/crypto: Add bt_crypto_rsi
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
  Commit: 07bd0d60bceffff8c8f6d3343f960a5ec8dfd32f
      https://github.com/bluez/bluez/commit/07bd0d60bceffff8c8f6d3343f960a5ec8dfd32f
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


  Commit: 4ab2161b53289c0eb6a3167da0aa4ea899bbc26f
      https://github.com/bluez/bluez/commit/4ab2161b53289c0eb6a3167da0aa4ea899bbc26f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: 6d79d8a3a64342ece72a40478a76e7b1a5eb8dd8
      https://github.com/bluez/bluez/commit/6d79d8a3a64342ece72a40478a76e7b1a5eb8dd8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/advtest.c

  Log Message:
  -----------
  advtest: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: acc0a1d1c4eb1b1f08eca32e03392968c2fe65a1
      https://github.com/bluez/bluez/commit/acc0a1d1c4eb1b1f08eca32e03392968c2fe65a1
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


  Commit: b9daa6718bdddc54d47eb128578bcfbe0baf1f45
      https://github.com/bluez/bluez/commit/b9daa6718bdddc54d47eb128578bcfbe0baf1f45
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix not verifying if RSI set is valid

The hash portion of the RSI can be verified if it was set properly.


  Commit: 62fdc13ed2efb9f95c42f0b5ca6d773730d62eb1
      https://github.com/bluez/bluez/commit/62fdc13ed2efb9f95c42f0b5ca6d773730d62eb1
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


Compare: https://github.com/bluez/bluez/compare/fe7094da8081...62fdc13ed2ef

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
