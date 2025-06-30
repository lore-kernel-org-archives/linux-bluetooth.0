Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEB28B7E7
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293028; cv=none; b=MDd0fp+yPzBlOZG4DTFMiRAL8HEuGSPFUUj3WqWTzPomPfrl+5IzI2AaUZJ722X6tSlcpCbkMBqUqRFGCTsX89Qzv60csFXBNg+ne85RV+z17r1VYWb0IVudH+amCM0Pgv9WHgmwC2ITeJGPATF+O79ibKf1N525Tq+WogArg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293028; c=relaxed/simple;
	bh=jojV3ngjQRZpHN1y5K7YPgvurGdtNbv6fdliioW/nW8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qz3R7FLCEfwxkLKSby791YgkaXtA833mDeuEunGDcYYFM3RsbVCDa7+15WGXAJMk54FhGyGuxEmwsDn7HCGQs2GWWW3vNp7IYVQd3YO3Pn8Qg+xLR2BTIYcWb3WYWKcT7mMlzFApFyMAEW1Im50QJaSqkncJIq/1z5pAu+7fpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aWSygJdV; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aWSygJdV"
Received: from github.com (hubbernetes-node-482c20b.va3-iad.github.net [10.48.183.53])
	by smtp.github.com (Postfix) with ESMTPA id A119DE086B
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751293025;
	bh=ttE6r2GZ3MYo7o2C6f3KfotTS7h/dnemxb+9wdn87CA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aWSygJdVDCdLBcjyyZ7UcBvVuc+/pcfy0WdQa7PYMdTuVtHxBwhPn5OohnkqfOKkA
	 tqO6aM8B68E2XSm1dOkVhavwyJFH4SMbc74iSYl+QZ+mGV+sV+pPTpGqO1Gh/qMT1E
	 beNxeTc8hyNi42WgmqhcOOI84gC8BYvfFVjrcbwA=
Date: Mon, 30 Jun 2025 07:17:05 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977338/000000-6f312d@github.com>
Subject: [bluez/bluez] 6f312d: obexd: reject to accept file when replying any
 err...
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

  Branch: refs/heads/977338
  Home:   https://github.com/bluez/bluez
  Commit: 6f312d2fc453ae841188d7eaa444b9104fbc4d15
      https://github.com/bluez/bluez/commit/6f312d2fc453ae841188d7eaa444b9104fbc4d15
  Author: Chengyi Zhao <zhaochengyi@uniontech.com>
  Date:   2025-06-30 (Mon, 30 Jun 2025)

  Changed paths:
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: reject to accept file when replying any error message

For security reasons, it will reject the file when the obex
agent replies with any error message, and accept the file
when the obex agent replies with the new file name.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
