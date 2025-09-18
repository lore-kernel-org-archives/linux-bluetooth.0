Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64D1DF748
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202332; cv=none; b=O46DJfpFDNljxqafRG78I+m/2TQP3NZXPfNKPLds2bLvAqXQklN0uMHrsT2KlFU4NrUnSh83wiL1sI1jHr0WyleTHk55xIWnupdB1wCcaYbtXYKUiRctbOcMn5Lo40oyLP+4NeoS9Q3xsVVhgSQpRNsBAq1K7cYQKaP8kVH9kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202332; c=relaxed/simple;
	bh=cDTGe0Pv3K0anNxSHcaWP88Zz9+Po8M3LWoYMIiVpmc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HO953FMnJLLLjVQPa888/k0pA8UHtgrtPj9AhtxIjL3Jume9buNY8QYTLlpRZghqCrF+hbzjQ85CKKODpoM2BOavEZtrIQ2r/AGnzKM3PpFfFimaGFP7kdWQptKVJBKqEKxaMc8iHNQL2cAAUmz21iEOLigTul8wNMGVvOFrid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TQo8oMGY; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TQo8oMGY"
Received: from github.com (hubbernetes-node-3a5170f.ac4-iad.github.net [10.52.184.34])
	by smtp.github.com (Postfix) with ESMTPA id 5B8B1213A2
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758202330;
	bh=QLfJ50pG2KpDjFliITSfzACcj9ZNGPeaxAqSMDB89ag=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TQo8oMGYqfjqksVjihhAqj2cVoB6oVRpqD1mE3jp81aQVwrO9PQ45F6bJR2DPNL2x
	 +nry04uxnsaXTxSxvzUJxIID8vx5bZKf99YNH+dETEcXNF67la+bTj4PMrZlLokpxm
	 tlTy5Airs9vUDyBvcOQ2eASjoccVaWXpAoZfhhNY=
Date: Thu, 18 Sep 2025 06:32:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001921/484885-000000@github.com>
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

  Branch: refs/heads/1001921
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
