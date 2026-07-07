Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DD430CFD
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440063; cv=none; b=ZUQe6JzqvE789lzXwKIN75kf2dCaNi1t5iKTRNiiWpMd819Xyw3LSC6j16XKT4WYm/PGdlKZduIOaWb315Ae9VpGdn1tuaGDnAQ5Ly+NTfUJvJ2+Fo6+bd12U4E/JYkWEpPVPkOHHNp4SzCZw0vOd7I7XvikmPYEy7ozNny0RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440063; c=relaxed/simple;
	bh=g/icgqx/lUv0grGC+P4ubOGWgwO/Rd+CjrTmG9TsXyk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qieF6HdI3H3zexqdCVyDTlV22WHFN87AMDl4TF3XuE2lFGLjpQgDVlyCPhSu5PHIN5I8X20L38mw7IZuCTXtiBM1qDwx/9xpkwsCRLwaSJN9M+OxXU/fCIlE7fmLeimtgoTjzlxlBvAx2GuwaqMkqjTSNUhy3ZkF7k7mIbukMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SSREVGaD; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SSREVGaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783440061;
	bh=WJ9J4e0sxDkuwSpBIRW2Zti/Z3sWEAOyRTULM7lEdCw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SSREVGaDjwH31Jo4x3CfzrWlmwbBY4YZfBjE07GW8yeSlVrLfoyC2+jNqFq+7xs50
	 6psYWHEjVdtKMlfdrCxX3N0rBEKecir6xt7HOW3vlJT5KbkJnUvNVNoWj3bBmB3dek
	 3ttHR02V5LHB9af5Z/i8tQInzFQ6JJrlRHVxVCZc=
Received: from github.com (hubbernetes-node-9de8535.va3-iad.github.net [10.48.160.10])
	by smtp.github.com (Postfix) with ESMTPA id 8C86334E8F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 09:01:01 -0700 (PDT)
Date: Tue, 07 Jul 2026 09:01:01 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/65d11e-5bc6aa@github.com>
Subject: [bluez/bluez] 5bc6aa: adapter: Fix crash on dev_disconnected
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
  Commit: 5bc6aa79e53700d56fc1f9f9364573ba4c78da65
      https://github.com/bluez/bluez/commit/5bc6aa79e53700d56fc1f9f9364573ba4c78da65
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix crash on dev_disconnected

Commit 5d836f1c697c ("adapter: Fix failed bonding attempt after LE
link disconnection") introduces a regression since it attempts to
call device_is_connected after adapter_remove_connection which may
free the device causing the following backtrace:

    #0 0x5cd6e384262f in btd_device_bearer_is_connected src/device.c:3754
    #1 0x5cd6e384266f in btd_device_is_connected src/device.c:3745
    #2 0x5cd6e37f8614 in dev_disconnected src/adapter.c:8626

Fixes: https://github.com/bluez/bluez/issues/2221



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
