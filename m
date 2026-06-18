Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65665331214
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763917; cv=none; b=Nu98sEWAx4T812pjxUZ5P4usrT2utrOA0ozu07Ft+QM4NZKEPAA+tk22drK6eS7cEw+Z/mW1fq1p5qZSY9aTKmJyYAw2RZiPORjiG1s6iHHazlCWj/bIdvSayRXCx+YUPrmB5d/fI8tq9Ta8C3UkMe3gGBFBbw7rFBVEEjyQTQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763917; c=relaxed/simple;
	bh=oG9HxXC2xILzdNYR7QlnQNfJB6IXBd4n1Pnyz/iTepg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G6N+k5gI4qzrxDPvHNbmehSwvxkd4dzBpTp3OsPPNw0r3CPhCmkUEx8B7y4lgi8nQrfcqNxumM+xpQmzrSltH/zpygsnQHPJR+TZTab/XubRmM/2DUKMMiV3vfZq31ITK5G4x+QQwlOyQqwJp8fNsWSQjt5Ki3Mjjox/iZ3h6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kGKNZ4mW; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kGKNZ4mW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781763915;
	bh=yies35Z40o7nQ7lhP63S3V/LnTuWcZXDy/x+YSx4tNM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kGKNZ4mWDJBd/OI+U968YAPeB7hLGFYQf/87AjZEKP/df2yBdSdBpcuHHv3Lb/6vV
	 PIyNYs9/mSlV6eYhv8HsEoueouysn3PipwxhuX9Sms5dndA/O9MDnN/ogITeeGIevi
	 wXk3PNXKojUGYdJapH0+FAZZL07n59Zehv0vRuiY=
Received: from github.com (hubbernetes-node-991b743.va3-iad.github.net [10.48.125.52])
	by smtp.github.com (Postfix) with ESMTPA id A44D878122F
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 23:25:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 23:25:15 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1113188/000000-0b6c6d@github.com>
Subject: [bluez/bluez] 0b6c6d: set: Abandon the use of the existing set
 gatt-db
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

  Branch: refs/heads/1113188
  Home:   https://github.com/bluez/bluez
  Commit: 0b6c6d816e5845827ee783782bd4d975069d5a3c
      https://github.com/bluez/bluez/commit/0b6c6d816e5845827ee783782bd4d975069d5a3c
  Author: Chen Zhang <zhangchen01@kylinos.cn>
  Date:   2026-06-18 (Thu, 18 Jun 2026)

  Changed paths:
    M src/set.c

  Log Message:
  -----------
  set: Abandon the use of the existing set gatt-db

When pairing and connecting a pair of earbuds, if you attempt to connect the
second earbud while one earbud is already connected, reusing the existing
set gatt-db will interrupt the GATT procedure. Subsequently, the attribute
values will no longer be read, and the ASE state will not switch. This will
eventually prevent the second earbud from creating a CIS, resulting in no sound
output from the later-connected earbud during music playback.

Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
