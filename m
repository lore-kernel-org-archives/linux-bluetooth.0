Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3906158545
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580576; cv=none; b=tKPNq6jsQL7YwEhllXjiZGPbc+cKdlnMMol+vcUpUTQX5YEkI58QQSR/MuVO+bVC6c29E9a06G5SK0ZnSyKaBCwHh1tc57P0I3aT/JZtO6RipOhgklG9L6IZv0WEy7FRZNAC0imRvJS7rYWsVkCWFelXJIZ5H19rb8/HTWigK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580576; c=relaxed/simple;
	bh=XigMc4X90jlkPOoZM99hZSQeU3KvBeQoa4wPe5WBoKY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BRDFaTUiWQCQu93HApkaA/OTh3L617Qx58TopATytIh+FEY0eLTb1L2VY37TRsLuZaNi15UjZmPLAUSXQYNr/QzUKzlGgez1XtkebeY4SoR9buMfDyA12/V39wKfIjTsKlBWz3mexzAegq4861fvZtw4PNaYQA8oVlOu6d2+dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=koqOs1K4; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="koqOs1K4"
Received: from github.com (unknown [10.51.94.33])
	by smtp.github.com (Postfix) with ESMTPA id B539C4E1119
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761580574;
	bh=RS0e0FIzinz6NxF3tJJVRmZH4+97jIvI1LMsmVcBcwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=koqOs1K4ZWPAvmWE9zpS1O8BXsDYSivj8f5UAK42b//ZF28BdFwx/bbTxtqvA9pGB
	 +/+grzMczhDo1iv91glLqKuXqwnn/zzm2qaxFeAkjjWAq6faUHRoE/y7ssm/D3XLvU
	 /3rbDj2Z9aYXbU4hXBNrro5fDlmpffCh3RbP3BwE=
Date: Mon, 27 Oct 2025 08:56:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014597/a17d4d-000000@github.com>
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

  Branch: refs/heads/1014597
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
