Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9230F7EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876993; cv=none; b=bY3y5g9plZwpZkb4HuH6kr4x3+WbvE2G0D7K0RdVztukyqJMD78Djpjs07Qpftb2C/Knenf8Ffkgt1rjNvAyOr8nisA0DFTl7NoDxaJAyl6kuX2mTyirzHyqUr7kLgMJaISMN21PzNGlao2JAsaB2HqzfZTFWIQV4WCo60WDi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876993; c=relaxed/simple;
	bh=CA4QFWk3NhCtO9+G7U3NEsijHariK1ALs4LGnNU1P+k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qO8IS8umdYfhkng8ELjmNsX4lBcZAxNXaHCyBirnJH2lbj5UsVHwDF52pA4zXMi4joOtDYO6RRe1VkvIfSgA7gkLR4F6aAUXQpjDXH1t/uZlSpbRdxC9/VqN4dK407VmrDEMj0MsgJkPPKKrDSmAwML/VAVEDTMNqk56xJ/dyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KpgftRs9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KpgftRs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787876991;
	bh=FHInG37kK/IELwyYUNB7539n4kaW9kNuCG3d0n5WbFE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KpgftRs98R/atuZd8nR52TkvB7ra6j+XyiZUGuisHDjJ89SbSmGUbbD7xPeGzZAUt
	 DdazqTjfiT5TMRsyR7ej7L4SrYLJwfdL3MH/Ip2dn/a3FVK0E8cUazMT29Ut2iUCQq
	 g/hmNU+i9eND2olhdcqNzWjjmc+3A2xGcWRaYOeE=
Received: from github.com (hubbernetes-node-8a002ed.ash1-iad.github.net [10.56.225.19])
	by smtp.github.com (Postfix) with ESMTPA id 85302520C7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:29:51 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:29:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149256/b625e4-000000@github.com>
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

  Branch: refs/heads/1149256
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
