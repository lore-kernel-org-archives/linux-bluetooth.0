Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728B26CE17
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661109; cv=none; b=NYFJCg7TPvybuOZXBzr4pO+Lx6XRcpuSWEZngIHUM6rNJlcsp2whvZThy2sEVczcewUhQskj7BJ92S6yZpNLgkg4OL03nUD7EaKcxCvqR9jiHfZqSzDAlxUgG6GJq+5RNEIzOg2KZv/88kN6egEB+d1VcnVCI889rlj79QBqamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661109; c=relaxed/simple;
	bh=6/kdO3w1Uph1DDxOyqBZhWKf6R+DCRo4KQ/dy2LpVZ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iP8gtw507AjTTbfQqzKiphPCQ+dJ3TCB3TnzK8tFxiOHDQkTKrqOZENmA4e1VRPNesHXhxBpGpHNHzd/M37kxdS0CbQIwJFp6FvVyJ/6cxjYKRSMIbnQDSNRnwy4Om5uTtiZ1Kl53uMIyY5kvN5tApBQLIOidpWVjgDyqdmtmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q9Xp7UXI; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q9Xp7UXI"
Received: from github.com (hubbernetes-node-f9bcf7e.va3-iad.github.net [10.48.166.15])
	by smtp.github.com (Postfix) with ESMTPA id B97534E0873
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758661107;
	bh=D4G7rCDrdr595mVeb7lrXrMrzbMlOOWxtI8dHO6wWL0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q9Xp7UXI0o+/e98QJ8/cgg6iUluZdEVQQIGxR3lB5bA4Daviq/Qc4MJLLJN7pO8ve
	 M8Gu0MQLTvVKJfyUKP5UgWwJ9LPP75Av05gAHPrzMhEYck/AMqtgtzKyP8H2F/po37
	 EA14enotthPRw9q13gMkzNXPx8gUGhtNjF/3cVT0=
Date: Tue, 23 Sep 2025 13:58:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994977/fd21dd-000000@github.com>
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

  Branch: refs/heads/994977
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
