Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A932AADB
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475644; cv=none; b=R7DV+NgjuMRovN1fGiRFrSQnT479myV1drfF3zzGBMY702Y4N9Qp1olTgszLgfsWSY7JaMMOcaOoVKoXeu7wtJrutWuWFHcd3a9DndLFd8sU/PB9iBpg2F1fzezOEpulSnLqUGnRGhZKKOczybGaaRBp/pNuZw+vtT2I2APOv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475644; c=relaxed/simple;
	bh=5YOQH1xVvxQwPYvcDsdDinFuF7FQnbiKCM+ctFoUI5w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bkMLkXpk9aqf9zbdvBsTJw2zQzGMjXfeS+c+CZl3UMLykgdtL/y3j0X3uWnlC2B0nyVu7kVOqLbwLBhQkhFMqcAZFHOKpzTTR1gGLl4Z2BeFbrcLDIqfUdXRnBQybjrAXEVZBUacXojz16x+WKD4K9mx7Be7NuejkS61FdHu9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SxmN4965; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SxmN4965"
Received: from github.com (hubbernetes-node-1928ccd.ac4-iad.github.net [10.52.208.74])
	by smtp.github.com (Postfix) with ESMTPA id 1990B211F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768475642;
	bh=Tsy/WQgkZSlDZ1ZsL9O0lDz+lpXKUbOB0YM3U6kuzng=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SxmN49659ZycjULM2khmJUAigizW1sdfdUJdM6w9EXBGF7qMNqd41TuBshOu7wPQG
	 fbyfzUkuuxoG1cGuiyBsZRVVgV8VFo17dHFndbxa48x1b3c1o3QaDnT8Mbo990cl04
	 wAchsWgJ7pjohUuK8xnj3VG0EmBUqZa0p//WUXfY=
Date: Thu, 15 Jan 2026 03:14:02 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033710/c18186-000000@github.com>
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

  Branch: refs/heads/1033710
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
