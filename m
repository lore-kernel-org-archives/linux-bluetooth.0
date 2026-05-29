Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29C2472AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071930; cv=none; b=MC/aHIDGGmr/KmC4enT1A72PCcDWRK1B/X+Rt4mEOi4+jeSB2JiXkBJ91+xBbmjUI/DEol0C/UNW5btdDNmDBygoFue4g32MASa7vTcMVa9N+P2RCGTH/jumdrT7ghOlx1On7qsb7lxUG/jgtrv7lUAx+STdi4sT+dbJBB5QQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071930; c=relaxed/simple;
	bh=LL9ZF0XZfok7nqS9QTuoP9ZLjIz79fMBMB67Mc3nbOI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ua+DNW2hmbpqt4Tib9KuX+Jz2u+MI4KA4lqkhND+Y5AjGAR0VgGPP7O9akgoAg/wZfPixh4oDS0x68rEskziMLYrx/BlzlX7jpgAWbgcbpOTkWN9C8CL2pSj+ksq5+cYx7byqEntKs8uD32BOqnM1Canm62bWxknA2hiGqAT5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FGsO0P7A; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FGsO0P7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780071928;
	bh=lBOdgzpVVrz6APDibZw5YgQqVkZutZnqijyDzsv0dIs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FGsO0P7ADi0MZJg6uTIXg631S/HYU0pZkkxsp0HLFvwVkq/zABfljMG0lqlx3fE0V
	 fNzsqClMnw8TQUpK11rp8FbQuz3Ek8oqgdCwd1/UHKdAv1iPws+Qum0yZqEyoRppXg
	 IW8hpyRtutmEgZyrXMXXO7HOu3QnRIgrtnZHeNZs=
Received: from github.com (hubbernetes-node-921bceb.ac4-iad.github.net [10.52.153.33])
	by smtp.github.com (Postfix) with ESMTPA id E4E149407B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 09:25:28 -0700 (PDT)
Date: Fri, 29 May 2026 09:25:28 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/68edaa-17fbb4@github.com>
Subject: [bluez/bluez] 17fbb4: mgmt: Remove mgmt_ev[] strings of undefined
 MGMT e...
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
  Commit: 17fbb48d8f7c22d0702b3b9daf69f9c06231d774
      https://github.com/bluez/bluez/commit/17fbb48d8f7c22d0702b3b9daf69f=
9c06231d774
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-29 (Fri, 29 May 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Remove mgmt_ev[] strings of undefined MGMT events

Remove event strings introduced in mgmt_ev[] but for which the MGMT
events has not been defined.

Those events are already part of the events_le_table[] in
monitor/packet.c

Fixes: f9557931ad36 ("monitor: Add decoding support for Sync Receiver eve=
nts")



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
