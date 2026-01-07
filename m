Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C8143C61
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755320; cv=none; b=XNIMRl77dRSb/b3X8ZpjBYGvjv17z//IASUW9nWnUgNH769SlOwRr+uKGcjkowVaXyjd30rUy7fvtoDDQwteXaWFeDe4mlhnECP3Gs2SiQTCaeXhfQzRIho1BybyMPxx52norqV9oReBHJa06Sdu+7tNB+2R+4afpI8Gx1bXz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755320; c=relaxed/simple;
	bh=bk7vS8CCZNGq67lbBP8ECEuAy1WDXyK7LNe2VaQJqiw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tRfpOYPMDYjQ5hQMX7CDUbWu/kvG8SC1/hEy8lv1Gxy1ys+rkRnSCVQ61WEFNzRkJHt/E7QdZVmcyY3/K6CLfcQKIxp40TCS1NEP36yhUSoi30tmtRrLmDnOt0aWkUn4ZzsMXXCDHfk55OXXLUsPvcQuUnEtbN8MAE6a6DdOj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J4uPV0TU; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J4uPV0TU"
Received: from github.com (hubbernetes-node-0b16e11.ac4-iad.github.net [10.52.13.21])
	by smtp.github.com (Postfix) with ESMTPA id 1A36F401089
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767755318;
	bh=54R2wxPdrdfmUJUT2ao3YcI2S3r+xIKmiwsk4UJVx0c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J4uPV0TUFBJgLL18f3wVu1reaKpJVZjIadpHUcP50dyPSVFBe8YJa6SDNDIsLopsg
	 aZJPKC4kkqBXmIVxTWd0oKxFAelln4gJ4LyZbxPCYfRK1Vqso8+HH9A0KRy5U0sP2E
	 BbVnKQHSPW0kkxOumKJ+QmqMoV1hXp3MfOuY8vPY=
Date: Tue, 06 Jan 2026 19:08:38 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031211/273e58-000000@github.com>
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

  Branch: refs/heads/1031211
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
