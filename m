Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9C328255
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539271; cv=none; b=ur2xgXuBpY2Gba3sx4xt/3zZssuswIDzGsS9U25mDFTMlaKudz8QMZrwNOEa5CAk3MfjyS0b0j9+IQ3tcrnTEALJSXHJgOj+wVtY0WB+u6wpNN7+dfnyuzksA4GfgkN/VF4iqQ6zL6EcUwO7SKfCmuuYqQIpCqJwzfRmr7QJ1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539271; c=relaxed/simple;
	bh=+dU+QsBEQV9xD305TGhDWTkkW+Kfk1ad71iybzSt5dE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l2rHKFWR6nc/AgGX/uE0TGp8wb8dB9mcH8esdXLU1+D/c+OxLz4424mbSO9dlwVZpEvS+JHve95AuanAkAbPSt1q9n7KYxlgty16RyQpiSzt96X3iKNKpMmVew7EN+cW0DeYttSesugrlwOH017G6NjEVO2mZ0hnXWrizbXNh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hGXg6yhO; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hGXg6yhO"
Received: from github.com (hubbernetes-node-3cf1e0c.ac4-iad.github.net [10.52.202.116])
	by smtp.github.com (Postfix) with ESMTPA id C3DD5210C9
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539266;
	bh=PLXHlhY7dSkCsyQM2LF2VQArgGGJ/TeFHuzQ3JDWoxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hGXg6yhOJJTlwPL3Lhm99Q42sjCstik4kZi4TeuxYQWiZXSFtK28bBXatzQciu1MQ
	 TId+QdC6aF/c0D+CsP482nawLTf99N1nSP2H4vKSDUv+IgQyjIvdRyrHaA9bbLnSMO
	 TZ7QiUYhhFjBzfc7k67losjoRst37SGOccdPciEM=
Date: Tue, 27 Jan 2026 10:41:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047693/26cf2d-000000@github.com>
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

  Branch: refs/heads/1047693
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
