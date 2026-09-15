Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C33AFAE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509547; cv=none; b=lthX9Mzz5rCVtT+boGuWaIvi8E3hHWC5OsYOdCtPkartOVItTBF5nGI2A0Of4dQgwXPPrDZ9h+2cy6KBGylZM9HTtHE2ygLgr8hpV/wMeY2er+BYp6rPOXNohzbPQhhqNvcUoqSeGj7BCTOx3FtvYk2dWmOq2hmbLoH9nAgVU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509547; c=relaxed/simple;
	bh=NPMe5hF74vK4AosGX8hIXFo640UOGBsd4omqINxuBfE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c/357P4r1T+OkOf80eou3oTLmVtlEFTjgyryt1b21vNA27nQn4to5rSC/mrE5H7ZgkS9SDLSkJNX/Diu5FPNEGnCyFaRtOne3OEMg6HeYMJfMCII9eLgCA6iM/xZlvHqeN6RgWg1itSfIqmpB8jq/qXBYjKxbE3Z7YyAWP2NIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lc+gqeLB; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lc+gqeLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789509545;
	bh=a21YhSw3N7i2tU2e5OlXX8+dm13Ufzz+0VoN/rBGHN4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lc+gqeLBoMr7JsD2BBcHjpsVy+Bo2F9ru/70QoO9ZTINi+iUS84UVv/KNiRWtaSe6
	 RzslVZHinnDu2MvEZiBIA0At5sQT1x7KpYtv5NEiFzRGYBG1z12cN/pTRD4ru7MVnC
	 hVNY1sxhaH+SNaltGznwRQhJj1hlmpObFzTJK2VM=
Received: from github.com (hubbernetes-node-4b04ac8.ash1-iad.github.net [10.56.170.10])
	by smtp.github.com (Postfix) with ESMTPA id 6E7828403A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:59:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:59:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165941/000000-ccee9e@github.com>
Subject: [bluez/bluez] ccee9e: doc/test-functional: Document PCIe controller
 pass...
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

  Branch: refs/heads/1165941
  Home:   https://github.com/bluez/bluez
  Commit: ccee9e2e0c9684f2c8699a3d875cd16ca236558f
      https://github.com/bluez/bluez/commit/ccee9e2e0c9684f2c8699a3d875cd16ca236558f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/test-functional.rst

  Log Message:
  -----------
  doc/test-functional: Document PCIe controller passthrough

The tests needing a real controller can now use a PCIe one with --pcie
and --force-pcie, in the same way --usb and --force-usb use an USB one.

Unlike an USB controller, which only needs its device node to be
readable, a PCIe controller is bound to vfio-pci while a VM host uses
it, so the tests have to be run as root and the controller has to be
alone in its IOMMU group.

The model wrote the option handling in pytest-bluezenv and this section;
it was reviewed and tested by the author.

Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
