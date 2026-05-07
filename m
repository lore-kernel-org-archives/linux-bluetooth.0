Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986093F9F54
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173280; cv=none; b=T1qzMdDZagtfXd4MsPtOUy2WUtEv4ZAVAFKzDDxRPEszQCPwOAGEM4HkY42t/AuSZYSnbC5SVK02S7Ky/oBAHqRLqNLQaRxH1yDeGZXv59g7esUyp4LTStXTK7CgcWr5Hn06JoyzytTIUmsqPKztUn1DD/8p4YKvrNrZuhfE+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173280; c=relaxed/simple;
	bh=qg1NPKYJ6Ca/NRZ1WwPc4fn/32uaSOmZ+Iupi+1jhCo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IjNQ3hyiR08Sn+aXD88rVETsa05jOZhCXBAndjzpEBUIQ+dAk1fiH7hQXmHGpGio4skbF7BYy0dRpVmGlTEn6pbK+2wjRPd5wofJgr0JfivTNMhWIEfOq6RIr1htnX3BIwNnZ9TOG6CxsGMrmhRSclWw6lwFwzz9lzpn7lOjQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h9VFnoG0; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h9VFnoG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778173276;
	bh=eqrLC2ZyE+5XD5qSyRXSo6Eo36Sq0bdMKQdOa/zwvY8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h9VFnoG0ccw+0und/QdcdxeGiKuccce6UfoHelU8suI5beSFdEyDf1K8TeuuYg5mi
	 yAZeIJDmeJiZescFtaAWiFLVlJ91//q5P11HypmR5XwwXNiEOzShOrVJRJgB8gszi7
	 i+v1RiSpuPPDEeRH0Z3KGAsyVXL1cZS2HyRuEfWM=
Received: from github.com (hubbernetes-node-844da97.ash1-iad.github.net [10.56.208.72])
	by smtp.github.com (Postfix) with ESMTPA id AA8AA921314
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 10:01:16 -0700 (PDT)
Date: Thu, 07 May 2026 10:01:16 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091167/000000-2fb1b7@github.com>
Subject: [bluez/bluez] 2fb1b7: client/btpclient: Add
 BTP_EV_GAP_SEC_LEVEL_CHANGED...
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

  Branch: refs/heads/1091167
  Home:   https://github.com/bluez/bluez
  Commit: 2fb1b777c8a379b17f3a0bd478af1f4164ee3b52
      https://github.com/bluez/bluez/commit/2fb1b777c8a379b17f3a0bd478af1=
f4164ee3b52
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-07 (Thu, 07 May 2026)

  Changed paths:
    M client/btpclient/gap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

This allows reduces connection time for the BAP tests.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
