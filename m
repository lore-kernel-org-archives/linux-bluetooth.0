Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AA28640B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355348; cv=none; b=t/og6wEjKLzobv08FgjUIuWZl5BI+DxNgmTQnE87w1HBztLW6aRXRuHKP/M0FEPtSftZIlre0kklNYNacIxz13LrEHGsftWS7uBPmwPRMIaia5iMOKN5hQgGkeXKD7p0aZLZvubNkz48UydJlSGGeUWv7/r0VwRkmIfKxTlPWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355348; c=relaxed/simple;
	bh=BC/h8HEchFE+gVw/esTmBDgsC0ifm7WofVuCWQXzIho=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WJNhz+JrwsbVdMvuR2Fbrkgz/l+nzynqR+TPVLA+aT+dtowD3h5S2MVhSYIjICzSAOvc9zohfKE2uK61Cz3CO4zzhco9NW6pf3OEyk2sDlI4L4K7O6GxBzzESoRAabKRkXcBiwmKFs6D5GD2RHWhDkIPAmUsBpAl9QZCMbpvX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xk3tEdoe; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xk3tEdoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776355346;
	bh=jm1YMUJC7ZO4uCzt315y4AQUA+i5INWhmbHL6lSNy+U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xk3tEdoeb2T55Uqa5mp1ML/AqU7wsFZeFlTkOUQsQaBFZ78+f/k2gq2znC2wuRCQD
	 ZbQEzlQJHwom9KfCz5Iay+CyfZEJuU62gIV+IbYpKvMCEQ0SAO9jsNNgomX1JewAZD
	 o2tr2IH1kuAXruzEpTv8q5hwz19x/cEeXYJFZbs0=
Received: from github.com (hubbernetes-node-8fb7d75.ash1-iad.github.net [10.56.200.65])
	by smtp.github.com (Postfix) with ESMTPA id 237AB561089
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:02:26 -0700 (PDT)
Date: Thu, 16 Apr 2026 09:02:26 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/07a0b8-150806@github.com>
Subject: [bluez/bluez] 150806: client/btpclient: Add GATT read and write value
 su...
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
  Commit: 15080642a4142dcbf4406bfddfc12913ec12db54
      https://github.com/bluez/bluez/commit/15080642a4142dcbf4406bfddfc12=
913ec12db54
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M client/btpclient/gatt.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add GATT read and write value supports

This stores the characteristics proxy and handle so we can call
org.bluez.GattCharacteristic1 ReadValue and WriteValue methods with
the "handle provided by PTS - 1".

This will allow to pass BAP/CL/CGGIT/CHA/BV-02-C and
BAP/UCL/CGGIT/CHA/BV-03-C.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
