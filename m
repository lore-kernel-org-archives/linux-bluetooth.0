Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4753451A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732508; cv=none; b=VNljTtYB4kHrG5WavUoRGd4FuuQM8KLD1FNh0yxSdCT91p1Zo3UxIym7OgL04LpxHbjTVoSsOIOUZ2Pwtu/UO3rsfqOOMIKY9GxFnsL/55oGaOjgeXJQ7zDooHTZeXtaXJjgmAnpeVTz3qy4aHYDJCvLU7Wj+PbcIjLNWTqYKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732508; c=relaxed/simple;
	bh=Rpu75h654XQUJNCe04vCRDG3d60/ANLU+nI3vdONIhE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qtwZ3n4+FJMiK9woRKkorWTuiFckeVNb0XMldahCY4j71+zPAvt2pVMdyRJpRlVV72FUBMkI87kV3gO6FOzthf3yKWeBT8N/+xOLFuFNISe0VgbDx/6jGEjmF8JHn418fcRGC3lt5Z8Eez/u6zYGQfZX/A8ZRWXUOYRq31VmDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=mF64gI+A; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="mF64gI+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790732505;
	bh=2+LEu+Qj1ryj+2Xu0BtSWjfVvKlCWvRknT7MI46mQjI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mF64gI+AeyQVfGzhdGa/ckIa+6sTuki43RsDu8H9KwO2wgNNoIZFC25FAnR4u2/4/
	 XOpmjAMLAbPjj3k5gt3AsxaRoKGQnGSWjM3rKh8WuTT3kaM3DgRCe99+kGkKh3mvCv
	 vwDX/BfSq759yUeGCbsvmM8IfLCG02jJu3oY4qZVHOHVnQsz3ybyFmliEw+1YUZwnd
	 AVpmB1rNA2HmTtdeowSK8jfcym2fPPR1sHNk9vw0ZT09hD9WML0HNpJKJqy7SCBu0w
	 fuBBl8S36Mu/libNhovobd95Gw2H0hIp1Dma0Sk0byhAaXztwSwyyjV86UPeYUTfCc
	 G71xD6AqA3Z3Q==
Received: from github.com (hubbernetes-node-0bcdb9c.va3-iad.github.net [10.48.65.87])
	by smtp.github.com (Postfix) with ESMTPA id E8518281199
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 18:41:45 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:41:45 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172556/000000-0317c8@github.com>
Subject: [bluez/bluez] 0317c8: doc: Add functional-hfp documentation
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

  Branch: refs/heads/1172556
  Home:   https://github.com/bluez/bluez
  Commit: 0317c85fff362ae9d88daac2d3258da26abb124f
      https://github.com/bluez/bluez/commit/0317c85fff362ae9d88daac2d3258da26abb124f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-hfp.rst
    M doc/functional-testing.rst

  Log Message:
  -----------
  doc: Add functional-hfp documentation

Document the HFP functional test cases, using the BlueZ HF
implementation driven through bluetoothctl telephony submenu, and a
minimal AG implemented by the test with org.bluez.Profile1:

- profile connection and disconnection
- audio connection (SCO) with CVSD and mSBC

Document what is supported today, i.e. the SLC and calls, and the
changes needed for the audio test cases, i.e. codec negotiation and
audio connection in the HF, which are expected to fail until then.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
