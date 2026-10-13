Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F04233926
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864038; cv=none; b=hS0UcQwG7068vHae+iHfLMjvrsjsx2TTKwV0gWvfqYl52fxZIeWkeSaKl137NjNuVpQ+OsI9VnMF51qU92Guqpw6/R4D6bOXbP+cqZfrYuZ4WPrEn5o1zfnK+fWcYqQMyhC1QrFUVEQ55G3BMck9tNcqGkb+iQOfspcMz7u0cKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864038; c=relaxed/simple;
	bh=BidQuVFloN3e/kqmwH5B2bE+G8bE2s5l4eD5FM89H9k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SScLZdjpOhjX+92cxA8Bsvk7bsuFH0XHiCtxkla5JCDAU86KZ+DeChnnh33I7pzO1rqXnfdwMML0CgRX3UIieK6FmXSxD6JPKUZ3tbsA3FD+V/La3SkgG/EKC2dQULpKar3R/wAluHa5ZSBhC+un0wvBa6KtcaAYU2LjZUJXlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=Ow5lvNZi; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Ow5lvNZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864036;
	bh=mH1OUCDj55FivG3eDaFn5XQD8uhQR620J0QS1p8K2Uc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ow5lvNZiFkMpgFMZcR0iR5qtlYiGSuwvpkm8HWYRSO2m1wwp0m7QsGyMKqZtayl70
	 AcokG3nrms97mCJ52r1gqtS7j3o4b+m2ijKNGSBOA7P4N4MUOB1cc1mr4DRkH+NXkK
	 HryEpLwuBcBnRmUW3i/FLS5ZRTydURcdNZzknQcDYQmmB9fT887ZZlBpxhCa8IBHXa
	 xncDrrK68Oc21SvDwNt32BMysi4ONwv0r/ElWtlUO/YqHMHknFEhge32GEFG9fIbtI
	 eK4qDyr2brPVYMsGIkLRy3VxnhqepD/Ym6XZrp3eTRgFQ34YrS9Bco4HvVx5QOkr6Q
	 U3RHERipAau9A==
Received: from github.com (hubbernetes-node-68422ab.ash1-iad.github.net [10.56.85.29])
	by smtp.github.com (Postfix) with ESMTPA id 26FBC360B0F
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:36 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184354/000000-b220d7@github.com>
Subject: [bluez/bluez] b220d7: shared/asha: prime volume before starting audio
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

  Branch: refs/heads/1184354
  Home:   https://github.com/bluez/bluez
  Commit: b220d718d9641b45c1292e58a08e143b84932d1e
      https://github.com/bluez/bluez/commit/b220d718d9641b45c1292e58a08e143b84932d1e
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M src/shared/asha.c
    A unit/test-asha-start.c

  Log Message:
  -----------
  shared/asha: prime volume before starting audio

Some tested renderers remain silent unless the Volume characteristic is
written before START. Prime it with the selected volume and keep the
write best effort.

Test volume-before-START ordering and best-effort failure handling.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
