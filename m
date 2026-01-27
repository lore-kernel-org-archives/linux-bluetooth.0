Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FE15530C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536225; cv=none; b=jYc33t2+bLBSM/8SrpinFr93y5PnXMPUi/eqND1P3Gh/ZwdI+jdZORelMnwTcwmNKt7qouSBTxYA+7xXx5dSw+Ymi/AlugxEh/ZTmo5AzjxPec0resKO3Hhg8wMpp5itvutSepvoChA/mvUzDftOuGN5COUko6Q9HLaN4Q5Jskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536225; c=relaxed/simple;
	bh=du3ndfwwFMVeKdCzuXpTMsTMXdZ0iihUMqwkHfNsrHg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V6Ptdpd6Uney2xZSNicfFe++F6XKm1rmASjiX/ilrrTfLLrCyiAST1y+a7fUzOT5HfF0z0io3xTuPfY2nS5obNCM+7rRg0yz9fmUKm69sKlGQMJPtFv1H6A2uyiKAi2+oQ43Mi7Z+g+A5CO6OT5eTPRJF4oi2ixNONpl/A15Pwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=USt7oQPI; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="USt7oQPI"
Received: from github.com (hubbernetes-node-892f686.ac4-iad.github.net [10.52.173.50])
	by smtp.github.com (Postfix) with ESMTPA id 8AFAE400DEC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536223;
	bh=2JamsjBcmrE+XMlhcZBrPalu2KigJlG7qmSmCjxvD4k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=USt7oQPITDRhzSW1F4EQ0J1xlPKwlr+c8PwHXHuSuxpnH1a/1OQNBkU0SrAb+sygd
	 KlUCGmgxwMN04pjab3NlIF8fD2TmwU18mv70VGEKwinTpG4jOTY+fkoMJOp/aYwuZH
	 csdpZW6PMd2GP9cAB6Ta5r5LvdmxF7sSKXrAbt4I=
Date: Tue, 27 Jan 2026 09:50:23 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047711/000000-9f3e9c@github.com>
Subject: [bluez/bluez] 736fb5: doc/qualification: Add PICS and howto for the
 A2DP...
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

  Branch: refs/heads/1047711
  Home:   https://github.com/bluez/bluez
  Commit: 736fb5569647b15d07a6532c0dd68a8dbbd68c14
      https://github.com/bluez/bluez/commit/736fb5569647b15d07a6532c0dd68=
a8dbbd68c14
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/a2dp-pics.rst
    A doc/qualification/a2dp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the A2DP qualification


  Commit: 3b131bcd1abae3ef1e2a2e484b60a198dd926ff6
      https://github.com/bluez/bluez/commit/3b131bcd1abae3ef1e2a2e484b60a=
198dd926ff6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avctp-pics.rst
    A doc/qualification/avctp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVCTP qualification


  Commit: f687525f1905eaef914f30904c4dc4bf2955de14
      https://github.com/bluez/bluez/commit/f687525f1905eaef914f30904c4dc=
4bf2955de14
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avdtp-pics.rst
    A doc/qualification/avdtp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVDTP qualification


  Commit: 7a35fc403549e1ec6485b2982b53e611a6dd120b
      https://github.com/bluez/bluez/commit/7a35fc403549e1ec6485b2982b53e=
611a6dd120b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avrcp-pics.rst
    A doc/qualification/avrcp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVRCP qualification


  Commit: d80c82c8be1b209cbee05630ec82ec281da743d7
      https://github.com/bluez/bluez/commit/d80c82c8be1b209cbee05630ec82e=
c281da743d7
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/gavdp-pics.rst
    A doc/qualification/gavdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GAVDP qualification


  Commit: 3930ee94c4334496e00dac0e75f5795e365e643c
      https://github.com/bluez/bluez/commit/3930ee94c4334496e00dac0e75f57=
95e365e643c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hid-pics.rst
    A doc/qualification/hid-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HID qualification


  Commit: ca59e41e1769c936cfca31ae213b98082bdc1533
      https://github.com/bluez/bluez/commit/ca59e41e1769c936cfca31ae213b9=
8082bdc1533
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/rfcomm-pics.rst
    A doc/qualification/rfcomm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the RFComm qualification


  Commit: cd79f886155f85a694b3e563fdb1fe62257c7fa1
      https://github.com/bluez/bluez/commit/cd79f886155f85a694b3e563fdb1f=
e62257c7fa1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/scpp-pics.rst
    A doc/qualification/scpp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the ScPP qualification


  Commit: d61f132ce1dd5d205dc89f29c8dd4cf8942865c8
      https://github.com/bluez/bluez/commit/d61f132ce1dd5d205dc89f29c8dd4=
cf8942865c8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/sdp-pics.rst
    A doc/qualification/sdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SDP qualification


  Commit: ffc1be2747f2f60b5e25477c456661edf5bf0841
      https://github.com/bluez/bluez/commit/ffc1be2747f2f60b5e25477c45666=
1edf5bf0841
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/spp-pics.rst
    A doc/qualification/spp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SPP qualification


  Commit: 0972dff0c643c9fbbd8e6a53876c55947c257c49
      https://github.com/bluez/bluez/commit/0972dff0c643c9fbbd8e6a53876c5=
5947c257c49
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hogp-pics.rst
    A doc/qualification/hogp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HoGP qualification


  Commit: 64d5f82e39daa6f686a945f114c3181305a77188
      https://github.com/bluez/bluez/commit/64d5f82e39daa6f686a945f114c31=
81305a77188
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hsp-pics.rst
    A doc/qualification/hsp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HSP qualification


  Commit: 9f3e9c6b77212de228fbcdc4991125070e02dd16
      https://github.com/bluez/bluez/commit/9f3e9c6b77212de228fbcdc499112=
5070e02dd16
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/iopt-pics.rst
    A doc/qualification/iopt-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the IOPT qualification


Compare: https://github.com/bluez/bluez/compare/736fb5569647%5E...9f3e9c6=
b7721

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
