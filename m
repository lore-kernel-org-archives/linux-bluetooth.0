Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815830E82C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359650; cv=none; b=WMmnwBwAYW1DxpfecyWU1DKuXDY6ziSr8HILP2Ai2TI2jYWIdDn1EQsH1TO64/H5Q5b4+Hzh9qI/UbQpqT7HdHI+nzRNQF7X/Y/1Y1+qqGF0JZ1g9EieG9sHBATLQcBD4bUvf0R2Wm5NS54+MFoTKeq6a+X7hZJ5eJEEqTfYfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359650; c=relaxed/simple;
	bh=Zgn8eQzydXjePbU2n/3Ug4/2C7c66XakzujutTYumuI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tBivsEatj7LUAstG9v3V5Q9vDlRBMlYk/+8mUNaLba3lGafqtQQbOGGgf82SAtxGYvkw20hv7OVlhIDKX+hkveqrfdlCjK/G7huXQTu79hEg4ZEsGNwo4HqmZ36Pm0tbbLL6tlDam3BUB5dq+UvzpS/d2tY6UCEAcDpypx/oJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j4saYda9; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j4saYda9"
Received: from github.com (hubbernetes-node-021ba1b.va3-iad.github.net [10.48.168.21])
	by smtp.github.com (Postfix) with ESMTPA id 6CF088C11CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750359648;
	bh=/di0YQmfpxzyy0s1lwIur+FWJcJYJqHTVkwu5xOrRQ4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j4saYda92UcJxBhPHbZgrCeVy4CpTBbQzIPuNSIKeh184KdJ2AAR239pOKr4H3+sc
	 qWfSd22UIgaVVvvboGqdTYJGtUKX/XU+gyEQ5k4lAstA0YYugQpIql8nCB2Wp/FfWf
	 JZRW4MFnmYaI1uPnlF9izaMiY+ZoOa6ve3ibe+Yg=
Date: Thu, 19 Jun 2025 12:00:48 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973966/000000-bdd62c@github.com>
Subject: [bluez/bluez] bdd62c: src/shared: allow passing in stream's own
 metadata...
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

  Branch: refs/heads/973966
  Home:   https://github.com/bluez/bluez
  Commit: bdd62c3a94162ae5341c1729e40559571529ecb2
      https://github.com/bluez/bluez/commit/bdd62c3a94162ae5341c1729e40559571529ecb2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  src/shared: allow passing in stream's own metadata to enable()

If metadata is same, it should not be freed as it may be stream's own.

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
