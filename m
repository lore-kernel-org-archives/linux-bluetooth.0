Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F6376BC2
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438925; cv=none; b=bVEjWvXfKQsz7azs2rd3RC3GUGCqcyFbtSGc+aTW0iF0LMijr0r9zByu5rK0hCb0HY1l+lrSUJ0SG52lpI25yCn1VWroa2Ol0xyXkawteoXpk1aJSPo+QVPA1QHTkBYtZggcsVOYpN0uwm/OmRUsaa8gEcO/g5bn6TZlDRBcQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438925; c=relaxed/simple;
	bh=NbAijxUKznHe+KQbdoqZrs3jmPMbMoLzRlZJVkliVbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dcq+3z/EjPDn7xYpQ7GNKyJk3mGL4tTaV4/SICMq/P7T/d4tf9XCgISycCRKEkji3ZIzxa5zgpTh8qbo4Kori2Vriote/jOWiZdDDmUOBoa3w8K0RgcDu/WzFzj5u5OkNf1mhJrDG9mjcE9EdAPea8eFhpP5bwd7pjP96t1Twic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JzqXwdpM; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JzqXwdpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438923;
	bh=oZBsbjHBYgD5jChaOEvpe6XDmsHcRAaK3kDEnFSG0rI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JzqXwdpMppKKlFzuDzur2+MKZb1ePoPHxOgF3twW4J+GOFCBNUAc/K7Y2WTbhJGpt
	 KN8SwiyDiZUX4Zg+WCjuGLB2dO216dtBBfdFMsWIockGIPSeSpL6Ln7d3PUQSACNcU
	 0R9V0/sacWeattFwR+MmoqyXzLxRL+WD0de5bMow=
Received: from github.com (hubbernetes-node-6cd5cc9.ac4-iad.github.net [10.52.125.44])
	by smtp.github.com (Postfix) with ESMTPA id 8D4AA4008E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:43 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108825/0aee36-000000@github.com>
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

  Branch: refs/heads/1108825
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
