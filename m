Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219602D9ECB
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898428; cv=none; b=W/kRBuvruN3WqQmhnmR9ZJe/1qWjgsHXRW4Fq0i1NgY5lMwDljlBSnqb9ivS6twf/GjHKIsdQvuJLDCJwnNP/OO0M8OIxpWE7xlGO0b1Akp0CmcteYEkQyjbiuQSS0urKSGDyuOnfxsBZsRvSSpI6AmXHdsDAL9TnoDbIrNMp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898428; c=relaxed/simple;
	bh=XnoP99DRwhowBgw7isdntUA+6QdvQvmaM3ZWg0cjFis=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pfOUC5+9OCOtkmPpZUeQ5oo27V3ybIwxolXf7kTJ7N1L2B3CMm7vqkE/ZlTd/U1z7TOWRBCJSkw7U3/cDvHJ0XnAZBBDEAryPwb/eHZ3uWhAhhkPh1cx3zAEZt0sHfTZdR0Mru4nWXB5YeNoFpWEQwd8vpVtqwAOOE5eMWU10Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H3fFbz0L; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H3fFbz0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789898426;
	bh=yy3Z06XqRjHPL2+OrAYQV4gaH+C3WXzzW3Je2/ME1eE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H3fFbz0L8Ck9hpP6k/JLRAOAqB1VVQCrjlZ8a4EpyrY7JXoGc5PtBFhhmvaCxOZ65
	 c+/kFzZs0F7RTIPUJjNwpCj3P1/dqHrICFGeuv9evxqxyeIXbhuPxAnQmEaG5Ue3w5
	 OXcFZlVS0jlbOnHpqeCQQ161ZfAPeWXy7TO/82qA=
Received: from github.com (hubbernetes-node-db7b35f.va3-iad.github.net [10.48.64.96])
	by smtp.github.com (Postfix) with ESMTPA id 16E938003CF
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 03:00:26 -0700 (PDT)
Date: Sun, 20 Sep 2026 03:00:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149614/e3ef89-000000@github.com>
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

  Branch: refs/heads/1149614
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
