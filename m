Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0941C84DD
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375700; cv=none; b=n3lzQAmsIRAayjs6BpeRFQUw2tud617eSck9X0CwI2KjdbhhoDMtaTR4maNuwe2L9Tj6GK/Y03ShyXmngSwsDPugjUdX+6jZAt4hV72K8nGUb4LsFrUaeYj8e426RL0bIYaLJLVvdqADiB0ajvz0SrXOoaIGpihfgJ+//K2aehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375700; c=relaxed/simple;
	bh=NL7dkOXY0s+f1vNhhOVh2Ke4bp0qp+quQTUT1L5pQOU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rvs5JdmbgfMGcQyTyY6FDg2YHZUqUM5Dt+pPTJ2f0KZUg9uVqufTy7iZuwoRxWrhE6B+mhflcghA0hbskpulrl6tkFJzfwu/tV4DT9CkCzZvGPJzEEUvGRfrFnnK6W2c2KsbRd337s6AYp9pF0fjApAs4pLSUZJZA12gu7R0c4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UW2nq5uY; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UW2nq5uY"
Received: from github.com (hubbernetes-node-63787f9.va3-iad.github.net [10.48.132.31])
	by smtp.github.com (Postfix) with ESMTPA id 3AF588C0271
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746375698;
	bh=gHTE73DkTMCudHXWJ8KDixiRPblnyo4xp5Yjkor6Kjw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UW2nq5uYrZirXkoZ9mJlNMSO2zIROOLSCmSUbmz+bedSMDh7AghnVi/ojqpc8cPvL
	 5LohMtPJziRRy2WGtQtxRiaQBMb2VtyFArA1uY8FwLKPSjt4IHC/8/M6B42/65ZHZ6
	 Gj4hoY6koGyMUzoKHDQ9yonzv/w4L1455kZ04DIE=
Date: Sun, 04 May 2025 09:21:38 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959451/000000-370c42@github.com>
Subject: [bluez/bluez] 370c42: org.bluez.MediaEndpoint: removing BAP streams
 with...
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

  Branch: refs/heads/959451
  Home:   https://github.com/bluez/bluez
  Commit: 370c428bdbb36072de14931571045ddcbd90fc3d
      https://github.com/bluez/bluez/commit/370c428bdbb36072de14931571045ddcbd90fc3d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
