Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A830AACE
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471062; cv=none; b=S/zQ/IcqDxRHnW8dDkS87pFzNSBDMnUQppkhVKg2X4k2EIQ/lv7Z3/mxoz2OfTKZbJ1nOQAA4RV8MFZTUzMhaAh9vzQrnxAIs9FYAan9ZbMww018FwUXIfTTa+kCIW8jCufERppQzF7sTnLyjFK0McybNudO0wgvO22Vz7MnWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471062; c=relaxed/simple;
	bh=MsMBRH2Cyng8YFPqCMNtL355pQDdrQCNQFy6xJXV5IU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QvOq8fnDmUK6Q4D8rWj9hT60qzXOLUgNQA1IE40ltwZwG857oVuFfjTsIEEricmF40E1GeU2zJcRqF4qe89LfhDXc/+bHSWnaNk4Zg5o/Aa9cIrkAZRNZFOXoQ5lZsrhzfWoA7z27PQD3iNSbi9c5M+HFJT3viDwooPMUSYVVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MzXVJIvX; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MzXVJIvX"
Received: from github.com (hubbernetes-node-1b3c1fc.ac4-iad.github.net [10.52.153.31])
	by smtp.github.com (Postfix) with ESMTPA id 5A3DD2124C
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762471060;
	bh=t0h8xW46q86YWgtScrQufQHlv2sqi/rBOTFqszYwh80=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MzXVJIvXcnWM+9yQrgiCESVOzdElfEBPwx9ijqJDsD8mxXMgN/WK3Wv+A57QhGbIB
	 2VYpfSkVDR45ayjruT1317jtK2APGFTEYTmIVt6Nqw0sRpDzduKtBNPilJhzf7GPeX
	 RJLHl2eltAuZL+WOoguW1bevsJY5SV0pWbJ01OJU=
Date: Thu, 06 Nov 2025 15:17:40 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020667/000000-e01392@github.com>
Subject: [bluez/bluez] e01392: emulator: Generate PA Sync Lost
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

  Branch: refs/heads/1020667
  Home:   https://github.com/bluez/bluez
  Commit: e013922fa0ead39be766e9c28cb04bf525450b2b
      https://github.com/bluez/bluez/commit/e013922fa0ead39be766e9c28cb04bf525450b2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-06 (Thu, 06 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Generate PA Sync Lost

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
