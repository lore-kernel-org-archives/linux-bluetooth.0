Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F425616CD
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999237; cv=none; b=oxLP/yrccXSDOitXjBvx5LdSd6dhFIy1PF0+I5WlwQIR07GrzjcO/juIbuh7e7zkrWPCCo/zcADkuCvU+WdJvsEbw00t0S3StM7/HZDxqxlKNhSl4Hk+nLkWNjXxAJylvBFQF3jILE9R2O1XbokCe3B3K7Dg7Pkr9X48CXcoPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999237; c=relaxed/simple;
	bh=3gWmM/tiST/qVixai3Uq2POkr4H+KEIii8vItU+J8hY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bDv9bGQIRa1ubljDc/7bNjKw2nlY+4ytoOaOHPTl9L8bOyBPKG96x3qPD2woqIlBC+l33DcxtPp7DfVZcjTzZMUsNCe+ndlQtI2rjk/7b0xdkf2G55s+F9ryOweNQzxqOyqMq8wvIWmo5OBJqwL8ssR4RRmTmrPxMkF/Wx2BiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ZZl5ijir; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ZZl5ijir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791999232;
	bh=VmhNQTgGJOGeznpIS42+S/2Tbsv+BtoNNTuYiC9TwXQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZZl5ijiryyATcJuQBOTZY4nKQj9KOB08vKcIDOSrXa3uhCYWO746jP4lOmS+qIraM
	 3JY9LCDaudf0W3am4r6PpB5On/FJM06vu4hRCb4uYRG3OWnWzyras0ZM74TgqMVpS7
	 OrHn6MfGo9ve57vc9xHzuOq09kM97zISAqP5VtjjmhGU3pCaKqglBBlxCXNIh78KS/
	 WJ+OuEN/vSBp4TBnnYmveL87QEn7FNqw3HkJaUBVmi5sixAG3vNTnt5iV3sFIh0OQW
	 xLDV9yBw0IBOh7f95TQoe8LkGfOO+1KJEiJOvCJSmVnzcEWM/SlhvnNSU0840Iyjmc
	 QBwpwMBvHLqoA==
Received: from github.com (hubbernetes-node-e26c9e1.va3-iad.github.net [10.48.162.15])
	by smtp.github.com (Postfix) with ESMTPA id B1D27801441
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 10:33:52 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:33:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184798/9db197-000000@github.com>
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

  Branch: refs/heads/1184798
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
