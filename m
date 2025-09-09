Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02D31D360
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451050; cv=none; b=jgp5BVmEFjak7vQOeBbo4XnWXTSG9R+QupeXWIHi/RGHqEkWoxVJ1sofDHXoS66gqMpFrIg5FILCmK+bj0zay6Ws3dQ0UOiz6DYMT9OsrXjinDe4BfFzyHYjoQlFnpqR5SsnVi4Om7wxmmPCYSMUtm4upy6mQEIygkBlNAX7pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451050; c=relaxed/simple;
	bh=hNXOZr2+T23gYMLKMFMbuyMp6cIjKjT0OZuIdrxvWxI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QvywzLqgaI3KVgxNaoXbaqrTpJY/XaXRC3hZyLQPkRk9QjE36FvjpYaju5uMvLN0wWsuAj9PZCGhsaXGcdB0CwR+uux3n4pDY5zS9aSdaxie8dNTD7hTmGvT1OEJCxXAvHZKmw3zCXm8N6nUFj8qrr9q6MO/bbg6vUN4evxUbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IVBnmqYm; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IVBnmqYm"
Received: from github.com (hubbernetes-node-629eb93.ac4-iad.github.net [10.52.162.23])
	by smtp.github.com (Postfix) with ESMTPA id A84C864135E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757451048;
	bh=N6DUW0SK5wp6J6LGE3lPHffh6oIlAeSMv1fM6XZs0/Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IVBnmqYm/ftKNN0buUNfea9AdHWw4woa6Nc/d1tOo5Zmu8F/LfuVQq8Ne3eXM1Ual
	 gKRUk/D/C00ncbYU1rgWLPSsL+QnzjUXF7EsicbB2q7dHp443DJSsD631EB+HAvtyE
	 PHe3MA4p/HQqjkcVQaNYtCDwFQknX/7m3VlKHwtA=
Date: Tue, 09 Sep 2025 13:50:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/999363/3b8e21-000000@github.com>
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

  Branch: refs/heads/999363
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
