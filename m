Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F1376BF2
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119371; cv=none; b=FN5ThmB7Mqd7iFy65FHNKB3+8F5JaX/FLbVaHWxgrbhkhJyckgfFtMcmkV3VLpQo0SkOc6DLDA9OU6888+YZEeLLnG+XdqviF7oph9eNHJ8i8iwj3odT35b6dtXnwnB3yZP15999LOujkYtxLDFjG6gF7Dn0CkuDw4foTZeQ61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119371; c=relaxed/simple;
	bh=ndNLiePKqTWKPO9Ue1JAN66h//JuyBRsZ49a6Dxk9TA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bStu/pZkhdm2KIPUrBpKYr7H2SAfv5kXmZf0RUwbvNFZXn7jikVj7mX7tAJBJ8eaZxDN9nA3UJder16RSsFZ7J8Uup1cYA4Wg8avcIUN/vA8G/MsXHtdn5qnJQpabLveaB9+mzZ0h2MAuwC2SkrAyypvOC/xE00TzCBnMNRN//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BgLE+rvi; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BgLE+rvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119368;
	bh=lZwyPgFRni2d15EhHvgwnpdghHHgzYqnkrNNVBe0zRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BgLE+rviGlvnowgYe1NQTinX3bUMmYcIW19vBeCsanLbkQJx8+gYEHKxbF1csMtFd
	 hJyI1yAOnwYUcAkPtNznYsm1pbUUeMqr1DXcsxeUrNPbaMW/30KBPNgHbzJrHT0Zui
	 SdrwtCQrNVqg8WMjlMbzpuX8XbHS+sT48J7vJZwg=
Received: from github.com (hubbernetes-node-8abdc71.va3-iad.github.net [10.48.150.26])
	by smtp.github.com (Postfix) with ESMTPA id E86E450116E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106927/71d8d3-000000@github.com>
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

  Branch: refs/heads/1106927
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
