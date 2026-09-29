Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CB400963
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708212; cv=none; b=Q/8nBZbD8LBXpEe7TPwbzTKKQ8RrYCaKTUysNvMGow0ujVf6M2/nDDCATGrjTWHdclFnZOoyGDWGci3nY6itcvcyw/D7Y5I0XKC/Tmy2Yj+YwgHP4NLzrK/k8MDxIQOilU1pxAf30/w++4HM/1DWcjfBdvs7xJeFC0+C+hjPhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708212; c=relaxed/simple;
	bh=Q9NwpnOfSuO6wChBFaQ1YWtq84x/PVB1PUUaDy9o7xo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q8pPXqH0YfxBd9lDz8KwKdU5Qnm7YUBvF82gJIxXqf4+UyTsyqGjKMSfflt9vx5uRPXtr6WFR94XQ0DxUr+Dde/2TikRTrP6ztESMakmTBLqCDACGT8yuTnXLAVsYR/fUV4sbO7KDY+5V3Y2N67exaoAdnaCY0eASli9HEwnbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=MLa+WwL4; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="MLa+WwL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790708210;
	bh=XY6hGR18BTDjBbYiHS9JIEZ61g1SahgygDs8xWUfSpw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MLa+WwL4aD8XDMDR7qQlrcdE/l1SqmE4x9q/CHxG59hW1vdIRqIf9iZ+LvaGc+MYd
	 obwiLqDtKyU7u1m1UqUymFOj2Kdrr+RCVt+1riuGfp4zYO5lTkbUE8+k8iOo7E7nwG
	 9EDnhtGy7DrOVPkH0L0UcvGnGz2V6ACBSqpEwrwz7KJ1vzoA144wdUYDdNmtcpOTuA
	 kS9uQB0ujwZBckZqSV0t1Bjm3Ui6OdYjIbx1EuCRSjMPFAbYnTNDMgJFaldZ9EwwHC
	 UNMfMMJOn/3esbJBW1RpgMdw9LtIUjAMc6MEmHLgREyqDIB3WGb+hpHUYqH+zgWP8L
	 ZUhs7q7D4SrMQ==
Received: from github.com (hubbernetes-node-038e647.va3-iad.github.net [10.48.69.62])
	by smtp.github.com (Postfix) with ESMTPA id AC020800AA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 11:56:50 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:56:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175582/fe7cbf-000000@github.com>
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

  Branch: refs/heads/1175582
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
