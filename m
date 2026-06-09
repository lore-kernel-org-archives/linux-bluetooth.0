Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8835F19B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037126; cv=none; b=SdSQZ0muKG0S3GMezTVI9X/D0B73XgvEJUN12bZrp8/RxNyypyM49sWhtLQcHS0dwQJzlU7BjGlmxe0GxC9lpu0rWBgwp+7IDPixEUFKntz6zEpNdORPIVX9BbiZIz8wzVdMhjVW8KClUeedzORKuREwMrWmhm/HR1hGbZ2NfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037126; c=relaxed/simple;
	bh=8hdlU3tglvkIeCQtrveiiU2BdKNvMXMT0XkrL+UyVw0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H1BaRqWc74SIuiz/jV2adwNGFW0D3mvLOll+UvLRzXut22GZDHZ6XINmiNbs455K73VlWr69Sc0NjCaeFLUCxKX020h9gfQv0/Ui6BhYOPrxJW3B6JQCd9UJkBOByWrWpXAiHKdF133hgpfPtw0XKTAwR71JoFP4a40yQVempKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SMMMAGhM; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SMMMAGhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781037124;
	bh=DraijFhGp1FGgGDYXireHvXkCbJq+sqHB4OQZt2gmS4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SMMMAGhMcWK4Eqj8U6k5kAw8NLaIuUDSNGv8O8Sl5g/oBxPIlhSElFYfzvRkhqJ5Y
	 o1PW/nnkUhMhFzJ+nk+Nwbzdi8H7YyI8bPnn+5Ly6C9PdqxBpWmwKftC/laFdKDuSB
	 XqjJANuRyssycGjQQIEdHlyYMMSFFl3XpJjZude0=
Received: from github.com (hubbernetes-node-a1a2a19.ash1-iad.github.net [10.56.177.33])
	by smtp.github.com (Postfix) with ESMTPA id D4B5984086C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:32:04 -0700 (PDT)
Date: Tue, 09 Jun 2026 13:32:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108736/2f53c2-000000@github.com>
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

  Branch: refs/heads/1108736
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
