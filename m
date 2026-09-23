Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8D41F5D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140404; cv=none; b=Blcol7XhyeLOyYMOEOO5NZ7o6+62sbhKahSMAJESkXySYBC1nWWPZERufpR2mFJDZiPAX07Z+VrLt51lss2mZveppPy57r0EbgZD1JEGF/TyOcvYqzLT/XwraZ7qrH+RZem7r3jrG4ZmPDCC3gEc1Zu3Q++e7Bcz8lXy/CVZZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140404; c=relaxed/simple;
	bh=nS0+HxF8QJv+0P5uOHVy+Wcc683+fDVFi5o+6euYcA0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PeJgAh1cHccw2mAt/A9yQYXeOqzVcFT9qxu071DicF1Yqsy4GkxFVxDQOWBvd8D6duZdGtGcP62oZEIIaCnEY8j0kPFHU5UfRfYljsC02aIKq2PFaNdB3Vj45Qa2WKUejK6VGdBD/ChHeUYx0CpFPKCNuOkh2Kf8ZikJr6KpKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l1PpDyre; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l1PpDyre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790140400;
	bh=2aVEODEfk+JoGb5/Jjso4YkxZWx1NEy8b5L+PaWwLmk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l1PpDyrePr4P2FGIqGOYOkp8vi3SykbrEZ0qc+2wgjt2HTn+W3ma0BPZmEg/gBgMS
	 /FIVT5cCoBe68vao5+3bUUY7t6QHzExYJSWhE9GSY5Cavmegd9F2/EAvKbfQGluAcR
	 QhCSf/8Y/CeOJtjjVOK+bM4PlMERaWw1+2WWKEg0=
Received: from github.com (hubbernetes-node-e97c30f.ac4-iad.github.net [10.52.162.21])
	by smtp.github.com (Postfix) with ESMTPA id D3EEE7810D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 22:13:20 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:13:20 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1171825/000000-3dc313@github.com>
Subject: [bluez/bluez] 3dc313: obexd/pbap: Fix u128_to_string skipping data[4]
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

  Branch: refs/heads/1171825
  Home:   https://github.com/bluez/bluez
  Commit: 3dc313067796aaaa397a5cf1dd9e594ae6be671c
      https://github.com/bluez/bluez/commit/3dc313067796aaaa397a5cf1dd9e594ae6be671c
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  obexd/pbap: Fix u128_to_string skipping data[4]

u128_to_string uses data[3] twice causing data[4] to be skipped and
DatabaseIdentifier, PrimaryCounter and SecondaryCounter properties to
be printed with wrong values.

Fixes: 5ee26d43c65c ("obexd/client: Add DatabaseIdentifier property")
Assisted-by: opencode:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
