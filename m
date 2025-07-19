Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486DBA36
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752951350; cv=none; b=hiF1UUbKBscyYySRrExXPphaFJChx4BJ9iC4cU+ZIgMqd+CdrWlH8HHyoirxUmkWMfihiR9MD2xb1U6dPJgGk2wd+jX9FdVqTo1R31Nl6kI9tMPdmOG7Lr8ZIWpbDjiwLQx7in6Obbtmu3PC6u+S2RWPiCynsNUEzuLIWNmwTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752951350; c=relaxed/simple;
	bh=qHvKndgqYfSl/cnlw60gNsxCnJdCVwvq9F1oK35jlOA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JCn12vJGkyshExTUl/ktIU05/QpE53ikfCX2Ijl5MK8463hSJJLWZm44s6HSKVWjM1Nwue2AF0itkABoH+KAPI0GJvEqMBtmN6W6/xaPhVTyIK9N8CjF+AMltUxVHDIUzlEGt7quFdShQycSktzGKPnYlOanKUJfDdStaN4/8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EWkKR9vC; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EWkKR9vC"
Received: from github.com (hubbernetes-node-006e911.va3-iad.github.net [10.48.133.43])
	by smtp.github.com (Postfix) with ESMTPA id F0BF34E00A6
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752951348;
	bh=ke9fjdAGKp0F0OXSaWyby45IhW8KtmJU1TFK3Kgz1xM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EWkKR9vC+HSzeq1tp05lz/nZvdIKPU/JpBzl+LItXhDTElMx6kX6Pbk3ZyXW8YzUB
	 yiWx1dBGMJhkWlyNEQnIajYg+aGiDIXxeqeK+VE+mCSNMJv8+mE9+PJ3fMWyAPrtRt
	 b4a8zBT7VHsT4Nwdo+BpHF3JqYNYT1m0yiPOB8MI=
Date: Sat, 19 Jul 2025 11:55:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973966/bdd62c-000000@github.com>
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

  Branch: refs/heads/973966
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
