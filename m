Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18752206B0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439290; cv=none; b=HguFRtxeUdfi6YQm+FEcaa7BN9ekY49igKnfaKyiEUuRFhFFZydywH9sCvegJV//ZEm//Hp/faJS+zAUZUua3j53sLkUojJoF6g9fryZ59V4jKuxayzMeXzBZFd/xHSnofAc6yJyPa+fOr2XaNWElFHuhUBaK+WOU82Lm3qy4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439290; c=relaxed/simple;
	bh=Sa64Ri2biy8uQ2+A8RfHS91UZctzfK9fy+wxPIkvh6k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ivOBWoSJjbMvahMcQwDx/0TSti8sj1lTvU9J1oOCNZyHZWLyUcTswQ7vWeZGm1myIuzwdDr9+XUwDAP7EkHXz5wu1JmIvwJGLdAZa8znzWAQkSoP5IjbgwLL1ffGV9ezcs6IqD8m5dPXcTr8aSzv3WuLGiZKlUh1kSKEeLMAP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bKmji0Jq; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bKmji0Jq"
Received: from github.com (hubbernetes-node-614d841.ac4-iad.github.net [10.52.134.23])
	by smtp.github.com (Postfix) with ESMTPA id 0F479640729
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 08:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1736439288;
	bh=Lbo9F2gMzxrd/lkE6VgwHwVmJIKGHQUhA7ESt2wROLg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bKmji0JqZy33duDGDTVdgDVist9KR6PW+TzW5tFUr8FWZZl5nQd+UeG71Y/7fcs1+
	 eIamDkrntbRJUtCBTu8VcaFUrRGvdgPaAcT380ASzE56VGlY1L2r+omWdNWhpoWIuW
	 XW1S3EAPhwYuL2dDEwKKDdvdNlpcKhjVeI2qF3zw=
Date: Thu, 09 Jan 2025 08:14:48 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8f8539-036041@github.com>
Subject: [bluez/bluez] 5e965f: obexctl: Implement support for message listing
 for...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5e965f8d2ac763fef35a4281655f5dd8df5f9895
      https://github.com/bluez/bluez/commit/5e965f8d2ac763fef35a4281655f5=
dd8df5f9895
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-01-09 (Thu, 09 Jan 2025)

  Changed paths:
    M tools/obexctl.c

  Log Message:
  -----------
  obexctl: Implement support for message listing format version 1.1 for M=
CE

This change is corresponding to obexd changes done for implementing
=E2=80=98Messages-Listing Format Version 1.1=E2=80=99 .
This change will emit the newly added properties values in obexctl
which are sent by server.


  Commit: 79441ae9e9002dd56303c02258ab2d6c0d44ce6b
      https://github.com/bluez/bluez/commit/79441ae9e9002dd56303c02258ab2=
d6c0d44ce6b
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-01-09 (Thu, 09 Jan 2025)

  Changed paths:
    M obexd/client/map.c
    M src/profile.c

  Log Message:
  -----------
  obex: Implement support for message listing format version 1.1 for MCE

As per spec, Messages-Listing Format Version 1.1 is being marked
mandatory feature to be supported in MAP 1.3 & above versions.
This change is added for MAP client role.

This change is required for passing below testcases-
1) MAP/MCE/MFB/BV-01-C
Verify that the MCE correctly advertises the correct feature bits
in the MNS SDP record.
2) MAP/MCE/MFB/BV-03-C
Verify that the MCE correctly advertises the correct MapSupportedFeatures=

bits in the MNS SDP record during MAS connection.

Also add the Messages-Listing Format Version 1.1 as supported
in mns sdp record.


  Commit: 036041136f10fdb9218d86befd738840ecd58892
      https://github.com/bluez/bluez/commit/036041136f10fdb9218d86befd738=
840ecd58892
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-01-09 (Thu, 09 Jan 2025)

  Changed paths:
    M doc/org.bluez.obex.Message.rst

  Log Message:
  -----------
  Doc: Obex Implement support for message listing format version 1.1

Add the documentation for the =E2=80=98Messages-Listing Format Version 1.=
1=E2=80=99
feature for MCE.


Compare: https://github.com/bluez/bluez/compare/8f853903bdf4...036041136f=
10

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
