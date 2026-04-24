Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434773ED126
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054040; cv=none; b=Gr4ts9EzrtGQUyGXmcj2wmvP2nyccsLmGM1Y7uRi1BiD6E+zZ5JNIWX5NmI/LZAg3dte1Iet4G9l+wUSrcQUxcTrE1uJMYblbcOpthHhjTDsCdONN2ei5XMvkzgO5um6eDSEtmAAVbJHUMWN5S3GOTGxibOw+J/zvITac3GXCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054040; c=relaxed/simple;
	bh=6F/tR+TH7/Iuvvhr/xljAik6iCaiCTogros1iKhLVBg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nbuM7pGbzQZUA4uSLwt8bmMGIcyucMGSvdDavBeUxnKx0q/OlJHaqb+2jQ81cp+thcUYLEBxxaSxuYsDn1wTRcrL9rlyhzOvyZ198TrA22W5oNMAQ++FVAXfGlHy2sFbyotC9nQyiZAAIuRzNTJbPkWqDvsRzYIH7wcShCYAxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=it/ZgSr6; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="it/ZgSr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777054038;
	bh=ZPzfMA6hXf/Tt78L0qtmNZhG9kg9O+ryjx8eB0E4wmw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=it/ZgSr6xeh3mcXRtRkKy86AiG/YtI3tAUi0uXTXZPrDvuuVyHcH4ZUAsv/+FxKYV
	 iJo17MckQdVGwqkGRVt+90AYEJNlyJPHHCCIEqwuos88Ki5wCQr0OqgW64V1zlsXS7
	 KKDs6EFaHEPA463cOr/GFFxj+EHKUlTrUzIclxbs=
Received: from github.com (hubbernetes-node-d31dcca.va3-iad.github.net [10.48.130.39])
	by smtp.github.com (Postfix) with ESMTPA id 676FA78116C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 11:07:18 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:07:18 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085307/000000-1ed377@github.com>
Subject: [bluez/bluez] 1ed377: src/shared: Add RAS packet format and
 notification...
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

  Branch: refs/heads/1085307
  Home:   https://github.com/bluez/bluez
  Commit: 1ed377735b9c70af6933671857d2ec6bfc6723de
      https://github.com/bluez/bluez/commit/1ed377735b9c70af6933671857d2ec6bfc6723de
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Add RAS packet formatting and notification support for CS reflector
Implement complete RAS data pipeline:
- Handle HCI CS subevent result/continuation events
- Serialize ranging/subevent headers per spec
- GATT notifications for real-time ranging data



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
