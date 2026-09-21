Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB653911CE
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018724; cv=none; b=YupwrouFPSfTu75toREZ5whL34bunZ0Hbr9B325p7mvhdJdtvc4UJ0d4Zz9BT2qeEetbyPZbhyXmOfKQXIa8MYFeWFgYNlWiVAFGfSsd2yJ6eF3Uzxw3mcdmPgPI/t6VY9sbuSe6wodPI5yMUswbus6lXVTJJtFoozEpV8EmkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018724; c=relaxed/simple;
	bh=Np9q2erd+gFF+5032uUukQqUyH/FAHrp7ybQqq61ETc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tzFQqN/CHqqCTO7WSAUDD5Kj/EDvl/MxNuRhaId+sWUMDNlw4roJMgyNDKS+keMzCvRt6ymc3tZ2EUyQ51Cc5izy52dFXfYNvnKb7s/VuUAzfZSXPnj+GSK/yvksD7TESYLXTGr0vbzUBU5lA/CUKHMCLyHmQEHZho98A2ukvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SD0dKSuG; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SD0dKSuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790018722;
	bh=AJ3QRohAEBcSiDC82q5VkJpy4NCqSOmvChEKf6agKWE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SD0dKSuGrVmV2xEEr5l4S+7nk9gNgTMytfxSpFBEHDqcPwDsL10UcyjZ1BOEUB67/
	 IwEDqh9zYwoigE865zT3ngeZNgQyfxR4OyG1NWxoHHARwoHOAe9ow8bX4rARXf/5eV
	 kYnxpsVOcURAAfuXVYO+43HqMY34L+0mrfPpg25w=
Received: from github.com (hubbernetes-node-22ba6fe.ac4-iad.github.net [10.52.138.26])
	by smtp.github.com (Postfix) with ESMTPA id 93CF7A13DD
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:25:22 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:25:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168850/6eb44f-000000@github.com>
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

  Branch: refs/heads/1168850
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
