Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAF1D5CDE
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746172816; cv=none; b=nTqxitr7uL9ElTHWltznlrzd9zmYrd+YDJEKGN03SdP1ByGmnUzszJ0tgiNIAUwY4sq3ITBLsmHhcauk949KYfEYAj0KIa0V/BVhJNKv+o6HthRKYa1ol1WtE30w1577a0tz3jwiLcXAPZvEs1N3OVTE5Kqxe1hEOph9mbrt+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746172816; c=relaxed/simple;
	bh=4Kw2Q0abuUtEQfl56GplamZgLXeKcj6i93BoVGNEq40=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JnwICnQQuJkfihu6QWEnHjuukMjIEwhBhRSEEtz84EygjYSP4cs6Jl4+P9jmRnvQPu0+3xOnCVsLCVwN41gQ9IBs6mFFGej73f/8WQWFhi3pAxiEk//qFyj3u341wneAXRlu6kuIjB75yYz26ULCT7pd9godNSxwXDh6oBPgPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R7rBoHaz; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R7rBoHaz"
Received: from github.com (hubbernetes-node-05ce5d7.ash1-iad.github.net [10.56.174.20])
	by smtp.github.com (Postfix) with ESMTPA id 4231F60038B
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746172814;
	bh=xLRkVB9TX07y529tZ46FJoALzXQxWfGcOnoeLBSKf74=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R7rBoHaz8115Qu8HE4hcPhg5MuH9GyDpZMLjDAt8zed4M4rFaK2htTQkQbbjWDEH6
	 ohwPpziKn2tmgldXuyWFwg021NyzdGpkld/GK3FBob6yvQxyMgDxQEXvQjAB9/eCs0
	 zdU+TdU+A8PSGOwvG3DCaciQi5GjQjekwKt/1/Z4=
Date: Fri, 02 May 2025 01:00:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/949188/ecb773-000000@github.com>
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

  Branch: refs/heads/949188
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
