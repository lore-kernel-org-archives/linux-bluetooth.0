Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADE78F39
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024392; cv=none; b=QrfVsINnmDsF9fw2FwgJKeomESRIMWs7awWLsdzCUX3FAAZJZPoJ1z8P2cgg2GpTwoX1WbFh+IZOQmQUyB5gcHXujnxK8HBEo9UyZnD25Ggc2bUB5axiyCLGh0R1jYOCkFwFq4GsvldMRj2N8nf0kUcA2vxwhY4XRm2VMQGUDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024392; c=relaxed/simple;
	bh=TBL/meFuoqdfSMQsO00GAUfB14dL63V6gr4/k144QVA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kAR0VLQ0rhPbsWzt55Xi1nP8Nm/UhA4t1Acc6DLPTeF2qVx2K3M7UXHegFv+yO3vOPE++TpXfwEgl6PqtjkNFZytytjqAFldK4ppgCI0yYBRG6YXDkpJt6z1sNYw/jgHHddKkdvwIld/+p5s2EWQywm0+Bo7jya5RQ7d6k52XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d2cXv/mU; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d2cXv/mU"
Received: from github.com (hubbernetes-node-d160d38.ash1-iad.github.net [10.56.212.91])
	by smtp.github.com (Postfix) with ESMTPA id E7A07141363
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746024388;
	bh=dSuJIeBU3y6QWskNbkcE8pmR80wXIp2TZb8OfPCbg7U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d2cXv/mUZyWRi4mafuvVRApdAly7VwhnUPnSRmhzDRUQRc3g4nFzDomQSWHHUhNaH
	 gTaHhm4zzAFkvYycc3Idn+35Aod1jEaV9KGlIqfPLrLl/Zu6UCTtqioT3/xu98T5uQ
	 oEuVft4mbPo6Gf8yQAefiREOk+riBucDW/QFIfMo=
Date: Wed, 30 Apr 2025 07:46:28 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958551/000000-d70fc7@github.com>
Subject: [bluez/bluez] d70fc7: shell: Clarify "mode" variable
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

  Branch: refs/heads/958551
  Home:   https://github.com/bluez/bluez
  Commit: d70fc7d0a13f7ce712318abebd627d7c993a61ee
      https://github.com/bluez/bluez/commit/d70fc7d0a13f7ce712318abebd627d7c993a61ee
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shell: Clarify "mode" variable

It's unclear what that variable did, and which value corresponded to
which state, so replace it with a typed enum so that conditionals are
more easily parsed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
