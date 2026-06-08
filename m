Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17873E7BBD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948242; cv=none; b=Y0UuIIIm+r9UIWIhrEX3AUXSb/FYG1ftrRRW5b4b8iJLLG+wVQkFEmRsp0BOF3TKxXtqfCmC/GrZxm23/fpwmq7wcm0Flic4jgh3dOkcWDjqoXcmGbaiIbGcdjA+mvZgN8R+Bs+LR1VCeR4+RgvvxwSJfvxekoSZlxBRmnn5Ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948242; c=relaxed/simple;
	bh=fhe+WZ3XFMfkY7LwzDjExUO2EkHkS9790BhO3q98iQU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nMLixD4LerTy5kG90ZvFgg+BsggxTRQgJMBH0B/uDzmhZZQbppclvWFz+vIDYGljOZcRWjSZdk8ev9rrbacHENc39f+DxlRGg5IHu3dc2mocKtAIfPy0GQGog0ll/posoGQO0Al0L0qMY0LF0JAlKU3B9X2kJ5KWoZ85RahsNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EU4CnqRt; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EU4CnqRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780948241;
	bh=mxdi5e2daDMFNzh2ct8vsJTIuOMhSoKo90kC/EB4eJU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EU4CnqRtkRyrjX17lLWZsogKDeMpbplqrBjzX1E4V+mwuc/Whl5s0BTptFPZQTmT6
	 W7SfIbM10gemyUw5MHtHr2gVhl2ZLR42ymV8OWOZhOQxUdnjl7a4zgHSWZXvPJveR8
	 +2Hz+AdCd1QeG++1bxICLvBVA0XBLFWJrBDSGJF8=
Received: from github.com (hubbernetes-node-b627f92.ac4-iad.github.net [10.52.176.37])
	by smtp.github.com (Postfix) with ESMTPA id 12E4A780FFB
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:50:41 -0700 (PDT)
Date: Mon, 08 Jun 2026 12:50:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107789/4db6f6-000000@github.com>
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

  Branch: refs/heads/1107789
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
