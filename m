Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570123CE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477224; cv=none; b=rEcVCw+6WvEA/8PeM9dAOLbMvGuRs8QGiKGCjFIhgRZ2kwxVHlnNlOpqZCamBx1ocWSMrjMN3GPEHRxOBx9lUi732Yz6Fr5KdqAXWaQSeOInPajw23UVtL7v9xdcQvMoVyP6f49itYTNLKwAb3bNlyg36Jq8m4193QZnOUWXPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477224; c=relaxed/simple;
	bh=rmpx6EzmlgTEtAn8GtI4FmGqtS7rpLDSjy7rFI1bNyQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hxRMV0YVTuI8cfu9Rkc1axdT6LU3w8ePtYhRUlZEFJJ1U5v9tG+paNpk5vMOptJHFtHBxfoVJxgaO3jlp2zRENu3hlKtdcp3MRFtgaRKLv+Xprch/smcKl6Nlpr0w//qlTzb477EbxqVlAQdb5E3w0X5YPiIRjTQ98qXEq6huSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TWg+n0ge; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TWg+n0ge"
Received: from github.com (hubbernetes-node-4971d96.ac4-iad.github.net [10.52.155.35])
	by smtp.github.com (Postfix) with ESMTPA id D35D46411B5
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477220;
	bh=N/Gk8xFc9Z7chTI3ahfFylWjZ8Cs+Zj5JktDeGJmm+0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TWg+n0ge52ov2+mID4L1zxAcrRAiiZrq7zc8sIi6lx7Llah2f20TOEBxiQe9FEHga
	 uksnwSjZlTQ7GF6Jol3llGI5jc0MewgCp8QfV+W9TZBzVlEO+Z7zOMau9ldI+CiTdp
	 bgUOpRVtRVlIFtH5tNpJwAQwGZOdZUnTd4JVdcd8=
Date: Mon, 05 May 2025 13:33:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958551/d70fc7-000000@github.com>
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

  Branch: refs/heads/958551
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
