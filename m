Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729947CC91
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509554; cv=none; b=ghNlB4/OaHFq6hExg5hlUQIEvLPGk8Vv/OCe1DE4ixh1V7uMQrdlV7y5QHzd9+QfrNZLjpmxVCIIrN1GrbPmUcXp92bXHBQR0MD+r9O2OIPC3oMu3UiUI8tyH/Qmqiir5k1k/jlrGk00BaduVowRpCvzI7Dz6UygL2klvHdFOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509554; c=relaxed/simple;
	bh=FhRiYrizkbQI2H0m4KrDg3kbyhXYdyB6qhg14MIvVWM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lztHpwhJg2hRlQCQ0QAvMx4R2biAHxC1E5tauihnVrzVdeMaKXbHktFc744fVXmjMfHQylmD35BkCDuvg2KqwUcY97zpzoE+U1zFBwRY4ehmffbiYR0MAxNHC2DBhzyTuKT4E4xn3ZaSsV2m2Q+U0E17rijWec0HSe4NjyLn76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OWa/Mzwh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OWa/Mzwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789509552;
	bh=X1NocGBV0hSMD0wK7YPRxpNXXc4Oa9DQGSWJU+E9gX8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OWa/MzwhwBhf4Kx4M6pdTNA6bfQNFu4GjY7yzr0VVhVrVcQyiqd0scWuFxd0dqxZo
	 PmgsDZqWZF/w6Mam9WKkx+d12/Nct7nR+CjHpcrEhHZYH0r2lcRIlHAFPaSkENcWH9
	 lq751VwfsIKQKplwNK4NOLL/Z5VBBn1aRHHzUPkg=
Received: from github.com (hubbernetes-node-518072e.ac4-iad.github.net [10.52.144.37])
	by smtp.github.com (Postfix) with ESMTPA id 9938BA0906
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:59:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:59:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164934/9183ed-000000@github.com>
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

  Branch: refs/heads/1164934
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
