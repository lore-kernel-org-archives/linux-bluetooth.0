Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9B35C188
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527411; cv=none; b=l7hAYq+Em3vtYKZZW+8c+3DiTyo55wC5YQygFUw/C84pu42AZfHmG+ize00lbJFKwpXMmXT027iiGoL3J2XkxdZI0DgQtEPnF073KDTp+FzMMW1EGrsNvVTFmR3OI8/mfgnbLm07FIFzgLBBkqQ1Q3lSnUbm/o7tQLHJMkq3nIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527411; c=relaxed/simple;
	bh=6p1CGNSU+0qgY8s4ibdT8fsDjwlxT2VV70rPm1n3PeY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IiImCrXZIUGdE5WQRh5iVRIQ7+EnZNT0fVnkKVJVJ98HESV4u7aQfiHmHs229kr3SQxoS3b0k7oFYL2ECfqM5NON8XysieF2GQBJE1wHekWXoXnnNLEEjtHKldXlrF7mhsmQ9xCM78aQALH+5pAWsdV2PBceCib9HzriDoC1sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dr0rbACU; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dr0rbACU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783527409;
	bh=+6PTjbc0/1BYjjPyeASCylla1/RhQUXkFlRYE3CPrYM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dr0rbACUCbiJbjijSMOAHO9qRAd1O8NtHvZ+WZmpvz8Ot4LoHfo+Qk+eCwvirf9PD
	 SIANsTLkCGMjSMY2pkjNcZgMbMATj60AzUyjxmEAP5sF4f8M/qXPPPS12CC0c1diHb
	 XoEO75fz5P00cUo0DDrTaK9qVnxdYHGPgZNR8lF8=
Received: from github.com (hubbernetes-node-f38b9f1.ac4-iad.github.net [10.52.81.33])
	by smtp.github.com (Postfix) with ESMTPA id 40114A094D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 09:16:49 -0700 (PDT)
Date: Wed, 08 Jul 2026 09:16:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107894/19245b-000000@github.com>
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

  Branch: refs/heads/1107894
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
