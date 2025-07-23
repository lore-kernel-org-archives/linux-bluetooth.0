Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A02A937
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281865; cv=none; b=mTO/hkhNNNXzdABqX9JIygaoa4IPBGH7HNz1SNXrhNVcgzJoV5+YYMN1pKWyWrzed/8b0TuLuLJczwn8DUbKWYNuwipZ6/kcUSh/ajCIph6WFU0sypcqoecVE6v4K2JKQ+7FjUY9QHBZCsBRuore2GtVcUCKJabJuP7XdNwve/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281865; c=relaxed/simple;
	bh=HtSV9bcVt2qcOQ3Pip2OdCynTUUaQu7Bv6tBI9Gi9jI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HHMpmDlrxiQy7WH223xrA5WR2lng+1r+MH9i3IBY8G6uLklyTuJKHChNxOW4PtuzQ7CgL3MXvDzSbZF4sif7JsqSpHdJ9D9JSf0rjhiRQMz6CVuOC05VkkETKWJIU/99am38EdWxeAUkKhMrYtssKQp2Fv0MeTUMkhOmCCKkclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RjcXNdc+; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RjcXNdc+"
Received: from github.com (hubbernetes-node-c199cc0.va3-iad.github.net [10.48.135.34])
	by smtp.github.com (Postfix) with ESMTPA id A805F4E129D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753281863;
	bh=E9G0ThG8KtZ6E/RXato3bCZY/dz2bgUSE+dSgcNYrH8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RjcXNdc+QT+07mtdgsVXBaxRhzQ3g2eoi8zz10+lc/bdsMEeHRGLubB49iK1PxJU3
	 IQplbNMHdNLxPNhPPM7QRlxCt3mQRlTgYtTPKd2lX74ZevQRfanXvjL8cPJl6V47ze
	 ByV97gZmx3sV1RlnwV1viHTArHg7pNDBKQBRGC98=
Date: Wed, 23 Jul 2025 07:44:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984872/90ab18-000000@github.com>
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

  Branch: refs/heads/984872
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
