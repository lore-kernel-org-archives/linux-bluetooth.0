Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92E30E848
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454080; cv=none; b=W9zCKNaQgPiBpRDK33YcCKd1IXielSwF8HBI4jREtXqKI9YwztSZrTOTqC3lQ/4XTK4ktT1V8YZPxmL64eBuHWuZE+9S6JaUa6xVO7y8gY0/4c+jD1Gx/SJHk15AGuKtA6FVNinUceuRqne9ONuVHLKb+ZXKey1k0ydgxFrg1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454080; c=relaxed/simple;
	bh=H7OKyHQq9LKTsp4ZJxSnopckdsDp4fCF249lMPeUNaE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AvDeeLi/4tUTn3xDUwNd/uLLJE5J7L+YXMRSpUEJCsF2n25OI4CIum0Ikftq33Ch3G/tAcUiZSts+sp5M1i/Ufq0mkuhNTPVQ/a6QmrS+wlNp8f2LZzGPsjroC7i/LXruv/3UnN5z1vQV91qcr/tFH8ZhhL9UbzQdFYyhsckly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jpRazqhd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jpRazqhd"
Received: from github.com (hubbernetes-node-9881bb6.ac4-iad.github.net [10.52.211.80])
	by smtp.github.com (Postfix) with ESMTPA id 01043640229
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750454075;
	bh=yBJklpD5LZf77ToVKX7VhH5+JillWVxD0+6ZVn30p5g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jpRazqhd1ANPKaoSI6tYZz1xnnybIE6OP35jw1uBVXexyZAeUSyrD+/LooS3q145N
	 /vSblb8QaKs4488d0ntd1kIAU0rKryRBl+NZobplg0/NWFjtBNNH3+OSK5xyg3sNUo
	 iJLFProfSWhYQPvRgfefMODJU+FUeyWvFpTGi2/A=
Date: Fri, 20 Jun 2025 14:14:34 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a209d6-01f3ef@github.com>
Subject: [bluez/bluez] 01f3ef: bap: don't pass in stream's own metadata to
 enable()
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
  Commit: 01f3ef3cd9d69b56554f5ef6d7ac2a5c40e41393
      https://github.com/bluez/bluez/commit/01f3ef3cd9d69b56554f5ef6d7ac2a5c40e41393
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: don't pass in stream's own metadata to enable()

Stream owned metadata pointers may be invalidated in bt_bap_stream
operations. Just pass in NULL to keep the current value.

Fixes:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7b86a76f5d18 thread T0
    #0 0x000000836745 in util_iov_dup src/shared/util.c:353
    #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
    #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
    #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
    #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:1981
freed by thread T0 here:
    #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
    #1 0x000000837002 in util_iov_free src/shared/util.c:392
    #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
    #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
