Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C91F03C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338032; cv=none; b=GE86tmtI6sxB8L8JdgbmZiDpFmdt2R7jUwPeby/rREI+Mnqmn+wLyE0G2NB0KAISWTaZdtqxf3jmzX+f0Uwtj8iH4Y7JR3nRBKJ1nTWS/D0aPGE0UGnrVYTlCU4K9lr7WO3uEwwzf7tQQPa1QS2v/ToHZImXhJFmj59j1Dz+Y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338032; c=relaxed/simple;
	bh=KWFeSwGEwERQ1oEormNWYvmxxXrPVLtP8JwIGrRsHHA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FZWbZdycux9UNZIka0wedPoK6pAhZ6cWsFrNu/7Y6vUlDiQ6AjhOvvtat5WXojWpRFqRdCuk1RXNoyHGZ+PpxvFCorpp+uyWKrhrHmKlRhqT+8BwapduwJxXcALoThLnSKosr4lf7xIRS2j6/o0MikaVqYtiHbyOFF8I9UCXUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K+Y8UCW0; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K+Y8UCW0"
Received: from github.com (hubbernetes-node-53d805e.va3-iad.github.net [10.48.165.11])
	by smtp.github.com (Postfix) with ESMTPA id 14669E03FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761338030;
	bh=GU/tIpj/78+ytjrKHN8AaWMiDp1rPQSdFovhpyYBVwI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K+Y8UCW0ovefuWqKTV0Bbeo1sIRs4E0h2TmboNIuZWVuKcRJLG9SMKORpkjusUUR4
	 Z6V6bM2Zt3snKld6BBCu3XRPcHKnoXi0MKxWvYoTAx0ClXSUO3gxlxHLnmkSMw9uVr
	 NMTNyhJSQq9HIic4/YWpGdziy8JWgGeB3mAg/LVk=
Date: Fri, 24 Oct 2025 13:33:50 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9faf12-43aed4@github.com>
Subject: [bluez/bluez] 81a995: bass: Fix handling of BT_BASS_MOD_SRC
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
  Commit: 81a99593276814df47f482df44ca1f1700dd5ae6
      https://github.com/bluez/bluez/commit/81a99593276814df47f482df44ca1f1700dd5ae6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix handling of BT_BASS_MOD_SRC

If BT_BASS_MOD_SRC is received and the sync_state is set to
BT_BASS_SYNCHRONIZED_TO_PA it doesn't necessarily mean that the device
shall be removed, specially in case the assistant and broadcast source
are the same device.

In order to fix this behavior this attempts to free the setups that were
used for the BIS being modified, then if all setups are freed in the
process proceed to disconnect the service and then check if the
device is still considered connected after that, only if is not
connected then remove it.


  Commit: 43aed48c30da96c64ab03d603d5ed675bd7e4647
      https://github.com/bluez/bluez/commit/43aed48c30da96c64ab03d603d5ed675bd7e4647
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Only attach client if initiator

This makes calling to bt_bass_attach conditional to being the initiator
of the connection, otherwise both device may act as both roles which is
not recommended.


Compare: https://github.com/bluez/bluez/compare/9faf1244a932...43aed48c30da

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
