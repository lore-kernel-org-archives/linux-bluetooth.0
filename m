Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CC246768
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068210; cv=none; b=h6IFE+1M18G2IJi0EgejWRy4snYE3IqmWJZOtkyph9TmoxQBji1W8CQ8W2HuoM/e60JM7C5Col9IdS7UGilbxw/xD8foCTG2/4jxshtP6n6gUyLScmtOQb8UyH3mguaSdWsJXtB3AJl/EcmAnuCYqQ+Y0E+auX9GVOoyFLI2MjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068210; c=relaxed/simple;
	bh=AJb3P+df2o9I7ZY/JH8zE2KuvVdH6f8v+rSATfqEhHw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IsO8tfGB55X+vWIvyyz4yivCArmbuRFzBIAGCdbqqbLsi4kymRqZLY7XUOIGX6etXMI3GKZnCARExpXH74VoM0/7r+IhdAhSGKe7KyS3pW2UQuqVHF3dOhUMfwHU9896AwuMMraWyFnPTSDSH4czXv8NlTKvHcuekgRuJ+0Toyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B4HNV1b5; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B4HNV1b5"
Received: from github.com (hubbernetes-node-c1fc992.ash1-iad.github.net [10.56.173.14])
	by smtp.github.com (Postfix) with ESMTPA id A81C39211FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747068207;
	bh=PVM7U2BVNPdw7xXCVY7MV7Zr2IeJezf4VZ/rPGZwxtY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B4HNV1b5nCBLHtA5WqMwlXLjMqhjBNao8rVX0P9sgeKmiZYsrinIs6QSuQYMevxGi
	 VeDeytjkkB9ZJXAyAUSJezj8ecnbzyoe8Bhdak966jxLT2TBSPO0FWOMp2MRqPycYe
	 /YWWxdqlJz3InyFRMcblA1tCee6Tnib4pOS615fA=
Date: Mon, 12 May 2025 09:43:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961526/c87831-000000@github.com>
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

  Branch: refs/heads/961526
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
