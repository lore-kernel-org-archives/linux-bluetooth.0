Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9813AA51
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264729; cv=none; b=cQj+/bU4WLR8saJVG28jBM+NVnI2pQ/92tI+hQOVrV73vt+cnajedSTczjxs4jIiK9gZwY80l/HqJc6OeQJTjnipthhC+2sKBBA/Ezj9Jde6OS1+deK/LVDO+DiFaJf1OpEiB/OvOl9jLOxo0F4Ee6fXE4OX1ZpXnXnIIPryA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264729; c=relaxed/simple;
	bh=K55H8kXxHqwL1ZhLeldVSpYiq5E9gVzMxZVDBzaayNc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cv2HsJBB+pHXbB2VifR8HefaKIT206t7ZUHWfoSvVF49CRllVyJh9fPZEQ/iypSgzJCaC21Q6hRb6JmsxP+WLhGF4t6B/qhXbwWRlyoyD9pBPcWZosPxpw+enj/Q8dgmbZ9XNW7F6dGVbRRI2iRDQQsGmutzmFsGXpWtfb8i5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Egkq5AWK; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Egkq5AWK"
Received: from github.com (hubbernetes-node-41977df.va3-iad.github.net [10.48.125.47])
	by smtp.github.com (Postfix) with ESMTPA id BA8C5E08D3
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712264726;
	bh=lkxydglOM1LxtVlUPUP3rVMi2Gd3E2SE4aLQ57ozPN4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Egkq5AWKp0uXVkBYFWboAB6gx3Aply0ihK9MIS419K0l/mxeZugkAXkjZKBPLUJY4
	 6SUy/BqbD7l/d4g0tcGL6P0bcO0brZsqV0se3PNkQaBmmCDto0qf+Y+JVoGz/db3hq
	 0V9AFqP+MoLCVBUJk+juyXVeZRFr1Sf85WzKXtBc=
Date: Thu, 04 Apr 2024 14:05:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5069c5-031174@github.com>
Subject: [bluez/bluez] 031174: device: Fix attemting to set WakeAllowed
 without i...
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
  Commit: 0311740498a2306a6143651a1195e2865c421c60
      https://github.com/bluez/bluez/commit/0311740498a2306a6143651a1195e2865c421c60
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix attemting to set WakeAllowed without it being supported

WakeAllowed shall only be set if WakeSupport is enabled.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
