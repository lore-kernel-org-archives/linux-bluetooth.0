Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE942EC55D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784555; cv=none; b=GAF59IEB9neG/RqO7cEA35Ji34nRncXdiMhoVlcNiPhwx1Mh3quVmemndJm9EvuA0EoEapObCBuv0XLUV3ZZ6yqfRjy68A2szf4a5ph595Tj94ZwVK36Z3eln9V0rR0t2RNrDCbGPjXODxALh2oQ12uou1wfdz2f0eaFgTU2y4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784555; c=relaxed/simple;
	bh=at028kdANhCFmfCiRC7PmT+BnOkE+aKFPHHEkmwQWeM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pa5bwvXpXvMouVZmRsVxiWFpchHogWxdVyI/CaPkW88/dBKky5y05UxRJdbbEbFP8ibxkG2t2Ms116DMqXoSQBWsAvM/27ItpZdXfvn+ZuNFjqf/yH8pPahc295KxBGDfzT86AFPGRF8tscT8nKSApqZv7UlAS0MsTvetF74faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jtlCOkTl; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jtlCOkTl"
Received: from github.com (hubbernetes-node-8d7d783.ash1-iad.github.net [10.56.206.80])
	by smtp.github.com (Postfix) with ESMTPA id A5322921322
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755784553;
	bh=UUtjF+2GFExBNm84L3YM5TU4bW3DPAN6/QPzlNW9Kzo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jtlCOkTlg5lnkKLzAs8Ksbb9zlazMXN8cGmr7PAshwtFz2pWJXBKAvX4uaUytvOeJ
	 gn1nSylkDOdBWglPp4HRJTBPS9FYGAwJnoF+SJLJ/VEO0m7YsxJsZKu+cs+c7vIMc2
	 tLlkDuukTd7PI2vqnG1zx04EZgT0HNTmsPYrOvz4=
Date: Thu, 21 Aug 2025 06:55:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993679/ce1974-000000@github.com>
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

  Branch: refs/heads/993679
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
