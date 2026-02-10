Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E202FC004
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749025; cv=none; b=KxAV12l5sGUmypaDB/CfcwvCgkkEJs1eBLmX9MwKriItyKDOceZcH2vSn+CoxygZCbZOq5ojNLVUqL0JPeFIFXTiH9qb5Yi3Jj0hX0EAjVOYxGpTv63oQwErr4ZHS0sBOpHxQ0LC5EsiofjDsIabLurJgP14qvDkaDsJsAJTcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749025; c=relaxed/simple;
	bh=KBANAjLC0saxurdnNW7t1ohTLIASmWy2iojQOvC0GXc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iNfvZIQjSzwTyAoojbiKxMQUX9wkoSk+pMuC0eH7VDH9dQeAUos2l1faXtvthoc5ZnaA36jyKTHtIBCprRqev5mLs9Ssy7Mv3ZdjWpAapjS0CYriReI6eTC/4v3HHFLBlw9Slx+IzXoAL4ESKEtq4wYNlL/OlL82mtZgxS4Nijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kfe+eI+d; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kfe+eI+d"
Received: from github.com (hubbernetes-node-2d2dc45.ash1-iad.github.net [10.56.207.82])
	by smtp.github.com (Postfix) with ESMTPA id 8DE59939045
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770748815;
	bh=FgK2YwWvajoCgm24RzJFq7j0Vkh8PugCXqeU61O5YIk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kfe+eI+dKmEEM9gIyC12DQA+ikOCKmig28UO3V+vEj2hiwzKHpj9J4v0qByAxYUqx
	 4LWtcpQlancuiiINw4tLJFUP9KXzhDBGwDqFOhXkNoenU7bz9JT2QRydk+16oV07LH
	 qR47rTedTmmQJGWFi+eU98tFRIyJRGX0lzg8e/m4=
Date: Tue, 10 Feb 2026 10:40:15 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052631/e2bb5a-000000@github.com>
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

  Branch: refs/heads/1052631
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
