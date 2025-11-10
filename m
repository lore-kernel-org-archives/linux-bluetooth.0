Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91A2D5A14
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760777; cv=none; b=VGnZARWxaRpQZzQZjheRWtbqDGkaq24O+8AIrgLi462+kHWkylbS9KhPIN9inClZncycs3BSWfp9y+sjdfiuuOezMRk3NZbmeII0fgohbwqJLphV43zzZYO+0vLxIhxk9q+9mohNgjcUHA/8LsZ3sf2pL3Wbvc2gxTFT4RF5W9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760777; c=relaxed/simple;
	bh=BevIoaSFafu8woc9N1nERqNY9EH/GOo7l/htilqWjfs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uzvg2oawDnsZ2X7ZQ+5pDrQyFtryYUPqtu42cbKszjUQhQi9ePPAAZLJiwHserv3Seybqgystax9l+K2vZpxy3fGVCL8S/IDk5YNXUvMOsmQH5FW3CT6bzwuU8OHRi8cJk0aefipVoPTgznhjdl7ipskETpgEls/gZpgCH7K+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MWytZlL/; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MWytZlL/"
Received: from github.com (hubbernetes-node-eb39a88.ash1-iad.github.net [10.56.209.91])
	by smtp.github.com (Postfix) with ESMTPA id 6DAF3920AA8
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762760774;
	bh=9XMvnkrJoUvcplm+vthPnX8n1jo3dV2PFnc+U+aM0q0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MWytZlL/rHx14RMEETtqtpb9uoKXW5cR9OBRw8oz496lmkrVoMg4mQJCTLomNxT/J
	 DGQyCxzKkuay0IpklATCmiRA3DuTzWlFUNenNLj32ZUrc+iJq425KOVcykvWZ4MXlf
	 ByiHSZZVbXeB+3v5PTho5D2VKB5bSXnN/h/uOtUk=
Date: Sun, 09 Nov 2025 23:46:14 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021420/000000-930322@github.com>
Subject: [bluez/bluez] 74b068: shared/hfp: Add Enhanced Call Status support
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

  Branch: refs/heads/1021420
  Home:   https://github.com/bluez/bluez
  Commit: 74b0687c958c2f59991c84c429c40ba9e1f330a2
      https://github.com/bluez/bluez/commit/74b0687c958c2f59991c84c429c40=
ba9e1f330a2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Enhanced Call Status support

In case remote device supports the Enhanced Call Status the calls are
created, updated or removed based on results of AT+CLCC commands.
This implies to send an AT+CLCC command on reception of +CIEV events
for <call>, <callsetup> or <callheld> indicators instead of managing
calls directly.

This updates the tests using FULL_SLC_SESSION:
- /HFP/HF/ENO/BV-01-C
- /HFP/HF/ICA/BV-01-C
- /HFP/HF/ICA/BV-02-C
- /HFP/HF/ICA/BV-03-C
- /HFP/HF/ICA/BV-04-C-full


  Commit: 9303221ff05070965671a0f1df56dd5a5a7df3cb
      https://github.com/bluez/bluez/commit/9303221ff05070965671a0f1df56d=
d5a5a7df3cb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Enhanced Call Status tests

This add the following test:
- /HFP/HF/ECS/BV-01-C
  Verify that the HF can request the status of current calls in the AG.
- /HFP/HF/ECS/BV-02-C
  Verify that the AG can send the correct call status when an SLC is
  initialized.
- /HFP/HF/ICA/BV-07-C-full
  Verify that HF can connect to an AG that is receiving an in-coming
  call.


Compare: https://github.com/bluez/bluez/compare/74b0687c958c%5E...9303221=
ff050

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
