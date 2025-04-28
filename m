Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985D18DF62
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870321; cv=none; b=jYXwQ5fSv3L9mQkvlYFx7zL4GTmeW7rpBQ/gAAaq+Lev9WGe4fWflbyvII+EvO440Y7Id5H7CUt6yX2rR2WCrgZVoC0TS0A8A1GHhvRrBUvKP6k36bVLHfbnihx/rvZak9Bwc6ZAUR60vNaJYVUYiyn9D7IFa4Amn+XRoTY8ihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870321; c=relaxed/simple;
	bh=q76rkTaz+FyjvpfT4HPF2OEZbTQDkXOHMI+xZLw7KvM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GwOI36hlQSIA3WD0cs7NjGLcBgGg/EXQpdzrnflWP3qGiY9oxO1PndX6SHw1J7IFeuNS2JwrBcijfitL+sj7sXBNV1DtipfKrB+ruwJ7s4n85r07eAhSbYLb4PycofW2v8eDYmAODnRlXs3086IdJHDhBXah1rfSl0jR/QLHILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wch6d4Mi; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wch6d4Mi"
Received: from github.com (hubbernetes-node-4c3612b.va3-iad.github.net [10.48.146.31])
	by smtp.github.com (Postfix) with ESMTPA id 66358E03C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745870319;
	bh=wSMbsRX4k6fdePI9wIbiTmqcWTeBZnvtJ6EjwEBW4Rg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wch6d4Mi1j3/doW+w/5cOq2V/48SLY19KKshrLEoKtC9Qve9zEM5BpOOKomgqxoX2
	 hjjb6VareoU43HD0ktv51W3slJw+FUp80gWNmKXvBnRcDFJMrV/O1OjhHr/SDcq9+8
	 1zZ472j86W2FshgoOcZmfXWgHPCfDbyXxsHdGllc=
Date: Mon, 28 Apr 2025 12:58:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957841/000000-cc95d1@github.com>
Subject: [bluez/bluez] e99742: main: Fix comparison of narrow type with wide
 type...
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

  Branch: refs/heads/957841
  Home:   https://github.com/bluez/bluez
  Commit: e99742221211b5516bad849f2d213f21ddcbe06a
      https://github.com/bluez/bluez/commit/e99742221211b5516bad849f2d213f21ddcbe06a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix comparison of narrow type with wide type in loop condition

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1213


  Commit: 95d86f50e633750e19ed53fc54c09b683724cd71
      https://github.com/bluez/bluez/commit/95d86f50e633750e19ed53fc54c09b683724cd71
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Fix comparison of narrow type with wide type in loop condition

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1211


  Commit: 4018a89f1f50e11b1a9ab2b338bc44761880829e
      https://github.com/bluez/bluez/commit/4018a89f1f50e11b1a9ab2b338bc44761880829e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix potentially overflowing call to snprintf

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1215


  Commit: 27bc1ce18a40543e92787e673630c8b655f9f9ec
      https://github.com/bluez/bluez/commit/27bc1ce18a40543e92787e673630c8b655f9f9ec
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Fix potentially overflowing call to snprintf

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1216
Fixes: https://github.com/bluez/bluez/issues/1217
Fixes: https://github.com/bluez/bluez/issues/1218
Fixes: https://github.com/bluez/bluez/issues/1219


  Commit: cc95d1000371c6d9452f57aa9eb66a8a58aa8651
      https://github.com/bluez/bluez/commit/cc95d1000371c6d9452f57aa9eb66a8a58aa8651
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Too few arguments to formatting function

Each call to the printf function, or a related function, should include
the number of arguments defined by the format. Passing the function more
arguments than required is harmless (although it may be indicative of
other defects). However, passing the function fewer arguments than are
defined by the format can be a security vulnerability since the function
will process the next item on the stack as the missing arguments.

Fixes: https://github.com/bluez/bluez/issues/1221
Fixes: https://github.com/bluez/bluez/issues/1222


Compare: https://github.com/bluez/bluez/compare/e99742221211%5E...cc95d1000371

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
