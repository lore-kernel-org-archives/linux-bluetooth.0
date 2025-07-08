Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDB2E540C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997165; cv=none; b=AfQZZtuKFgjLusc7XcABIKrmQ20xAtoI5DI99fNwQLI1gvAP1eryOaDC3unFy+7S35Lw0oZfc/zE09aKtbJVGbI9lLdhHc+K5FQmsA+yGnR26FxJz19gM2LjC6Nsff3YJorNFf9AchSvIbWJyryCR7rvwPh1XNz7mthgJQcHs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997165; c=relaxed/simple;
	bh=lqpd0wJaExniuPvvN7e9Y7WzhsHPC+vYKxyw3SaXrzg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b4gRLNOyME51u/tDyLNbuax74iys7Nb1iYx694iYZGw0mKYCv0ollL8eWFXvnjAGUtZ9/mNbMsxLtTlEa35W3bznLJi99MTjr7EctUlB/hrxOB7SER78s/pMb4hGTNmFSA6g9piFzCRmAbeDiv1jo6FpKG0ishBR4QZQKZdP/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V8uAaWq1; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V8uAaWq1"
Received: from github.com (hubbernetes-node-1bd8f97.va3-iad.github.net [10.48.12.29])
	by smtp.github.com (Postfix) with ESMTPA id 7A7AF4E079F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751997163;
	bh=n+k35pgR8YSrbBrfxqADKDwv1eoZHVxTxyUUwESj+Co=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V8uAaWq1V8Aw46vnooH3jciwbm+fRvH/JYZkrCToI8JlK6ZPTd+9sXoeJjkv08fhS
	 Vigg/JFsoBqhTEqXPpi/kSHhXXIkUJueES6UleGwHvtteiv7/y8c2PnRhyeYhcjYXT
	 SzFnpEBDseiGLBorWPnTc1gLGcp1Tsvfhrhiws84=
Date: Tue, 08 Jul 2025 10:52:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980144/000000-378b5a@github.com>
Subject: [bluez/bluez] 378b5a: shared/util: Introduce strnlenutf8
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

  Branch: refs/heads/980144
  Home:   https://github.com/bluez/bluez
  Commit: 378b5a1cc74db971d1b0d608b24c255e0e6f9f1d
      https://github.com/bluez/bluez/commit/378b5a1cc74db971d1b0d608b24c255e0e6f9f1d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Introduce strnlenutf8

This introduces strnlenutf8 which works similarly to strnlen but return
only the number of valid bytes of UTF-8 encoded string then replace the
other copies of similar code.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
