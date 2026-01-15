Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9B396B60
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479929; cv=none; b=iO2CC3tSdDww7ZGSoBhjKvl8ri1puxllAXPz0bLuRfThxNzjei8evg3h8HcYPaqEnpUp8PSCTth9QPZrKCgclkmI+nb4lwb/mbuglybc0OLf/IKuLT67z+7csf95c+c3G1niXLcRLVrE1RKGFWkju488CJV2k0axqpPEhuxPAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479929; c=relaxed/simple;
	bh=yH7rvwjN0JGNQHvPsZ6El2B/uFF0F1d71rsyWpFokrI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DMGjwO/7ry//zXV2wNzFPl0IVxLAEUHfTP5BMm+/Kh+9K7m5NX2F9VzRZ7ETuhUNULCmu8djvJr7puO4VDUUBhLSFwhXh1cm4uPYrRa1Fbkg4EXZzCdTUegBDjIJIhw8vLTZ4xcDYCkUglHfnndSYt4m6d9eZK1SznP7ckXHZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a/j/DDbS; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a/j/DDbS"
Received: from github.com (hubbernetes-node-9a4082d.va3-iad.github.net [10.48.170.51])
	by smtp.github.com (Postfix) with ESMTPA id 1EE05E0B6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768479927;
	bh=X5FY3jK7mXgARnHqhvYYcRX0+4gOW0TI+nxPJrl9GuY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a/j/DDbS/ZSF+kOOv3Yj+8/Kx8zGdVgVqe4Foik7WbSetnbn8vXULv1u2JioHT057
	 kHLFyq2ZBM4mWBZkRlOAo/zdHEmvO1VHiJ7OnUzDLYv0ph9QJPvDA/m/gLJYw+vu+q
	 Up3h0rFeZknJ7PIWIkNkylsFL/FunA9R9qC0oOcs=
Date: Thu, 15 Jan 2026 04:25:27 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033733/b6db9c-000000@github.com>
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

  Branch: refs/heads/1033733
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
