Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6901A9FB7
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627141; cv=none; b=tjxnFQO9gNPXifTQicLqFvGGRRBjJdPCst2UX0Q0/hM31WfmJ9OfCT0eajScPWBi6G6/g9yaWbY23MtaA6mVthrRu3tC/AdH5c9By8kYywER+U7oNqBun8/0gaQs09S+OkQCumLo4Vm6SFL4FXeftJbFGDY8Lygn7BN4OnGn+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627141; c=relaxed/simple;
	bh=ItF4SDR85Dqu1AOH25Q1J9job2u7hd5ZXmePuhxwxOU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u0kdKNq79xpwHe7Jjq8qqTb+augsaHrXE/AqdoGX4tTTYxAbHjl4ni5B9Dmsrf2kXQLuK+xTeBFCi6rjbhxDCYVMxZQazCVZoO4juStNLvNZJKqZkR7vHoM7zQe70jRp2WA8ze0K3UCqBO0dbg4nfkEzwzi9qCzWZCNwcYi22x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=alXBQmMo; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="alXBQmMo"
Received: from github.com (hubbernetes-node-651fda6.ac4-iad.github.net [10.52.174.52])
	by smtp.github.com (Postfix) with ESMTPA id 29957700279
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756627138;
	bh=kFi75MHPqGWahuKPKaQkGgBEi3GXKEg894WpOt2o4Io=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=alXBQmMoBZ8ZuwfPBCAARqF/b0Eu/HZeTnJ+ifBhDUf7i8xtG0FhrNI/an824F1TO
	 OQm7mN0nRRzjVNzg+6CX7ze//P7ZXii3gw9drIbKgc91cIfRpaGecNqu3ZAf2YjMko
	 90oPSzLFIs46S24SB9DHko5LDdVuZkmbfGbi65KI=
Date: Sun, 31 Aug 2025 00:58:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987581/b54aba-000000@github.com>
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

  Branch: refs/heads/987581
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
