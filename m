Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001D428461
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516269; cv=none; b=ZAMjVPWGWc2K/K5+MHm1F1I0MEqPrS3tdYrJpyLh0PcYkT5AsWfTX7g8D21I5rln2H4KhP7dmW5qjY85jkAqYmfgjbiz6uDeCKhlU+4FIljJhhgMZSTNC24Uj4+eEenO1nGGNEOmtQfC0RQF1MAjnliwyci9kFCwBWlJ1rwv5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516269; c=relaxed/simple;
	bh=twywRtBJVKyk1BQtMeSbcSy2GjJrq2fKIV+yFY12rNs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d500WrlHsfasajSUCcA5aOEif5pODDgrIMk8jyMUPso0ddRjLn83zII7Qdnf1by/pwq5oWbv4OL/6930ysO9pFpGezY6RKuMB/wwEiQh//7uH7VlB5Jh225mt7gcUwsycB0viwifue8JW16QwStYi7yQQVWXPKXazAONTlQ/8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cn3zAgi9; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cn3zAgi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778516267;
	bh=lcmN7/hSnaYChzxZp4wWi8pWPFaEakHX3QJk/mNHL34=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cn3zAgi924JQWU+4j5CH25ioJq38edIXg6VZUveVcs2nLepuZLMSiuSItqAzqYV5u
	 hgMyHR+ljxzY2arDMHAop7VKBoPtXRWng36yFIoWiEjZcpa4n72dpT2iIr8YCtSgof
	 jEj3lRWJDaMyAtq4RczLcR8AvD0QFghLZMI1lucg=
Received: from github.com (hubbernetes-node-1057fe6.va3-iad.github.net [10.48.13.73])
	by smtp.github.com (Postfix) with ESMTPA id D7AA334101E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 09:17:47 -0700 (PDT)
Date: Mon, 11 May 2026 09:17:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090532/dc4d19-000000@github.com>
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

  Branch: refs/heads/1090532
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
