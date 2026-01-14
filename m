Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3C3A4ADE
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427691; cv=none; b=Dcdnde5FlV85OXjNDuSmpDgoTLncA9ltPChB8+y47zSQwDSGFbT9sJRTWdYY3WcnY7J7tqTEWpyo1zp9AQJNfxUBOzJBYy4+Gub1HTQR22zsUY6+FpVwlbYjQkBTxLqbnzLIwz/sLSJMckA76xFodF2oHffEMNzYOqSTJ3TkgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427691; c=relaxed/simple;
	bh=7XDI9li8L3UW247ntABxuWJbbv+9/4bEDoFWySf4L1A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SQqlXSFaErc3RbcBLnap+bztlK1pr62KgaR2xletI+10FCTkA2Ooit/EKRj8R7zGo6PArKVeWQfTA+WoxvzVGf3hspMAepimLdukcTl813R4ZnWRAr1f/4xXSm3PVB7ZqcyR+vZpEmPkVPdJczlrfx90vPftcaJfkkpPjBY60o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wrg/yRva; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wrg/yRva"
Received: from github.com (hubbernetes-node-3263c14.ash1-iad.github.net [10.56.131.82])
	by smtp.github.com (Postfix) with ESMTPA id E1B2F601257
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768427665;
	bh=ZmlbWvi9DcEjkpSL8dzKYp7X1+IR7fPQNDpf+8TICEU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wrg/yRvacpKzXC99YT5cH5Y+bn8e35dTYLlmvlzXubUSv54y3Br4YsGmDTF4KdaaC
	 joW0Tglo9fatasOdd/abNCXmBdnmZyIeMCK4M+CrXxzseCR4ELsd4Gk87h//UBnYI3
	 270u2SZBgvh5y0cVWmtjohUPbpH7HSh/w0QJEk+8=
Date: Wed, 14 Jan 2026 13:54:25 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042511/000000-0ae390@github.com>
Subject: [bluez/bluez] 860724: shared/crypto: Add bt_crypto_rsi
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

  Branch: refs/heads/1042511
  Home:   https://github.com/bluez/bluez
  Commit: 8607248ae3d5aed495b750b6d67bd16ce52220b7
      https://github.com/bluez/bluez/commit/8607248ae3d5aed495b750b6d67bd16ce52220b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M src/shared/crypto.c
    M src/shared/crypto.h

  Log Message:
  -----------
  shared/crypto: Add bt_crypto_rsi

This adds bt_cryptor_rsi which can be used to generate a Resolvable Set
Identifier as per CSIS spec:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/28085-CSIS-html5/out/en/index-en.html#UUID-4dc0c19a-2900-d43e-6ea5-e651151d3c3e


  Commit: 6e9787c231576afebb05fb12dd564fee8655a29e
      https://github.com/bluez/bluez/commit/6e9787c231576afebb05fb12dd564fee8655a29e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: afa931b33af8a8f1e15993529857ef9399d38cb7
      https://github.com/bluez/bluez/commit/afa931b33af8a8f1e15993529857ef9399d38cb7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M tools/advtest.c

  Log Message:
  -----------
  advtest: Use bt_crypto_rsi to generate RSI

This makes use of bt_crypto_rsi to generate a valid RSI.


  Commit: d4f716f13454acad1596e1dc044754086b849aca
      https://github.com/bluez/bluez/commit/d4f716f13454acad1596e1dc044754086b849aca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M src/device.c
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Make bt_ad_has_data return the data

This makes bt_ad_has_data return the data found rather then true of
false.


  Commit: 235992d1574335e3657f95d21ea328bc8c959bd6
      https://github.com/bluez/bluez/commit/235992d1574335e3657f95d21ea328bc8c959bd6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix not verifying if RSI set is valid

The hash portion of the RSI can be verified if it was set properly.


  Commit: 0ae3907e956aa906912f147d13b6980ce008609a
      https://github.com/bluez/bluez/commit/0ae3907e956aa906912f147d13b6980ce008609a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-14 (Wed, 14 Jan 2026)

  Changed paths:
    M tools/advtest.c

  Log Message:
  -----------
  advtest: Fix displaying RSI as a byte array rather then an address

RSI should be displayed as an address if the intention is to use big
endian format.


Compare: https://github.com/bluez/bluez/compare/8607248ae3d5%5E...0ae3907e956a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
