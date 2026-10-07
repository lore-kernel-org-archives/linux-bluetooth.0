Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA136A341
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399320; cv=none; b=Q4ZjblV08DNVCo0xLdaJgYHLWjRasI6s4XoqWfLWVcyeWrKEoTLs5E2nzvfhnXDzbKB0NNUy0Yhk5IxVW2yKBm1nDMyU/lYxOCG4X9IFLMClpbV7rlxAt9UJdkxzbw3kjfOvJsp2oCpNOsORBoV5VJgnLlbkY+V30txKVANGw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399320; c=relaxed/simple;
	bh=MND7rigcoT+s6jRnecpelo5/dORVZvgy6xQt6zoxBeU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ROK9sg2Q7d8Ne3TdY9Pvh7kh/edeXdI6BnAV1S1EPzlTFm+3FFNkPSx0FeAkOGGE178fCMZ5+6MbQlECpfRxooL2dV1RuqDyLzxxi1I9tN4FAA9gcuuhe7+55L31SJFsZ5iaRoFL9uSRKoBe5oto4AqXaVcBS0QCGASV+BAdgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=WvCiSFWa; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="WvCiSFWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791399318;
	bh=ESCjrssZlfpSWv31ZAwfz429Zsh55FFDqz77jOHABhA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WvCiSFWaE98E417kJlIwnHELrHKBtomfMjt3/OXGNGM3B95aTTVPKJf14RHLJmCKN
	 170HkQtrDLODMKZk2xII0JoKAUprBfl28R7YjpIdEidBZtNrLQ4WUk9d/+kPfxYjIZ
	 HQKjn/kzjGVM4kMxvC41r74GSXnx0rr2WDRwl/DqzNaqt8EJ1MW41kqtNAD0YdYW9w
	 W8gY6CuLOMq2esmjuqPCN3H7q+bejp6pdqfekUIDQDJudYEDugTMTFdBQfmi6O4hp+
	 5hg9FxCaSZsYN9QF1Vn2O1gZYE5s8/+VCPexi81jZ5VBq6sxQAtG92qn8+eAoBxgbr
	 yiWWsBGNWlQWQ==
Received: from github.com (hubbernetes-node-59bac78.va3-iad.github.net [10.48.132.30])
	by smtp.github.com (Postfix) with ESMTPA id 91D397811A3
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 11:55:18 -0700 (PDT)
Date: Wed, 07 Oct 2026 11:55:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1180235/2e6860-000000@github.com>
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

  Branch: refs/heads/1180235
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
