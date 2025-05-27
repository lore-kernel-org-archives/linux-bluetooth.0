Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1F2749F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353241; cv=none; b=Y3iSySc3bqJn7MSh2nwawmJusOGM7VmsUHaF3xYLCepqU/dlg+rzpfLEnQcooNcx5LY0flPrDqcTk9AuSvJZwK8OhCszzSt2x77xA7o6R/lUpG6XiN4/ZtO5v5j7TuzPftqX9DPUzBhd2tLuCAYG5dTT8Qm4tMIsOjQb0vXPNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353241; c=relaxed/simple;
	bh=vCk+O6WubMUdHzcLXmKIWGPkOHjDwPWRy+ofA4dT5WA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uy3bAWK9s+D9x9aXIiC2sGdttK9tuavOt5fpHvTkwpvw997t0Zayad0z+zwtiqrF+qs4RYuGNVbysgQfFnMnVuMuLqbohpmFOJXcYkuCRXpaU5G47um0gFHm3cF1Y2CQcWLG5Vhg39+CYqazVXIgwuP7UBkqZYVXE2SsQs5pxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NvSnpmro; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NvSnpmro"
Received: from github.com (hubbernetes-node-feb3a44.ash1-iad.github.net [10.56.158.21])
	by smtp.github.com (Postfix) with ESMTPA id DA508921330
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748353238;
	bh=9n23WJkRBaDRsYv8AOz5+oDFpeQtjKQ61LvDPCpNzBU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NvSnpmroa+CbzYapQ8pqW5kO+VrTNh7paHyGQ1XlUmB7Xxt5N5yAoY5yrPBzT1n3C
	 A+Da8hg/RPppauWBjq4JXNzSfvgq1P9t1xpYzgjvBBQ7Zij339TVdjfAKUE+9hLuC9
	 1+vCSYxHLi4ly/3Jms+ejIiPCxODEgt/4qifqqQk=
Date: Tue, 27 May 2025 06:40:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966677/000000-a08983@github.com>
Subject: [bluez/bluez] a08983: shared/bap: Fix not handling read offset
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

  Branch: refs/heads/966677
  Home:   https://github.com/bluez/bluez
  Commit: a089831e49937230a2bafd94b356d07ec5628b48
      https://github.com/bluez/bluez/commit/a089831e49937230a2bafd94b356d07ec5628b48
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not handling read offset

Some attributes may need to handle offset other than 0 in case read long
procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
and PAC_SOURCE_CHRC_UUID.

In addition to PAC record this also uses
gatt_db_attribute_set_fixed_length for attributes that are considered of
fixed size so gatt_db can handle offset directly.

Fixes: https://github.com/bluez/bluez/issues/1294



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
