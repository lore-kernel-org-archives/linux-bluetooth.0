Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA664F30D5
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541682; cv=none; b=tQKV4SpeHkT7QLWXk8a5kHFBjIWvw2AHF/FQsmWnV4SGfYltF0eGjODb+ysXjSvMAlE/dql7LZxvN98d6YreS+UK4u7DZTRiJWjZVoZScoNWXRfbwzMKZPZGPhhKesNcwiCYUFOw1wsrX4es+7+vKhM5d6m2CJCIOTC5wAB1ceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541682; c=relaxed/simple;
	bh=qgSNy9oBv8lnYpt9feRN2ZBzw01G79HCNfgmtlo+EyM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ETI+BwMDM43U+0rrKo0qxoLgODQ63q3xw86NR9UwB5Bygg9DL8Fp6wsn9QwUwgbSbxFJfuQPmypuHhguGUaHBVevPFLXld/Kgwd4PFM1HTPeN+jhd/VHrFTamag4O7pbu7/GX/6XH0VFTFSPIGWMq9dI2JI9xErj2jIt/xqYIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CxOLW18u; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CxOLW18u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788541680;
	bh=DfSYLjuTjMe3AO6n/IOVnsnEPjpyDWxq5+oguTU071M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CxOLW18ueLbLiw5MjxBLLndMTVqVn7WCD8ncUq0SziU3hyCQcRjTSICugpRjHXwbr
	 1Xv9VwOf9zgHJDhURiyvDL1WHe/FYzar2pl8OnT5+0MKLR16vVMtBT36O2nst6rpV7
	 y8mOLUPPgEoz8nDAzOUnSklrjUO8Neyqoe2nYbFg=
Received: from github.com (hubbernetes-node-934bf96.ac4-iad.github.net [10.52.132.29])
	by smtp.github.com (Postfix) with ESMTPA id 9A91B9408B2
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 10:08:00 -0700 (PDT)
Date: Fri, 04 Sep 2026 10:08:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140873/b30228-000000@github.com>
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

  Branch: refs/heads/1140873
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
