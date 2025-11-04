Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47975226CF6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267740; cv=none; b=Liy15hy0Z94Wi0/bHPPmcaJn01bITB5kJdc8f00SjKktp9xJenERlJ/W+WEX0CIlmbqpmtlf1hDDvkUlPQwBwned2wTzWdkqXDPByJrgttEf68PLKN3rklxROWaQ0C617dB+zNuDK7+mePTI3HUzLLEmZvaHOFkt+YMENzrY7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267740; c=relaxed/simple;
	bh=oThuaxxlVDCi+WO2H9L3VYN7G68JucUFzmn3UyZXWFI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GYVrA3vxOui1qIpCuLARDxy3IGEQq2DP7vau3DLGnMmqi5xPxLNSrE2hRTUagLDSjDIouvtsNt0WbhrFtSMl16I5Myd4/07mhlp4xXzG4tSblkJ2ZBXouKEX/dS+4UdF9BGvT1dsQ4V1Ng3xYj1kPxRoEDooX4d8Mg1U0hfJOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a3iEjt++; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a3iEjt++"
Received: from github.com (hubbernetes-node-370bbc9.ash1-iad.github.net [10.56.207.101])
	by smtp.github.com (Postfix) with ESMTPA id 58AC46001B9
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762267738;
	bh=gKpETq4NNqx56ngNkukdPRjO/gKINix/oQAU49y8A8E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a3iEjt++PSSNAxpmVr1+9QqXZmVx2P2fsMU3dvVlLnrdD4XPECBX2yF0GccmTu13X
	 hBiu9GQhzPCwbZ7bpPaZpQUikILoZegg5hfr2JzQDe3fJF4i71aTjNCDhtm0qq4KFL
	 Gsv3VRVtodIFSIqLulY9YnXCYCoHNUgXbzqkZW4I=
Date: Tue, 04 Nov 2025 06:48:58 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/32d740-654c4f@github.com>
Subject: [bluez/bluez] b0db5e: shared/hfp: Add extended response code enabling
 co...
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
  Commit: b0db5e1c330ade4cfa188105468aa6fd60293ab3
      https://github.com/bluez/bluez/commit/b0db5e1c330ade4cfa188105468aa=
6fd60293ab3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add extended response code enabling command


  Commit: f3904a8f1c2cae24bb19099143b2ea8e7511a7dd
      https://github.com/bluez/bluez/commit/f3904a8f1c2cae24bb19099143b2e=
a8e7511a7dd
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add NREC disable command


  Commit: 654c4f5755e7ea4dafd34ec3b5498d3a961d1825
      https://github.com/bluez/bluez/commit/654c4f5755e7ea4dafd34ec3b5498=
d3a961d1825
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add ECNR off test

This add the following test:
- /HFP/HF/ENO/BV-01-C
  Verify that the HF can disable the EC/NR function of the AG.


Compare: https://github.com/bluez/bluez/compare/32d740d87970...654c4f5755=
e7

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
