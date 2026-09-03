Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB54B66CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447610; cv=none; b=KgP9k0ToLj+yKQHwGBlFlPduYwRiJCFuAs8OyxUt1hgvzi91nUu2BZ+fGzho1Hu55SJ9Q+Qleqpwo1CbhCH8n3Bn6fqS8Aiod7tchWGKpvg3RzupwXdMQ+FAu+UR+oiTKx72OUv7mB3E/Qhp0m4ByX2FEsPjbsnDLcmckyXdHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447610; c=relaxed/simple;
	bh=p5OOhWzCC3+oMURqJLcpdnPwXx5sQP8/Iy25mKSC1pQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t67aRzZjyg3/Rqx840FCeuAw/5YpkEPuzcewPfw7IgTeGyEzViSop9bAlEk3MdOB+RQclVfG9RE+8U9Ak9PcXFoAi/EB9Gy+dJXBc2ZG7qstWIRxIjHFzZkCtSpUdLUR9/AR1oovhvB/KqJbtQuWchc1jzg+t4kNARmrx4dLGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S42ILcVz; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S42ILcVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788447607;
	bh=FCqIDQ20f2bqwvI2DFpESkBfBE3q2rTrH3QAZE8IjEo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S42ILcVzmcsB+3hKApMeHwP6+BQ6mbajTnp+qTuMT93oijUb++te8mY6H3OyYjssU
	 givY2TdEuC22fxv+V2B5+LiELort+3fccK3Eelw1uwwXYJGtmsRsMs7oSKryLGr/H/
	 k+H+dVY62NCA6+2p43tnxhuPDk45E8VP2dQtfCGI=
Received: from github.com (hubbernetes-node-6e38296.va3-iad.github.net [10.51.99.32])
	by smtp.github.com (Postfix) with ESMTPA id D84943414DB
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:00:07 -0700 (PDT)
Date: Thu, 03 Sep 2026 08:00:07 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157040/000000-5bf564@github.com>
Subject: [bluez/bluez] d76c66: btio: add BT_IO_OPT_FORCE_ACTIVE support for
 L2CAP...
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

  Branch: refs/heads/1157040
  Home:   https://github.com/bluez/bluez
  Commit: d76c663e701c5685230217496bf43977b3536d83
      https://github.com/bluez/bluez/commit/d76c663e701c5685230217496bf43=
977b3536d83
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M btio/btio.c
    M btio/btio.h

  Log Message:
  -----------
  btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets

Introduce BT_IO_OPT_FORCE_ACTIVE in btio and plumb it through option
parsing and L2CAP setup.

When set, btio now programs BT_POWER on the underlying socket, allowing
callers to explicitly control force-active behavior.

Co-developed-by: Zhongjun.Yu@quectel.com
Signed-off-by: Zhongjun.Yu@quectel.com


  Commit: 5bf5646d6c16b447d65f0d3ccac946f6bb5b5d62
      https://github.com/bluez/bluez/commit/5bf5646d6c16b447d65f0d3ccac94=
6f6bb5b5d62
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  profiles/input: disable force-active for Nintendo Switch Pro v1

For Nintendo Switch Pro v1 controllers (VID:PID 057e:2009), set
BT_IO_OPT_FORCE_ACTIVE to BT_POWER_FORCE_ACTIVE_OFF on the HID interrupt
channel during connection setup.

This avoids repeated host-triggered Exit Sniff requests and reduces
Sniff/Exit Sniff churn linked to unexpected disconnects.

Co-developed-by: Zhongjun.Yu@quectel.com
Signed-off-by: Zhongjun.Yu@quectel.com


Compare: https://github.com/bluez/bluez/compare/d76c663e701c%5E...5bf5646=
d6c16

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
