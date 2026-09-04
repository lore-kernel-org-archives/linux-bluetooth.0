Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B2339872
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557828; cv=none; b=lQECX0fzJtDVBtypILc5YzCOjvu0rTu9796tJso4MVpApwbXD5FZfebG1TyLqw88+G/wFk248DdQ5HU2IANgZHQPmWSwFL3Cs9reubDY6FEf9I73NG/12FLXCa2I5J+ghJ4lybRWkUhd4lxR+YkX8MHv96XjiSVV669nA6PgsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557828; c=relaxed/simple;
	bh=vz3DUOWMQADmVrf8Q5JpeM46wodP5LGkeBq3DCHxcDY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jst4+fEOK4/SAvWgcl7P2anKl9PdoD4a15tkk1XLwo+gSaovTxBFHrunqHjTH+DtN41vhD3FenXnBitI2/PK6FB78aVziry+zwPYNKN6+L6X1JeY0qKQe/38GtIIWS90J1WabJWgM1nXofUrSAPF5CqlWxY8Pzzd7MLca5li5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N+Em0JUT; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N+Em0JUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557826;
	bh=JZe5pKcDbr1vEJkxYaa5GHyrefOhF9dN0Lr4tQ7hSPo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N+Em0JUTxYys4qwrHmRFSvRCfsnN4CQ0KfWQxdQkj5nCb2OTpcYq9Yl3IYSn8amis
	 HnyJbg3Orl3El4LX46HC9XGjG8dn6piuowSu63EB95kk2zVr/VImWpiXCxTRL7AntW
	 Q72WEKc3k3DY13OX5uI+1AHPcryLT4rRURDmTgEE=
Received: from github.com (hubbernetes-node-a51eaa7.ac4-iad.github.net [10.52.184.36])
	by smtp.github.com (Postfix) with ESMTPA id 01A78740C3B
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:37:06 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:37:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158246/c7a20d-000000@github.com>
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

  Branch: refs/heads/1158246
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
