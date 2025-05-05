Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4B8488
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473420; cv=none; b=Q1A72750fSO185ljaIM7q+N+5UP5dd93zBJJZ7vEiYF9m42e0ibhYOowf3aGAI9WJv7UukemJ+TwS2TdqB4nyJAqUaLkNcEVgA/sxv1l4kfQOdUnJ41pDhM7vSn7887Y8wZztUfM5Sz/HjBEIweGnz5p0skaFxN0j8KBUnCrPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473420; c=relaxed/simple;
	bh=PCcabbOAxNmnyD1DD2HV4Cy8oJV/guv7hUGF3AZgLT0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dy70DuzxOrgGGO02eTmunP0dJJvG0SPBR+WWBQBwokJRmVL4QgL7S57WfuAt2KiPeAw5VnCQ5Ox7yK3Ak+q7IOYy33nZlHZb6pcTq6Psa1Y+1rTnIyoAEXHpEY9v0PaKh17sJxVxmxH0Shd6VVgrw01SgKKYe0GvylytMyKypJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=c6OJy3a/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="c6OJy3a/"
Received: from github.com (hubbernetes-node-43bc67f.ash1-iad.github.net [10.56.163.30])
	by smtp.github.com (Postfix) with ESMTPA id E141A14052E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746473417;
	bh=hMph3TCuQJEd9psVPJvTtgKkhiNRXCZ/N/rIgbodE1w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c6OJy3a/7vwwIIOhza9wCvTusByY7M8ckGbFnnL2/8DQUBr0iD+QwPxk4PY/GsMT5
	 eb1EwqF+ORWTR0eM0VsrxMBEf/DvgDBSvKhNiygcegVNPjG9HiFEiR9jIs/rdxKqd7
	 7fdVXNnJzbbce5FS/Zb18lIhRMDf5NL6CKVVPDs8=
Date: Mon, 05 May 2025 12:30:17 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959755/000000-e28486@github.com>
Subject: [bluez/bluez] e28486: shared/bap: Fix handling of ASCS_Codec_Config
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

  Branch: refs/heads/959755
  Home:   https://github.com/bluez/bluez
  Commit: e28486308fa489a0619603e923e8060d6d3304da
      https://github.com/bluez/bluez/commit/e28486308fa489a0619603e923e8060d6d3304da
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix handling of ASCS_Codec_Config

The codec under bt_ascs_config is in little endian which may differ
from the native endianness when it comes to vendor specific field that
are multibyte causing the following error:

BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - setup complete
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - run
...
 bt_gatt_server:src/shared/gatt-server.c:write_cb() Write Cmd - handle: 0x0022
 bt_bap:src/shared/bap.c:ascs_ase_cp_write() Codec Config
 bt_bap:src/shared/bap.c:ascs_config() codec 0xff phy 0x02 latency 2
 bt_bap:src/shared/bap.c:ep_config() ep 0x21d6600 id 0x01 dir 0x01
 handle 0x0022 len 5
 test-bap: > 1b 22 00 01 01 01 09 01             ."......
 test-bap: ! 1b 22 00 01 01 01 00 00             ."......



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
