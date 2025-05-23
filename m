Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB47083A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985481; cv=none; b=FC715m0VyI151lu1WCh1ctSa/jSJ9h9Tw5zyHKFAt9VoOVXQ4a+YNJbigF/2/dzwp3C0UDvDOiLThFPksA8IDZ2jZyL78+fr6mQ39b16s7nPOgNrNnJmpF9+Pnl2aNr2WkZ2pMNAEBK5HrUBBeWIUAqOC4lt/imvFe28RsnVwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985481; c=relaxed/simple;
	bh=liPopsR/h3Cli8eYSLTgiYmurE94UK3DuTDVmp87hFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XOFRHVq8OIrAn6zuA/Fo8xJ4mzmnsNqZGa10/LOtY1GZBNoc4uknBGFWqBRTS5jTJ/2ErJxMsA+p9s9HDLF213Ph1fHni9hfFIhr72QziuVg2qBUsncOynq2S0dAzhPeuseKQGAPybv1BoBd2cwEvLEN/ZkPhhRVqOtDT0aH1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nGmgUZuh; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nGmgUZuh"
Received: from github.com (hubbernetes-node-57802c8.ac4-iad.github.net [10.52.202.143])
	by smtp.github.com (Postfix) with ESMTPA id 375F42125B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747985479;
	bh=WyYNlXPTjd7m+mME8zzhBsJnZPetal50BBAlc7fAVd4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nGmgUZuhZ5x+GS7RuyPiZCroscY7F49iweT3Q/ZL9PRu+w0Wzx84W493HoZxMC35A
	 TMFgsDeZ1YS3YIwJenxfukvJ6QIrDirHOIqkCA8Z1zxxFerpEmogOEbttEBV579TO5
	 wBSQswyTeCJvFE89zJHJgG9thY1Klugg6x6+7c0o=
Date: Fri, 23 May 2025 00:31:19 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965695/000000-f5df24@github.com>
Subject: [bluez/bluez] ba6ca0: lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE
 define
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

  Branch: refs/heads/965695
  Home:   https://github.com/bluez/bluez
  Commit: ba6ca062e609e834ac11936cf9add0bfac2ea9c0
      https://github.com/bluez/bluez/commit/ba6ca062e609e834ac11936cf9add=
0bfac2ea9c0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE define


  Commit: 3e4f3a471e70b7827e200776fd828e0e49737659
      https://github.com/bluez/bluez/commit/3e4f3a471e70b7827e200776fd828=
e0e49737659
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Add Disconnected signal to propagate disconnection reason

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.


  Commit: 85ea85751feacf7738fac1a3b7646ae9c5c91e88
      https://github.com/bluez/bluez/commit/85ea85751feacf7738fac1a3b7646=
ae9c5c91e88
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/device: Add Disconnected signal


  Commit: f5df24d93e23a4c03baedab696269368de747550
      https://github.com/bluez/bluez/commit/f5df24d93e23a4c03baedab696269=
368de747550
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display disconnection reason

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.


Compare: https://github.com/bluez/bluez/compare/ba6ca062e609%5E...f5df24d=
93e23

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
