Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007D384CD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613878; cv=none; b=SF6UcxVFfFZgOuOVbDo4xxkMLOOeVpwWUpVzwFex1Qf8oZQYXJ8j0zJfqIxWc54XEafohpvS+VvLLpP9bqY38igVvPugcf7j53VZbTjHtudDPGszWJzhQoVJgKHPbH0iBQA8NwYwYPGh6pYQTxBm1VVaBuvL+hmTDODylLtdlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613878; c=relaxed/simple;
	bh=gsal/95bzcP1ekxXk/U1gdporCTvDVnqZg3QWgwI5/U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C7U9SiWLlHeMiEuZ5pDom+PYVvBasHdPIiR13uj9LDR9FfmRJJOVBEICcLNCH5cpwtAGXrYuMCoEwWLTYnmTTada0hNaANB9Lai54Ck2SbqOnbFgLqGTBJDPoWcDAgdO6CgVn2uroFBXHB/O5F+B+nSVHrgDA8ogKiTPVVSnlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GaOXo5O9; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GaOXo5O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778613876;
	bh=URGnt+5NmxwJbcHYwJLqNbuVTOVbWdaWBe4/qkGmIzM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GaOXo5O9UDw5tQUh8mdNwxY/dZzEhpOF0ikGLan1fK8tL7/iCiEh9sclZ/JYfFuhd
	 5MP7a6hC6WZcuHq6QU0czqgyeGJInVDFpgMRWpRLwH/zOtRFz/sMGd7CmphUERms6F
	 H5VCRUuLuWvfDtRc3bBh5r0MrnIqYE9+Jpefwcww=
Received: from github.com (hubbernetes-node-3bb540b.va3-iad.github.net [10.48.205.17])
	by smtp.github.com (Postfix) with ESMTPA id AD902341045
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:24:36 -0700 (PDT)
Date: Tue, 12 May 2026 12:24:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093117/2c6d6b-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1093117
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
