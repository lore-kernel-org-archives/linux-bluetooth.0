Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C01CACF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700482; cv=none; b=YmXp30OxvHMFe69lkc5woFXuIYv6gh2iVQhHce1OaFrP7UKt0PrQTz7dblHAi8gqS/gUo9OXTBccRKgDHujMldXWV5NfU0XREo9bS+wCsi+Zs0mOQIDmvkdw6STh0gTwQGsiQ5HHRS8Zqv7LkLorJF6bnWuiLfMP/0qg/5EAwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700482; c=relaxed/simple;
	bh=nbjAKMEMBpYy+1JAaLhnD9QtseV8dCZQ2zKDm9QyglM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c0lBJXf6fBh2U0YlpQcEIcYTeWQ6TkkO5a6NJx6ZSqZHrn9EJpF13y0BMkhDaNgWRyhqMXHY9P59fdICcgN2L0xqtyALmu78UE7Zm+5/PYiifiuhyPMILyC6Wi2C1E9F6FbZmmrkJoGXp8HjCjMubYsOJ2yoHOSvkvJStqKl7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bBdzc1Ld; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bBdzc1Ld"
Received: from github.com (hubbernetes-node-1abcb8a.ac4-iad.github.net [10.52.156.38])
	by smtp.github.com (Postfix) with ESMTPA id 867417008BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729700480;
	bh=49a2D88qOJyuSQcHUUHg53Rj1i+YCuMM+gBeM7MXpeE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bBdzc1LdkrOKCHMjC4POgTAYvDHWPkXEXWB5ordQqedHzHW0jGoNsHFnBFDSWVFCX
	 tlVFy3MJB9+RKUqxy1ethvOa7lrgjNBmx0Muxjb0yrmtixiKp3exmqXgYC3cpOEy9L
	 nq+mIUvlpXghq6gjar8sTsqJiT3Ca22KpkxiHC2U=
Date: Wed, 23 Oct 2024 09:21:20 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/29174d-ba98be@github.com>
Subject: [bluez/bluez] ba98be: build: Fix make distcheck
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
  Commit: ba98be0356215dd3fdfb0cd40d7bf4cde4d7359a
      https://github.com/bluez/bluez/commit/ba98be0356215dd3fdfb0cd40d7bf4cde4d7359a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-23 (Wed, 23 Oct 2024)

  Changed paths:
    M Makefile.am
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  build: Fix make distcheck

This fixes the following error:

make[2]: *** No rule to make target 'doct/hci.7', needed by 'distdir-am'.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
