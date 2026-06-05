Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBB416CE8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677302; cv=none; b=KZ18QKhYTRoOEf8d2NsMOc/I/qowAvcJKQ/Xpv+E55qjxlOa/Tdal5UQBzciUjROGtxKiwk0hhtGcmgRU0CW6dQ3F+VBOIwBdnjIPUdeK1eueFKJBW358E+RO2pgUJlk/8E+DDkbfr1EjMdY5iooFcTHrs8/MtHOKH6TDjH+glI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677302; c=relaxed/simple;
	bh=lG6YgWUiHYEq7HfHtC4Vo9/bwQ6haSbM/WXoABtFVLA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gwyxHHJjLpgARkcNN5Ldj6O5uPFWygefrluXFruCQaO1hXRS3k1R1ghCQn9wWqbEXioN8ngl4Z8IlTmIi33LYNela0Xq9BuxyvvpcyN0pxJRCZq9J7Ebqo40yz8QPsgOW/W4Dg0IX+9rMd1u3Imdk4uDBQUQC5uHD8Xa8n9YRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DZ00oTi0; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DZ00oTi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780677300;
	bh=CDFfI8za3x0zpGp7ILLetB6fsFV6LueT1pYGDwRqBA8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DZ00oTi0YF7lq3JsfsB+WSVsU9/Kj5f2Lsypb4joegSoTL5q0cVkOd3ZRBQbPekMv
	 sAwXCW9SaWU1NdVEsiLWpccp34HZpKq1ZLd5kCBz6BUyMRQjwRHH3ObO6cz+0XNpPp
	 r07DLxDZw9zAVRF+AuUcP2GGSuPd44aSF9v9db7c=
Received: from github.com (hubbernetes-node-8006cc4.va3-iad.github.net [10.48.169.38])
	by smtp.github.com (Postfix) with ESMTPA id 5FC8C801038
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:35:00 -0700 (PDT)
Date: Fri, 05 Jun 2026 09:35:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/3dfee9-573ed2@github.com>
Subject: [bluez/action-ci] 573ed2: ci: Use gitlint to check for missing
 signed-off-by
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 573ed22b5272556bbae648c399b78f673e8892fe
      https://github.com/bluez/action-ci/commit/573ed22b5272556bbae648c399b78f673e8892fe
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-05 (Fri, 05 Jun 2026)

  Changed paths:
    M ci.py
    M ci/gitlint.py

  Log Message:
  -----------
  ci: Use gitlint to check for missing signed-off-by

But only for kernel patches

See:
https://jorisroovers.com/gitlint/latest/rules/contrib_rules/#cc1-contrib-body-requires-signed-off-by



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
