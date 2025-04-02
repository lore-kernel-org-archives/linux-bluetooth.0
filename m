Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E236458
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590570; cv=none; b=bVuk8YKh9V9+4x/Lj1kkb+ZEI/TRLHDvXLQtT4QPBM3ncm2kbDQMN0i5/RvoTvuWf26G+nNMw9pIgIEyxeQ9PWLb6vrNddt+L0LcXoRHfcZN8b89ee1L17nN6cmIQzgNe5CVVlnkDmSZ4XixNRIw9du2NxdcIh4dG+KV8JKOdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590570; c=relaxed/simple;
	bh=DovCR8eUZIN2z+lICY8UBvWmKEcJoU/yJb67eWimiwQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TR0hQ4lXpP7xUwT2AYHSBXZMFOsYqwtc8h845kUS9ZxN+1uxWnSYIwliIFrEmdtKW12IgsVaT+aJ/v6Ee9HuenJueC8BNERVg3kiYT3V2Qa2g1q1M8Eu78kKfpnL1VT/m3qgEi21npqi7/bblT7V5kR+Mgn6KtCj+i5OxqDmwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hoKZgQT0; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hoKZgQT0"
Received: from github.com (hubbernetes-node-ed2b54f.ac4-iad.github.net [10.52.145.23])
	by smtp.github.com (Postfix) with ESMTPA id 5279221270
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743590568;
	bh=TZowNNH/6u3pjwva/r/q9R90+rO5XFr17MBjWeSupsM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hoKZgQT0EtUPCiv6gbOmdn5W5NWQ5D7uZu3k8ZYC2FpemDnY1bbFm53A5tIYYf+Do
	 Ikn6PAiO6vNhLOaoNGMOnNtHIJU+KG/xQfSc6PEJH8rTbdlmL35JPN0ViIR9MJyssc
	 V8kk6DFKHEs2I0YGwayOc8myJylaL3Lw6wxgIUso=
Date: Wed, 02 Apr 2025 03:42:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.82/000000-5c2e45@github.com>
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

  Branch: refs/tags/5.82
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
