Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89A3368B0
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479782; cv=none; b=FY3hwk+NlNKUy/ilIMcW/UZJp5aMjorHHsG6yndE/UNtX78FRfDzHBbpGZiu4YXl8HPIu5giH9l/r+IyiAkDuV9dVW3NCYLt9DD+NTsdB9CcRG3UO8xPYIko7b81QvoKad4ZE5oc8hfJ+Yu8wIvJC7K8Vlzrurz/05pN+xNk4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479782; c=relaxed/simple;
	bh=lXxnPtle6cMSHqFw4+wJACsL9ZnAD5UJZ5qgyQhySSo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HRBcvdJnBZJ23q6rNqwQ2mgXg+35kIw/wTNYiLcg9Bfx1u3XwayxnC6RrbCPpDyHFKQhQFY9Ke9m6S7/mR8mg0q39nHxG319wWZojpp22JHblofiHiXhzjUkMqoHmhje2IA/PhV7HJzilfuKfrs3FHIGJSpgxfewNEHtAxd0V04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cVSYyvtA; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cVSYyvtA"
Received: from github.com (hubbernetes-node-de39905.va3-iad.github.net [10.48.131.33])
	by smtp.github.com (Postfix) with ESMTPA id F2EFBE02C6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775479780;
	bh=RVlQEMR0FMCreM5STJFS5hYi88yACwvM2Szrls8rQXA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cVSYyvtAenNsWhtANdXR9TAjKFQZOTjGVeGdEZvvK3fjvgr37B/+dnybmhREGHeGZ
	 8I1FTZSB9IN35jPH0TNUIUmO4dNAmIuge7Z4Yj5kXI4i5GFf/296FTQ08p1WFqgR2S
	 ocnQKP9eCMcHNIuPnyMPQ9/IB2nUygeyVmje4L0U=
Date: Mon, 06 Apr 2026 05:49:40 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077645/000000-6a5044@github.com>
Subject: [bluez/bluez] 157b82: tools/smp-tester: don't write array out of
 bounds
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

  Branch: refs/heads/1077645
  Home:   https://github.com/bluez/bluez
  Commit: 157b8257c9c1f0f21b61bd39acf46e528ef4a7c0
      https://github.com/bluez/bluez/commit/157b8257c9c1f0f21b61bd39acf46e528ef4a7c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/smp-tester.c

  Log Message:
  -----------
  tools/smp-tester: don't write array out of bounds

Fix accessing pdu data out of bounds in SMP Server - Invalid Request.


  Commit: 6a50442844e7d4ef533dcb68a500ffb372cbc854
      https://github.com/bluez/bluez/commit/6a50442844e7d4ef533dcb68a500ffb372cbc854
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/ioctl-tester.c

  Log Message:
  -----------
  tools/ioctl-tester: don't read array out of bounds

Fix accessing (invalid) param data out of bounds.


Compare: https://github.com/bluez/bluez/compare/157b8257c9c1%5E...6a50442844e7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
