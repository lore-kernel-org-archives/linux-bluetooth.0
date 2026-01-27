Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7D2EC09F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534801; cv=none; b=F5HD+bpjBZfpQIxfjN4moyyMVF+jisYxPULSAtXWROmK1lKlRkPvcCxgPyoYG/mKjpwUUJboHUy1hzqWi9iFoujRT5hL+FV4Q34O3YEsmwo7uRgHsNX2afQ7epl8RveVrsxNK0RQhMKUUXlVq3xnX6J0aFldEs+oZkh/5RmbHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534801; c=relaxed/simple;
	bh=OQjjkHv6d8nARJJS9YtRwBjpYJRJVV3CtFaJ/ohCqHI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZpXZ0R7HD9GNaIzcinr/RG6EHpfPq5hiIV4o38tzGOFvT1KO2shLHiF5kGlNVLVnlJBUqFJ7hxvpTXPPKJYQ3iEF3qcNJ7dce1xSb5FaBoPo+C6o/gXkhJRgnfvAy+CgkXQxmZKSlawSyREbM3R9vk3IBLDkhYeNYzQP+BdhHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iFUy4SOJ; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iFUy4SOJ"
Received: from github.com (hubbernetes-node-fb7c32e.ac4-iad.github.net [10.52.130.37])
	by smtp.github.com (Postfix) with ESMTPA id 5F87F6412C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534790;
	bh=HhBasUXxHIHqXbTPCsqK2gv69lkXZBj8PtBny6VAgYw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iFUy4SOJIpLGSZh8r8OWEyu/YMx/wNfm7cmMTCTd15lB1Rm/33XsS/K7+lXDrjxiH
	 48B1G68+Jk/dmKCR64rKc/rfFS5zgiFQaLTaX5/sikla9HA46gJl09JX928vSKPBy9
	 worMn1MNDyCs15gI2serx7BK5iaw5gTSB4IoWNTs=
Date: Tue, 27 Jan 2026 09:26:30 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047698/000000-96c51c@github.com>
Subject: [bluez/bluez] 96c51c: doc/qualification: Add PICS and howto for the
 SDP ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1047698
  Home:   https://github.com/bluez/bluez
  Commit: 96c51cbd710bb954492f59c5e298d3e3869c2964
      https://github.com/bluez/bluez/commit/96c51cbd710bb954492f59c5e298d=
3e3869c2964
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/sdp-pics.rst
    A doc/qualification/sdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SDP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
