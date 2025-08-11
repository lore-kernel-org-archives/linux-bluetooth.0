Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6527602D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923532; cv=none; b=ulZPm+vOzOv5+druMlvktqmgu1kniF9HHpJSXAvEWs9v6l4g4/CRKngS80s4/2rX9+oUUbW09OCrcts4BT0ODHCk4hyvnPgF4TiLEU9+gFn97Z9JUxuRgcNYWKXWm9cjbpO/jmOxz//fwWNEe8N57HymmFjhDC32Vs/ayozEnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923532; c=relaxed/simple;
	bh=VuT39EAlMReOJooFctZmZmgdL/x7zzwsx18I1pjXj0k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N21Iqzt1zXn2oZfhJNBmUvqQ/+//H1lq9qDI4GzztZGKcYTOX6+NRpyx1TKbF28d4U/NGIymFF9glGOgDbIUPq2+E1yCWjjtEYxR9whWTRNJ3T8DsRzbxE5Cg8lhtMGkVQjVDon/RS5M2AAQhFktCqfDln2iUucDYoXO0BkBCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CTzc9Iua; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CTzc9Iua"
Received: from github.com (hubbernetes-node-e3925a6.va3-iad.github.net [10.48.161.42])
	by smtp.github.com (Postfix) with ESMTPA id 640678C1018
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754923530;
	bh=GQuBp4J1NUT2k9Yp1rjQO+e4Cbrq1f8g6JhPXvByyf0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CTzc9Iua6OgNwZUwu1sGjrSZDcEPu8jn2RbA87wgrsanr8eG+ySra21diEaq1j0+X
	 JM2Ar60v3eNWhTSji54yuC0LlLyG7rwPNj3cKhPioZRItNG1yTD1h/KXYvnMBoSIKV
	 z+PB0YNUTbwDkeCb3sKnRQDPqo+V+s6GZcc1m4bc=
Date: Mon, 11 Aug 2025 07:45:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989501/289167-000000@github.com>
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

  Branch: refs/heads/989501
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
