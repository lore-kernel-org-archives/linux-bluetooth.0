Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5D27FB24
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422605; cv=none; b=tdWm05IUP2EFjVTON0TmvL1Ssr2fkqhpoDnx9sl+iOgK4x45KiJpyNAk1X/MqJV691GIWvTY75A53FhIpDxnkJKy/c2/skAhPE3Nmnuj78RC9rsgW7buXN7LnBN3foZ+tQIHoGL7QtFjPx4pN633CfCM897GHiGEuS/o6tlqLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422605; c=relaxed/simple;
	bh=723HKfFNIopuPbog/uoXd8GIqeKXA8Io1+jnFfUx1vU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pwRNj+huZQmUoIpXIqiqUvWknx3/ppWbb+r+xHuLlYQhhBh22FdI30vOOIYZI2ozCiflemQkMQVlhd3B3e0qY+R2eOt9TFN3WX/Y3xJBcVySKib2icH3TkHXV3V+zfwIV8q5nTpKHikE2NjQdqe59b7q7hfKfZf4tuzOG6inrMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P+sIhF8n; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P+sIhF8n"
Received: from github.com (hubbernetes-node-4f0dedc.va3-iad.github.net [10.48.181.30])
	by smtp.github.com (Postfix) with ESMTPA id B3638E0707
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747422602;
	bh=SRUcL4kBnd5xSPCQLZHkhtmiPZceZKR/qQ9pAk2ggAk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P+sIhF8nKu6rhBoEip9wb/VwD1NlEGqhLZW8n4iQldENrC+YNXU30Pb/qH9Yl0MgJ
	 gysEYoEBntCuPEw4XKgMJUtiuMiCvSXItDMl6Cl8QVnuoJOM2cUdYSutqSykRTAvpl
	 CM1MOPTJEyt8EI97YKslAV8Jp7huk3TyT9cRW+tQ=
Date: Fri, 16 May 2025 12:10:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963744/000000-ec6a8a@github.com>
Subject: [bluez/bluez] 00c005: avdtp: Fix setting in_use flag for local seps
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

  Branch: refs/heads/963744
  Home:   https://github.com/bluez/bluez
  Commit: 00c005106e869c4d5a442fa628c259200fb313a2
      https://github.com/bluez/bluez/commit/00c005106e869c4d5a442fa628c259200fb313a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Fix setting in_use flag for local seps

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.


  Commit: ec6a8af871bd4d1dcd065d9ba9ffd1334649f3e1
      https://github.com/bluez/bluez/commit/ec6a8af871bd4d1dcd065d9ba9ffd1334649f3e1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  a2dp: Fix a2dp_sep mapping to a single stream

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064
Fixes: https://github.com/bluez/bluez/issues/723


Compare: https://github.com/bluez/bluez/compare/00c005106e86%5E...ec6a8af871bd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
