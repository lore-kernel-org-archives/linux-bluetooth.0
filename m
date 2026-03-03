Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDE47ECED
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550699; cv=none; b=ERqBcfbp1bE/3Gr3wNRU9rLb1bmqtgrt0HhkWN2ZjLN0ipy0OdR29g1U/FxCfYHg/yOczd66pqZUj2TiENWWzwwF4A94P1uIKONCYAco973iTjGeVzHnOFlWD/jXOxhBXKL3T97wxtbc4QIBURZLGfv0me5VJyGl9TeUu8K3HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550699; c=relaxed/simple;
	bh=1gnINDO4FXq5LOuqTGwoU4FwqFzLl72e8kuds4g/648=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BmG6eQ7GZ59JSBsJiHct1kSXCG53aehLynrqbk8FvwTmfkHmYj5x6+imKaX3j5khtpNvxD+ui+mnFvcY4fHOwY987dV0YWL0iMpCRwx8ftsC+rdQkrHf6dpBegdZLxglVRLTzGHmECxpT6LebJ0iolP50vaRSiP2yvoajEhN8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I4QtcOgT; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I4QtcOgT"
Received: from github.com (hubbernetes-node-b7593b7.ac4-iad.github.net [10.52.221.73])
	by smtp.github.com (Postfix) with ESMTPA id 8E7A6401896
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772550590;
	bh=lVAkRytSB1qNHvNUYO1DKahzAGYPuz3b09ZvOD+ZJ8U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I4QtcOgTJ1+5RiWQV8G4FiZPZFB9IIPq6pDtb9zp2BvFNqQK2LpIZrjzh9eoeYgoO
	 KXSWYJWevBXQWBwvUG6fyVrGbVPfyZlmdsPXDrhM0v8Veaj9IpXIy9PB6xG4kYfOIc
	 mDK93cksy9z8AOVJ6dkcYXTEyuDfDqO+QLmy8kTg=
Date: Tue, 03 Mar 2026 07:09:50 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d66e23-081dfd@github.com>
Subject: [bluez/bluez] 081dfd: monitor: Fix issue with Packet Logger Notes
 missin...
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
  Commit: 081dfd785fe594f581c892aae68955436915afd9
      https://github.com/bluez/bluez/commit/081dfd785fe594f581c892aae68955436915afd9
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-03-03 (Tue, 03 Mar 2026)

  Changed paths:
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Fix issue with Packet Logger Notes missing null termination



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
