Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84314E50B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675502; cv=none; b=Uiqth9DpqvwrNwzT0AZBofIq9w53nOVwnEcPXMrbbrXXnEZZiKwyccTweQlaz5tWJONX10IaU+tUjVHZ1IZJ6PIp8vIyBfKGQXtwM4C2xFxDBzPVzSrR/T71YNsHq7+qji26z23xvWOo39nwvh133aauGDqVlSR4D9P62rHUJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675502; c=relaxed/simple;
	bh=CrGcGsg7GcCM6xXVGCSgTQ/TDNZsTRNLjA3CyvmYxT0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MfgQGqH60u9PTxx8TarDJcdre+EyGRCYCxQIkAyxh5lgXTfp9u6i0RbKCfAJEC5yEK9tlcS0N6gu007U6iiN2BKsgEWCWWYYWRM41quONY5WNH1DZESqzxiAi1R3OAu0mxTGmTBbuLGuXpfOdYK6taqAVpsgo1b8vxWGYSH/6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HQErY4gx; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HQErY4gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789675498;
	bh=P+9cqKA2GqjuIDtkseoQOpoozkPDNg5q4BX9HpGl1H0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HQErY4gx1FLCUSs7lFWmmw+U2fdZVPppq9oGNojH3b1h5doIto97Ga2DlHC5oQC2L
	 Aq4AQWfBHk1/R1akBSTjFZ9XwuRmSsjSpRjhFOqKIygl08PeYVXv14We8+b19imP6D
	 cP6nW+PRfsUktw6Am7erTx9mPKeVstyS5tdU4M00=
Received: from github.com (hubbernetes-node-c5cf0ba.ac4-iad.github.net [10.52.134.27])
	by smtp.github.com (Postfix) with ESMTPA id B0D2640569
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:04:58 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:04:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1162311/9ddfe4-000000@github.com>
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

  Branch: refs/heads/1162311
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
