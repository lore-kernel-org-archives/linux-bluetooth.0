Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA35328632
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539267; cv=none; b=JSmS4+/E4/1IBUh8+GnuBAM7acefSo/w2LQZnFIjn2Y7Ly8WwV7byG6Q6AKzxkWg6nzNhJlTAaxZZ2ZpQ1/Y8oSkfJCCYA3hVXtSaagfQEEeqYM0hBoK5IfA/IlL7PzrL8JoUDBKgu1rJUqhF2yZ9XPwgCW0cSry48cs5Sltpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539267; c=relaxed/simple;
	bh=TkgnodTG5TBWRoG4OaqAORnZdIkeL6OsHCcsu/Mi9L8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=euGebMUUgKP0qu86lYezyO2LJPWLYk+GmH+W3ejgCsk18Fk0cin5gz/X903c6sRIgCEZTYwsk4xmIl5eyFvoUhYBgozvKajFAWUBcWbdqdLW1RzDTfzonSIgKi2A1wwJnS6OdnBoWIwGUcQ958gBa4ak4SJZqAzHH0gwPZ/CE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AUx9L2NP; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AUx9L2NP"
Received: from github.com (hubbernetes-node-d1e60ba.va3-iad.github.net [10.48.205.93])
	by smtp.github.com (Postfix) with ESMTPA id 98692E072A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539264;
	bh=egB63yD1JELDR8vSkry8FbhMlbyE29SsOn8/0TOll4M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AUx9L2NPDGqJ7Yiv4wFAMFMV1YRzw6ZQL0JQ+Ts3bKVucbb0DXTZC82b/jlY2/8b8
	 RgsSMn82T2rH4aEZypAFExRtotsb0u/AOIzuCyCcYa8s5G73v3xy2xUz/e8Z+EfuTF
	 OWAx9cawq6eUYHBWXTln3GP/5YFBEakb7HZ7n+DQ=
Date: Tue, 27 Jan 2026 10:41:04 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047694/b609db-000000@github.com>
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

  Branch: refs/heads/1047694
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
