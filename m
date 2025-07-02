Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEF2F50B2
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477622; cv=none; b=fK18ZEIVacemjt9Vr+Sog+FJka8bfKDc3o7/mkZp+O6kT+KaDB/4vEHl730SjDe2rp7iYvjQzFRAu5XX61xrQwnHxznc9+gbWTsGYdvErJvDFT2tp31VE9b9vt4DiSCuBtKmQo3MCrjtsUFPSiwMIpeiT89Ic0x8EOdlQYNtO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477622; c=relaxed/simple;
	bh=eXr9HpSHFL8ej992uFQUmO+s1vs72jHr/HTASGK1atg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LyCgqpkghoIde5DJbFS8lds5ZyKXpM87bQkv5/PkAA+GzixOK4jebigkz0Ufug5MyXeBORn8mYD1z8EB/bqI36xiHD+eEarEOzyYUxcnY4oivRVIEM/VxylPvIYIeTDvYVniEJg7LlJqgs4Sfl8FphKrvNN58xl8wPbrQnQb7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l9U+tIZX; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l9U+tIZX"
Received: from github.com (hubbernetes-node-4dc9df4.ash1-iad.github.net [10.56.128.39])
	by smtp.github.com (Postfix) with ESMTPA id 76206141256
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751477620;
	bh=apc6G3kpw7Y9B0IUNScEHZG3EHQvtK6hSD7uf9sli88=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l9U+tIZXY7YR6HhvDxQRYSECFXyY7HQE/rI0W9V3FPCgFLO7Q/8pbFZ7VAq3qeI6V
	 bDxaM06xSwGHB2oayfxv8s9st3gMzW8SpfucRSeBZs6+VWdRw7enjMB4iaFAtedYEq
	 uhJ+n8gTNP9F86z3vo9WQUCwxpFD9XkB7RS+hROo=
Date: Wed, 02 Jul 2025 10:33:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977745/e71481-000000@github.com>
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

  Branch: refs/heads/977745
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
