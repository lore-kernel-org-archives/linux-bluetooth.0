Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CB349AE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119365; cv=none; b=uxqytgcVk6U6XjA8fW9NyF5uNQibZJI+uikjoPDkdzOgOplIk46cMFoNY+/TuoeYQGqR4ZeTpLPIWXsQxb9DHC7yR9h8bmzlp+or9wBZYQvT2UuRiqIic0upG9tcHCuHYkaDx0UWVLWynghJ2OqDBTfUKmngH2Ml0pvbAVMO0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119365; c=relaxed/simple;
	bh=ZI+n3ZoNrZ28x56DVFMYtNLM8yKEAsD1RfJViKMakcw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YqYGtXmKZubp7fXo9bO7WHfTMwxcTQs0UjPUrmPRKdPOrrgwYk9/wRuxAHOCBc5wzrdU9u7tF0X1QMkO8DD+sV9gBltiiiSwP9C5hdrPOH+aSjlgZ71Al6E2bZsTja1n/wSkvoiQXjpGSt6EMM4Y/e+xcKALRZeXdYnqFF+QZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FzdBZJKD; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FzdBZJKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119363;
	bh=0tJJ/ODPqW5nB9m2hyJR0Zf2rQAu6sspd48wptUAwaE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FzdBZJKD9J6wJgRE1bSWc9S+n27y7cl1tnR7rrAM+RFEZ2kS0dXgmuyznxfOPV5Ij
	 EXHC2lI2lGcuyOW7i6yBmsdnnTAxujzEqdO0nwRy9uazxHOrjSAdMO5+uFzQ+je6ul
	 hKProeYHl/blelWtIo4VDomM6mLhZtq/xNuClj5o=
Received: from github.com (hubbernetes-node-3878174.ac4-iad.github.net [10.52.145.26])
	by smtp.github.com (Postfix) with ESMTPA id 6E72F780B68
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:43 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108826/95d160-000000@github.com>
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

  Branch: refs/heads/1108826
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
