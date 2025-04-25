Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF221ADC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608251; cv=none; b=RBKWm3Dv0l2Y/sl4uzgVRAIQtpeTuga3TgGgChr9dEx4c0amOmo9guYWJda1CpWIF4KCiI/+rkjMVqvz0Cp4o1jUPvo4ARCN5sF5T6AotoBGnYOX6LgRPStAwazSqiPcE2XEei+vajCk6nDL875ZXaX/sq3mxp+jtaMAGj1Vld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608251; c=relaxed/simple;
	bh=65e4dBCFqL83LML31iu5yN5NR51/O4VjJhI6ERg+8oE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O5U4iFZfN4ryLUIZqeAi+hfMPHYkMRKyL9hdblbwMBrmOHLSzsgFAEDcbZ3GnYBTqUqnJI3cOR8Jh8ImwNREMXpR3WMFvI+nzNtVG29LUMm/AMYxKwzNBmvsz3O7jz2liSjCQnfpdWTTeghSgQFuYRh52Itl/+q9yuXX+svyd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WuErSePj; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WuErSePj"
Received: from github.com (hubbernetes-node-93b324b.ash1-iad.github.net [10.56.171.10])
	by smtp.github.com (Postfix) with ESMTPA id 937F26006F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745608249;
	bh=h37X/MWjO0nFw+kPLAbbd9JF62njGasQVySBebPlH74=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WuErSePjGUHeZcqpmJovlmLzK3XRjNaxGKU1ZqHmvyoOaM4V6x1w03JQB1VsrEi9L
	 /xtWhAbKpfJuhABwCWD24XvRcKBQrBsjfn+NO4fRCT64eUMhspo8ca2ItEP/C+I8+c
	 a5Q+n4r/4lrTw58fusqRXpGPnZ1jzh9VT2SMXCrw=
Date: Fri, 25 Apr 2025 12:10:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957118/97ecb3-000000@github.com>
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

  Branch: refs/heads/957118
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
