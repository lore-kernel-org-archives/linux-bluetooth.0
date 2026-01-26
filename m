Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFB34A790
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450137; cv=none; b=fWx/W/YXhdL6/YoFzmDq72dsu6ZEPhxsTljz4cUIHSFcceaXCOwbsuspiTofm6Z5So37InCPOTWeNkGSELhcDhgwjUWKhJJ6Ab729Wv2RplfCkgs6tvSMT0wM8oLXkci0wy4p802+oVhKsfn4xbFNtWtjJXmvVfs4aNwarObqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450137; c=relaxed/simple;
	bh=0+vXhFz2I5SCZ4QeYp5yS7ChGZMzhaASNTIJCvSs0HQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QojQbxeE4sN9XF81PQL2j7gu4qfQfuel5AKaESC3bqo6ZfHebOCQ7M2ANOCWoJopMEvfVnwp4An7QXB6PQGiG4+/QbQYvHPApNqWSEyVbV/KcOk9lkYwMfBhW88iuCfc7FvOtgk040sYgDLt+7Lwh8xhlPvwvk6XH/MfSi0Vjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DcRcopgH; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DcRcopgH"
Received: from github.com (hubbernetes-node-915d32c.ac4-iad.github.net [10.52.184.41])
	by smtp.github.com (Postfix) with ESMTPA id 76C1E400AAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769450134;
	bh=XKs1JRwuJVT62pbftp1XLZ4bHBS0x8zl9AC0Lc6+mjk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DcRcopgHjpjLM0WXZzQshuWAjsTCjBf5zBiwTggmcDtay+Lk69QGK0n950Y8423Gn
	 Bp1TV5pnAGCCAm8vbx+sDpOBVeZRZMRvXW6nHLchtPrzQ27ySKRFNcXwFh9IvKCUrU
	 0yQLSyElo/yGH1YtmfbVO+L7lXfM0DPsi33nWW+w=
Date: Mon, 26 Jan 2026 09:55:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047149/618fd0-000000@github.com>
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

  Branch: refs/heads/1047149
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
