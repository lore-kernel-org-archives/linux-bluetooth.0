Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4C2D8399
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178303; cv=none; b=QY7Ukq5WimSH3v2rFizN7ruBJF757uSQSHsfoDC1RGJVBKqJG2jKuMZ6OYRH5j+vy7vf9m8le0+BpMk5egYCot49zgNCB5C61WblQrMHs2uB+foNVt9pIZtdAzDfi2OFqx0FBdhNNfWy9GH8eTxggXzMJ88aErQxtSD3OlUZ5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178303; c=relaxed/simple;
	bh=OwLZ9B9aHmF8+ACo+eIdLKiCgHbhcdHpI5oL0Qp+mrw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BvGWB9YZQuiVHeG4GUXbBzqhndcTvp5eX9+1RAe4b5bmXGVydv9BxFJfqr9dmYqZ7nZWjI103421qYKr6pMSpF0FwfCSKZc+lHFwtbBbt0RM+7Jh6ks4wNFiT+4uZOOPqXlncSm5JaOBrIgk5fZ4EQx3OnoUIhXoT5TIXFsdv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fZuxq3Zp; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fZuxq3Zp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778178301;
	bh=hep4VKPhw0qh7ir55DYhHl/11VplCUBtL2Q0ZmWjCNU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fZuxq3ZpHsKBm7K1Ib/iEixOht2c+WMJxgGadaOeL69E6OvBuigPmi71uqN/Ua1Ff
	 sNDyEKuDQ9bqjKOI8jaBu7Vj1hVHwQVPUnNQrgGISHRcSPkERZqJQIhw5CSgyPR/Ap
	 fehjcb4zqjwgLVUSWaJBCxYz7FiZ8p7Xy3+gE8yM=
Received: from github.com (hubbernetes-node-15446f7.ac4-iad.github.net [10.52.208.57])
	by smtp.github.com (Postfix) with ESMTPA id DF77732117F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 11:25:01 -0700 (PDT)
Date: Thu, 07 May 2026 11:25:01 -0700
From: qarnet <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e3dec6-d45fd4@github.com>
Subject: [bluez/bluez] d45fd4: bap: Fix typo in QoS D-Bus dictionary entry
 names
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
  Commit: d45fd43a1cc3ba791858f11c144112c518a9ad84
      https://github.com/bluez/bluez/commit/d45fd43a1cc3ba791858f11c144112c518a9ad84
  Author: Thomas Kirschner <thomaskirschner85@yahoo.de>
  Date:   2026-05-07 (Thu, 07 May 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix typo in QoS D-Bus dictionary entry names

MinimumDelay and PreferredMinimumDelay had wrong spelling, causing
them to be exposed incorrectly over D-Bus. Any client relying on
the correct spelling would fail to find these entries, breaking
LE Audio QoS negotiation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
