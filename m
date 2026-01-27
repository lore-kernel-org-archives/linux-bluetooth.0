Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEF3271F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539207; cv=none; b=LA2PiZ2h5PusPnbLlNP8m5MkCBPuu7piCMlu/JGvQZuY2KT2XEHiRsrEu1yqrGBK9xjY/k155mRdwu9PcwJT/zNE45/QZk8OsjqtNAfMjHZ+hyDqpBDbo3T47G9HMa7fgpu6AP8TTsAg+Ks1TLsbOrrIZ14g9UqvtE2Xb+N8aVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539207; c=relaxed/simple;
	bh=devRimQBQ/soXmD2WFAIhFWB7+MHEatglg5gjIBzO8A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ag8Rhq4r92jVEjnIPe9UN6TlT1iXalRtYftfqGIHZHY9YfxU8qJ3tftHu2bToN2zEveGwoO6zp/HSRPwM+9kLR+he3IBqNH452JR7iP2pnPx7Aef2Sj5Fu5O+3hXn91P9Pfmql2aeOHYMfx/74rSiyUFWxKaaE60TQBJWS4PJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i5s/A4rP; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i5s/A4rP"
Received: from github.com (hubbernetes-node-9f6e463.ash1-iad.github.net [10.56.185.35])
	by smtp.github.com (Postfix) with ESMTPA id CF02A600A3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539204;
	bh=MCDq3kjo2trBX9DW2R0M6lLfdZNMg/ofH9/7l0KGejk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i5s/A4rPv3Tjk8d3PC7tY99BwooGa/9l2siPtkO/sxYoDUzIP2mvhKk8haF+3FtCA
	 WeduaVDzkry/b4hdORHH+ZjCjFD4ex6j6NwJhRj4JG6uEY82OqmoHG0ln7iKb5E6fY
	 oDqC3kcMiohPCo8qJf6D0KlvF+x6qTs4otHAmO50=
Date: Tue, 27 Jan 2026 10:40:04 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4e43a6-a3c0aa@github.com>
Subject: [bluez/bluez] 72e756: doc/qualification: Add PICS and howto for the
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 72e75617ab8e387ac7145ebabaf40b959330de07
      https://github.com/bluez/bluez/commit/72e75617ab8e387ac7145ebabaf40=
b959330de07
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/a2dp-pics.rst
    A doc/qualification/a2dp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the A2DP qualification


  Commit: ae788af205adc3332e613bf7bf31d825cef0d9f7
      https://github.com/bluez/bluez/commit/ae788af205adc3332e613bf7bf31d=
825cef0d9f7
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avctp-pics.rst
    A doc/qualification/avctp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVCTP qualification


  Commit: a54bee4668f4a4d777ce6f9e1a767e17d5e4628d
      https://github.com/bluez/bluez/commit/a54bee4668f4a4d777ce6f9e1a767=
e17d5e4628d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avdtp-pics.rst
    A doc/qualification/avdtp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVDTP qualification


  Commit: 3a6a1cc0c8989091b69fde665d9be46fbd1cbaef
      https://github.com/bluez/bluez/commit/3a6a1cc0c8989091b69fde665d9be=
46fbd1cbaef
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avrcp-pics.rst
    A doc/qualification/avrcp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVRCP qualification


  Commit: 4a38072ba45e6f893be3c61c65e9137b33128063
      https://github.com/bluez/bluez/commit/4a38072ba45e6f893be3c61c65e91=
37b33128063
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/gavdp-pics.rst
    A doc/qualification/gavdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GAVDP qualification


  Commit: d4a8e19cf91160441fc4df90d352c068a93dde9a
      https://github.com/bluez/bluez/commit/d4a8e19cf91160441fc4df90d352c=
068a93dde9a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hid-pics.rst
    A doc/qualification/hid-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HID qualification


  Commit: 04d67cea10f75e00c1f424ac4b333eaea59186fb
      https://github.com/bluez/bluez/commit/04d67cea10f75e00c1f424ac4b333=
eaea59186fb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/rfcomm-pics.rst
    A doc/qualification/rfcomm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the RFComm qualification


  Commit: 9621ab4d51c5c965540f07b10ec7cd3acbb92693
      https://github.com/bluez/bluez/commit/9621ab4d51c5c965540f07b10ec7c=
d3acbb92693
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/scpp-pics.rst
    A doc/qualification/scpp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the ScPP qualification


  Commit: 516b7adfa7a336bc9cf1d7ba16885427bfd648bf
      https://github.com/bluez/bluez/commit/516b7adfa7a336bc9cf1d7ba16885=
427bfd648bf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/sdp-pics.rst
    A doc/qualification/sdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SDP qualification


  Commit: feecc7f60de884a22c1cc0faa9d4ed95a30b08f9
      https://github.com/bluez/bluez/commit/feecc7f60de884a22c1cc0faa9d4e=
d95a30b08f9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/spp-pics.rst
    A doc/qualification/spp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SPP qualification


  Commit: 402d0c52ac4071a8bdf33ec52bd96de63f9c23d8
      https://github.com/bluez/bluez/commit/402d0c52ac4071a8bdf33ec52bd96=
de63f9c23d8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hogp-pics.rst
    A doc/qualification/hogp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HoGP qualification


  Commit: e4b4db9702e6e535432475f66b2a098cfe256c03
      https://github.com/bluez/bluez/commit/e4b4db9702e6e535432475f66b2a0=
98cfe256c03
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hsp-pics.rst
    A doc/qualification/hsp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HSP qualification


  Commit: a3c0aa5fc106b53c939aec2bd526dc58f4e09065
      https://github.com/bluez/bluez/commit/a3c0aa5fc106b53c939aec2bd526d=
c58f4e09065
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/iopt-pics.rst
    A doc/qualification/iopt-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the IOPT qualification


Compare: https://github.com/bluez/bluez/compare/4e43a6283736...a3c0aa5fc1=
06

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
