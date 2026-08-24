Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCD36194F
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584984; cv=none; b=dAl7tHna8+yJQbhnc+DWvOuFp8wlXiq8GXtEe+NTgap2clmw9ql7JFHR1R0UcI+Oa+fy2lQfP/VZgIkzNkeRCBEUuXM2nacjFwReuZdHgBINGbM3vdDH85OejJkyMRjeBPJ/iLR7oqBBrWfoy0I1q10RGCP60d732Dhp3Ia5juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584984; c=relaxed/simple;
	bh=H5k/mYpK1v718rEju0k1SA413qhOZFHqmRFT7eMh/pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QITLlfZihB7mkvKENJtNhqmglUXen52Pu4x0k5FV9093xoo+vGBq0TmTqP5P4D6D7Y1jNY0w+95YGkU7aSJDMxprC5vFZBpQOqiNf89prkxkZDByGZLrrn00n6nk6dx1ZfNUDTkBKl7Yogchv3/l+b4hKJ3gUcVfKOL8ueoOgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bZV/x4w7; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bZV/x4w7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787584982;
	bh=t+x2aojuS89O9zzHX2ynD/tpfPnp5wbdZKGOTHvfnLE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bZV/x4w7GChWazkWkJmeDAZaspvgYHz6sPZ0CZctpNnMXo663BVZkF1ePlyQiQ649
	 HMDO0opOQOpUug7dvmlmBhl6G6QptIy7iEb2TGkb60cszVhqu89fIXyb5cssUvKM3f
	 zVNR6ywA6SpFhXfbKjBGQTD79OQtNVG7H//Pbti8=
Received: from github.com (hubbernetes-node-238b0f9.ash1-iad.github.net [10.56.224.63])
	by smtp.github.com (Postfix) with ESMTPA id AC422601217
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:23:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:23:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149265/4ae582-000000@github.com>
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

  Branch: refs/heads/1149265
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
