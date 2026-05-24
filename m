Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6F2D131D
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779646346; cv=none; b=EIQiSCi/6TLRahklgoCBZ6Tnb8j3uCDAxcjbCEE0MtptXiO85mDtkOD6yDlqjKLhB0G8cMgqAofjltOI8H1D7YSR1KHtgjGdwihTsh+5dNZ07D2yUOzB+Ji9RBMJloxZclW7nc0376PS0e2hov0vhUyORj8MofZr6pjSPsaa8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779646346; c=relaxed/simple;
	bh=YKVTOKijjf2bKHTXB+8ls87TJNXSchZZZorl74j4iCo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LGaoJgAMla2492FRQoZaa7FOxd47h1B+5v/xUhMBcrIC61i/WSXGSHAa4XScksYYpbkkBnwZb5UYgbjpu06rNhkVFUwHK9utO0Wx4adP2B4tijkqf2jRerilr4v8kjZpMru7GeeGf/CWdEyK7QkSKYlyeJO7WqCfFiBOzthV7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kuZxVJ0x; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kuZxVJ0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779646345;
	bh=aE1pWaHPkwByq0pEywjNhBjgDGrVF6P7yAyNPRygYZc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kuZxVJ0xR1/S74kJbGmqCHgDmNvX67d/Wc+mURRugxuwO3G7ttNdkMUTsTFWQE7lt
	 w4JV8eaLsfjHPLwJBZ22+lVKEwZ5laHgQJ52OU15IPpQ/cnn8YzXHixumlVQzMn5OX
	 CfUW9yHzNLsQAqTgJpQRKMGDWvW0aj+ZDKZ8bcns=
Received: from github.com (hubbernetes-node-2c0cc02.ash1-iad.github.net [10.56.81.36])
	by smtp.github.com (Postfix) with ESMTPA id 212629203C2
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 11:12:25 -0700 (PDT)
Date: Sun, 24 May 2026 11:12:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085307/1ed377-000000@github.com>
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

  Branch: refs/heads/1085307
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
