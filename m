Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469223B8D6D
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Dec 2025 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765717684; cv=none; b=uHT2JU8ObnSo1pfjvcdSiur+s+Y1Voiv6+9N/vW1JVNTksHxfGc7xKBbbxEVNRsgqhsiW86sSFSvidAev/aC4ggAJ6s0JmSNN/RlSrBScIsYSa9jMLZ4Dhs6PHXfJEz6+TPvC22xtI8X7PWw9vBuHuivJG4tiflVHJIM/tH7Z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765717684; c=relaxed/simple;
	bh=1cSjmibLMzipa1MNESDnfUdute3ZfEgGiENGSRwykWQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g9Y9UtXTE9WROCnq9+ey0Sq0HXsNsqQMavj001dzKYWrd6Tlinl8nNKgddTJjN7wyaUTv9XLKM1qKzvm4I/l5S4zuXPjND+pFan/jtEWS4CHOhLJE1TVgw50SCO9ev7eRyVO13x/1x8TyqdSX1QEdY+UG6EfrcS9xhMVTNkddx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CgReMDRa; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CgReMDRa"
Received: from github.com (hubbernetes-node-b6d634c.ac4-iad.github.net [10.52.147.33])
	by smtp.github.com (Postfix) with ESMTPA id 44183401063
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Dec 2025 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765717681;
	bh=gctp3gKLQk7mIaZktWjj2/jWJZoqEMpGI5SjMtpA5BE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CgReMDRaCuUxKoYSsSFnndKO2PJXo3l8QlKEzwNCYgm3pkwazwAw65e7rck1211Mk
	 S/vfLHYQ1GBhzhm8wmU+v/34qT5u91wqh6HlpAHyyXI9nkuKcjkwKHDkK5eIuj7W3I
	 kZZFSSVFgGRjqoMt9PhyjcJGm55Efj4to9Q1NY5M=
Date: Sun, 14 Dec 2025 05:08:01 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023520/32be33-000000@github.com>
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

  Branch: refs/heads/1023520
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
