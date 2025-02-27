Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C519DF52
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688691; cv=none; b=pKNLocqwwqAAaoh9mVtPRKUnvjlIFr6jlVkiNtatdFClZwUIbGvL+bRh6W4eugAS2NSv8ryaseiOGnWrAG4S0QB7l0M9weLHIgMrhqqEE8DTAQXYx91/F9aiDGjDwA6Kc69+E8gMb3fk7nhIY/xXvFIUHYXkJWYNZsb+HpeJzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688691; c=relaxed/simple;
	bh=gVAnMYM//qakCLJIAXmKrIX67LRB02ePdYe3MvjVmg0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TA3WIFNnaRVH7SHjkNGmA0PYCeyarb2/QVTSwyn9itsUet9Wikm4VnVcOwfNBb+E6WPn2kFyE+az6UKv6TivRyjPSB3ocBX4g8NisuFxg8e5A0Lt85hBKJMMiNFoLF08eHXpqZJrZ32X9Qp7sV5tOMNqtuVNkDZB2hJa6CHjLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LOUmGnSx; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LOUmGnSx"
Received: from github.com (hubbernetes-node-f6f17ed.va3-iad.github.net [10.48.158.12])
	by smtp.github.com (Postfix) with ESMTPA id 453574E0AAC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740688689;
	bh=PIz+YKZvMvAU02jvHjs1656FZyhkjrplT3rYs3Uu8Fk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LOUmGnSxzKyJaBoSGJpMH0DCWzQZVbu/YZFq8Tes/Mncmn8zYahj9DNkuuQlu3M6p
	 znLEzFSunjc/OsTQA4hzt9uDqt6fgtrrKd2Ko1rOkUjOkUW/Apk6/Z3Rm1KlMnzawu
	 DCdzDe/XqkCS0g3o6c4NLSCFw2G0skJMDnR3GWyU=
Date: Thu, 27 Feb 2025 12:38:09 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d68dc1-5f901b@github.com>
Subject: [bluez/bluez] 5f901b: org.bluez.Adapter: Fix DuplicateData default
 value
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5f901b5377165fb1d9a9fa57cbea74a76931bfce
      https://github.com/bluez/bluez/commit/5f901b5377165fb1d9a9fa57cbea74a76931bfce
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-27 (Thu, 27 Feb 2025)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  org.bluez.Adapter: Fix DuplicateData default value

The default is false not true.

Fixes: https://github.com/bluez/bluez/issues/1113



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
