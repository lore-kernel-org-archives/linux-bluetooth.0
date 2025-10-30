Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5232E136
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854334; cv=none; b=Zbq2ii+qCoOKbcsqrx/Ym9J8YK/R8+stNDgfO8IDZ6LWwQcPErv0aQMjWefCWtUfwcMqXYISAbqBEyHAsO0b7Gin2sMC6+B+KSEj/O0MrFRmgjcpAIsovBq7A1ShySXQBPezIlUSHeDCq5dteVrKc0ia+etJhcwgWOZ3bbIk+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854334; c=relaxed/simple;
	bh=4U/z2cJjJM1aQNzdevscnl9ikJxNckJA68pOI4rryLo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s6SkE+STyxnfrObpLBme0ksGzeiUCpVn+uHPgtr6PAVdHMBxlu/TpTlAhqXBt16rUwO0DNBQ0DH5uPe03/kW5LRm+I3INYvfuS31lyEcWkWpg6V4M5VGXw+3s9VSRBodrezU73aHqTT+wCh4GB8TKpF09tyti3aC+bSBEupc7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZIxjqhKS; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZIxjqhKS"
Received: from github.com (hubbernetes-node-40033b1.ac4-iad.github.net [10.52.14.35])
	by smtp.github.com (Postfix) with ESMTPA id B430D640A6F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761854331;
	bh=0yEbGGMLpRxxZ8+1TZdCMXHnf0H3pzhtvcMTwvvdovY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZIxjqhKS8V58PYgwTlpvz+LI8wr90GZeH/eVr88AWfjYtHNtG4LdIUlEV+nf2nQuj
	 Iv4Gv4KfjXUDYabxh3jHmqvYKH8aWpBeoP1hVHWpu7e81H96rpLSIE2qOBuGTgwL/n
	 7Rm9/YP347I7Dn6kmDoQ/gBd2Ll3I38WY7/oTIsE=
Date: Thu, 30 Oct 2025 12:58:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017831/31dd96-000000@github.com>
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

  Branch: refs/heads/1017831
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
