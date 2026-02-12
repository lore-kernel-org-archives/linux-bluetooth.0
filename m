Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAB330D24
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932402; cv=none; b=j2ikCuIdQdOZ5s+51AIZKfY/qvhPZcxdZwwb8PiQIHLz5+zzCqa6wo+H1spapUiSrVOF5TMYpFST8sYfpm9ZC8zTntR4vyx/R8sbkhUE3vQluGdPUT8VTbSevRV4FycXsC64U68/G0nlThUcinGIwXh7fMoreyi746kMU75k3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932402; c=relaxed/simple;
	bh=7egdWPASm1TqZk0oh0j/FyjYN50W98l99PRDDXY2lEM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eV2Cwk5T73V+vrfuz7DChMkVHONaWkPWvoxe2HXyudWojgAL+0UCuRzKKvbXCsIAvDUIwccswUK+C8W/AbNxlnr5SWxdPm6br9EVO3t1JmEXDByq5Nj5JY2U97bFGcnxwaF2wW+W0PSIQh4W07qFq9YUTcp19gZmdFyVLLI3eqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=inenxgG6; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="inenxgG6"
Received: from github.com (hubbernetes-node-3f2340e.ac4-iad.github.net [10.52.125.43])
	by smtp.github.com (Postfix) with ESMTPA id DC0F06403C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770932400;
	bh=RgJR8kenwps2BJEQ6dWsFgcB8mFTGj1bSZLd7MvE+xI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=inenxgG6W3euIh2iDDU2oVVQYWFZh3aRFvOXQuiQkfFdW1D0BWrSUsjq7soA9sYJl
	 fWcVlTslYBQR8vE6Eadiae0yzaUv0Nr2BfjP6om83qVSB1cDeBdhuCbnssrhNLlFA2
	 aOpQvGA4A7CAfEfW29+6WDONyCpXp4qvp3inSWn4=
Date: Thu, 12 Feb 2026 13:40:00 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053686/000000-95e693@github.com>
Subject: [bluez/bluez] 95e693: doc/btmon: Add reading output section
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

  Branch: refs/heads/1053686
  Home:   https://github.com/bluez/bluez
  Commit: 95e693c7afb11fd5944d020ddc21b1c4a1269e9a
      https://github.com/bluez/bluez/commit/95e693c7afb11fd5944d020ddc21b1c4a1269e9a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-12 (Thu, 12 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add reading output section

This adds a section explaining how to read the output of btmon.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
