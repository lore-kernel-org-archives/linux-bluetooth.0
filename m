Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8D3195FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963171; cv=none; b=THI42Bg68qipAfITzc3AubwPNJ9qBC17MH43Av2tbeOmoDwExJGkbI6LgdtK/xsfGFM6sp7RkNAqtnKfqRI+dB7NLMzFZ/HeOb9fhBhqCJ3eSFcaCKVTbLlRpv5w0T3qKPSc720oX+tWGQ0oVxUbv0XHzHZsSvqKHLjaYzU8QV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963171; c=relaxed/simple;
	bh=/GTJiOoYZwO/l0Rwb/xBRQOvnVT9bM1V+nTtB2UZGb8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=my1s6uZ4CcIialTaiyGtS7g2DjL28X3ZD3mQlaxIWWbgN0unkJFNXk3lin/be9z9PD2kG9hQyR04mjKZih4j4RzO01eqAo+RFvHt8vSGIijS2BLQ5EQDrnkPRZcW+s4N1QLykRXlmueqnpOQKUJfaTXGbeca0uiREadaLhXcNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ah1uEVrV; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ah1uEVrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776963169;
	bh=X4QkHzVabXpNJfQxU0I4pnJtxWOb3s+KKxsaGLb6N18=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ah1uEVrVrgoJbRGY/L1q0JaYs784e+RX8vEi4MMTjX3p6QfGQa53iA/0+SKydE0SQ
	 51otWWulf3qpwd8K9IZP/NpbNHNFsartaAnGZ5XCBWM8Bt5/AdjamsKMyW7pD5oVPy
	 fceEeHDRJf1QTDXakBogxwsfTYpI759ILNGSjFbg=
Received: from github.com (hubbernetes-node-b6da109.ash1-iad.github.net [10.56.202.69])
	by smtp.github.com (Postfix) with ESMTPA id 141E660112B
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:52:49 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:52:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083806/5cb819-000000@github.com>
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

  Branch: refs/heads/1083806
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
