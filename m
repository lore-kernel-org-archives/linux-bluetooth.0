Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115B3909AE
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488347; cv=none; b=YkTz9+TmIIB010UJSU3cI3maiL1UNu9daHNXoVEJ7Rz3DJy2tsW5mPJngKE14XWtBcZzvi95/ZjGWzLcLalhI7romhNrcvw4PhrpFedF/i+AAD9/EU6Vb5+mcJGJgKTUXBnixbufl7s18tJneM4wyAXSEB1hNsnLpPhz25LtDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488347; c=relaxed/simple;
	bh=ighCmIpW3iXZWw1Fnpx8+6ZRgkIjdEsc32m1rUZRb6o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZQzmcM4zlcW2B+b7HFfyANhxezCFFZd0LsruGkrMmBd5sQVtppfHqM+W0Bfu9Ae/zBhv7KxY28v9UKkKSgk65iWwttl1UZ0DYMp52lAGz0jhLqJUUP3WC1iAGoe7i41DTaM6b46zIqOYtFGLCU9HCVy26e/5fVDMCDYfd2YlQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UrQofbtW; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UrQofbtW"
Received: from github.com (hubbernetes-node-5d93682.ash1-iad.github.net [10.56.208.37])
	by smtp.github.com (Postfix) with ESMTPA id 0970C920A28
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772488346;
	bh=ccjAJCEuNU0CCzGgAsD+WwFvUU+GkMi+5vdr8RG8xlI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UrQofbtWs0Ro8zofmvrrnWoiKxJyPRLlNOrhFvkGdfTGYLGVoL2fFmIecP8cdXqzK
	 J6ZtoIHzrAB83D8VIqlmYYsliQS/UKwy94h29PcMRlPkKF0U62h7hc6TAQX3WA2h9x
	 YhINfPy3gXuL2uobzy5dxDRdFO01vhgB7ehx2qTE=
Date: Mon, 02 Mar 2026 13:52:26 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d99f2e-d66e23@github.com>
Subject: [bluez/bluez] d66e23: shared: Fix the Apple Packet Logger format
 detection
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d66e23695b1b46df757482bb6f7d98cb7d556814
      https://github.com/bluez/bluez/commit/d66e23695b1b46df757482bb6f7d98cb7d556814
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M src/shared/btsnoop.c

  Log Message:
  -----------
  shared: Fix the Apple Packet Logger format detection



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
