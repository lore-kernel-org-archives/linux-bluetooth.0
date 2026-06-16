Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A312E1DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612399; cv=none; b=gxdY+LRfxbq7+BPmxlBfB7GGW7M8rdbBJk84yfmRciZz4s8ZJXx8TzmKIJJpKRTsthzf5p3QBOxZsEJZGuNEmsrDCTgDPJXGoEPjlEV3qmQpLFNYC6loQtd7d/v0z9KIygWONGA1LVGx+suKGtLxf5Co5rmQeQOxngfhBMQagwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612399; c=relaxed/simple;
	bh=YcKaXRfqVQStgrQh0dXKnX9pNPhTpO8k76ugnIuqdMo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J4HyABCclmurMKUk4ZdL0k97z2L6uFP3SsvUBL2176rHdV/2mnDjPCawCxln/Iu5DgFsYTwuNzT4SZTuvh7KS2oaB9nMJ71V4LqPh0WmIVzHGtakKiXVbPAsnB7ohU68NxqHlpuQD8IdAkeq5Qgne2qFW4es2GlSphxAFHaKHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MZPC5Fh6; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MZPC5Fh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781612398;
	bh=Zo6yc6aGtbWWs2YMCn+tvqDHkwvfyp+shjzzRLPQyVk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MZPC5Fh6/smJpsi4FTF3yMuYmwWmclWCsVnrBM20QJUZAqGEOK9jKaPnfYppIlBuU
	 eatvvtr+4uYYfsuWCCnPehX/FhnRi3P7OP3PI70O3XWvrb63obMQ6ajd6O/s6Z36Mg
	 7xJaNJ+ZDXvaMt/CwLtXJWX378dbSBlFhhDJPchA=
Received: from github.com (hubbernetes-node-30d569b.ash1-iad.github.net [10.59.97.39])
	by smtp.github.com (Postfix) with ESMTPA id 0D840840255
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 05:19:58 -0700 (PDT)
Date: Tue, 16 Jun 2026 05:19:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1109997/cccd99-000000@github.com>
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

  Branch: refs/heads/1109997
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
