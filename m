Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A07403123
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572304; cv=none; b=OIRLhJ203NfmB8mR/68Ya8m6jJ6o0ZX2wiFO9o/6WQorFNsxD02NuGTFoTpmFf49uuu2Jjn/5RgKxM3QZjuAHL6eE3YmicgNzSRJQGvVA+VBmyN8bOE69R1Uv5Z0w5/iFr86sUVyQuKEpwjCfx1YtgIvEqK8O3IDKxU1oWtzWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572304; c=relaxed/simple;
	bh=3Dsmmd2KN/0+VLbbT00Q0txLyLIP3mmeRzt6CV5DPcM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AXlN3iRxO70pQvk1T0KzjjxF5dbQMPTKEDed1Ha7k2EGCuS2jYalg8+/beczN9Urn1qhnHE1LvoOgDUgEpHW1tI3lyerEbH6IdoQ8gYG3L3qQUsTEL/tY4JCUSHkl5xIgoxb4sYSLo2XkdtDIvyvRX7s9uN1/1jI2sIp3cwfbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LN7rIM+8; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LN7rIM+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572302;
	bh=zUniqSA2yu8QHmE+Cmvu31l6vDHbjKiQXBwbuHmVMrY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LN7rIM+8Z2aRnkN+2K9wLmutTIsDktHu/bUJdcapqyepl1bgVnai3/RRe+O/nuGaP
	 1H3cq2SF/i/VrvLyC7clJav1lh3N23a/5F9wEED+dICJOG/7FsVPUSvBQhhQ3JYw8V
	 pOFfmpkxqvQlu+MyQbA+eSiSPwlbr/HOykOKJiW0=
Received: from github.com (hubbernetes-node-b7b39d0.ash1-iad.github.net [10.56.200.77])
	by smtp.github.com (Postfix) with ESMTPA id 60AC0521116
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:25:02 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:25:02 -0700
From: fundawang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105842/000000-d02777@github.com>
Subject: [bluez/bluez] d02777: build: Support libical 4.0
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

  Branch: refs/heads/1105842
  Home:   https://github.com/bluez/bluez
  Commit: d02777b690980cce8cc761b1ab040ba58e704c5e
      https://github.com/bluez/bluez/commit/d02777b690980cce8cc761b1ab040ba58e704c5e
  Author: Funda Wang <fundawang@yeah.net>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Support libical 4.0

libical 4.0 split off some vcal related functions to a separate shared
library, libicalvcal. As libicalvcal depends on libical itself, first
check for libicalvcal being available, and if it fails, check for
just libical.

Closes: https://github.com/bluez/bluez/issues/2090

Tested-by: Bastien Nocera <hadess@hadess.net>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
