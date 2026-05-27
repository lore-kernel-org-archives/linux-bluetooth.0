Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C43644DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908989; cv=none; b=Mc4JpVMl9t7uH0NVtiuKPOJJislDJkSVYtEEOsyIMdJO7z+Oq7WTtAW2dA6ZWZpD6LPvH8JaazHD6+Yq1gbJnOYJrloUu36tHe4fTn2IJ3UdC3iq995CQ68Vxau99rEXvRhnA/TwkoytzyyN4LWCjx4LMF2lRzhBkWPhXuV/Pys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908989; c=relaxed/simple;
	bh=D0UYgaYLXKBSWy3bwtAv3EJV1+EbFVolTQrZhAW/EJ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hqi+R1A27xoKs680sPRHRInlr4OUqD/quD5fiQ2r1AzpGGutE/E8XtBSAsxmQo2m/7YPWU9PnjNhP4Lp1n3jHvr3Rd155cWdEUQkIh7tdYeBZoM8wRlqInM5aUszorCiyXCLOlBkDvGOUqD0TZAGgFj0bRzIGZ9ct8u6ujBU948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fnhRhCC5; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fnhRhCC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779908987;
	bh=v9Nv3VbAMYg7oeQV0ijvgfjHEI8zhaS+Ko2X9W87RDs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fnhRhCC5KeNwmkYTkvRIDldHQwTzVD5OjQ9Ntl/tQEe+UsYgaxptRTAgb0v2Lhnri
	 y6bT4u8QWdKT9fTsAtGKHkb3kY0DGpzgdGNqJaZjAKcmxEucF02YfCg2O2nDVQM7Hi
	 XwtwyqaIX0nj65Wc3ChUSf9OFZtq+bHgmpqYC3So=
Received: from github.com (hubbernetes-node-22de21c.ac4-iad.github.net [10.52.148.20])
	by smtp.github.com (Postfix) with ESMTPA id 4A0C29408DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 12:09:47 -0700 (PDT)
Date: Wed, 27 May 2026 12:09:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086284/318956-000000@github.com>
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

  Branch: refs/heads/1086284
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
