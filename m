Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B413FC2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912227; cv=none; b=laVt45SWGf96y4E3DtKJ+IAIqVHWIFuFN4JRsoUAk21BMGr0IsbozY5G8avIqZkkvCi/5KoxlXar3DSjn8FkBccVujWpUT5OXm6upLBfZc5Ctg3KF2YDnhUhvH8pg8YPjWb2zUw7GatStu8+cs5sudCp7WHR/TGkzw0TD9Qm/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912227; c=relaxed/simple;
	bh=BUUsGdAlv/bht5yNT0VpRUQju0dE8/NGSoNvr+zWwkI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H7l7gHoiInrqW+D7K9UUFyKUC29EeOausf1xHv8r5Bs/1vy3kFETfiFJXUvcPrxb8sX55m5BY84k/54CLZjg/dce8e2Rql3kOuE3sgLBKii+QTRDSYSecukn1pDRo9s1DcSxDdokt6r2B3kgZK7ZYgw0etNq8mZe5/IK2rAIHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NlQH/Qrg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NlQH/Qrg"
Received: from github.com (hubbernetes-node-aede493.ash1-iad.github.net [10.56.156.47])
	by smtp.github.com (Postfix) with ESMTPA id C1F261411CD
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751912224;
	bh=vIaefu7bpJuMqBgUnL370qZDhEpPTL450F+X1s0XMQE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NlQH/QrgNLHxyXr26FQ/kl7HxOPwPRmVtDYmjeaLqYlFnxZBCPAQJalTseY93h1IT
	 AsEVW/K05SYNvquRUNAjVLMsuLG9QgruFOoIRoyDe5LTwSzRFE2d6viWeR1Puq0chy
	 snz19xJgugDpwptpvI4833S7ZIBg0WkwOId+bhO0=
Date: Mon, 07 Jul 2025 11:17:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979723/022fee-000000@github.com>
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

  Branch: refs/heads/979723
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
