Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F63BADB5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622076; cv=none; b=nu8HWL7h5Lu1Za3ZFlTpvqv8Bzn0YNZ4isaDZ4O9xkZF24CuukFhEnSiNFzogPgXRZV2XOjBLcmrV7QwF/PXMw+i9mEVIiVHHWx/k6ORpM41CN/CfBJFC9HTAGJRbM3/pcuIEkenQtbIG7X7qzFQaUzaqTY2kwJ/tNwGVdnP3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622076; c=relaxed/simple;
	bh=pKVdEbBXANFHFalIaPrWIDPA5gTkxhLYj+aecg6ErJc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DHRa/XEj0KOgaKIs7y4v2c8U6dgwYMVsIj4UltHWoNJAQz6T+YRao57GRl1emiV2BR45KwVvO6foRT9KdZgGzATpjpcsVJNpwoZjV2zpzcLGh7YGtdKIU63FCmZEtDvukpoUeYkZi8074Mr3QrYc62evzWiPmYn0iliF/oNfQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l7kZijo8; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l7kZijo8"
Received: from github.com (hubbernetes-node-a0eb99c.ac4-iad.github.net [10.52.161.35])
	by smtp.github.com (Postfix) with ESMTPA id 4D4A6640C37
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774622074;
	bh=inkVlurFFuTfwSLFmF5d/uiiQY0l+dXbFXj1E7Q5eCs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l7kZijo8xYJr0/fyJzxbg3ufYgaBfvfimAoHm2RE0zDHxve9oLq+qDVAFYzkVt4kn
	 Szs51N5G0oFFKMIWu5mMLGZjhCMUuv+EQo/7JZ7Ylk26KDLiLgufk4/wBVwtptnh8e
	 TtsNRE2Qc9jC2LdeqRy6vt9lMfvIgNPdOMihCAQM=
Date: Fri, 27 Mar 2026 07:34:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1073197/74448c-000000@github.com>
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

  Branch: refs/heads/1073197
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
