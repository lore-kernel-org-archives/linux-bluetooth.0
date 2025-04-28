Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42B25EF8E
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854466; cv=none; b=ENI1YOM7S9zRLODl4wNxUisomsSTc/4tN3sTzpn2gBRgPLRq9TJNWElHTIpY1KaUYThr3R0lBoyfl88SnNtTq4x7ILEM0O/nxkDj2DgrOghtAyGvCXOxuDw7MIuzEzjnTltw3u0VQcZmYx7PmRcfnu2T/BV6m3Vn4J13S+AAu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854466; c=relaxed/simple;
	bh=f/KJ4Oaj79cRPIj7FXMSE523VwBUJ7wvIJYW4caCLJw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=X+swB9vu5EtVy64vo+T0rxFggIsP6mkkkFUjKH9BzwrCDb/RDFCyvfojXTFEcRIoOcoF49i2UKK5ojsagS96Cg1uyELjbCcPKHp/v9MT2Kt53N5SzmPSclpgZcHf1EVK1ThuiUwiqorsPeJvhh/ElBiz8rhI+1Kh/M34q9DI2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hfZQjKce; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hfZQjKce"
Received: from github.com (hubbernetes-node-38032fe.ac4-iad.github.net [10.52.151.31])
	by smtp.github.com (Postfix) with ESMTPA id 7BCAA640B81
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745854464;
	bh=qd+91krrLxymYE2WyWu0bLeg9R0X55jYGIKG/uMJ9XY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hfZQjKce+6uKaOOEsAO+Yy1CpZjwbyeu2WuKOAq2hAv549L+N4cU0xLeeA5Be1h85
	 RietJjz5HJP75lSyB3IbG4jkmTQhvTL8EAQuc2QdTgwmE9Qr/oFYJO7G9yEDl8kDAL
	 4ezw+S2JzZjtgK8rSU+i5TZs1vdasKqKy0zeSuCw=
Date: Mon, 28 Apr 2025 08:34:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/alert-autofix-21/f1d167-198457@github.com>
Subject: [bluez/bluez] 198457: main: Potential fix for code scanning alert no.
 21
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

  Branch: refs/heads/alert-autofix-21
  Home:   https://github.com/bluez/bluez
  Commit: 1984573513daf25b7da6b39b39a0f166c00dd182
      https://github.com/bluez/bluez/commit/1984573513daf25b7da6b39b39a0f166c00dd182
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Potential fix for code scanning alert no. 21

Comparison of narrow type with wide type in loop condition
Comparison between
of type uint16_t and
of wider type size_t.

In a loop condition, comparison of a value of a narrow type with a value of a wide type may result in unexpected behavior if the wider value is sufficiently large (or small). This is because the narrower value may overflow. This can lead to an infinite loop.

Co-authored-by: Copilot Autofix powered by AI <62310815+github-advanced-security[bot]@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
