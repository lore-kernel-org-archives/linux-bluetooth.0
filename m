Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CE2F531A
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011632; cv=none; b=fpQTgDc9SeOEAV/kOItrJIlH3YHLVpQOY4l81h6AKGx/mp7WXyBlgPTsZplyXwuxnWCKFwynBiLWiEyhq+gGwYJ8M75oDCQSzlUY2O+HWLpUCXZ6iPOnyP1AgB8eQ2lVXgvcLtYl8rGjuPR+QNy74om7gkBWUX3v//sl1vdDGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011632; c=relaxed/simple;
	bh=dM0rvVjWYSZXnNzI7NsfKGbfG5x295n/HPMmzgKIGH8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T6u8o6Lb0qPXiQzffpuk/3JNxZB4Hi7rfh2TVigf5QdGGrfgA4naHpiiKXQIlK19gP5Q3mzlCBl36eB1Fu2gLvh4OpnwjF9d/VqZt5vrfgnG6PB/bksd2Wo143iKhUSvx6ooqQ/LUGlfQgrrxsDK68ZmvkvpG3mYYoguHST6V2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EqiOsX0S; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EqiOsX0S"
Received: from github.com (hubbernetes-node-4f6370c.ash1-iad.github.net [10.56.178.17])
	by smtp.github.com (Postfix) with ESMTPA id 92A68140834
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011630;
	bh=y9uktaulooACstQ7PzET1ZLOQIHjaQcv3m9wmOBaULY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EqiOsX0SqmM4rKbFZBoUpUdTAlkC595xQNHFViOx1QQsYJLQrtVjUyIz3vHY46alh
	 jaJw5TRrBQcVrDS7xNfgFFXvJ0rbi6YolgHC2eVgCwWMmlakhmPxSRt0UehxF98n91
	 WxJSvCfdKaOlLgrHTG/WV3dZYzmDSPgocYsyOwiI=
Date: Tue, 12 Aug 2025 08:13:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989673/4eead4-000000@github.com>
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

  Branch: refs/heads/989673
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
