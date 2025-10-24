Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E881F03C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338080; cv=none; b=ooig+AD3o/DCjs1zo3wgN3TjiitN4P6Qu0rNgUsa4fg2YheIpwSkU6NobcuCPBJyMr3ccEMVRRxHgNbOKVkviDg0N9vobDOrbrZaBV8Euyn04aYLwgyMYb8v9PImQ+Q+sBFn5IVX58wd/y+c0tL9G1CDknNZhtRdsqoUCzjh1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338080; c=relaxed/simple;
	bh=0Q6e6uPc+UtCkpJa01p3Jta7TfFWfPg3kK3fhs42mLQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KlbPCtcFw+QZFqOnHu5v+DcTwmBAoBwMFP3+5NxtZ0t1yYOW24VAIkKFo564z+JAIJI8ckzsuM3K3SeyCWvbZzmZTXBrnZDCf5t3W7DVoDCfXy/e2OG0fLfLfse0j6/07gvubVTj6LeinVpU/FjBhqbFKQmbgMjJvBI847nWH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YSB5P56r; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YSB5P56r"
Received: from github.com (hubbernetes-node-117dc4c.ash1-iad.github.net [10.56.156.43])
	by smtp.github.com (Postfix) with ESMTPA id 9A07C9211A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761338078;
	bh=6y9FUk2m4KpJfg9HanH8zKcZJmdBnQTWYGh5F6JSv/I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YSB5P56rDQnIJLqigB+qMcNdxQGXTkzsOuHjc5x53ra6Zxo04Pmy0vW8hAKaz9c2M
	 uz9cQVCnoFntB7WGNtj60XNehu6K2wKX+5k07gT5jjEN8WTgicgVcDawXfk2NMEWW+
	 eoJcPFQjk+Xz0YzOy0bJKHeYFLF8wJz0+UWgpjxo=
Date: Fri, 24 Oct 2025 13:34:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015549/a0d59d-000000@github.com>
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

  Branch: refs/heads/1015549
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
