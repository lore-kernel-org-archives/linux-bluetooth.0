Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A612F0C79
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986150; cv=none; b=mG4bDRissBYXqGk9tF0ez7K9CfAkELo886hLw84zf8W6dY8JdDNOMFsVkF4loJ1nS8F4GW2f5yvSYDr4B6gEDJsyPngAu1oo1xzTIIMYbEhYgqJgne0ZlcHfTYNG2JyoRe87N69Aj5VC0KTkuK60GKkg95TGBRQ0W95n0BcHerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986150; c=relaxed/simple;
	bh=neZm9LBGwNzfzjKojfp4BshSvr8Q12WhBntZI9Z/bEg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j9QdYTNOIwnrO7d5bsbvCCOZu9qjVhPA5rGzuW/cHl4sh0zBvOyyeh1v5L9nrEUgPHCZDN77NePH3OJNVOP2Kw6qqukt1U7+8DcRWaO5X2BSY3knDg343ett/ykXWHjhyHt8G2Ykry10nHOJ77DMkgcNv4uBDfw76YVlgNAatcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BBeQW3hO; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BBeQW3hO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781986148;
	bh=1xdHnFHUvxbsgxObuKqet/szsKyvI0FPZuYyb6pvZvc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BBeQW3hOQG7j1hhyBJe8K3jBwtkhrGmNcmHxxigtCaJnTUF4hW4eHsILIWN2BIyBw
	 3aUJOAFajEECSuM0OcMTnkXOTNTn6/7UU/K0hvzyuRfRfULregvKZ6vYJpBvzu6KAi
	 lCGFjLEQU0kniQFTPcMgegSQr9wWRzJQaQ0YpVDc=
Received: from github.com (hubbernetes-node-b3bfa84.va3-iad.github.net [10.48.124.82])
	by smtp.github.com (Postfix) with ESMTPA id 389ED78040D
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 13:09:08 -0700 (PDT)
Date: Sat, 20 Jun 2026 13:09:08 -0700
From: Geraldo Netto <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114241/000000-dc20a9@github.com>
Subject: [bluez/bluez] 92081f: audio: harden a2dp parsers
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

  Branch: refs/heads/1114241
  Home:   https://github.com/bluez/bluez
  Commit: 92081f8ff1f50f6acd338bea9222e9bebe6e319c
      https://github.com/bluez/bluez/commit/92081f8ff1f50f6acd338bea9222e9bebe6e319c
  Author: Geraldo Netto <geraldonetto@gmail.com>
  Date:   2026-06-20 (Sat, 20 Jun 2026)

  Changed paths:
    M Makefile.am
    M Makefile.plugins
    A profiles/audio/a2dp-helpers.c
    A profiles/audio/a2dp-helpers.h
    M profiles/audio/a2dp.c
    A unit/test-a2dp.c

  Log Message:
  -----------
  audio: harden a2dp parsers


  Commit: dc20a9c9a09e4dd566a0bfa5edde8be179545880
      https://github.com/bluez/bluez/commit/dc20a9c9a09e4dd566a0bfa5edde8be179545880
  Author: Geraldo Netto <geraldonetto@gmail.com>
  Date:   2026-06-20 (Sat, 20 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp-helpers.c

  Log Message:
  -----------
  audio: reduce a2dp parser complexity


Compare: https://github.com/bluez/bluez/compare/92081f8ff1f5%5E...dc20a9c9a09e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
