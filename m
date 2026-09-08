Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8A51A759
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905053; cv=none; b=Lq3w1OPX2WgaqLlNq4278qsuguFFhwJc7PrE6hkvKWQI8Iwn62BShTY6lcmlNls5H+DNpMdNA8Dnl9xQvTsy1tA90vlXyg+goSlaU1Pczw16cw0JMT9SqnwAmZwodJFeKfBRIwgRQrnxz0uiBLv2PQZLLm8n1j3sNrCziFkw9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905053; c=relaxed/simple;
	bh=qqzeLcS2vJNFxmGwdq6A+PY5/ZLLQf85CZQ0ex8B+sQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uxTggJr0Vcga+X9dN66IoHgccY+z+lVPZS3mqOJGky06ODUl2wy0Fccw/gmwBI/nFfHdg0vR5tF9HTuOJQMWx1CodMBqPkBVZq6bILjk/yfdnRE0j3OsbPGSZooarMzBeiEP+ETxvnELkSqbfwIhhD+b8VpeEKv/RriIQqlOe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mBWWLAg7; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mBWWLAg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788905051;
	bh=dcuwFFRcZOLbWsmATovEz42u7H5W/9S3UjJyquXsSio=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mBWWLAg7vSG6GoESu/w7EqlLlBBqCsrSeKOoIiEqap2Wf9oBeO3d7M5GuG1dvdmov
	 Hu2BYF6Q1dtAUE0ZVWgdIvRDEzzlcKK7hTKk855t9Ge3xCPMO5xeDW6mQnzTTyt0Y9
	 5e+T9nRe1w6rAUCJ7fA8ca8k5GtW3d6jVYfM5CJg=
Received: from github.com (hubbernetes-node-c1f6fb1.ash1-iad.github.net [10.56.130.73])
	by smtp.github.com (Postfix) with ESMTPA id A990E8412DB
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:04:11 -0700 (PDT)
Date: Tue, 08 Sep 2026 15:04:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1159124/bb3619-000000@github.com>
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

  Branch: refs/heads/1159124
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
