Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EE35C19B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749397; cv=none; b=Jq1GwUVtaESx2+gOBONtU+1cHXfj00UnAyHUO0042xZ3jRaWZsOez7OHddXLvoaBjdcquAOfF5y1uF69VAavQSCKLwFQA3l0Lai0Z5XObcG+Lb2pqO8zx0fpSYBozYqbOJ+BNhyKs2BOhjvl4PAPgFsbkPxb/w0/4tUTSNySUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749397; c=relaxed/simple;
	bh=1+JDCmTsCui9ATLCkKqOMmMXVGSGRZI6EUkLyVxrFaI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J27rlrA1G9HUdps/8PRIQ6QrJjkhY2jXZfc9aR7LgraDFxyC0QHPtzigyo0ucJwGrSoIomTaqlUhg3n7vW61NGz3344tbkvEar+0IO+Lni8Z08zvbKw7Mb8cCasPZgpAUUbcygFFmlJ/YfiI95bANtiR+1KHXb52zcmWdNSVFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UHTxM/pJ; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UHTxM/pJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784749395;
	bh=+ZnF+Zh3iicYkN9oa1VYTcLgmBKQi4hg5GntZ5uB3GQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UHTxM/pJ6IiYekUMn3C76rxC3YTkYfupkrBh7Z2ZikuYeKNNSOdkhEO2JSRCce9Lw
	 jJA+uIpOlzsY4EP7EqRHutmw2UNaxVhNityePdHU0sOjDbTPkOOHGtV13goWk+RgJD
	 pnBazJC5zVuLYWggGVgZ+CWQMEJxi3SsJfQzP7Ww=
Received: from github.com (hubbernetes-node-d7b6d35.va3-iad.github.net [10.48.75.85])
	by smtp.github.com (Postfix) with ESMTPA id 42BE6341317
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 12:43:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:43:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129618/9efbc3-000000@github.com>
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

  Branch: refs/heads/1129618
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
