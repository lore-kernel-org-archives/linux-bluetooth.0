Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D56307481
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004014; cv=none; b=QG0hYJoR3eSVWzlwI/1eHToWM0vp3zMo9QcemdNTzJ5lxmyE1kGewYYCnLiPEpCJ+KmarRX9SwS0g1yurM5V8mEcgr+8fyqJQBhUKe6R19PT8Eawv5+sMAB0cPhuPEPzdL0PsrHykSwqhAd+4cDx/6/0zdbJvBqlJ6Y/3Dc7Qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004014; c=relaxed/simple;
	bh=V/Vjg3dij+7pJfxwbpf4TS8Kv3St11QvhT4DpxhgnBc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=slHDcBFfUtujCMvzp+vl5P8i/w9gcRw76nIWBvHucTSp11XK5Mq6u8EIBG1U7uvK1U0WaR54AhgQ0WvCGdAeCHk/hBARp4Ly4ICaHMW8Xvijn+cCoJ54S/4gVTQD0vLA0T5AzSxYnnbdJit7jDw7dWguVjFQrewb4BuTTEWpGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mnrMvv4G; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mnrMvv4G"
Received: from github.com (hubbernetes-node-5895fa3.ac4-iad.github.net [10.52.137.32])
	by smtp.github.com (Postfix) with ESMTPA id B7476641474
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757004011;
	bh=2oeB4hzcZGSuMichvnx7Jw3gaQ9SbDBWiMeOZ/cIh4I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mnrMvv4G1u3gr4i5MH5EbiKevPac7A+VKeBUPoo9Cx7slWGajpZm1hCu//4YF66ae
	 FQynci8oupW8riY9/vmhlDTmYzyBpW7AkJ/ndYLkcUsChzlSj1pQghISJhVzWMQYff
	 SgdDtfw65S65zuRIK645CZWmpB20xgWn0El8eUfs=
Date: Thu, 04 Sep 2025 09:40:11 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/998967/000000-0b5f0c@github.com>
Subject: [bluez/bluez] 0b5f0c: main.conf: Add FilterDiscoverable option
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

  Branch: refs/heads/998967
  Home:   https://github.com/bluez/bluez
  Commit: 0b5f0cc3547f96db129271f21052b6463bb409ed
      https://github.com/bluez/bluez/commit/0b5f0cc3547f96db129271f21052b6463bb409ed
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-04 (Thu, 04 Sep 2025)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add FilterDiscoverable option

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
