Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FC36CE09
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340807; cv=none; b=CUqvVnmPKDjiOTPQn1AxH7krXrCduT98Z9TT/UL+PxYrLSrY+KWn2BcxvI0Dj/dKGSnLWSzIaHF9riCIeTKgY3456v+lpy/RcqBoCJiXMd8X8Wt8Y0CqBumCV/GxMUVex8FG1UcRpyLZhAdU3RobEWtXrKyjXLpDBN9JrBig6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340807; c=relaxed/simple;
	bh=j8rkUevZsUJZ/kqyc7XhRCrqp2SG91UNMKCrH2rd0RU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DWO7G97EmUNBGF9IQyE+Nk5Vcv1aUjckfcjRb0K+x8m8FrEycQcE19myXKcUngpatp5oWV8buWMbmBvk1H4P5jW4ATyyz+SfY2EU2kUoylKkShGP4CVJ9ndBOta2RmtS8A1KW1k7HhFHbtnhSDppyqlf7mHWMbOofQi7FU9IVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mBwY88iu; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mBwY88iu"
Received: from github.com (hubbernetes-node-7ad441a.ash1-iad.github.net [10.56.212.17])
	by smtp.github.com (Postfix) with ESMTPA id 196BE6004AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771340805;
	bh=4Z0IuRuviFDmF7PxT6Mptqv/VoagFz0ZxDFlW9d4maY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mBwY88iuRP6lzWQanUvWvbmBuRsULP2v9M++VupfzmI7jFjnoMX1SFCRFaGhdFYOK
	 AkukfuCAVGvkrEGN/ThFPD9Gxoh81KEm8uwlNnrQrhXqSbLdSXtO6uWwFmwzlafM+V
	 ZOF3TGi3czjZ6+CYiJcedX5uALmGf2j4xpOHWGKI=
Date: Tue, 17 Feb 2026 07:06:45 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054617/25a493-000000@github.com>
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

  Branch: refs/heads/1054617
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
