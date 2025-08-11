Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C85FEE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945248; cv=none; b=aCb7HW80SqGkoB88OdjyNXUdihmHlS8jL1FQo8i74nhvr1fg2/NenZf6IA4f0MQzVgEqHU6wSbpX1bjvfQauNdQqqSuTmCp44DsoBrR7a0mMRDqmBNQwGLWHRP93O/4dPV8v49LIqz5QUErpkShriZ97R6wIdFyg7aOQb67VT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945248; c=relaxed/simple;
	bh=LVhJGfiw+2H72g0AECyE9LJLQL9BF22kCjKoroRcWKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iiF1wLQ/8R35eApR2wTKHYFXeZzGVUQnxxe6hPhR2O7jtrwOBU4fB7HHBjl5Hv4k0jTrPzr7/1aiTlEK9nDa7pwKa8+/NbFCNGWjuqFoCjjiGRQsgoBiDiGRoYwzJl30mD+pLfsNnDWqiGOF3+dPnxRDhb9PF8TLOMsCBJwTahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Famnww3o; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Famnww3o"
Received: from github.com (hubbernetes-node-95c5780.va3-iad.github.net [10.48.168.39])
	by smtp.github.com (Postfix) with ESMTPA id 553684E06E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754945246;
	bh=EYAxRrC4V4NfXI7iRycKdLFpJR3prFgqSq5JVj+E2+Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Famnww3o5YC315KZt0UY8QPoEcuffiE8UWr2iu6fa/0MVHj0kvrHmSuy/vuMXc55J
	 W5YBNZrsLSD5IpF9bQB4bRWT8/SzmTYEQC1ntxm6XiFKjsYlINQr7U617mJyx+A3gJ
	 tjMHSU253SQpgtk0OlgLluge+ufsOxV8MgTf5khQ=
Date: Mon, 11 Aug 2025 13:47:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989695/5c523c-000000@github.com>
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

  Branch: refs/heads/989695
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
