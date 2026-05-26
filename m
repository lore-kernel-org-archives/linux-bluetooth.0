Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05841B36A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817212; cv=none; b=PvcSEg1bEbtxPBRjruqrb0v84Osklta0qWlRW9znIj/C2hl0VTuSqiW4L4NLpdB+GnMCzqeWL+0VR4mSFgSXGL4CSu8KU1exEy2JdGy2IFi1SzieN6kuCF2tiEw0pZsFbYXIP5XC5gRnvpdi0XYJT73PhKrKX1Qr6fsyvx1Mj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817212; c=relaxed/simple;
	bh=f7m6Xs18LHa+zwjr5gzZ9IjANHG+ZEGz/HKaHZJTz5g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ifhhINKdKC1VKWkPcuL3hB4x3WUNnwLKlIYfqfxSNcz98M0HXdyv1+XBWyIfOTc5U51CC4HSJoCgtyxXvZfR5x1qqA0t2aaUH02XGsoTAyJM2/CX8Zzn2Fe/bXlcxzRWup7EvWsn8q1rmy/+lN2VcAEp0UZQ2ShG470IZBFgoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Af5t0K+N; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Af5t0K+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779817209;
	bh=kW+EqArDQzh/ahajCrTZH5H2pxKuoOnyO8T94XuNpiU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Af5t0K+NCSPss7727tgtbztyrBtvv+/MRs1kYzEOtZL+/DNK0Aw+gaCOt0aYbysiu
	 uI0nMhX9R8LQccr24iG5uudDbgqmWaNuM9fv6AaxdpxpUS/5u0ZhUslArPX0XwPeRf
	 mxSzmrHnyKM9gPfY5pVoQs2JpssH3LM4cXXBYtQo=
Received: from github.com (hubbernetes-node-26ef609.ac4-iad.github.net [10.52.86.43])
	by smtp.github.com (Postfix) with ESMTPA id 9CBA1321210
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:40:09 -0700 (PDT)
Date: Tue, 26 May 2026 10:40:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099512/41cabc-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1099512
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
