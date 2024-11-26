Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB41B87D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655521; cv=none; b=kLkXI/yGXbOpnJncsdrZsZ4FIBZKkoHeGUOGoVc7hpQJne5HZZMxJf3CBsh2I11P7C9nDBwnDiZsFbw3ZN/eF9YDvrIEEqVYcFYLfSkALrEsRqRu3Cbpe2iRFImkyDbilO8KPvHllYyND+EIlZMl9YsamsabNJXVF1nZku2pdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655521; c=relaxed/simple;
	bh=aCJ8LtVCQDFiKbGgktNZmYAX4KiJ5uTuvnSgdOKBic0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ECf1kgQqA+FwYjDULUlShyuvT9RVco+d8knc8UEPBI5IVzUjp1/wLoTpnUpZ7DYVMP/Hm3BVdEqRcldqMh1danqrGfKCHYImTBippl9YvT9oz6zYyDVvW+0lBxm2lBt7tef7YQGXK2AIMEkK8OWPgdypG59TQJhO1e38zOqDREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WyJajMB7; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WyJajMB7"
Received: from github.com (hubbernetes-node-1fb8caa.va3-iad.github.net [10.48.131.36])
	by smtp.github.com (Postfix) with ESMTPA id B4AE2E03E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1732655519;
	bh=ShOX7R5MNJCrJsvXYppSwTciuDGlHkivKhl6K0e56hA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WyJajMB7BRSFRby+pUWqqoIKyA7r5AUNBzDOygCIDomgPumUXu0btJ+C24UVtpTt1
	 UbnaPXYfvPmDx8l4wKm2qIvJayciGAeanreQ2W88iE2aqCzBZYFynHjZyc1Hd2bB5t
	 8/j6l/2loGm1Q9xZZmt5qJ2z9iXMi3qKrzPsW3pY=
Date: Tue, 26 Nov 2024 13:11:59 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/385f0f-501492@github.com>
Subject: [bluez/bluez] 501492: client/admin: Fix copyright notice
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
  Commit: 5014920870d92ac6f616a4eb9ba757bbf538fb22
      https://github.com/bluez/bluez/commit/5014920870d92ac6f616a4eb9ba757bbf538fb22
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-26 (Tue, 26 Nov 2024)

  Changed paths:
    M client/admin.c
    M client/admin.h

  Log Message:
  -----------
  client/admin: Fix copyright notice

Fix copyright notice to use SPDX.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
