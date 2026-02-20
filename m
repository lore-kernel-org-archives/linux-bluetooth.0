Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E0280324
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618730; cv=none; b=T3qoMS2c22uo7hSAHTHYXuMw1aMQqnQKyvZka6lqpPZkIxAf9xvO41AYCfLuMJGJcJEnMkAdO4rqosv7154hjaj/qSk376by0QyVHuOYj3r0q/+t/Z888svxuYOfH+X+ReOsoIr1nO/MQM/fTw8JHQ7YVOuRpVvmDMi8gvRg1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618730; c=relaxed/simple;
	bh=5s7TSEpPIcDOr/34iXIQg8ZUkSfy0PJCtVDNpPxb7vU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U4OJWgzdmoxfyECHKTeTlvnYEuMovzBcJWLBPMe51AqK0qZuzqEz9O5Cmbid8nwgbx9v1KnGVhgWc124rvQOYxJJSCNHvOUJwZ8/cwM5SO+yLexUUDPd103nOCTbA8EGbxbr4dYozE4bhWC7PHXFk2W565ZsHGpCdV75Ju9hOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eS/57gzt; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eS/57gzt"
Received: from github.com (hubbernetes-node-0749313.va3-iad.github.net [10.48.201.39])
	by smtp.github.com (Postfix) with ESMTPA id 83A464E051A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771618728;
	bh=bvpPd4wVhxPspAR/49YHqe1GWxdGKliJapWgFzeXDbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eS/57gztVUK8t5AbRIPfiPEDJ//Uy/TvT5cO1KclaysLmBAXSJ7uM4xJdljAUpCIp
	 Qx9jSRi+UuroVr9OJUMS1OueC4kF6YY/CZCL+dbOnFC7Z92aQfiQnBtRoIrrA65wER
	 5eEs3wxnNjZGSpJrZvv1e7wQ+Po6NWstJMgrI6Lg=
Date: Fri, 20 Feb 2026 12:18:48 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1056016/000000-752bb0@github.com>
Subject: [bluez/bluez] 752bb0: l2test: Attempt to use BT_SNDMTU if output MTU
 has...
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

  Branch: refs/heads/1056016
  Home:   https://github.com/bluez/bluez
  Commit: 752bb0127adcbd41a107919da256025f64527549
      https://github.com/bluez/bluez/commit/752bb0127adcbd41a107919da256025f64527549
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Attempt to use BT_SNDMTU if output MTU has been set

With the suggested fixes for L2CAP/ECFC/BV-27-C the kernel shall be
able to accept setsockopt(BT_SNDMTU) in order for an applications
to require a minimal output MTU greater than 64.

Fixes: https://github.com/bluez/bluez/issues/1895



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
