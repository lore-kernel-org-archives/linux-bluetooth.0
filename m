Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7B481A88
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930557; cv=none; b=inrBn1letNrLwVytqGEJaiIStQF7obNKWH+K9y1vvec8/3CSaE3Ny88BU2rKZzJ1Y9jsRv1GLf64hpdfgCNXc+2Duucr+BgBoTCr+cgRO5lKgfys4oKdwvJtweQLoaRGO83I3NSgpTkoN6R81Z68KnRa/fragHfFPg4Kq2qM3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930557; c=relaxed/simple;
	bh=OcST5n0HzQsOt+NESiFjVyGrhOLmtrH5ByAKqo7wr5U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s96vX8JFPUJ+ZhvJ6REUuzsIZ5zLBxgZmx+MyMdboTMKR11+mQicJqNSRZHUlyPuGTx/FOUQSZwY8KTZStBaOh6L4KrtZZCU3OSkj/NginEITSnRIWADiRNqOhQaTxC8aFPX8sEdiG2c6psyRcHKg7H7ezcDfWw+UR/asUAs4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k+Gbj1Db; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k+Gbj1Db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930552;
	bh=xpqIdlCg5y+duSCJglj0urADq8/jwbABA12rip+FcVc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k+Gbj1DbJwzMmuV8ILToqF/nM/xWX1LIS1HaRWXYtjUE/cb51PqYCj/ExtgEu5RHS
	 VRrVKYMylDAfACzOSlM9X6Lp11GBoxR83vhwSQzDs1pytHWKdyMKGCT15CJbnczA1Q
	 aytMLEa5PHbPWwX9rmH+b4e8a2FGcg4ryYWuK3FA=
Received: from github.com (hubbernetes-node-bbfb7fe.ac4-iad.github.net [10.52.86.25])
	by smtp.github.com (Postfix) with ESMTPA id 6BF2DA0536
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:55:52 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:55:52 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107813/000000-3c59a0@github.com>
Subject: [bluez/bluez] 3c59a0: device: Fix cache update on device remove
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

  Branch: refs/heads/1107813
  Home:   https://github.com/bluez/bluez
  Commit: 3c59a00a62750b4a8c78db5334c7275c5cfa7a46
      https://github.com/bluez/bluez/commit/3c59a00a62750b4a8c78db5334c72=
75c5cfa7a46
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix cache update on device remove

If there's no other group than the one explicitly removed the length
returned by g_key_file_to_data() will be 0 and currently nothing
will be changed in the device cache file.

If there's nothing to write, remove the device cache file.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
