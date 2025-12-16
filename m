Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602532C309
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880076; cv=none; b=aqOcNMyFhG8JxWqElepBCTALQCNjRKa3j1NcKBKrDIuw3rs9iBRlyjp1YsUE7WfvCfgVNM82C942AhqI37dTMitDd2QX24eDURTT+2BtdbZtWC73O3sk95l/gh8/E1TE+uaTzTOHSsG1QEkBqdjejJDKWOzQXkLFJ1vs+KKTThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880076; c=relaxed/simple;
	bh=gdhqGdcfZ5OC1HeqKTZYbZbfFQCikfjbNjqjK2wnVUo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t2dRs7dGY2PaWDSUuR8TGVTn8pRjaRikjk3G6tQuX791QOUc+LKE1QU4tTOAtPK5awQt8yvZOGT2glhZ7sOCXe4ZHoZd3HkcE2yCcshm4iVq7xnMI/kzq9jQ2pYv/Z+8LwFbz0Et2gdibHu6TBtGCD+lmDZEaN2SRqltrox7TlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cEaAGIem; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cEaAGIem"
Received: from github.com (hubbernetes-node-15a5d0f.ash1-iad.github.net [10.56.14.13])
	by smtp.github.com (Postfix) with ESMTPA id 0D38A14070C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765880074;
	bh=lTvRWcDip6tdWAGlVUfCNvoIVWJ5ngVbH38Ln8oMKLM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cEaAGIemUaqyCPMw+rzkUZjW8zjZLrSOGGKL16ijM5JUG45QUwJmQnuIVDJ+l/4UT
	 ypB9x2v2pXmbCx/0ZPWiNWCtUKJZXXXLAFZEKx5AoyBmOVEpka9XwDoAFTUILC8IF4
	 8N7NIQORBx9NC+TLlYC7V4wKnf/YOhSUZaAsNP1I=
Date: Tue, 16 Dec 2025 02:14:34 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033710/000000-c18186@github.com>
Subject: [bluez/bluez] c18186: bap: add PA sync monitor timeout
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

  Branch: refs/heads/1033710
  Home:   https://github.com/bluez/bluez
  Commit: c18186abbc6c6a539c25a5ae7e17835d39ea2cda
      https://github.com/bluez/bluez/commit/c18186abbc6c6a539c25a5ae7e17835d39ea2cda
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add PA sync monitor timeout

When PA sync times out, the BAP broadcast probe may remain
pending and fail to exit, even if LE scanning is triggered
again.

This adds a monitor timeout to ensure the pending probe
is properly aborted when PA sync does not complete, avoiding
stuck states.

err print from kernel:
  hci0: command 0x0000 tx timeout

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
