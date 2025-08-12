Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB72EBBB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011650; cv=none; b=ns0SjeZiT5XCb/lz3AVNcpNN7Seoha6tQQnhv4rYDYIcbD1rM4VT0Sk+9WjdbNMvDR/l4MM3//nAoHBIVeeU198K5cA5442BSTVS5VWigl6xlMXPyEY98pTH7ZZL6tHneijiELY+QR1lCJuLtroFHE8XzOM3q3okuTAfvPOuofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011650; c=relaxed/simple;
	bh=+EzqqobN6iz/+kn95PjZUNEzH+bUiAHTCUkc6vqWdYM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WtAlGIOj26o7jSeEgZXH/p5U3Z4CjNe7exh8Jfw6ca4cL1tNfRKiLSOZFZZUaTLN2LGEznQ5q2D/O8WLOImdd6g4mYTT246KG/d07ZFCTGga4vJp4YeEhuz0DgScMSpY9rzDAxb1ktu+U/OMYcUq50r0uVE/gAlBM3cucPhctSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d5VzIG5t; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d5VzIG5t"
Received: from github.com (hubbernetes-node-7086411.ash1-iad.github.net [10.56.164.42])
	by smtp.github.com (Postfix) with ESMTPA id 20FE3921179
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011648;
	bh=Zwu2QR5JSExl8oSZi1KanhhfTuNxi2gqsa695pnc0+o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d5VzIG5tUaYJHzxCuopN+23DZH+fNaLazlUL4l8ChECIWIdGmFUiUalO3iKiPPduz
	 kZIRuLqlak8VoICfHYE/OPGTlMoczPzGEdJCD/qL6HXm02F7HjHeRIEj7n3qcpvE4M
	 +2K76n4p0a/VpRq1gOf5trvu6fdQxQXxJL42elss=
Date: Tue, 12 Aug 2025 08:14:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985528/3cc1f9-000000@github.com>
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

  Branch: refs/heads/985528
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
