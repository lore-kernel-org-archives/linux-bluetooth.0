Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCB76C85
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555450; cv=none; b=kfEVjLLpaLnyk2ZFYHw+mxNnDSJDFLWAm+cIe6RPZNliLrFVHebwof1G5ro+BOMrI9AclN4SVdAephXnx+GV81nJ90sfMnRqFvfI7oIVjJlhvMJnbtlylLSTMO+h+i7WjOydlNm8le9BiArxCh/MzLvkBgob+tUPOjT7vUZYx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555450; c=relaxed/simple;
	bh=8I/oPe6dJDtOhn60bg0ucaNST8bFnMkTFwCXXIl+mtQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AgRDd4eyTPVn06vFVxo2b71mOES3tXfj0kGIZGwQGt0yGGZ5/yP8NZ/RvyrWy9kGJzwOAoAQSaSMZ9rG6Up2gd12Epk/i94w8oZTWgTvlhSfOGvyA6LBj/neg3sFvXQl0+ROJxtwqTjiih86sOlEfTr4jxHz4tAmjwtPVCGBmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CIJGoqP7; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CIJGoqP7"
Received: from github.com (hubbernetes-node-093a6c8.ac4-iad.github.net [10.52.221.42])
	by smtp.github.com (Postfix) with ESMTPA id 08E145E05C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706555448;
	bh=/nChy4hs/X8CAlr0dIOu9hvqLKPIOcvh6MjgEMg2oeA=;
	h=Date:From:To:Subject:From;
	b=CIJGoqP7JKCZHH3GKRc1SzTeqQO+jMd5k/pjdsmRFAfcGa4ncHMtJcs+ROY7Am1mZ
	 G81kPXZmKwAqazOIB4jdv9jv2VHkX+ntxMYBWhRi2Px8iuwbW/dRDlVdRc6V6pu+0l
	 wc7REUlvFZGx/AE+qmBrQWuDmr9+RF0JfW4SyB64=
Date: Mon, 29 Jan 2024 11:10:48 -0800
From: Emil Velikov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0de32f-f59f49@github.com>
Subject: [bluez/bluez] 2a5c9c: configure, README: introduce
 --enable-external-plu...
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
  Commit: 2a5c9cf632e65b9935ae3bcb7a3dc92b1d580b30
      https://github.com/bluez/bluez/commit/2a5c9cf632e65b9935ae3bcb7a3dc92b1d580b30
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-26 (Fri, 26 Jan 2024)

  Changed paths:
    M README
    M configure.ac

  Log Message:
  -----------
  configure, README: introduce --enable-external-plugins

As the README chunk says, disabled by default, since they rely on
internal API/ABI and can break at any point.

Instead everyone affected should work and upstream their plugin into the
bluez project.


  Commit: 004b5b28a04c52e26ad5cafbb53a586a722ce3ab
      https://github.com/bluez/bluez/commit/004b5b28a04c52e26ad5cafbb53a586a722ce3ab
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M Makefile.obexd
    M obexd/src/obexd.h
    M obexd/src/plugin.c
    M obexd/src/plugin.h

  Log Message:
  -----------
  obexd: factor out external plugin support

As a whole all plugins should be built-in, otherwise they would be using
internal, undocumented, unversioned, unstable API.

Flesh out the external plugin support into a few blocks and simplify the
normal path. Guard the external plugin support behind a runtime check,
which will be dead-code eliminated in the default case.

Hide the internal API (omit export-dynamic) when built without external
plugins.


  Commit: 1db7a00e35c48efa48d4cb6a8510e76081270782
      https://github.com/bluez/bluez/commit/1db7a00e35c48efa48d4cb6a8510e76081270782
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M Makefile.am
    R plugins/external-dummy.c

  Log Message:
  -----------
  bluetoothd: remove external-dummy plugin

The external plugins infra is getting deprecated and disabled by
default. Remove this dummy plugin.


  Commit: 9f71892b63f6b65dab874a633d88ae2dcad93a16
      https://github.com/bluez/bluez/commit/9f71892b63f6b65dab874a633d88ae2dcad93a16
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M Makefile.plugins

  Log Message:
  -----------
  bluetoothd: convert external sixaxis plugin to builtin

Convert the only known external plugin to built-in. It's a tiny 20K
binary that distros ship a separate package for.

Make it a builtin, which allows distros to drop the separate package, it
also enables us to compile out support for external modules - both in
terms of extra code and hide the internal bluetoothd API.

This means that libudev.so is pulled in, which is fine since its ABI has
been stable for over a decade.


  Commit: 109cc8a0f6aa1458481f57c106a01357d9dff7d0
      https://github.com/bluez/bluez/commit/109cc8a0f6aa1458481f57c106a01357d9dff7d0
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M Makefile.am
    M src/btd.h
    M src/plugin.c
    M src/plugin.h

  Log Message:
  -----------
  bluetoothd: factor out external plugin support

As a whole all plugins should be built-in, otherwise they would be using
internal, undocumented, unversioned, unstable API.

Flesh out the external plugin support and simplify the normal path.
Guard the external plugin support behind a runtime check, which will be
dead-code eliminated in the default case.


  Commit: 7a1d3c7c4bc708b5989ff5a08c83e3c512941445
      https://github.com/bluez/bluez/commit/7a1d3c7c4bc708b5989ff5a08c83e3c512941445
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  bluetoothd: don't export internal API

... when building without external plugins.


  Commit: f174724c76c6c8b91276f444142fed9c2537e5c1
      https://github.com/bluez/bluez/commit/f174724c76c6c8b91276f444142fed9c2537e5c1
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  bluetoothd: change plugin loading alike obexd

Currently, we print "Loading foobar" for every plugin, before we try the
respective init() callback. Instead we handle the latter in a bunch, at
the end of the process.

Do the init() call early, print "Loaded" once it's actually successful
and drop the no-longer "active" tracking.


  Commit: f59f4902bc4ea0bf5f1fed2b1e5e2f4ed52f0cb5
      https://github.com/bluez/bluez/commit/f59f4902bc4ea0bf5f1fed2b1e5e2f4ed52f0cb5
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M android/Makefile.am
    M android/hal-audio.c
    M android/hal-bluetooth.c
    M android/hal-sco.c

  Log Message:
  -----------
  android: export only (android) entrypoint from the modules

The android specific modules, have a designated HMI entrypoint. Hide
everything else with -fvisibility=hidden.


Compare: https://github.com/bluez/bluez/compare/0de32f67f685...f59f4902bc4e
