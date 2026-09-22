Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF94AEBC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057740; cv=none; b=UM8siezfTOJ1Ovon0uGijZYsu+J0IECryrCJ5aW02Cm3L79FimJ6Fni+0FaflQ8wqA7Yxns/2WVN+aYNCghwrnsOdGYBUvAYScGq9fQi6aEwcq+LE2K33VXgrVqkMA1EBM1IBFYQ/sA1KbIoFPeGy6uILVGiB5nINRGK63IH+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057740; c=relaxed/simple;
	bh=Td/NqPpRMQ5JGePIl/olCTqKfCvCLSEOpZGcE0TCUww=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B8nIsDArOcoi1LKmuUXixBZ+oh/NntFZQtvIyMt10BtGUIJq+w7GaqCxxHI8MsDyWIE55kFyycX4UJQ9bJBfAeXoXaiRVvlw5EfZ2U6MiIhguHBPwOLEzyjT+p5u1oDkNNdZ8t4+YiKvifNpa1FsmB7oemIY0/Xqpuo910PX8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PEiAGVJs; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PEiAGVJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790057728;
	bh=De0FMAp7kqvu6XtKt82qZwLIn+UCk978+pTZrOiy2S4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PEiAGVJsJlWoRNF13l2ajyA68GItgTfnHb0pdN2h/Hq2Lqz7mxeX6mQv7bh03CFCP
	 bdzhQQnA/iwpzw4dmkJP2m7p67IRu5s7anejKWL5z1TgP8OWhmPvNWXUUEXMV4aaLM
	 L+1xYVfYyndGikKr4QHylMv5mDGKmo7ZMv1K032w=
Received: from github.com (hubbernetes-node-98c177b.ash1-iad.github.net [10.56.154.44])
	by smtp.github.com (Postfix) with ESMTPA id 6E3E68411B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 23:15:28 -0700 (PDT)
Date: Mon, 21 Sep 2026 23:15:28 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1170934/000000-70bdf4@github.com>
Subject: [bluez/bluez] 70bdf4: device: Fix NULL pointer dereference in
 dev_proper...
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

  Branch: refs/heads/1170934
  Home:   https://github.com/bluez/bluez
  Commit: 70bdf4950b9c15c5f4974db53a5f50778708c39d
      https://github.com/bluez/bluez/commit/70bdf4950b9c15c5f4974db53a5f50778708c39d
  Author: Tao Cai <294305068@qq.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix NULL pointer dereference in dev_property_get_uuids

The bluetoothd process crashes during D-Bus property serialization when
the device UUID list contains a NULL entry. Add a NULL check before
calling dbus_message_iter_append_basic().



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
