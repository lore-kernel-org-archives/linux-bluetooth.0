Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CC327BF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471976; cv=none; b=BSSd+yvuDeEEhlk5Ta1lmnN7W9s6JnkBbLS4udmSglvObSR24/YQ9rdssypqq3wovJPdxeXoMOdIrkAs7NtZ4EEegom62hWXiTkY4YJy36Kj1efHa7uTNguj59/urXkt2el+ziLRgDjYYcIkxlaHzHwldewtO5APXcoQ7p2Yo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471976; c=relaxed/simple;
	bh=j75kNfHSewxsrsigE7kZ/bs4SbPusqstXTzeCsmxcdc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UclkglcTL9C0J07VXzgsgZA6v2UcacnayJBDPFJbTAH2/Vc2k5Bsb9eFeVSW+GUHY/sOfwobt3Lp6+8pyuQujt0lZYS/lF+0qEEc9XPBukPh/m4JRhf5tAXXqWo5GoAIh9RaxIyIKRbbzjrKag80J7zpPPMJyoDJLja42M6CuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f3a0uK2O; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f3a0uK2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779471973;
	bh=4JwfnxZccbe4xmDsaS1lcf16q/vPTHMY4Co4lIaH+Wg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f3a0uK2OmAqVXYNrwXOUjNoNITDjkjHSD1DTcT/+o1KZJ3S7ok0VzEluVlY5rYy/r
	 noCrruz1D3cg+qZDnAlB3pl2ng8afqXBZkA10bbVYmy6/xkOW0S/dOTsorDubjI49t
	 Gpn47xKS4Qir7GQIhjfxzBCtjX++qi7X8hoDbw+Q=
Received: from github.com (hubbernetes-node-d9360c5.ash1-iad.github.net [10.56.164.50])
	by smtp.github.com (Postfix) with ESMTPA id F2D1E9210D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 10:46:12 -0700 (PDT)
Date: Fri, 22 May 2026 10:46:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099512/000000-41cabc@github.com>
Subject: [bluez/bluez] 41cabc: test-mesh-crypto: Don't attempt to run test if
 AF_...
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

  Branch: refs/heads/1099512
  Home:   https://github.com/bluez/bluez
  Commit: 41cabc74bc4c769d4fecddc592d5ee54dac68aac
      https://github.com/bluez/bluez/commit/41cabc74bc4c769d4fecddc592d5ee54dac68aac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-22 (Fri, 22 May 2026)

  Changed paths:
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  test-mesh-crypto: Don't attempt to run test if AF_ALG is not available

This make use of mesh_crypto_check_avail to check if AF_ALG is available
and if not just bail out which is similar to how test-crypto handles
when bt_crypto_new returns NULL.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
