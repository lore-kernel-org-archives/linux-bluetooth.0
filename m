Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1B263F2D
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155081; cv=none; b=ODzVGXo9jSwPjeBp42dtmclMN6iq1xTqvRw7KyINa+I4cP8ZPMSTqhxIsqovWATiKUCS6cWThzVC7U2kJTFFY9z5MIWQf4urIyLDSCqwnvBSfZbo0ftToB0GdNmz1ZiW1cs3VUY6AqwFaiJkz1g2VromdZLBWynxF96W58ny+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155081; c=relaxed/simple;
	bh=jPrshL8qnlNWjzCdCUg3VC6CSuDWETBQpAgiAi/R4+A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FEzHdTXHWxpX0prWsEW3jIulerq7XmLmrwR9Sh/53bccmdTUKUbgvBuWb9GM0YduOejTT/jlM0QWUWU7E8tULpLPjzuGN3feDQic+3PxW1kfkuzkTTXGGeJErfLx2NG66Ys1oDzmaHXyEs/fHQmYc6gX8F3VfLmgnmi4mFrJ8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=c88tlIfh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="c88tlIfh"
Received: from github.com (hubbernetes-node-e3fa9e0.ac4-iad.github.net [10.52.166.22])
	by smtp.github.com (Postfix) with ESMTPA id 9476D640979
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766155079;
	bh=M90CiyDgb1XWaLcXW3d8cZwn4JW+N2s5rR9VcZlOsM4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c88tlIfh/dYLcwlPc02MUkw/HVNTVQx45lxbeFfwD8J7xK0QyMCZrTBHyIAcKbsN+
	 2OqT0odbMNGzV0dWfmKCulSRpKBlyrvdjbJgpVo+s4xrygTk754kq2KUtiRrSsSs3r
	 0bUsL4eemDewavoHFICuyWq+N1DUzqpWz2T0/ymU=
Date: Fri, 19 Dec 2025 06:37:59 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035059/000000-ad7749@github.com>
Subject: [bluez/bluez] c5ef28: audio/hfp-hf: Add Operator name support
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

  Branch: refs/heads/1035059
  Home:   https://github.com/bluez/bluez
  Commit: c5ef284c44ab31598e1ab862e3685057ebfdee81
      https://github.com/bluez/bluez/commit/c5ef284c44ab31598e1ab862e3685=
057ebfdee81
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Operator name support


  Commit: a8c403f5833b4d5f3be17bc37a7cedebe8348196
      https://github.com/bluez/bluez/commit/a8c403f5833b4d5f3be17bc37a7ce=
debe8348196
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add simple call support

This allows to dial, hang-up, answer or reject a call.


  Commit: ad77493dd3fac10d1738a6e5c6969a464718016b
      https://github.com/bluez/bluez/commit/ad77493dd3fac10d1738a6e5c6969=
a464718016b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add in-band ringtone flag support

This flags is set by remote phone when it wants to play the ringtone
through the audio channel.


Compare: https://github.com/bluez/bluez/compare/c5ef284c44ab%5E...ad77493=
dd3fa

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
