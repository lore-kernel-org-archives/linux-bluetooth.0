Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30E152E02
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424101; cv=none; b=it8b31Xsy/6mPwysjoR3SAhUsRbHHNXDGyqKbweKASgZ1jFU9+bNRvMmAszAQhhZ9OkF+PVpBVlmhTSseZ2FXsVm1Sd0MfG5OE3VTdlAhAfDU8kuxtRbW/UG9N1MnD8UEBTgzSume3ZbDMy1B+G6qcf3mU+JpM9dsjomtJpDXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424101; c=relaxed/simple;
	bh=5Vc4OXwjZTyl4wK4KRe1F1ylLXOELgB8lxn/CxtZaiM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N6N+wqmY8nzb6QGPuGgSpQ+HeuPe8rw9Q7cqClY5BxbTC7h73C7Ilq9K32b45AULDDDHV0KKZAacivJT0q4mJmds4p99c/kGWDOoJhOkxOzHz/zS+0xKtNdEigGugI/ohCyULGdTojplavg8k8XISPQKbISN85uFmV+M4+22Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lP/s9Sx9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lP/s9Sx9"
Received: from github.com (hubbernetes-node-4151e64.ash1-iad.github.net [10.56.206.77])
	by smtp.github.com (Postfix) with ESMTPA id 4AF1A600C72
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748424099;
	bh=OYu+EXzCpEzN3qOdEdpz2NuKv/RISxFXOAm1U9ptnjA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lP/s9Sx9tUXnaZfGr5vjssTLDdaqoGi+3ZTLlmNlOuL5vdWl6g+7uCqHtUAUY7X3c
	 rTXG/UStKKtFI7HjYQTybIPzsa5ERA3C0jCXSOR7HxN20S6ePgkuQi4pWaInQqGg1x
	 ZNT+N60w5eFpmdC9RK3IDWbom2DFNlA3T/nuXyBo=
Date: Wed, 28 May 2025 02:21:39 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966926/000000-cf0bd7@github.com>
Subject: [bluez/bluez] ad0031: doc: Add new telephony related profiles
 interfaces
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

  Branch: refs/heads/966926
  Home:   https://github.com/bluez/bluez
  Commit: ad00313e0c6f830380eac292446432ec2cacfd38
      https://github.com/bluez/bluez/commit/ad00313e0c6f830380eac29244643=
2ec2cacfd38
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.TelephonyAg.rst
    A doc/org.bluez.TelephonyCall.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.


  Commit: c3a727151928c43a30f74cfaea2b196fbc374b9a
      https://github.com/bluez/bluez/commit/c3a727151928c43a30f74cfaea2b1=
96fbc374b9a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    A profiles/audio/telephony.c
    A profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add shared interfaces implementation


  Commit: 6832e10ad2f29713bf4e66d93483381ab0058ec8
      https://github.com/bluez/bluez/commit/6832e10ad2f29713bf4e66d934833=
81ab0058ec8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/telephony: Add skeleton for HFP profile


  Commit: e45b3da83101bcc5ed3b03c10db17a061b33fa5e
      https://github.com/bluez/bluez/commit/e45b3da83101bcc5ed3b03c10db17=
a061b33fa5e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP SLC connection and event support


  Commit: dd6fcdb4bd0785e0a45e684222562f81b51c9b51
      https://github.com/bluez/bluez/commit/dd6fcdb4bd0785e0a45e684222562=
f81b51c9b51
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add dial support


  Commit: 4e3f6631e41afc9e3c5c9560fe4ca257576c921b
      https://github.com/bluez/bluez/commit/4e3f6631e41afc9e3c5c9560fe4ca=
257576c921b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup all calls support


  Commit: 583f0999ac665ebfd10b5efe7c0fa95c44be5b68
      https://github.com/bluez/bluez/commit/583f0999ac665ebfd10b5efe7c0fa=
95c44be5b68
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add answer a specific call support


  Commit: 5c9a157d8fb6e7d7eeef5f3144b66d9ef1c2acc8
      https://github.com/bluez/bluez/commit/5c9a157d8fb6e7d7eeef5f3144b66=
d9ef1c2acc8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-telephony.rst
    M client/main.c
    A client/telephony.c
    A client/telephony.h

  Log Message:
  -----------
  client/telephony: Add new submenu


  Commit: 25a77c37baef52e0f424b6d478fffde7b17fca19
      https://github.com/bluez/bluez/commit/25a77c37baef52e0f424b6d478fff=
de7b17fca19
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Remove call interface during profile disconnection


  Commit: cf0bd7155f214c81d41c0462ee1c306732f4bd2e
      https://github.com/bluez/bluez/commit/cf0bd7155f214c81d41c0462ee1c3=
06732f4bd2e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Create existing call during SLC phase


Compare: https://github.com/bluez/bluez/compare/ad00313e0c6f%5E...cf0bd71=
55f21

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
