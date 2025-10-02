Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66782263F49
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422989; cv=none; b=fJqN+V44X45SZwmHeld+931RS1f4kfSl88CJPLoqWZa6kiNMKTVePR/S+qj1l5LmiMHZr3o2WKXsN6YCB53oU5X05f9GfZmwL74fUb/dueltVvBXxtRSSprWKC3voErvk7pIfBuTTq409YimAuKmbh7KGHoyAFllO07VVUFs7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422989; c=relaxed/simple;
	bh=mPXxNklH5ztwWPrv+z+gDc/aZrv7eptnm53rRYaSA8Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Iabhkw0e7gI2GZUWS/GvEkuEGn666KkC7VPbr3jilD8hzKQBT5P6qv+doiAVkna/FtBzOluoKgacRTuJGLNOGhA/97KWDaMbIjsyhEAGiFjrgf/tx3ZgDS6gmV4lgrrNaG9niDZKqRueCRhEEk5SpTaGoI+403fE6pBRBoNaWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JexvF7P5; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JexvF7P5"
Received: from github.com (hubbernetes-node-ff2488a.ac4-iad.github.net [10.52.202.72])
	by smtp.github.com (Postfix) with ESMTPA id 65A5B2103E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759422987;
	bh=7Vr5Jd4YeMustSmmYX3PhXov4Yoh60voJn/jsPgT6Y4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JexvF7P5vQqJScYYdJs8gTt8+dQlZjbYmGoj3g5dEdzc6yjtOQMFMxRvGdRJC/mGN
	 1zkmahLNAoTSVBkEe3BGFQ5nJ5XZW6z8qi6FNOukBtBIr9+hsaxTyEG4CldRjsKpUY
	 /3KECWeeYJVMTZLO3hBieOj2hOp2fLYzxFgZ3yEQ=
Date: Thu, 02 Oct 2025 09:36:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/73dd85-3e5547@github.com>
Subject: [bluez/bluez] faca31: shared/bass: Fix permissions not requiring
 encryption
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: faca31657e1b0cec0e03bbb7bf0e2d81222079d4
      https://github.com/bluez/bluez/commit/faca31657e1b0cec0e03bbb7bf0e2d81222079d4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M src/shared/bass.c
    M unit/test-bass.c

  Log Message:
  -----------
  shared/bass: Fix permissions not requiring encryption

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c


  Commit: 3e55476bf6c8ed4180d6cc70ff7cde524e6f1bfa
      https://github.com/bluez/bluez/commit/3e55476bf6c8ed4180d6cc70ff7cde524e6f1bfa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Set QoS.Encryption if QoS.BCode is set

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.


Compare: https://github.com/bluez/bluez/compare/73dd85a18b13...3e55476bf6c8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
