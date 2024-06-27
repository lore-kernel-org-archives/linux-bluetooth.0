Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59493195B18
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513484; cv=none; b=NNp2yM6ugS1SNlt6ZRCWuSegiFJ1Bq9kD7nYjQieEW+zO9IUfG0RzxOcl+8cRudUal4NsQWRx3584Qr6bUU1/Lh9IJnigUc+0JK+BICzTDAB4Rrzol9P+nnOV0efacRYTnoKWUFaIb7BJGwaJrXPLrYB7/9SaAJIbmwPWqZMqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513484; c=relaxed/simple;
	bh=YoWwn+9ckklOxgITeVDnQt+9xydRahOpCtw0+hPBPIo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TMg/fR/WkD5n3GStVMxhtkCUtkykwbpWSzVnUEZ28dx223idPtTigT08C7mWf0swYL4HpuOcC2Uw2ds+FNVqkjseKTbYulwL08JOJ/74dPu8A6sPUAZEHoXUrGsIUF5kOuR/enOiJyb6WnTxKmy1A2D8HHKtho8JMIlWFeUFMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jU6OV0aK; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jU6OV0aK"
Received: from github.com (hubbernetes-node-aaf78af.va3-iad.github.net [10.48.209.73])
	by smtp.github.com (Postfix) with ESMTPA id 4C3A28C1147
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719513481;
	bh=9j6z8yFLKYcTB7Ka6qgAjv2d1M59ubHG7WTL+MOtgsM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jU6OV0aKki40McgnQm+PEbzccajU4YDWxqgHGCfzXt2Z/i76MxFBUjAZx3ihqOwXy
	 l7h+H13Wr1tKaCamVz5SpGgu7dhr8sLTTsTN4SGppH6tzJ7ODISWT1Yi0x/2sQOaVd
	 i7xbyGwzYnv20lV+SXUNF36wmGUOfQQJpdTL4qdo=
Date: Thu, 27 Jun 2024 11:38:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/944909-e3616b@github.com>
Subject: [bluez/bluez] a1e3ac: l2cap-tester: Add tests for multiple data
 packets
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
  Commit: a1e3ac87b547f8865d7ecf905c886dfed812e9c1
      https://github.com/bluez/bluez/commit/a1e3ac87b547f8865d7ecf905c886dfed812e9c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-26 (Wed, 26 Jun 2024)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add tests for multiple data packets

This adds the following tests which cover the TX/RX of multiple
packets (up to 32K):

L2CAP BR/EDR Client - Read 32k Success
L2CAP BR/EDR Client - Write 32k Success
L2CAP BR/EDR Server - Read 32k Success
L2CAP BR/EDR Server - Write 32k Success


  Commit: b6f8c0024a875f519a6f7f5642615ab02a0e2594
      https://github.com/bluez/bluez/commit/b6f8c0024a875f519a6f7f5642615ab02a0e2594
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-26 (Wed, 26 Jun 2024)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Introduce bthost_add_l2cap_server_custom

This introduces bthost_add_l2cap_server_custom which can be used to
define custom values for MTU, MPS and credits.


  Commit: 72c3f5bf1ce676a92064a21b61fc56bfea6b3361
      https://github.com/bluez/bluez/commit/72c3f5bf1ce676a92064a21b61fc56bfea6b3361
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-26 (Wed, 26 Jun 2024)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add tests for multiple data packets over LE

This adds the following tests which cover the TX/RX of multiple
packets (up to 32K) over LE credit based flow control:

L2CAP LE Client - Read 32k Success
L2CAP LE Client - Write 32k Success


  Commit: 2ebb415b12c48a727b106b6f28452cc430996964
      https://github.com/bluez/bluez/commit/2ebb415b12c48a727b106b6f28452cc430996964
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-27 (Thu, 27 Jun 2024)

  Changed paths:
    M profiles/health/mcap.c

  Log Message:
  -----------
  health/mcap: fix memory leak in mcap_create_mcl()

set_default_cb() can allocate memory for mcl->cb but it does
not free mcl->cb before exiting the function.

Add freeing mcl->cb before exiting the function.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


  Commit: bf4ec513929bda951f54cc73fabbee3a7a12e3c7
      https://github.com/bluez/bluez/commit/bf4ec513929bda951f54cc73fabbee3a7a12e3c7
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-27 (Thu, 27 Jun 2024)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix memory leak in endpoint_init_pac()

asprintf() allocates memory in the name variable but does not
free it before exiting the function, which causes a memory leak.

Add freeing of the name variable before exiting.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


  Commit: e3616b776ae0d50c94807ed970cb724518b8a47e
      https://github.com/bluez/bluez/commit/e3616b776ae0d50c94807ed970cb724518b8a47e
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-27 (Thu, 27 Jun 2024)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  plugins/sixaxis: add NULL check in setup_device()

btd_adapter_get_device() may return NULL on the next call stack:

btd_adapter_get_device()
    adapter_create_device()
        device_create()
            device_new()
                g_try_malloc0()

It is necessary to prevent this to avoid dereferencing a null
pointer further.


Compare: https://github.com/bluez/bluez/compare/944909f2b2c8...e3616b776ae0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
