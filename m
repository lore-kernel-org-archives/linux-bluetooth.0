Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAD1F3B87
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353411; cv=none; b=lK3Bt+wj+QJtdTHEw29KlEtGGzwQKIadx5ue4vHSJNWKuKF5DNQebeW/cDZLKneyL2TYqAP1fuIZ8HAJX4+iu04rIKNWw4j2HILMi6XnJhq7Evk5Y1AjG6Von/RQ7F2yIbgDNqa9GZpN/z9kafPfzJS4hP4wdtgtKq+m0DpOwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353411; c=relaxed/simple;
	bh=57ZAAzVCaFr5WdMZ99uiqAkh/VZ3YQZrkm3lLMFXMCQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PHVUK5NhM9BD4VOT3hQBpUSkVn4pmv+3Ay4qNDYdaBfxei5/AdL+75vI1WBQtjlckOAxQW1rbfDlX8xzIKEiZry38OsZdy/G8B3fT1Gt9P5F4KHS0ShqMj9ziGISOJBtlXoL9uDD1OSidsOHkKhdlQOAwRX2Z9pgB3fUkFgnxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eZEylIJk; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eZEylIJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779353409;
	bh=dkEeQF3/x7e5TgXVVdpfP0XhgNleQtKLykekGBXTNas=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eZEylIJkDaOzCT2UiPebXcpho8eZ5IpKjfwsMj66Sqs/K/7j7Uyvn0f3pxINVuNm4
	 eDGxMrGtaDrf06BVUuJgK1z8pJFrxj3YXeXmiADB5CNO8kfh086ZKv54QIfkyR86n4
	 uhaCsjjP5e3H03X4PYaEndKxDxaUVvO69qkgPQTI=
Received: from github.com (hubbernetes-node-381264f.va3-iad.github.net [10.48.209.97])
	by smtp.github.com (Postfix) with ESMTPA id C84D61800FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:50:09 -0700 (PDT)
Date: Thu, 21 May 2026 01:50:09 -0700
From: michael kong <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098468/000000-b65a3a@github.com>
Subject: [bluez/bluez] b65a3a: doc: Fix Data Path direction in
 btmin-le-audio.rst
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

  Branch: refs/heads/1098468
  Home:   https://github.com/bluez/bluez
  Commit: b65a3aa938b9ef692cc7bcc34f25abe520403936
      https://github.com/bluez/bluez/commit/b65a3aa938b9ef692cc7bcc34f25abe520403936
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M doc/btmon-le-audio.rst

  Log Message:
  -----------
  doc: Fix Data Path direction in btmin-le-audio.rst

The Data Path direction 0x01 should be Output (Controller to Host).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
