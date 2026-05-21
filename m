Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0943DA5CF
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373895; cv=none; b=qHJcSly2xYyhTKGIY3h3de4I+iWB5IsSTuxYwAMN8q142KDdQAwV+wog93k1hS+c0I53Ewuv4lDYD+3/pZpgIXHmuPDdf3GcYdxFnB97rguBkSD/aCJh7u7YxXpVrxUkDit00+kp42u1OUofkGqbOCO1sGnpVjTBXYWquXVuK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373895; c=relaxed/simple;
	bh=l3OBia6HYADBr/EyxoTC+44w+KzGnQoLKVGI0IVXDQc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bBtf8i1txReiDSAbcJyhMuQ+Hu7mHvmrIDeFxSLnlQRolD1FvkHC+VoGgAkfLMD/jYyFzUvahGayd7F7cbLRCh9xNce8lMr6eLdiDfSFzMb8WdgAbHkL3dNpm08y3SOV7BqC9ZLdQbdq0Dt7rY56Oey47kzcsWXIbEpCDeBkyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LFxQQv9i; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LFxQQv9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779373893;
	bh=5C9novFTCRyeOQ9hQk2phhe6dh2DOaXzNMktcHe2xtI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LFxQQv9iIO74+aluMTj3ZKneoE7j8UKy84jxfBP+IbNt3TqL2Ckdj4thERsGgDUPM
	 NpycSQzZdvq8Ih79HGUKmpn9adgDonsWV8uzmeowZkdM/SP6mWxnAcb2uGHmMbwvIf
	 PQZ4ZJ2uDWlupfDsWRAPRyMdvU1s9Ev/z/K/MCY8=
Received: from github.com (hubbernetes-node-4e89813.va3-iad.github.net [10.48.204.60])
	by smtp.github.com (Postfix) with ESMTPA id DAF30180B65
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:31:33 -0700 (PDT)
Date: Thu, 21 May 2026 07:31:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098658/090000-000000@github.com>
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

  Branch: refs/heads/1098658
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
