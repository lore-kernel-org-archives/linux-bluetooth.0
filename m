Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73355D86D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092015; cv=none; b=u0dwkgUhx+xToFkdT9t86Y3cYyjQsIFhlHm4tMyUsaki3bR1InFjJZV+3TJEsY/TZWJPubQbNbkycOSAN5UzzIIXdlh9XZ8Kr2xfPstRhxqbWTkaUR+ouZEx+hnw3iYn4/wf9BsdROGbWMo92FCb14CZsjQo6xqmfWk5IKWswVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092015; c=relaxed/simple;
	bh=aHHwk8lHkXDxJhDzF1z/Oyz8AiMBSwTw1UHiA5esI80=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gG31chr9MBs4yna4GuTJGhsGqgqv+CE6FOk32xE+fTcQdS9KDsFpvy2eG4kukpEsVOF3ZC1ghc24S15vvl5MV5QbRsVWjDetHG/su113rpK6cf8gE5SFPy5+mPcsbZGRFSROEJmqQVC8ANrDLVEt+fA6v3PX6FGFfsiIOVCTK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kR0VKzI7; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kR0VKzI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790092006;
	bh=DHnuNirNughaKWTc+KciZ1CaNflgO9anYStgExIByrc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kR0VKzI70D67jeqqRmmafdM12vnuG2rFhFUxWiXvtz1BzohnXm8fOmcbmn6r0Mqzb
	 xSuF9ULdIPnHbh/yiCfacm5ycs6vXgvS+g7xumuzD4P7+OAKYSuE6datB6MoDJ3ffu
	 sWT2W2SbS1MfiVJrgr50z6c7hYZiVapsp901r5QQ=
Received: from github.com (hubbernetes-node-282776d.ac4-iad.github.net [10.52.202.62])
	by smtp.github.com (Postfix) with ESMTPA id 9CE0F9411EA
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 08:46:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:46:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1170934/70bdf4-000000@github.com>
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

  Branch: refs/heads/1170934
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
