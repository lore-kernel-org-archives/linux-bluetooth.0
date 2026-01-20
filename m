Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323B340A6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928024; cv=none; b=JOT1MJ8qzx/8uX8XySl7/aL4goji1qpOYgMery2IXkUH6mwbZuyeMTQ52bOAANC0zDuvTy9LlQT7LUS5ySAvXNN1Ew/nLHA5lyOZVuCguOXsC2N7mzH3+ZnrK/l8Zc6BI5H6uQs0UpOZiHiZEC6Fy+lWWpQC59WDAoX+F+scC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928024; c=relaxed/simple;
	bh=W5M14pJS9rhB72pEG37Lh0Ll179w3TBa2aXF3FMFhto=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EEWnz7GTlMgEWk7NoYBvriUQlMrTKD0YuL7E+rtwwLT8rwrxuPnVr0SdWOAidjqIH0ulrE8lSg5ltE6LLOuwrTRipPH2tju2m37e7jHo3weP74EwWip9sxLXGE+hBBA5AA6CtOPIUcijX5v1UwFoIqYyDqaugfDSkTV4K+kzcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=amRCaQd3; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="amRCaQd3"
Received: from github.com (hubbernetes-node-0b24f29.va3-iad.github.net [10.48.142.32])
	by smtp.github.com (Postfix) with ESMTPA id 4576AE0435
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768928022;
	bh=KyU9O3QRtEDUHDEGDwYmiWPxS/vwrKTW5wUebQStmm0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=amRCaQd38ahiPdgKqZTHD+ba5Wi0g5Pb00wxB/v6RtyuNcRBMkpNLQKIg3LbOpzRp
	 T8WZeiFnYaIEZ6d+NGW+KfZ+e+ha8qaYQ9vpShQ1OoyM5fPt+gLQiblZ4BxCDMeN97
	 nqWJ5Qs4qiFlcwrSOEVkokKC4AxFaIEDiBEOsl+4=
Date: Tue, 20 Jan 2026 08:53:42 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044175/8d6e78-000000@github.com>
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

  Branch: refs/heads/1044175
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
