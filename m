Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF453594A
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771011135; cv=none; b=GalWxHYQRDsdgmO7k8q7AUgBAC7W0s4ihWm9Tx5tq8TG8FbWvzv+26tJLaUQLQnEYKd2lfyUXgvPOr8y/Pi33TzlskpyiL9nQ9Drp+9wT2ZjGxVF1z440mYWGcLiSIi0p/wR6Cd1wOIoNcjXBzNIAdYWvHQe83T76ho0+3bEe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771011135; c=relaxed/simple;
	bh=qm/wEKq4x4t8jvXwIk16srmaZgFrOGbMO2850gOCLvM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iDF4CNZi6S53T1QnfFxQIJQf9Pn+Nls4RDod7XPmCNVvlz4M/lv8ixuxu6YpR+T2gbr7iBBAredqpRLGFlbpEnw3hcdOVFOmfjxDonKfCk6H9vKr0ia72TwlMtFzQUT3oTiHaMWUAJ0ZDrhd5TVpYW9Xfd0OVCF9132ZMDrm5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gwfcMAgu; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gwfcMAgu"
Received: from github.com (hubbernetes-node-48fa146.ac4-iad.github.net [10.52.206.108])
	by smtp.github.com (Postfix) with ESMTPA id 7078E4010C2
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771011133;
	bh=WK4svXH/uAeBaahtthurAkXD+Y1a0dD3CPApJTN2CrM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gwfcMAguh5gKk/n/nnH2DthvmJ0jgqOPKcRYt0W4zlCDiOOi83qeGbXViPSmHPUt/
	 mbSm80mCKhW2ZTJqrHXRsiFz+jyZeuEsDpNe9Qxcv7y5JUweAzXZkBM2squhqgHdar
	 PVjLShHuZfxpEqRAyw49xiXBEqBukoF/RUgSmdDs=
Date: Fri, 13 Feb 2026 11:32:13 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-dualshock4-random-inputs/3fb5ad-902d82@github.com>
Subject: [bluez/bluez] 902d82: input: Improve documentation for continuation
 fram...
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

  Branch: refs/heads/copilot/fix-dualshock4-random-inputs
  Home:   https://github.com/bluez/bluez
  Commit: 902d825f6b13444cae60e8950d351cd78a6ae6ef
      https://github.com/bluez/bluez/commit/902d825f6b13444cae60e8950d351cd78a6ae6ef
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Improve documentation for continuation frame handling

- Add inline comment documenting intr_datc_count field purpose
- Clarify comment explaining DATA vs DATC frame handling
- Move explanatory comment to precede DATC handling logic
- Makes the code intent clearer for future maintainers

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
