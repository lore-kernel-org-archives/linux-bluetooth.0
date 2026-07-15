Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7C417D96
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138489; cv=none; b=jfTT1Z1Gq0evt/NuuiuQulMAWjOMIM0QpxM3DuWeHXnkk+XaxRO2gjn5wy4LgYJXjlblDGTlESdtB4Kcsfvn5y8nP+fWsyBG+tL28aVPBPRfS1OuoDHZcrUFo0uQ/ynv4s53U9AYWozAORpcsBslIFEnvlTeUPCS9RVW3USoprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138489; c=relaxed/simple;
	bh=+q0nDXT0WOV5hvYxShhhAdgAV6QqOcYrnE760i/0wZk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XhHXjvHXWJdGRtWpRxUDGfYISIKj0aVXt3m7hF7uyZkeC3YMdmkoYI+y3N4Zo1YACmimv2XOEl1GXpPPkLRZ8Xi3RXGSRmdpfGKA2Nj+6iZwFdypIa/SGJ0vVq+Lqb0iFzeXHQ3W5Hx7foswc23AMwHsVQJdj9xYMds+ImkrMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cRwTlyCf; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cRwTlyCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784138479;
	bh=4IChFAqtbGyEqVyd3hhzjdjEiA9N6ffUGcgmUevJLD8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cRwTlyCfW2K3Z/5Zxvdzk6bQJ8S6YXZFGnU+gq20dPfxidjoPJPx/4XHJbp+CNwxo
	 PkkAyBKZnmpyyRxgnq3ZPp7WyikqQD2yRbvQZY3Ct+v9FKLftvadBN4/5/ZXWLm1e0
	 8aerKAGaowmpi0yNJXbPkuk9YZcbWmaX5izPU0ng=
Received: from github.com (hubbernetes-node-7898aca.ac4-iad.github.net [10.52.200.122])
	by smtp.github.com (Postfix) with ESMTPA id 03E96A10B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:01:19 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:01:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128302/000000-48f9ed@github.com>
Subject: [bluez/bluez] 48f9ed: monitor: Fix build error
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

  Branch: refs/heads/1128302
  Home:   https://github.com/bluez/bluez
  Commit: 48f9edabb38bc0e24b654af8b788457285770933
      https://github.com/bluez/bluez/commit/48f9edabb38bc0e24b654af8b788457285770933
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix build error

This fixes the following error:

   36 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   37 |       __bos (__s), __fmt, __va_arg_pack ());
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
