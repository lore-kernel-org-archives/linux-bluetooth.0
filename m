Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2281482EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806377; cv=none; b=L7dcnBViZyi7h6nCqFPrrZUQRTxsrGXMiIxCEt3e8YR0y65Box5Q4+qN9KXUWHQ8pxKPIqmmF+2dyV1nNDY5SneRyIf9z/hyLrlxJhn5Bd/v/S0ROWUvelCEPR35z6xWnrgrqAeYIeUxN3f4lEEjftXXAMI2MdXBVhYTMb0WSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806377; c=relaxed/simple;
	bh=Sw6jGwn50m9Fwky10p2Ywx5iwpookLDB2/sQOfrR4zc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a8KIdS+Rd/KDqMItc9I4Cn4352usDBZZQcQfAXWOfGwNBhMhs/dZ69bGaOUGLQ6wA7NmiLFUDzSi3V0E1X/lt//FiYfM6oLmEj/ObWcb2uQLP3V6584qqv3nSJ2lZiTjxuzlaWXedDD1FIyJ6T6tmQuWWtGea13Yc3KNgHBfANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=buNYl+T2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="buNYl+T2"
Received: from github.com (hubbernetes-node-e8bae5f.ash1-iad.github.net [10.56.148.33])
	by smtp.github.com (Postfix) with ESMTPA id 47F1A1411B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718806374;
	bh=ocUKGI7k2BkQk/Rv3eSEwQRm80O4/eSCLmH8bZZIFCM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=buNYl+T2ywfao0ZH3DGROqOeY0Zm9No+GR4gKEmTtXKlTChUddaPU7TMvcCvbYhVv
	 0pO+w5jRAxWYnZNiz2PUGCb6WnNxtM5Lj7JWoC4bj5F+aidokYA5w58MS3fQAE5jCE
	 eXNRXjuinDlNQ4a14Pkzn7o8hJNBt1OWbssjrlM0=
Date: Wed, 19 Jun 2024 07:12:54 -0700
From: ykharuzhy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/52bda9-811e48@github.com>
Subject: [bluez/bluez] 0dc5bb: gas: Fix reading attributes on every connection
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
  Commit: 0dc5bb2ed6798c25a451516f95c747a60014978b
      https://github.com/bluez/bluez/commit/0dc5bb2ed6798c25a451516f95c747a60014978b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-18 (Tue, 18 Jun 2024)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  gas: Fix reading attributes on every connection

Attributes only need to be read once after that they will be persisted
by the core so there is no need to keep reading them on every
reconnection.


  Commit: 503ecbc655c5115a09ae1b1fc2cde3fe5bda9203
      https://github.com/bluez/bluez/commit/503ecbc655c5115a09ae1b1fc2cde3fe5bda9203
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-06-19 (Wed, 19 Jun 2024)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add util_iov_new function

This adds the util_iov_new function that allows the user both allocated
and set an iovec to the desired value, using only one function call.


  Commit: 5ec05848a9d441603a1d34ca184e2c470f0bfd62
      https://github.com/bluez/bluez/commit/5ec05848a9d441603a1d34ca184e2c470f0bfd62
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-06-19 (Wed, 19 Jun 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Use util_iov_new when setting bcode

Currently the broadcast code is set without memory being allocated
for it resulting in segmentation fault. This fixes the issue by using
the newly created util_iov_new that allocates the memory before
setting it.


  Commit: a91471400f9702ff0126c016771661878cd84781
      https://github.com/bluez/bluez/commit/a91471400f9702ff0126c016771661878cd84781
  Author: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
  Date:   2024-06-19 (Wed, 19 Jun 2024)

  Changed paths:
    M src/shared/mcp.c
    M src/shared/mcp.h

  Log Message:
  -----------
  shared/mcp: Implement next/previous track commands

Add bt_mcp_{next,previous}_track functions to shared MCP client
profile code. This allows user to have basic control of the media player
in addition to simple play/pause/stop actions.


  Commit: 811e48d340d8cb8dcc3313555a6c4173d41a69f5
      https://github.com/bluez/bluez/commit/811e48d340d8cb8dcc3313555a6c4173d41a69f5
  Author: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
  Date:   2024-06-19 (Wed, 19 Jun 2024)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: Implement Next Track and Previous Track commands

Add implementation of Next/Previous Track commands to the audio/mcp profile.

It is used by the Bluetooth media control widget in KDE, for example.


Compare: https://github.com/bluez/bluez/compare/52bda9d45572...811e48d340d8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
