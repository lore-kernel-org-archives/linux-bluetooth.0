Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CD1B0F1E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411540; cv=none; b=pOF9vejbA/uIAcWr5ZFSWPwHIoIeq1tbESFyDUoQ3aBSkYglJ9bjJj3Q+rRDhK2AHWgTIn/gNCSTu50CmxHE61arxEfi+7ca6ThXoGPD/btpvmbOd95jhFBsp93domFFwgU6+U5E0Bk6ZS+rGFih2/HxJw3MVQe9CcfC4DrHG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411540; c=relaxed/simple;
	bh=07psSmqF2euayiXLhnggTK1RazSvKZEJzjv7zrU8QUQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a0aw2Hz3EtKm+NyLi9Gjj5QyiPej2PTyi8ZiQZJMBw437OQn+9JFfjI+yksGkR3+SbiugVASj8mMZy0CipKMNFHXNpHHXRfiVw/MsxIa+pi+4kpkKjgAvRqnsMU7/djTuvIHB5B0z96VQjtsxgqd6CpFuUh2HBzIFP5qI/xNg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dmd6IKXK; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dmd6IKXK"
Received: from github.com (hubbernetes-node-e8a60f3.ac4-iad.github.net [10.52.158.15])
	by smtp.github.com (Postfix) with ESMTPA id 4A5C7213B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742411538;
	bh=ANdxIxu2t673pWc5Y35fBrO2aCn3BS5QKQ23VlVLA+U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dmd6IKXKj+y14n1RvQQtKEN4EL8nla4DLqZcUefna0XtoadGW/jdRruF/tAT0YwfR
	 mpDMEwoheM8YcO1xnqD3yzPfZSDqar/Y5Voe4ehV3HcZjofuTYRcRNW8t0OU0C0q/p
	 QUc+soBcNZ21ZYxwBnX0+0twWsSexiCjIAraNPcE=
Date: Wed, 19 Mar 2025 12:12:18 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/775243-50a01b@github.com>
Subject: [bluez/bluez] d26a7f: tools: iso-tester: add inclusion of time.h
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
  Commit: d26a7f96cdd4250f4de3792fd647c3b92581712e
      https://github.com/bluez/bluez/commit/d26a7f96cdd4250f4de3792fd647c3b92581712e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  tools: iso-tester: add inclusion of time.h

Inclusion of <linux/errqueue.h> requires that 'struct timespec' has
already been defined:

| In file included from ../bluez-5.79/tools/iso-tester.c:21:
| /usr/include/linux/errqueue.h:57:25: error: array type has incomplete element type 'struct timespec'
|    57 |         struct timespec ts[3];
|       |                         ^~


  Commit: 6f26f2f8de7f57fc8e885328e6b73d95bf227b97
      https://github.com/bluez/bluez/commit/6f26f2f8de7f57fc8e885328e6b73d95bf227b97
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M mesh/agent.c
    M mesh/appkey.c
    M mesh/cfgmod-server.c
    M mesh/crypto.c
    M mesh/dbus.c
    M mesh/friend.c
    M mesh/keyring.c
    M mesh/main.c
    M mesh/manager.c
    M mesh/mesh-config-json.c
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh-io-unit.c
    M mesh/mesh-io.c
    M mesh/mesh-mgmt.c
    M mesh/mesh.c
    M mesh/model.c
    M mesh/net-keys.c
    M mesh/net.c
    M mesh/node.c
    M mesh/pb-adv.c
    M mesh/prov-acceptor.c
    M mesh/prov-initiator.c
    M mesh/prvbeac-server.c
    M mesh/remprv-server.c
    M mesh/rpl.c
    M src/shared/btp.c
    M src/shared/io-ell.c
    M src/shared/mainloop-ell.c
    M src/shared/timeout-ell.c
    M tools/mesh/cfgcli.c
    M tools/mesh/keys.c
    M tools/mesh/remote.c
    M tools/mesh/util.c

  Log Message:
  -----------
  mesh: include <time.h> before <ell/ell.h>

I get many of such warnings:

In file included from ../bluez-5.79/ell/ell.h:8,
                 from ../bluez-5.79/mesh/prov-initiator.c:15:
../bluez-5.79/ell/time-private.h:15:43: warning: 'struct timespec' declared inside parameter list will not be visible outside of this definition or declaration
   15 | uint64_t _time_from_timespec(const struct timespec *ts);
      |                                           ^~~~~~~~

It seems that there's no guarantee that 'struct timespec' will be
available via <sys/time.h>, so include <time.h> directly [1]

[1] https://libc-alpha.sourceware.narkive.com/yb0aXzSp/defining-timespec-in-time-h-or-sys-time-h#post3


  Commit: ba9f9fbde34a3f5841eab4b94ed1d618fb4988a2
      https://github.com/bluez/bluez/commit/ba9f9fbde34a3f5841eab4b94ed1d618fb4988a2
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: include <time.h> before <ell/ell.h>

It seems that there's no guarantee that 'struct timespec' will be
available via <sys/time.h>, so include <time.h> directly [1]

[1] https://libc-alpha.sourceware.narkive.com/yb0aXzSp/defining-timespec-in-time-h-or-sys-time-h#post3


  Commit: 50fd1d0cc4c8501b6dd9e2e386529f88975298d7
      https://github.com/bluez/bluez/commit/50fd1d0cc4c8501b6dd9e2e386529f88975298d7
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: fix printf format mismatch

%zd is meant for 'size_t' rather than 'off_t'. As there is no printf
length modifier for 'off_t', cast to a standard type which should be
large enough for on all platforms.


  Commit: 50a01b0c17e9c46b7d1ded7cae7df5ea029819dc
      https://github.com/bluez/bluez/commit/50a01b0c17e9c46b7d1ded7cae7df5ea029819dc
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix printf format mismatch

struct iovec::iov_len is 'size_t' rather than 'long int'.
https://man7.org/linux/man-pages/man3/iovec.3type.html


Compare: https://github.com/bluez/bluez/compare/77524358658a...50a01b0c17e9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
