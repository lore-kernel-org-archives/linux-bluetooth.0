Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6C318ECD
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818880; cv=none; b=gszKfWNzM49M2y9NbZzWQyw9BJokeHaA5Ggyx+KnWPJC6/ENpCJd3xOaGdAmmkrq2hRDaddxdr3PGLQXMVWkn9rU1jJOu3gX74WWTWxlVA2lk1YZZJFVue8QoynJZIw5B+yUIxNeLJIP4NloYiBvpG5MwIRPQAuFrZGSuPT36Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818880; c=relaxed/simple;
	bh=Pej1DVMR7FlfKmhqEOj4U7WyEnP3MIjDLVbJXgepwso=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O77oWOugQjuJYeXdvIDf50UJqoZPryHCcWEmjN9jEn+YSd1Q/mAEBXJwMzreHHf5QNYcJAXpQVFvLqLGsfci1+DQ0skR9vHDpF+LX5XnRcmugj/xO4x1FIUyI4YzfbBzTzB0u3QPoLDVPwXxQElNFiWcEm/S4Q89IZffFACGRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UZqmSYns; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UZqmSYns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788818878;
	bh=GbIYQOiXJhR0XlRLu0iXxZEzHO70JaP69XkYCAnfAY4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UZqmSYns3nNnnbBtSQwFI3K/9T/i9kCo21+5JkTMuEgPzfcEz1EYZG8pCr60mnTse
	 4uVevvtbeJHDoi2FHvZcV7fL3Wa9+hw5cFl4zFGE5uWjSyqnzatF0txfL+jOlRtJu1
	 HYmg/gpHD6bodfhGhy8N/mG4eZ1kUwbc60Ui+A6A=
Received: from github.com (hubbernetes-node-192a84b.ac4-iad.github.net [10.52.202.13])
	by smtp.github.com (Postfix) with ESMTPA id 559A8320401
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 15:07:58 -0700 (PDT)
Date: Mon, 07 Sep 2026 15:07:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154605/2b1fe5-000000@github.com>
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

  Branch: refs/heads/1154605
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
