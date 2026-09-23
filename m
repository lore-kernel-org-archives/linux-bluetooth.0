Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D43E073D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200167; cv=none; b=GMYg19VqfVLlvvSeiPtKAWsVzKeRSCEH7fmnDrRYa06xligCsjMTh6TlOXsVTnLWflvgawrob8zmpnd52C1dFxVL5Tev7WQFRRks6yegFd+Wvw71YiPVG2925xPYUEt6F/sH8LULdLdSbpVsNDKQSl5RtD7TT/Et4e+Sn0A/f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200167; c=relaxed/simple;
	bh=1GATfiwBHYzVmJyoNVNiKVQNyL6heLMOkuU04Z3sVbc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ocROA8ldKahaJV/VnTEPBDmlNBQ8+qFrps4rocFfMGaE2OajINcQIlusKVQuPU46F4P1rsxBf6g3kdWkiCzDsgtxX5bZ2AeS429tJlqP/rbXDeRJB5a+DPO/bXNaGQthKkIzkA2fZ6UjVvbj+i92L1D7wGoaKI7LF5BepR/KBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R95a5dtP; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R95a5dtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790200163;
	bh=knSZt8VX9aZ/DJ5ZXNIwolEykVaQc4vQ3neaBDZKVGg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R95a5dtPlyU4UyA9KgloGkcsvj/xyWyO6BIeY21QynTniID0VW4QpanEqxSzrPI/0
	 OhjOfWW0el6MqZzK5FIWXD1SOXErxLLfdqpgP1cGw3eOppD+znYwp8m+Xgf+zwhF5C
	 Y9FebNfjnEMo56rb3p6xuaUK+sy3zTVEcHP40dIk=
Received: from github.com (hubbernetes-node-8122701.va3-iad.github.net [10.51.91.40])
	by smtp.github.com (Postfix) with ESMTPA id 381C93407BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 14:49:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:49:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f26da4-8b4a41@github.com>
Subject: [bluez/bluez] 97431a: client/btpclient: Improve GATT read
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 97431abc432fde861f180f5ada31c8c503bd93b2
      https://github.com/bluez/bluez/commit/97431abc432fde861f180f5ada31c=
8c503bd93b2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M client/btpclient/gatt.c

  Log Message:
  -----------
  client/btpclient: Improve GATT read

BAP/UCL/CGITT/* tests request to read the different Sink/Source
Audio Stream Endpoint characteristics.
The first ReadValue call triggers read of the other characteristics
and PTS, which tracks the read requests, may disconnect before the
following explicit ReadValue has been replied.

First try to read the characteristic value from the proxy cache
before calling ReadValue explicitly.


  Commit: 8b4a4176063831476bc9244d20f43b552e4b5554
      https://github.com/bluez/bluez/commit/8b4a4176063831476bc9244d20f43=
b552e4b5554
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  obexd/pbap: Fix u128_to_string skipping data[4]

u128_to_string uses data[3] twice causing data[4] to be skipped and
DatabaseIdentifier, PrimaryCounter and SecondaryCounter properties to
be printed with wrong values.

Fixes: 5ee26d43c65c ("obexd/client: Add DatabaseIdentifier property")
Assisted-by: opencode:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>


Compare: https://github.com/bluez/bluez/compare/f26da4389e2d...8b4a417606=
38

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
