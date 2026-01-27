Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C09362156
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533214; cv=none; b=bwCBu6ySX5ZZjz304V0bxCDHbJ+6XfVlJXirG0PV1vYTU28dDxib/BBIF2vwXLffqN/R/zMI+hZMrv6X65ocBtT5DvPmLQmOt5bmm16dGitmq1lbwYVGIwRRHyh75YIs2kLZ+1tze9PeNQ0vFXnOfaZWbcepWsgQCoqjVEKUrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533214; c=relaxed/simple;
	bh=zw7ohVLEn4YAMMl21haOm2zgEvcA/eFvU65E1ry0xNg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aFxlSXnG5v7MHE+y2McTHAUBaM17+Jx0tIJEA0ZqCm4KaSeaDXgD+B8YgLdQMkCCg2tB+3r1ldhYQnlNLX+uSnmGY+WJBCXu1Xue0WcR33+IEHnziFQjouHeExc/jnRXnWG4vp4JwZnVThh3CqZ5bN6on+tEZdDQrUCa16RGsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QI8XBmkj; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QI8XBmkj"
Received: from github.com (hubbernetes-node-f8850ee.ash1-iad.github.net [10.56.200.51])
	by smtp.github.com (Postfix) with ESMTPA id A4FC81411B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769533212;
	bh=x2ECBbiAqRjFDftUyj4Wkytz0p4iDxPEdUcfKYKIISg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QI8XBmkj01SgrPg8+eujQ7Ua6LEZFe0IzeQZtHQmDFmBJEnPCwpN8pG7XrrfnQNDf
	 cT3ivrSAuSq1ISwOla7BOOHlsg8LbjaxH/XFQhrezeSfXrAO6l05O3w0tfsY+R6BSg
	 FVTC0OwVzVa2k9PbDiziGq/EuxHO+YGuD5+rkMXA=
Date: Tue, 27 Jan 2026 09:00:12 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047491/9f639c-000000@github.com>
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

  Branch: refs/heads/1047491
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
