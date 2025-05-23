Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AB283C89
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986973; cv=none; b=RnK9ENcesu0tuIJflh1kljcf107xWgYakNliXGgswuaX3wJm9EuF7auBEfhtH61F9MsKF4j+l6AOHFhMzNu+TvrjK5FJqWRSs4HIYPMLRpQAw4qXjbb75xPEjliWAyiNwtKvITVcMxo544f7Q7o5oj+pH2tG/c40vG3QOTHaGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986973; c=relaxed/simple;
	bh=ydK30kVKNgcZ4N1cfZxEtLh5Zn4SKo6EosaFwZ5gdIg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VZ2eyoeTlPbhiok8MNNXw0kXkeXV4QAxoddf9yUgeO3WUe6foQbn4tQjbE7XD8V1BLWKph0lCR+xlyJF7J42vDqj6t4anoswrrs6RPB2CoOB0wyWzhkBTQDpGlsd0i4KJ8sX6hAD/w5M2Q+/fWLWw96UtRgft/ftZIZmWI+7sD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hI4UFQnu; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hI4UFQnu"
Received: from github.com (hubbernetes-node-bbf6df1.va3-iad.github.net [10.48.156.55])
	by smtp.github.com (Postfix) with ESMTPA id 29FC1E034A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747986971;
	bh=e7M9Crx23Y4gFYCsQtPtw7WWHqDSeQa+Apdw88gvj94=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hI4UFQnuTmBhuNfvjfDUt98OfllqpLtOr53MWvTbKE2bGkz9I2DGoyA18XTmcdBjb
	 gXc/6E2Od7NRfRUoBsJ6qU0KxJ1wSNSbVZnbAprNPkdUUnfoNdGXkgfEy0/B3wZKe+
	 XSYKSukCtYKTMLsS+2kTTNQvKiBicdWTs3y25zTo=
Date: Fri, 23 May 2025 00:56:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965460/087a3a-000000@github.com>
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

  Branch: refs/heads/965460
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
