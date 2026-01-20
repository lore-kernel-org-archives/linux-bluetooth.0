Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BE44CAE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932082; cv=none; b=TAadXhScunawrviF1WUwtMfAuoBzF6eaaEZ3Ae8rr1XS7MvSqW6w5L1SMb+/hdKLP7r8w+g/X3l1/6F8hTKgRvIsz2Nm4paU4t9lG44oPNUKLWiyRI8zVH4Ql7O1IGuoDYRoeCr1NbyUrdnYsgPDQ5Hb36wFURHjQUzc8nQod3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932082; c=relaxed/simple;
	bh=c0RBbrBU26bB89Lh9CYMGKGE1+2qoQqQXjbtG9L8ROs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qqkc7t5Ob//pSEfTz99RW+GJ5ylOx/gBQMrEQB3Uq0pbwFM5XCl5u6AkNnkCNvXeoBhdlBIRZ6tRrAXnds1oaGVSQIBGXoAueR/VpEVmj7JRGzpxLIo3WHpQ+S6SJDKJTBLAyTwtRqzc4RLJfX/YvhqDQ3VtRhEuFgsJ8RjQXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R3FO5cbq; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R3FO5cbq"
Received: from github.com (hubbernetes-node-31b3d7a.va3-iad.github.net [10.48.178.39])
	by smtp.github.com (Postfix) with ESMTPA id 5FFA4E031D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768932080;
	bh=aFtSitaw4OH8IPWhldTZJ0UHN4wDR+Smy1DkyHgYgwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R3FO5cbqpw+HDmLkcYob+nndav7UQaskBhCSFOgKpkMM+IN0eJuXPUAdMsK87toPK
	 jP3j+d66ZfeWJPkJLpZkDBz9pc7hx/vDk5/FhLwn6g2cd/zDLL/IjryJwSkjs9dOzS
	 A0uv8nwVKS4WibCaoJoGR8Wh/HHEvgs5JZB5SEwQ=
Date: Tue, 20 Jan 2026 10:01:20 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044766/f2670a-000000@github.com>
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

  Branch: refs/heads/1044766
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
