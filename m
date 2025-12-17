Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77F359713
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993731; cv=none; b=VQS2z3Eb/S5nVKL0B+zBoVgCFKGLPJwbLWT8BY6/YvQELhFjvHL8FEhtcbLWgACjScRCpqOlOTPiokjuvZNOBej1SmNuvGbJbQjCEwYpzVDKhhbv8rkWpxfjT/f/hPnNVcdQLrOV/agtXChM/fwNrslJU1Nm4jN2QtaAi0aUIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993731; c=relaxed/simple;
	bh=7gkgVp+y1ZglN6j7UqG5A0IVIY2bXrHkDMVB3IHl9Xw=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=tAvTLKKuUY/3Dv9WTYi4GOMdtvFiWFUOUcHDrccMM8aNH6yzftLIBsWOfag6ymIQ1uSB8B2xaCYjr8xv56htyrBuZRp+wOyGERktMYjz5knSrpUtulVswjR0aJbBlmc11SHNH/F6YIHUfAS8U5D7uI/oQzFXCwbFz5KIG949GYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=llvJq9K4; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="llvJq9K4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=5JWTobkjK8zwRNO4BowqZmZhHQNJGawE+o480fIoFeg=;
	b=llvJq9K4s5S47K7bFAqxta+h+x89E3mmb8ac4k6G90BN9Bc2X1Dt1nzsB2vIePhihBWf
	3fLzscb7cEHNHN+c3JioCBanlujIHPOOg6Mw7o7BxqIxxytSPB1e143zvbfcq0IYVBVjXv
	0SXkpcqZqwYxS81l3ZtnrFh/8BazqD1Xg=
Received: by recvd-7575ddc4f-fq9l8 with SMTP id recvd-7575ddc4f-fq9l8-1-6942EA55-B0
	2025-12-17 17:37:25.95495576 +0000 UTC m=+2570740.375168435
Received: from out-25.smtp.github.com (unknown)
	by geopod-ismtpd-51 (SG)
	with ESMTP id LHFjamhNTZuPJhShXZ0a3A
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 17 Dec 2025 17:37:25.923 +0000 (UTC)
Received: from github.com (hubbernetes-node-eb75fd8.ash1-iad.github.net [10.56.200.80])
	by smtp.github.com (Postfix) with ESMTPA id 45AA5141147
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 09:37:19 -0800 (PST)
Date: Wed, 17 Dec 2025 17:37:25 +0000 (UTC)
From: fdanis-oss <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1034282/000000-d11bfe@github.com>
Subject: [bluez/bluez] 5080e2: audio/hfp-hf: Add Operator name support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EkEW1ILLE7+TyiFtG2yqjE93HGga+mz2MoI5EtQ9frJ7vCSIJzT95OeHq1?=
 =?us-ascii?Q?dtSDtzXJma3sKP+2lS4z80FC7jtM1NL3RkV5C1n?=
 =?us-ascii?Q?GkIQbt=2FbOH5uQKK0jywsSeB+WVJE3QQ36OXgh9z?=
 =?us-ascii?Q?QF1ZoGaZGTL7qj9phfUveoDy1OYWku97gHF4w0k?=
 =?us-ascii?Q?HOdHZzLyCCO6OzBfDhI2DasjEWJTztYc3ch4itI?=
 =?us-ascii?Q?3pbcCHYZ3qYdOk0fCKi1hH0ajt+pxoWtHt=2Ffqr1?= =?us-ascii?Q?Vd8a?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1034282
  Home:   https://github.com/bluez/bluez
  Commit: 5080e20f5295ce6784b002cb9f414e24dc9293d9
      https://github.com/bluez/bluez/commit/5080e20f5295ce6784b002cb9f414e2=
4dc9293d9
  Author: Fr=E9d=E9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Operator name support


  Commit: 10bd1045426cb5d3e180f866de0c65a68652da50
      https://github.com/bluez/bluez/commit/10bd1045426cb5d3e180f866de0c65a=
68652da50
  Author: Fr=E9d=E9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add simple call support

This allows to dial, hang-up, answer or reject a call.


  Commit: d11bfe40f42694e7a0dd503ae58a3cba98ccae06
      https://github.com/bluez/bluez/commit/d11bfe40f42694e7a0dd503ae58a3cb=
a98ccae06
  Author: Fr=E9d=E9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add in-band ringtone flag support

This flags is set by remote phone when it wants to play the ringtone
through the audio channel.


Compare: https://github.com/bluez/bluez/compare/5080e20f5295%5E...d11bfe40f=
426

To unsubscribe from these emails, change your notification settings at http=
s://github.com/bluez/bluez/settings/notifications
