Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E341377ECC
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209190; cv=none; b=B9XbIc7jlLv8wmq58gnxygwqVT3yOjX9FEAjlfgW80qAqK6rK/baEK53t5f8W9M7OpRKqyByw1bGU/ZFhHMHVhC+B+fAhvEMx/3/lmE6zV00sbcXndDgicc15fT0HAkACFknsoRwpxVhrQYf9OrmTlIFbDeYDeflungV4FYrp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209190; c=relaxed/simple;
	bh=P+KDt8gzz/Tj8aK5XjtBjVpN79jOa/nYoWArtGmCFZk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gk2bKiElbccvFB154x9K6HBjPNgYO0wN4xuJ/0OoTSIhxEn/zeLn1CYY7NuK2v7mstiqzYaA2Fh/Ah4OnH4YSM8w2uoDU/DlH7BUPV7YKGsDD++a0+66iVTtlEn/IEI7YnbSRg7Uy/k2y9iUJljuadTkXRMSGrF+EmITqBkzPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h1ShzRv5; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h1ShzRv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788209188;
	bh=EcUidNnAJdq5dw2JMqDxKnUyscfz2saXnN4lkLtj+nY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h1ShzRv5L8wmf8xBayjcmi9vuSo+EBqKFRIcjvofAPvwYC2aJWFCyy9YkP23cvyUK
	 vG5ulGeBw+s/6VcdPSrI/rvpjPaLH2Hs1RMlVF/1sAbNzWt91V1yDYxVbYO4suhcV0
	 T0HPUIJkwpJMjeD7eUSfGIPbbB2CBtbyGdADF8tI=
Received: from github.com (hubbernetes-node-9f32dc4.va3-iad.github.net [10.48.69.52])
	by smtp.github.com (Postfix) with ESMTPA id 81601180713
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 13:46:28 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:46:28 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1139642/d768b7-000000@github.com>
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

  Branch: refs/heads/1139642
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
