Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D04374E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696607; cv=none; b=IMe4BWzCBkFeChLAZRl7wasAP/h0opyrwxYLB+/5X3VBDISpM3kMvSRdTN6cB+1txSp78FblrZ30Gz9b0nKwKeNygl0Pj6bvBhIO+nnuk9e5HEvxNX2afDhWKEN+bVV8KdPHT3q1hgZF300JkNRqsRuazldZSc+o2bLm/6YhTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696607; c=relaxed/simple;
	bh=qxBf3Iba6sMjaYQKCG6GEjxB1gRUXL4TS0Sx1MdnIL8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dzLV98XIKn8R6yYOs7tcgf81t5sufhcJ8mfkaQW4TfJ+Ky0e0HXKB2D8imcpLo7PCKxtFVa5FVo8N1L9qBY/3E4Umw28h5ny9NOmnxLa7h7yLWGzshb3KowKodkIasTNmpXmjizD9oY/vdBeIXbz1BCd4VCuQZnz3gvEXK6XimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lsbY/pO+; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lsbY/pO+"
Received: from github.com (hubbernetes-node-b6b8be6.ac4-iad.github.net [10.52.130.35])
	by smtp.github.com (Postfix) with ESMTPA id C25AD6411BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705696605;
	bh=I/FE7R9kZH7J33/EgkGgZZOxqS6KD5y0GsD27nm23tY=;
	h=Date:From:To:Subject:From;
	b=lsbY/pO+gYLScFTdcssVji3B2mmh6sQG3zxXwdxjcv393Qbt/AYSmBN2oJkIEMBoA
	 /9vFCWVFuD1Qh+R5R/KvRpWwS83bpPz4DAB+YudIh1QtAMctUtuppis2vsaL1fjFuA
	 3Xl6y3bAI/HNDVd11zeuroPFTU/WbFxYFqBbImzk=
Date: Fri, 19 Jan 2024 12:36:45 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e108c7-2ef2f1@github.com>
Subject: [bluez/bluez] 4908e5: player: Fix endpoint.config for broadcast
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 4908e58bd1a953d2a48c543d15b246b9f69fddf6
      https://github.com/bluez/bluez/commit/4908e58bd1a953d2a48c543d15b246b9f69fddf6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  player: Fix endpoint.config for broadcast

endpoint.config where taking different arguments for broadcast which is
not recommended with shell as it doesn't support such a thing.

So instead of taking different arguments for broadcast both remote and
local endpoints shall be passed but in case of broadcast source both the
remote and the local endpoint actually refer to the same endpoint
registered by bluetoothctl:

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep2 16_2_1


  Commit: 2ef2f122e60826ee3f4acff150bbce4cb262eeb3
      https://github.com/bluez/bluez/commit/2ef2f122e60826ee3f4acff150bbce4cb262eeb3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: Fix crash when attempting to setup a broadcast source

This fixes a crash which could be observed with the following commands:

Run bluetoothctl -e:
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep2 16_2_1
> transport.acquire /org/bluez/hci0/pac_bcast0/fd0


Compare: https://github.com/bluez/bluez/compare/e108c744fa8d...2ef2f122e608
