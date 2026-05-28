Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7035F5F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958907; cv=none; b=hJ6qCwd1Gw4hEb0B1SXUzlDNJ4LkhHNFHw5MXzuwDYFJUmqkitlGtiSf9DqHc/uGmgQHvkT61J4/5g7W9Rip8rpiYuAK6TVEBlrz8Zhx4u30Lx7ugPN/gE7MOTeucdexcef49eeJB0idg8ijUaptQfpAdxGYnFJCvixX34RbqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958907; c=relaxed/simple;
	bh=SW9cj6bf4dVjrSCjIXZf8sCN5F60r2wX2sWhW5pDFf4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f9cZLda1VenPmWyXs8PSNmZ/vwTkCwF0lA8Rk9EOOdjL3arsjZu0BfgfEC406UImmSVpfbdGTCifiGZnyBS0272pCCFO1b9n87BvWC227I6WFO58hO6B9OtYzFDxU7j4p1MPQO/9gJNP4V+WKrcbBVvTEPg5q/ZqwZdrSIh+Bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WrNUOuZw; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WrNUOuZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779958906;
	bh=serqBkzeGKmBOGzbJwJgeEXi04uOPJUMi1MesmGVmEQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WrNUOuZwAber8NluuW51EDGKn8h0XwgDT244UhrSG0krQOXuomQbeAfBsw3IKFdd2
	 vxd7N5OGowZKn8ydEW9+jSY3PZGxldY+5hArvuInrjPcrU+YRn0FqUhkkNIVUEPnQe
	 MlhFZhWKdIEHUFG2Q/Gx/UJm5sDJZT6lHTVjTTXY=
Received: from github.com (hubbernetes-node-31cb82f.va3-iad.github.net [10.48.158.21])
	by smtp.github.com (Postfix) with ESMTPA id 12C7C28129C
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 02:01:46 -0700 (PDT)
Date: Thu, 28 May 2026 02:01:46 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1102048/000000-516271@github.com>
Subject: [bluez/bluez] 516271: mgmt: Remove mgmt_ev[] strings of undefined
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

  Branch: refs/heads/1102048
  Home:   https://github.com/bluez/bluez
  Commit: 516271591a80db6d744a611d7c684d2fb9032d72
      https://github.com/bluez/bluez/commit/516271591a80db6d744a611d7c684=
d2fb9032d72
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-28 (Thu, 28 May 2026)

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
