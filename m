Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29B2989BC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270460; cv=none; b=UowzvvLRquC/T4/7NJaeQYIHqz4+Tw5S6VKa7NUPR3HDRaWsXVqwdwtTIXz2mqUlawrojkTOHPP0iV3r8y9XHs3Wq6dfjPRfbHogsAgqe7YEmq1QXZn3UYCsIh6dHMN76XXMXXGAh83E1ms7ocXB6nzcJKx9kn2fXs+us7oW5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270460; c=relaxed/simple;
	bh=oOXVTTDhuBrCKh89esnlx1IE4KhAU+BAX0OP6YmkHpE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WubdFLG3UX/1/7Qkl/0pbxn8DZG1ustCTcE4mkCXLIrUAf3H2z0N+pRYo+2isP+eBs5OHggiVQXoFixQ0FEYdXQwzcTO5obYvtUhH3vRS8cifEy9JNcn25oQP9F8HHiT3M9IVLlX6MXdcg+9g8+M86lmB+kq2xDM9mSbQ7JZ4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eniK8ow6; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eniK8ow6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778270458;
	bh=gZfVagq4ep/ivLKNBqwO8Fyhv5a0JPCFIaIxqwz/lME=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eniK8ow6cUWO948kOX0YRp7h9e3BmsH0cR88cwQPLxheHNLXdTShm9DOSvi09lsUv
	 J47himdxp/ppXj4+MjoZCFJLI2Iw8QHHmo3vEMhuloniV+zUb5AdKUp7JBZCeBrgPO
	 HYWZcneNMYIHbJNJAlV/Zgm+nGoeIBqpb2khAaXc=
Received: from github.com (hubbernetes-node-bb64c0a.va3-iad.github.net [10.48.221.84])
	by smtp.github.com (Postfix) with ESMTPA id 5A0742811F8
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 13:00:58 -0700 (PDT)
Date: Fri, 08 May 2026 13:00:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091417/b1528e-000000@github.com>
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

  Branch: refs/heads/1091417
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
