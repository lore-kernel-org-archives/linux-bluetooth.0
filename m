Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54F20F08E
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682095; cv=none; b=TQmfDQG3SjWH9wvFiP/P53thSYGEAmlkIp7iPlDwLrYtfvTHTyK4MuaMMm2hBO5mmqjXEOjub7YXyJWowEoHPr2TMoXv3c9Q0Z+zkhjkRL1XBd/I/whqq3zazggn3UryknOtDqjHoE5vYl0FcvN3U+vNm8Gd02elV/InfGVnxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682095; c=relaxed/simple;
	bh=MxNhglxUR62vQUecYMEwsg1PaRpky/xFNQolqhsMF9M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KPA5qgpU5zs3bMv/78fg0AJiFlmIWlcAbuc/DKApuwk107yToCQwt+jWAGHiwVjAKmYI4XtFciCniiBXJtcHF38Lx4/hzG5/naqIidk3mZpNX1wzyZdU3WTwe3AtzaqHRFPx6wJICryqZIK2ayZQ9JM2pSzvQJKgAtzuS/F8Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dsmh53We; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dsmh53We"
Received: from github.com (hubbernetes-node-15c74b9.ash1-iad.github.net [10.56.211.44])
	by smtp.github.com (Postfix) with ESMTPA id 748CA1410EE
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747682093;
	bh=7gPfDOxyigVhYvMXfgdUTKuIG8KZsjeSVOJVpA+cS+E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dsmh53WeQEgu5Wguriv/VIE3h/uf/1G1FPBRFa1TKbzKPfKriMLx5ipzkRZsGqthe
	 1R9ylRx0i+pJkiHXHTX8OHwd+kPv+phv/a7ypsTF2aZtNs6+p1GJ/HEH8lcOBGntCJ
	 WahP37/r9g3WheYS1T3Ec2ZYAvaMBNmPvyA3OpNM=
Date: Mon, 19 May 2025 12:14:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964210/4230a2-000000@github.com>
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

  Branch: refs/heads/964210
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
