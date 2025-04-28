Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646D26A0F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848802; cv=none; b=dPuhDyfK0nLSNO3cA+cYZpZ0YUiPXX6IxnvOHlLEDrbzY6YiChoqbsQaJLlccnf/ecD4VY2thM935/TaPPEkejtE7jjs8aP8/c37NTpZsGJAeyvO8epI/8BCntgWWFklKjMnTdKlADM7mvyKbqEoTSI2/lZTJGHHAnnNGhBMx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848802; c=relaxed/simple;
	bh=cLAfK/3yiUz+du6c0UDBgQ4HBMRqeA6O4nPxeZacddc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p1D2Vimv2z0TKWxyzTZQ2sTPuZB6Pq37Fwpg4otM4eL10FBe12l/G+iaN5i/Woge8nZAx1q73ejNL8rZbfahQqu8oTWieYccr9tUSTSMH+HzzeOcL8y81WDtQQv2GHSyfIVJaHLp1V7A3EBjWDnQ7gEObrBjkewBm48xy/V1MxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bydgY+x6; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bydgY+x6"
Received: from github.com (hubbernetes-node-501fe52.ash1-iad.github.net [10.56.166.32])
	by smtp.github.com (Postfix) with ESMTPA id 589326007FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745848800;
	bh=XifuWpRMVu3wxJE9fstmPFqGg6MpcpvJKDD0WXtCwYY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bydgY+x6UQcXnORIScxMt39MmdCbGqH3ftDRKmiDoysGEiM8h5HMtGa8vQAcgr6Cw
	 ymEI7rakxFQBsIH6zQlcE6IvChpqxSeyhVWns0irrVWJ6vuY/C8xVa+lSgWvyFhtNc
	 gbJAGqTtfDyoJXM/5jcDtb8w9JbKCl/mU2hF4B8k=
Date: Mon, 28 Apr 2025 07:00:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957156/a762d3-000000@github.com>
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

  Branch: refs/heads/957156
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
