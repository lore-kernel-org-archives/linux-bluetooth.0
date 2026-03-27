Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE442D23A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619512; cv=none; b=HvVC1B683eXxPqLjrsiFCi/hGdKccP6ewAtX+CPQ8KTFVxUCLOOyVB3hSADOrh5I0UxoIChcGAlZvzwKCwEC2rjp8hHpqU7cCdUinQNkpw1wd2y/zlZgdIww9Ah46Dc148Jqm8ojv6Huu93FMrj1mah5kFgHUYheQxFOKC0aHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619512; c=relaxed/simple;
	bh=R9l1LrCDAq8Mhw01ZEdyjXhoCkedjZcO1YwfbYKhID0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gqc1Wcmm95K+JW+/wlNRI+tHR8A4P/6N1bFqNzh1DvadXBylSilw7kvlshb4XwpWaxgzGuP9RwG+IS4iBnjGXRAVgBW3GUMj7prhsuEjyn78R5UZBqe7cAM3Q8q5+ZaWxypscHRp7I2fJTX7Tznh0kKyQnuJIRY62PumuTSTy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R03yquih; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R03yquih"
Received: from github.com (hubbernetes-node-c4e5eb1.va3-iad.github.net [10.48.168.22])
	by smtp.github.com (Postfix) with ESMTPA id C113C901161
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774619510;
	bh=schLL3wyRt7vOTI/LYD8qBzSFEaRq+Bh339Dglqt+io=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R03yquihlr/RyzOKGMWKocXHnKuqxHG+aKLjonyu7lffL8VkPBq5AVkDkH5JI0Zaz
	 gaJZxLhQ2HrfSWSbNqoxOzWnh/cIuKsmYuYOVPrIa2P0qD017VAdsSsrAPcpt0YinV
	 MQu11J5bwB1+sof8kvCRiuYoC0ZZRvuGSQ+yUvpw=
Date: Fri, 27 Mar 2026 06:51:50 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0d4bb4-8ea1d0@github.com>
Subject: [bluez/bluez] 8ea1d0: doc: Document bidirectional (Source+Sink) ASE
 flow...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8ea1d0da24ae505c1e2226a35e3ddd7eb8066615
      https://github.com/bluez/bluez/commit/8ea1d0da24ae505c1e2226a35e3ddd7eb8066615
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-26 (Thu, 26 Mar 2026)

  Changed paths:
    M doc/btmon-le-audio.rst

  Log Message:
  -----------
  doc: Document bidirectional (Source+Sink) ASE flow in LE Audio

Add a subsection under ASCS explaining that multiple ASEs with
different directions (Source + Sink) on the same connection is the
standard bidirectional/conversational configuration.  Document the
direction indicators (Receiver Start Ready for Source ASEs only),
a typical setup sequence, and a note that this is normal behavior.

This provides LLM context so automated trace analysis does not
misinterpret bidirectional streams as an error.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
