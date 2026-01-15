Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F3329C7E
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513788; cv=none; b=JJ4Xow054tVoLBJatTvjp4rMx9QGFtisw6WRyWHEREq6p+hZnicPySAQTMN22yoIzUaiC3Rudy8K0NuuMLmxaU0M9sDZ/8UFFXkqMjgRkCxa/mwwAsQwBjF0RCZh8CwyitruxMt2WhxVogN1evkCpvw3CfXFPIU517ZIOFOf2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513788; c=relaxed/simple;
	bh=Y8jdgFBiRGM0OgalQIdxAKCm8M4Be6qo9uA4bU6T0Q8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VPXD0zh7bF/8eWDCIP7SOEXH5BQvq1iQkACq/yvxdpi/Z0684s6go+BSMTo/nCS5VHCU7on7LcKzPFvmDCjsiV8sRwfp+DIHtvyHgfllrooprG4FjmRvDfs7ZocaLSpZy28WYj+eXXYvukq/sKQvbr4p65rPrBR+Qx56CxQeREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ewK1YrL9; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ewK1YrL9"
Received: from github.com (hubbernetes-node-b52ccb4.va3-iad.github.net [10.48.204.54])
	by smtp.github.com (Postfix) with ESMTPA id 9CA2B4E03F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768513786;
	bh=N6VPhPRzUI5dwJ3AFXiNKzAfTf/KmqLzUk89rt9vg3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ewK1YrL9v8un2nwkVUOvrRAPPAug74UzRAOjEZrJa/ZQ1/krSLsPHlfZTxnTAcXU5
	 S0jmu5gc5VbNPV0Y19ThVyXHO3kfekJQFeP4F/sRbsn4TctAiCU5ZLA1ZbsAFC24ga
	 WO+g91eLuLbleoW1HsWWBgCqBqfIvqBoG5LpBWcM=
Date: Thu, 15 Jan 2026 13:49:46 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042851/fe88b4-000000@github.com>
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

  Branch: refs/heads/1042851
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
