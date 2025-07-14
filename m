Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F623643E
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527853; cv=none; b=GIP02BC9Lpbx/l/H/Y9xGQ4fHpwI91wtcix2fjp9Ib01Q/NaAD4E+qFudRRM+IH24swApIzqFJ2Gt/8ywl3cnfrKvKNq6oejKvkNFQy3QSRwJDgKHCuxsW+uSwxteS38e1gxcVF+f0NuvEb4B3qzwZ++J9YTs0NaRf2Nki0JmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527853; c=relaxed/simple;
	bh=BLLPtwD3vXUbZy5OEIV9dEGJj3WyBRc2AP/0PI8KSbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D0PrWee9R9/q4Ie17DrdXhtPmdM4DXdjo/oICyezTQqWNGQCw2xohX34LyV6Py9PZcpipVPyPiyjg39xPZMRvaa8A6wCNvAUL9E98adiTX/tHQ77cG6OL4FKmtMFFAhZcuuOOyOSOs1D7LlViv22H26hcpMswJfjGnxS0BZV2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d8wteRoq; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d8wteRoq"
Received: from github.com (hubbernetes-node-4bf8c1f.va3-iad.github.net [10.48.182.45])
	by smtp.github.com (Postfix) with ESMTPA id 39C82E0CAE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752527851;
	bh=w9rLZfbgNiIYowZ5xxXDnFg75MfL2rV/TibJhsPAGTA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d8wteRoqJVzP/pl6sTVnXvSfbR9MkzL6P+D2CJz4aIoAT0MFPijEQUpoGJWTHooy+
	 OxmDdz19uncwW71i+ATuMybUW2JkTQgR+qWBG8z/Q7d+5Z4mHoLyMlfxYvAwO+SIxw
	 lI8mo8eYUL69adrz8gR1NYA7CpJV4IH8MV9sDLH8=
Date: Mon, 14 Jul 2025 14:17:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982161/f0a742-000000@github.com>
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

  Branch: refs/heads/982161
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
