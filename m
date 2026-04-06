Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933A38B140
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495092; cv=none; b=YAW1pPW6lZWncRAVHuLocI0T8/9wSnRLSVrn+dZyEckxan1H0yflttucXh49vS+ByWd83abTl5e43CC9SoVimahKHXOLnNt83YAilWy2+dmHXCXqbEUbvx5Kqi158po5wnC7UOx0iTDdFWSSVHTZvF2PDVWoLR65XhuAPSwWkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495092; c=relaxed/simple;
	bh=oLYV+OFrjn06PoZUizMa71CsIDJkzVt7yDN+AF1EDNI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fQkb/llshf8H+QiLqft3pv5uTF9Jj9X9hIEfvqeQENJXeTMa4VebLEuJZV3a/YaBgRsYaoyK5xSm3q56QA8eab5LBmVw1igmLq9AO253ITqOTRJT0K1GQRdMbVBtz0o+UJ74NLfKvcX1uhetwZ7Q+pV6qXEhiiVpmWliFthMACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SdLt8y2q; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SdLt8y2q"
Received: from github.com (hubbernetes-node-0276ecb.va3-iad.github.net [10.48.152.44])
	by smtp.github.com (Postfix) with ESMTPA id 212AC90111B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775495088;
	bh=DQ884Ese0fJs4Cid3Z67Zx3/U5vgEZbGAXj8ylyJTJg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SdLt8y2qNqmenxoIz4JuqaxG/uO6Ek53VCAMdMNKlyax13Wyhb6XtmdGJ9Oy+Msii
	 8nC5aIlDfEL0cYHBmNj8klEL94PwqKm/U3Aj+tChvtzuN0N3Dk08WkN5zAU+AM5e9O
	 yvffq+I++Q5OEtlYpfjLEoxhcBbg38dDjZcXNd1U=
Date: Mon, 06 Apr 2026 10:04:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077640/40f101-000000@github.com>
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

  Branch: refs/heads/1077640
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
