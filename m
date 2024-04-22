Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A5219E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812606; cv=none; b=OTvCeoUwgFkMEg6rELbWCnrazeiksN7nmo63Nnk2JYDLQXmSrtg4hRv6Z2R8BcVgpoylDZZVB/ZqIGgmPwXS48gsEA2TK5Bd6Kti1IfcVkk/5Ktp1Vmu7emRPTNTLcDJPXudtrEsdaf9+EPk/kmKPCoMMhdYWmCVUEN/3sRaxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812606; c=relaxed/simple;
	bh=lIkpjArycO9csXz/wtMvD6MoLco0tn7JAzhP5O1r8d0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N8HNONSEO12qDzA74SVCek1tGfZIe/F7TCz6s/zTOcSv16FXUbwsecKqVVo0nxfOF+rPp+nMLKTRPEEN4cIbwph7nZVyZ8lZT3HVIkU5P13qd/Egkp8YbtkdsYVbUfJrTsFWQjZIpJ8zOiKJmXl3gmnX6H8oXit32xDr54BR+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M8J0HZYg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M8J0HZYg"
Received: from github.com (hubbernetes-node-b0c1f8f.va3-iad.github.net [10.48.145.23])
	by smtp.github.com (Postfix) with ESMTPA id 9FF168C07F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713812604;
	bh=1AUMCH2VZVOf8HLyyWwqeDiLetIguZF5XlNz4c9QVbc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M8J0HZYgZePV6a9K3jGQWek1UB+xazw1DiTi6orDvHI2ReYUoSdOOfXh6Zhwlx9DG
	 7+mcPbarWc2in82orftUrId94r2JIa4yEjLhBncL1xAA1OhQ/VgjXrXlDw9FORKIms
	 O3faaHAX3Y67RZADHWBI0V+x0g/NzXDSu2ymVlac=
Date: Mon, 22 Apr 2024 12:03:24 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/041535-8e5f34@github.com>
Subject: [bluez/bluez] 8e5f34: bap: call select_cb on bt_bap_cancel_select()
 to c...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8e5f3433dc5f88164aeba8e077cd125717146e34
      https://github.com/bluez/bluez/commit/8e5f3433dc5f88164aeba8e077cd125717146e34
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-22 (Mon, 22 Apr 2024)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  bap: call select_cb on bt_bap_cancel_select() to clean up

Have bt_bap_cancel_select() to trigger the callback function with error
code, simplifying the cleanup when ep is freed while SelectProperties is
ongoing.

Fixes bap_data->selecting not being decremented when ep setup is
canceled, which results to transports not being created thereafter.

Fixes: 41d6c4e1c92f ("bap: cancel ongoing SelectProperties() before freeing the ep")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
