Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9758396587
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329763; cv=none; b=aKTt7KaVf+dL1smTpsaRK7aY8nJJheqyF9ewRPi+ZLMnd+0dBr/BCPlI3mjIu0Y+59PUGUwMtWmaPFZi7tTRshYRkh7wJENm3t6s9tD2i+nFZTb4QLGdpr/H3SNdXaz9thb5jZI9thhE1BdDkGXSt1tr8IS+vmsZzYUPp3PLG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329763; c=relaxed/simple;
	bh=A4gNGOzrdROWfknNLaifNM3QPEHEUWhMItb6XfzwLkY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TmiYkKR3gh3yRwZN38gcfb5XZjYTbZZWdGtjFdVxA0rbbfEe00T9cAhFKsnEUxwYGx8S+df1JIubxNo8JSgofh6e7xXgGxM/50/rZmfQZV0kEVx4x67rAC9ozMlLRVnjJiL5RnOhcEiTKN/CGQYAzPW/21A3VJyqCW48hMJWns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KOkxvCIC; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KOkxvCIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776329759;
	bh=9Ux22l//cnTIewTRsq8WRezKsOMVfD1xd/k252M7wZU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KOkxvCICc/oRDRSA06+HCokWoEBfA8KqQgDkglhKU/d5bmNyuaA3dEDaj2BM8e396
	 xC5LZDmqfp7QkOjNagmq0Lr9AzYK4plmeMq5+FdGH3WNZPWQM5+5z5RQ8eBM4J9lI9
	 IWpU6IAZcBynFv01MX8obWdsfWIcYSfkgoxu7fmQ=
Received: from github.com (hubbernetes-node-8f8375a.ash1-iad.github.net [10.56.208.60])
	by smtp.github.com (Postfix) with ESMTPA id 9BBDB841112
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 01:55:59 -0700 (PDT)
Date: Thu, 16 Apr 2026 01:55:59 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081931/000000-b409eb@github.com>
Subject: [bluez/bluez] b409eb: doc: Add missing btmon-cs doc to btmon.rst
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

  Branch: refs/heads/1081931
  Home:   https://github.com/bluez/bluez
  Commit: b409ebe29213e7e905fb84dc19a3bcb362b4a3d7
      https://github.com/bluez/bluez/commit/b409ebe29213e7e905fb84dc19a3bcb362b4a3d7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc: Add missing btmon-cs doc to btmon.rst



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
