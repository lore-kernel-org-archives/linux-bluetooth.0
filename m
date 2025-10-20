Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D03195F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967428; cv=none; b=Q+NKGePwZPwbOFMNnhuT0O+WFS8mkry4UDGsO/883+0xaOz/Z8Zo6lIoNj+2noGRQaXu3h1mZsXYYXQ8DEjqTbgk2RwYau7N3B2za3EfAj4i+dxXTVBAO1JuPBv0iStnMy1h1QAfn/dmSLr7S7v1k5Xbz1GrJgjyLoXt79G+0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967428; c=relaxed/simple;
	bh=8q4G21USgJntGaffDLomIcZGpI8EHgaPCZynEcYe+04=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jlswLeFKLD8kydWtCU+9Gxe0RxURJdO40Mn5UiscrvvrPTbtYo6UQnXN7lL/5Zre775dZnctxLlmV5vxiIhRZrU360yXfB0naGneGwv0Vt8xpzEdqYg8RarS6mZBrHiytY43S+catZCGkryC92PBGjXXPypsmzGZBpHZIQkacAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PycVxImg; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PycVxImg"
Received: from github.com (hubbernetes-node-1c89b84.ash1-iad.github.net [10.56.200.75])
	by smtp.github.com (Postfix) with ESMTPA id 86BFA9212D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760967426;
	bh=jwd3l1QjJ4ZaUYoL37rEugFJdOOlw3I5aESHOHZ+QWQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PycVxImgRJUj6IPF38vDxi8NM1zebW5leNSUDVbSyFy9/BPNQb9DnB08XYK5HUWJ3
	 5I9Lz66ukHd+wdS3fTMiTEQtyMtH2nPjnnbVHLNYqtwI3qhyf9GuwMHcNoNVtV79y2
	 T60C1RspGV7i3mMDFcikvmmZoKiXIkRKj8kwvwAg=
Date: Mon, 20 Oct 2025 06:37:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008955/c5216a-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1008955
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
