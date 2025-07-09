Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC8286D7C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054625; cv=none; b=F0/UejpZC/ACVDQU7Vin7ab3OKBD4lHs0qlKIOBsQWxtpo4DPQ3dw9tnfJT7k8g+cvuLmXZmozSV//U5siPyeZPXLVm+Gtw00qDLbVuFg/SFVGUannhx1NnVrFG34VUEcbdwXtoBEAK2L6SAavFB+0rzPr8SyyXYWTOOl+eLk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054625; c=relaxed/simple;
	bh=ANMN2xv/w1oPocAxAwZViUB7ROgeLm+JDrXfCUoj7Xk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pbBzuUMVZSO2x/VVQuqpVIz65+mPjLhq4o26uRiHdJP5PSddOf8i0vgdLPc05uwSHO0A5p+0UtV2GmCnRqb9OsiuZNRjqDp5v1UvOdyMw61or7G4UhTWuz1s4FkPMGYWjstdoBYHLnYYJ+AI2uU124dFXUOKvJEd29wpJyhSsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SurTg4Rl; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SurTg4Rl"
Received: from github.com (hubbernetes-node-6edd165.ash1-iad.github.net [10.56.180.40])
	by smtp.github.com (Postfix) with ESMTPA id AC3006002CE
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752054623;
	bh=fRCRqRS2gGQaARNhEKuBz5ryQE1zIgTfV7C5g1g+OZM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SurTg4RlqGmWYXuFRU1MZlgn99LV6LZt1lUXVIHUvMvWSkuZlf3Hiv6pIcBT40imE
	 qy4cG+ygQ9KSE+cXCfJ/AcchjcjemIUYzYnodJiF7frm6J3uUgE9gxMyMFaBxfcL3a
	 efj2AB7Brkseh9zr+y2Zo92fUjyZCPu49STUBTA0=
Date: Wed, 09 Jul 2025 02:50:23 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980429/000000-877e65@github.com>
Subject: [bluez/bluez] 877e65: shared/util: Refactor code from strisutf8 and
 strt...
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

  Branch: refs/heads/980429
  Home:   https://github.com/bluez/bluez
  Commit: 877e658bb0b07bd7dbc65f2ce081be3da5551d1e
      https://github.com/bluez/bluez/commit/877e658bb0b07bd7dbc65f2ce081b=
e3da5551d1e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Refactor code from strisutf8 and strtoutf8

Move duplicate code to static validateutf8() and fix boundary access
on multi-byte character check.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
