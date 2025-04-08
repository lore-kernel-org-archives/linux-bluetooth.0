Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282622A7E0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125386; cv=none; b=K1WCxSe/ISwRP5LZAJhkLIOHnDxaxY6ndG1fKTpXv8xPjLmL0irBPfzsM9kREmnICtf0T7PokbeLBIkmeV/ZEQtsRJqmw2Sp5Kra/6VGqN3yl2pPBsaePQsc/xVcZmcZ4qkPZguRLp7d4lOa2Zo2CXziTB6xktTkO4Pqc1UEf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125386; c=relaxed/simple;
	bh=hMRgFN3cYHdfBkmt/AnTxxXQaB7X0iNytSIXVU9JZ+s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eIGsSh9Zh50Wn36d6A5RfN4trMwfAqHNlQYzU8R8yXi6fR7xao+CtwOYYjTQmAwG1Mli1IktYHQSeIwzBws2w0H3gYczkDpAzuUU+I4+YZNJHsiHTXGYPWxXGcLWfLJ6j70F2i84CS0SSOus2G7O2ddczUw2VhpR4uHPqOO1oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J4cEZSC7; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J4cEZSC7"
Received: from github.com (hubbernetes-node-eb3946a.va3-iad.github.net [10.48.135.45])
	by smtp.github.com (Postfix) with ESMTPA id 2D932E13AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744125384;
	bh=jMgxLCfMvaeUtUao6PAUeJpaFy3wClFi0P8htEpj4ws=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J4cEZSC7+7Z8YMT6XdXL+ezG1yeoynkDnP2QilC6irAYLL77oFnmn/g5Ssu/F6J4n
	 L0IQZnHl/mGshn5SbWvBXh+dYmcE05LFBORHUIZdnsPno064l7385wVksU58utG6AV
	 Xv+ozmsZo6TcCxhtmKmaoQgd5o0gMfhAbMyx8U10=
Date: Tue, 08 Apr 2025 08:16:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e36724-956b27@github.com>
Subject: [bluez/bluez] 956b27: test-bap: Fix test names
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
  Commit: 956b277f8da6803efeb6ba52b4edfa8839faea7f
      https://github.com/bluez/bluez/commit/956b277f8da6803efeb6ba52b4edfa8839faea7f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-08 (Tue, 08 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Fix test names

This fixes the test names so the are accourding to the testing
specification.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
