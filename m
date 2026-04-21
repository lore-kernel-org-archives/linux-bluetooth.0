Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5933DBD7D
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803701; cv=none; b=neMy6zoVYvvXZZUQ/uqcmKA5rUhtT0JCV6ONvDNPXg8h82GgjB8pAmYZ/E/tcJC8JS5XyGuKh8YrHqQrkZWSljNuZdohfErSSDZe6Mb5kfRe7t5xzV8wZvFeOQnWk2FaEhGfrcdNUNC0aQfHD/SDr8azwMZ7e+GbCTa9uf5aDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803701; c=relaxed/simple;
	bh=JC//+zR3srtRMCh7di3gAZtZjdfgoJZkEMAHQJOJYqs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i4jLD/KV7qj25A2pDyHDTndd2FJEbKAVp5RA5mUH0tpdaBfqLSJDmYxygfWuLCn9q2SeIGboFDgztNtOU4JOaYokEOuga3npTNjZ8vlN9ZYjwxIR7JxVvgWYdP+GpnGl4TqtgNdlSVDcNY6SgSmTakk5nB0o94T8h/tlqbRrldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cO19x2e3; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cO19x2e3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776803698;
	bh=ypOERReTZR0SIM5Q9jR4/pdoyc16eGxwvil+SXqD+NQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cO19x2e3ZfV6LzOMgRj6Ajcx61CmKnlak5Aa10zBF3ytg4hX1mMfazLXHNn9M4S4L
	 Fv1x0X8Dl+Yu/ueEHwaPx5xsQsR3DuclBenFvPqvgU+UvNBQs5ynmDZGUeyxsp6d6F
	 SccrNw7lvr9cVfg7zFV7K0ac2CbrHKZJtVYNqXSs=
Received: from github.com (hubbernetes-node-3127c82.va3-iad.github.net [10.48.124.62])
	by smtp.github.com (Postfix) with ESMTPA id A56CD501184
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:34:58 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:34:58 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084033/000000-fc03db@github.com>
Subject: [bluez/bluez] fc03db: input: Fix checking LE bonding on HIDP
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

  Branch: refs/heads/1084033
  Home:   https://github.com/bluez/bluez
  Commit: fc03db8ad548a5676fe5401ed94caa54ea860bb9
      https://github.com/bluez/bluez/commit/fc03db8ad548a5676fe5401ed94caa54ea860bb9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix checking LE bonding on HIDP

HIDP is classic only, LE uses HOG, so there is no point in checking the
bonding with the address type which in case the device supports
dual-mode will map to LE random/public address.

Fixes: https://github.com/bluez/bluez/issues/2034



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
