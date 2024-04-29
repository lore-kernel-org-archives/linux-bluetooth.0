Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E8249D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403262; cv=none; b=I4AtpYSHKl8VIBKXS6Szq4gu/HSyQnWnOHGYn27Ay3/vKMkHcH4qrUqarnHPtjo/J9cZ9XksW0QVaCh1SeaF4dzca2MVl9h3gGWMLbzSoXsH78G2a/AX15Z9liqTxYapVQbOzsAmD64FD+sZnYJKZrte7StnivFbgd5YaF4FuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403262; c=relaxed/simple;
	bh=I9gpa/xXWUcM89zG6A29dTWHMzs/PWOn1ZtsSPp/V3s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H4X+LqUFvnYQ2DsZsAZ0iTSw1R/t6HznR1vD/Bvj9yo5mGTqzrzhl3osKIGmhMu/sYdMS2pGrGx4Hg5n7I/S4YHWeVJhbBaOxyZjPov9vP9rP3VrPmZQh48Qt42kHi6pc8+9f+4oQpu8pkF7stwrMZ2w4oYhDxS/P1XdoqSfBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AuQxq7tS; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AuQxq7tS"
Received: from github.com (hubbernetes-node-98f0704.va3-iad.github.net [10.48.135.30])
	by smtp.github.com (Postfix) with ESMTPA id BA706E0C4D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1714403259;
	bh=G7YpO4znSKt0UsiKX4gu7uST5EWUHY4k6BEVta4EO6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AuQxq7tSRevDjxzq00SHCXs9/9TmM/OYJ3ikJC5+4cel8PZRD93MuqcSwh1XP6uDV
	 xFjFeo+5dC1ShZStG5LwQnyPerhwTe9DkWy3t4MtBMgMcoPnWUzXyR795/JWjWXUCF
	 jMbhGArGrOzIkBv6wnSfAzQjHvgbHSc7Ap+UQfsc=
Date: Mon, 29 Apr 2024 08:07:39 -0700
From: BajajSarv <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c42702-d2a2aa@github.com>
Subject: [bluez/bluez] 129b19: org.bluez.Gatt: Add
 org.bluez.Error.ImproperlyConf...
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
  Commit: 129b19166304d40073a424d8b9ac28d3802b52f7
      https://github.com/bluez/bluez/commit/129b19166304d40073a424d8b9ac28d3802b52f7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-26 (Fri, 26 Apr 2024)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst
    M doc/org.bluez.GattDescriptor.rst

  Log Message:
  -----------
  org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to
WriteValue

Some attributes may require to generate
BT_ERROR_CCC_IMPROPERLY_CONFIGURED when its CCC is not properly
configured so this adds the possibility to generate it by replying with
org.bluez.Error.ImproperlyConfigured error to WriteValue.


  Commit: 9b29784717f4682ca527c76c81b5ba92ba00c313
      https://github.com/bluez/bluez/commit/9b29784717f4682ca527c76c81b5ba92ba00c313
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-26 (Fri, 26 Apr 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Implement support to org.bluez.Error.ImproperlyConfigured

This implements support for handling when applications reply with
org.bluez.Error.ImproperlyConfigured the code will translate it to
BT_ERROR_CCC_IMPROPERLY_CONFIGURED.

Fixes: https://github.com/bluez/bluez/issues/827


  Commit: d2a2aabee646c4e95655bc5dc93c323efa5fc588
      https://github.com/bluez/bluez/commit/d2a2aabee646c4e95655bc5dc93c323efa5fc588
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2024-04-29 (Mon, 29 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  Fix null pointer deference in bap_get_ascs()

Ensure that bap and rdb pointers are valid before accessing or
allocating memory for ascs. Added  null check to prevent potential
crash


Compare: https://github.com/bluez/bluez/compare/c42702cfc48e...d2a2aabee646

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
