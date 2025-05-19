Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78F1E8342
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682047; cv=none; b=Mp0n4HamLe9XgKexsCZwEo7IquBODIYYAFyvQsYRE22rbzqh2IHo7NsuSrP+CNS4mdHyhR8UHUllQm6G42QPVZbt3gkeDK8q6hDFCpSg3u1vvK+b8NLBKncTK2i7+wHdbxwVDbNCCg1sDnjZSrvJDDWYOueg3Ln7MYw7NiAaTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682047; c=relaxed/simple;
	bh=IWkvuN+o/h5pYkPqoleaXXeYY1JbSiwmq9KQUFgA3BQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MesAJ+O62+A+5gKzrhKPlCiAHvHqNSVhO6MOUw+h3n/3TE5R/YPaS9WM0eE+J+S5FRI69KZ21UbF1e7fzjBPsml7gEDVLg0EJvtG62fdJSuK8QIHrwVYFcorrLQ3h5FQytDzixxQAsoP5h6uuyIUpOguPMwL2ramXXCDYqmSGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KeCpBNpD; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KeCpBNpD"
Received: from github.com (hubbernetes-node-9dd4631.ash1-iad.github.net [10.56.188.33])
	by smtp.github.com (Postfix) with ESMTPA id B5BDB140CB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747682044;
	bh=BqG6Z8FI8D9ikcaJu7eXcJL/kFRiE/XyhLIHZr7QxxQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KeCpBNpDxzG4aHceSAxudaW4eOj/PR9g6t/Iv2/qRVvCvozKNkDE37odJMwnvDXo5
	 kQITf+T0UjzGPS0RtF8ravNL8fUWBR+Rwu2/hj9whmyWujVEufIwIEHBKFh128PdxA
	 XxqEEeZvfiG4wvGFC395rG8K4pybvJ57lPQdJ0Ic=
Date: Mon, 19 May 2025 12:14:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cdcdfb-6a8fb8@github.com>
Subject: [bluez/bluez] 6a8fb8: client: Fix crashing command info
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
  Commit: 6a8fb8a00e533dd519665b2394549f66c124268a
      https://github.com/bluez/bluez/commit/6a8fb8a00e533dd519665b2394549f66c124268a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix crashing command info

If command info is called without any parameters, and without connecting
any device, it will call find_set which doesn't check argc and argv are
actually valid.

Fixes: https://github.com/bluez/bluez/issues/1251



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
