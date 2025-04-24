Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C318DB18
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509509; cv=none; b=oHqXV8UewNYHeU43e4ok5syDvCF9y0yzTGNiIVVnrTuGuWbPF0X1cqiXlQMKkB3HIGYoEqGafHgtqtpWtkIX9C9vnij/yu2Me+btDuAvLYgGtX2GpC2tUQvQZl0okJiZMNXDakUcahLr42f2xOCw141psjBLWiCg57rKu5DCXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509509; c=relaxed/simple;
	bh=zRR7SaT58oEGcUJw6vQ1jxNg5uOg9D68FCnPQt0qwA8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q2icCZ6u/vH2Ossopuycvyvpy/tnAw/vP/NVWFpHSpG+KOaISzshTdKJ/zVSiQmGnYFVwE5bWZM2GkBjQWhSf3RouMIeVSgKY5EpAApusy8d55JcqQiLBXJ1kF380LqWf4b0WXhPdBksf/H8YtV7InpjDzCg40DAoKIFHCWmBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cGUPMAC/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cGUPMAC/"
Received: from github.com (hubbernetes-node-1f2e298.ash1-iad.github.net [10.56.153.42])
	by smtp.github.com (Postfix) with ESMTPA id 63021141111
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509507;
	bh=tXyqS6TOSFLOIUH0tm/MeKR0nENb9eDkImoYNPNU1l4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cGUPMAC/CqRBtnmZ4OWhDy56tYvJBYrO7mm+HfgXT9e3ai/ja1PlL+1pAPU5O5bOQ
	 JJ0wfaoUCcr4b/8qEdVAE2sUMIj98mmQ4Ql0FsF7YqSIcwQS6w/a1ru72J6K1BGcxl
	 Fw50EihN6MMf9jurT0cSG3golZ7m3OBW52SNQbWY=
Date: Thu, 24 Apr 2025 08:45:07 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/949647/000000-8c0f0a@github.com>
Subject: [bluez/bluez] 8c0f0a: bass: Set the service connection flag when BASS
 co...
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

  Branch: refs/heads/949647
  Home:   https://github.com/bluez/bluez
  Commit: 8c0f0a931f85ee9fbae7312259ad2d85436d245d
      https://github.com/bluez/bluez/commit/8c0f0a931f85ee9fbae7312259ad2d85436d245d
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Set the service connection flag when BASS connected

When BASS serice connected, set the service states to
BTD_SERVICE_STATE_CONNECTED. Otherwise, the device will
timeout and be removed, triggering the automatic termination
 of BIG.

issue: https://github.com/bluez/bluez/issues/1144

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
