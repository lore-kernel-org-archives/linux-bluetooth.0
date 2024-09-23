Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583C199FC6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104703; cv=none; b=cQSFhRYvUFmAVy9Sa7jCUgwweWtWXGH/VAG6+3rlf+Pib18J2+wkRrPgIRNPOhAAtOIf2CX1RskDihysmzhkGzKB7rCQnO13LTdCMpfHb5G9/E8xYsrurxanc/TYLAhcYbV1vlSFUjCdKvvy/YrCV36Tjmqm8W+Yybn962ln9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104703; c=relaxed/simple;
	bh=pb1VPsA/Xxn8Q8/JZPW/AvdQuRjP27tazijeyjZRqvY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iJQLuh0BcoSqJXk4k31RmdlsMjD8TgjPNjgHlZa477oQPVomWuSOO+rIZB+u+ED9KKF7W48TC/LWQ/dw0dPAQpRMIQgbXNFPWb+gTCm3JaFhjjkBM1CPuU6lzjcbywxhpgBTfouI8CS1G0LOocp4nkpPcH7XGU2FDr9gq4icR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TQz4SmGn; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TQz4SmGn"
Received: from github.com (hubbernetes-node-e98d5fd.va3-iad.github.net [10.48.138.20])
	by smtp.github.com (Postfix) with ESMTPA id D3DED4E0CCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1727104700;
	bh=l/vCiidwiVZE4bcsQW0qsJeqyI5lFG9aIT4nJwC45CE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TQz4SmGn4V9CPTxdZSW/wJMruZOEa9mdTxQveYWCINS1e12iw6k+gSFKbA6HZnhu7
	 aX/7t+DgD8QAKPfsAl5wVSY9IEJnBlPrQmlKhb2VGCfq+P3LLwNQTufBA3t5etUrjN
	 lJ/kcvYD2foXdsxKLnD80zNS0HWXG1TYfp93APmQ=
Date: Mon, 23 Sep 2024 08:18:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ce6462-5b6ffe@github.com>
Subject: [bluez/bluez] 5b6ffe: adapter: Cancel the service authorization when
 rem...
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
  Commit: 5b6ffe0381e80dcc980f0e73ff0621c2a6033be3
      https://github.com/bluez/bluez/commit/5b6ffe0381e80dcc980f0e73ff0621c2a6033be3
  Author: Cheng Jiang <quic_chejiang@quicinc.com>
  Date:   2024-09-23 (Mon, 23 Sep 2024)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c

  Log Message:
  -----------
  adapter: Cancel the service authorization when remote is disconnected

If the remote device drops the connection before DUT confirm the
service authorization, the DUT still must wait for service
authorization timeout before processing future request.

Cancel the service authorization request when connection is dropped.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
