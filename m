Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B621C195
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321962; cv=none; b=tv2LhLQayr8u77ScdcTaP+2YuysFIJofCBa6UuxjCluaPOVAgaOzjLc5+zC2OrzV1KfcYRDKv0cTAGucbOfC+ZEldbJ5gDGeFyFGlcNKDKf8f2dy6bGQzYgYk7q8/d0sxTT/JZimJZ5B7i4LuJ/8Q92gpWJ1++qcJOUOuFHkkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321962; c=relaxed/simple;
	bh=25yEpUx+ULAHMphMyNU+kXZ9h9w5KF1nqVR8MHQCgDg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FqSCedpVAtH5fW/u7hB0l+66mxsAschj2T2PZUI2QrULYuti8Cy0pB4tE8MLtRJx0dedev/+2v6gTJDqu4fpqH4lSjY/ZR00BdpAvswnsuvBhhoXb8oPXxlbeg/OBcyqqVqHZNV4nFfgfdqBJx1uUZ1pqEOqSkG56VztoYwzXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SsWhJFf1; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SsWhJFf1"
Received: from github.com (hubbernetes-node-cb53705.ash1-iad.github.net [10.56.202.67])
	by smtp.github.com (Postfix) with ESMTPA id 1FF8F140183
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754321959;
	bh=4jpuqBRDadJNiTzdbt6Oa6bU0svuZOg/EbMoIvdXHRw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SsWhJFf1ubXqOpkjwG19yH1PGVK10VRwnpWYeRtA6mfHoJVHB8UmCsuxtzOAhzOJc
	 WtzQMBCS7xvRQWkP56kvkBOyukBT9wnLyh/nR/FX8i0dB9Y0RUlI9p9STDsgybI0Az
	 PTLyCsSx2OUT9xdvPB1+AZ3gISmjmmwdfpNfTIcU=
Date: Mon, 04 Aug 2025 08:39:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987426/956da7-000000@github.com>
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

  Branch: refs/heads/987426
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
