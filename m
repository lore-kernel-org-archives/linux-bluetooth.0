Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61643FBB41
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861930; cv=none; b=oOeXqIbB2GKKoRZK2OczqVafA2zvL+0FSxy8F1E+bPajAGZLopYXaj2oJyVAPJtHyewiu/LD+UvWwta/W1q0X2E+zhIcv+WNLZs0Sxyo6o5U4iFzAtOCjPCHwZC6g+LCh3xBSmKbNtC1GGs9X48O72ayMvmbYwR9ClUDzKMfGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861930; c=relaxed/simple;
	bh=whgOt9qsrj+DskrHda+P+EGKomfa4btXa2sYNVm/df8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qLV9xAk5/OJBNPJ8N2l5vIbJCCXNAejBC55un2e/VlTZLKmsoo0kD1OflHSxUgDlW5XcKWAkerCliMEU7URPXdJ7WWY7INwtmKukaVfHZkHWbFztnb/vQkrsuIHMT/iLuWi6Wt5CnwZ+WuJ7/Zlx4qcxAQchqlpmGQCpRhctb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jPXuuOfN; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jPXuuOfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778861928;
	bh=nMmKjDUXN2bFoHj4+ZvKpU6VqkbBvIuY4MNRDR+NikE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jPXuuOfNvzytcCug1eQnCBSM08VoLUIaQDCXjeCY6/TZT/5n1xVdrkuS8dGAhbwOV
	 aCOhUPynhuR0xu0TzDZwJnedZm/wM8f8EYHxpA/vQjk7HLOFYItHou/b/JrNLTE2f2
	 wgAF/UM32XflkBkvAKsfehg3XRfKIIskJSTPWdYU=
Received: from github.com (hubbernetes-node-e846ecc.va3-iad.github.net [10.48.131.36])
	by smtp.github.com (Postfix) with ESMTPA id EAAD6280B98
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:18:47 -0700 (PDT)
Date: Fri, 15 May 2026 09:18:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/48cb22-4f4dba@github.com>
Subject: [bluez/bluez] 4f4dba: test-rap: Fix gatt_ccc_read_cb on big-endian
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
  Commit: 4f4dba4a7863d4a4a338dd4c1a36a55de9da96a8
      https://github.com/bluez/bluez/commit/4f4dba4a7863d4a4a338dd4c1a36a55de9da96a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  test-rap: Fix gatt_ccc_read_cb on big-endian

Reading CCC values shall return little-endian 16 bits, not native
format.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
