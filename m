Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AD27877F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355205; cv=none; b=QHkp1f5V73efw/CixvhyP9lp+lSy3OlKXYv/hDMIP2KxlcpztVNfnbht4DeVwg6IsaVPajKQTI6Mg7YX1a2+jyMr3nvv0DMy55Bdqo4E1fflGXxrLrtgx/C0g16yZzHs1rCOAKhNrt+SelTa4aAkikYzb0D8PPMGCD8bJ2hMfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355205; c=relaxed/simple;
	bh=otmOtFtgJU9kpLCw6u4hIA9MSyqCe7uOTMuBzkhP+T4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s9YGgsq/LIizlShtfo3cctidOOpYoZ6WAnFCKW011NUZmRTd+1cp0lyW5EothNJ/4Le06sGaTLQrnDUhJlOywckXDvuB/litEF8phMmONCIYCkEzCQsW1JjinOX4R6w69VAnic/dkKob2ynPn7/J0YaiSbM1jTBQ+i/F6AxGBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MMtFT0GG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MMtFT0GG"
Received: from github.com (hubbernetes-node-b87cba3.va3-iad.github.net [10.48.152.36])
	by smtp.github.com (Postfix) with ESMTPA id D4E074E1154
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748355202;
	bh=CfyVQRcCEyMGPQ1Gj5UPz3al2bkoldwBgaewXuBy/g0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MMtFT0GGEuJF/Tzitnqco1NzrxItBmGB2sClptKGiJC8VIgXW8jXlF2Za61B67jxy
	 YQ+QUKAkVeUro77AS/rl6rpsrpFkxeny+eeu8A0BFRm9ImQVpKPb6ehLxmpB9N3rn8
	 TtlZuGBRD6hcWSJWzzb7VhV2jBoZahzUOeQDHHcQ=
Date: Tue, 27 May 2025 07:13:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966556/47c788-000000@github.com>
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

  Branch: refs/heads/966556
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
