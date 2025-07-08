Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9F13957E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985197; cv=none; b=ZxwNwLvykJWVK10EM8HDaeI0jD51onf3OwawqkE6Kq69NCU2WKX595yzJ5MXcI4mSea0X2TvAUTQZMXV1MjkXaee89CAWCN7aMFK19tfKjbSIeOdu8zfzkLiFMFeCy7jAkLEtIAhYfImVu1tS+fzOX2xJa8njKPo0qIS/MfaqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985197; c=relaxed/simple;
	bh=MWrtgvcgoUfkS3z7NkvkGp2ScahqgjKi2G5tlC0RPr0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R4gRHXHiltwbaVMPdv5j1BgHkoc3lNIDImJv4QLgtvOse0lhk3MBiCKGLT34+IHlzoq9DKJcZiXgBodJCMtWYn9YWs6UqFIBD1IpfLqXFRhYVAS/prFw5tT3K2SLNdn3JafogHLVUfuwXNpFGXRLwaTZCrgO9+rxpNle2+eVrqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NZwlNMM7; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NZwlNMM7"
Received: from github.com (hubbernetes-node-552c987.ac4-iad.github.net [10.52.160.26])
	by smtp.github.com (Postfix) with ESMTPA id CE1E5640D77
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751985194;
	bh=PeHbzPYrQ2K28tP58ivFELMBF5Sb7VrmYd2JS/8EAos=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NZwlNMM7eDDDd5jp9L6aQN6PYAL5+7iIgSXuycPWfFz2BU/DLP5360+FFh7coYt+g
	 cD3B5KqVUTBy+g2UNLYsN65uU45D2vToSNhIe5skbeJbcLuwlo4ta11WEG2yrmVaYB
	 abIiAcvpRQPVJQOoThAQKAoeAuzqb+pvFYe0pZfg=
Date: Tue, 08 Jul 2025 07:33:14 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/be8c03-a5d517@github.com>
Subject: [bluez/bluez] 9fb0e0: doc: Fix extra word in doc string
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
  Commit: 9fb0e002fa04242b3890faeb1329bee397c51099
      https://github.com/bluez/bluez/commit/9fb0e002fa04242b3890faeb1329bee397c51099
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc: Fix extra word in doc string


  Commit: 18cbebbc7252bf92787a57b129b7b6a3122bf2cf
      https://github.com/bluez/bluez/commit/18cbebbc7252bf92787a57b129b7b6a3122bf2cf
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/midi/midi.c

  Log Message:
  -----------
  midi: Fix debug string


  Commit: f3db585b5f6f920975e0a331c562d65a199b49c7
      https://github.com/bluez/bluez/commit/f3db585b5f6f920975e0a331c562d65a199b49c7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M bootstrap-configure

  Log Message:
  -----------
  build: Remove deleted configure option

Remove this option now that that the supporting code has been
removed, fixes a configure warning:
configure: WARNING: unrecognized options: --enable-android

Fixes: f0512114aacf ("Remove android support")


  Commit: a5d517dd4134ab5457423e39f839db437a890372
      https://github.com/bluez/bluez/commit/a5d517dd4134ab5457423e39f839db437a890372
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Remove deleted files from .gitignore

As all the android support was removed in
f0512114aacf ("Remove android support").


Compare: https://github.com/bluez/bluez/compare/be8c031baaa8...a5d517dd4134

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
