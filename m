Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218AE474274
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509568; cv=none; b=QsNNYytw9pBJAM0V6bKHMpA6rnxA8eiFiUk1jPVPHOQzcY3T0hkbRIh+id7h0MXedcio9+nEO+CEEzHMxFm7KHjjQBi7ZlEVOMBPKSM95QW9xRb/yjHSimI8Mh4WGamxgfOor0zGc8Gcy9BRdTw7hEMNiOT1hYBq3/JE51DrDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509568; c=relaxed/simple;
	bh=FhRiYrizkbQI2H0m4KrDg3kbyhXYdyB6qhg14MIvVWM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=liIOrzFdhaqYUFQ9HFl/GDmIQg8UBOtjfkeH1aTbVv3yQ7TSXylGTLpk5yki3xcdOMcpjr7zLqsek/pBqt9r8fnNGUoTr3jd9lDX7yNeGDk6vFdk9ecb1QLBGIaMVhMiAYdEdr+YioIZHdvBXnVznS90qOTUDOpdOkBlE2y46p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dt2ciGeK; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dt2ciGeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789509566;
	bh=X1NocGBV0hSMD0wK7YPRxpNXXc4Oa9DQGSWJU+E9gX8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dt2ciGeKOwvHX/TXJ3fjfaG5BGfqLfnEOGIrhsbNMjNs7YuhC1RdX4eMjICZORiCZ
	 74D/dNLW71ODPdQWHVq9wFcflDsoqlIQxa30m/uehbYWm3L8b20XoULNd0zY6r7YME
	 1svFaEstsYJZjgN6jQRPMcYnAKXTHGtjmEiD1uW4=
Received: from github.com (hubbernetes-node-edac5fe.va3-iad.github.net [10.48.178.48])
	by smtp.github.com (Postfix) with ESMTPA id 42FB27800EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:59:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:59:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164934/9183ed-000000@github.com>
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
Message-ID: <20260915215926.D2-qNrpU8mbWI8ns2J0WoDLMFKWx72FghRx2hVxcWZU@z>

  Branch: refs/heads/1164934
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
