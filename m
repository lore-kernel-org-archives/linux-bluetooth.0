Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBE188A0C
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754826390; cv=none; b=m2xM4xdKwDIVjXvjKliseZUZbSHyr41LI1IrERefP7Jxxn604ThEA+yMwgbuI6+SZlzmlU8Sf39vkcta3W/pMgstvC/rlxzvTS6iRJ8htzqZi0gHAJpoIBIWXQwGqlyIBSRxIFiw/QXVEn5uydXeXqg4hwpSb3+YvEat5iDa+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754826390; c=relaxed/simple;
	bh=xjSH4PQeYnnl4+yhQv775YfUzTMeYIDmCPQK+6sCTlo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SB1OmaTqnn6kDu2zgnqorwhZZ8jKEvFuQTuFppvtH55LkwGbu2hF3K1qP0bLtYsXIIUv9F+mzhPKP2nOpUqDOYXpB70j9LIGoZM+8CoJNhOUOsw1f4woMRnQbZRvP++4ZsNiAQt06yKrviJCwcOHw8eY42jxp701tV5+kUk5G9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j/E7QXx0; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j/E7QXx0"
Received: from github.com (hubbernetes-node-c199cc0.va3-iad.github.net [10.48.135.34])
	by smtp.github.com (Postfix) with ESMTPA id 5589DE03C6
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754826388;
	bh=87wC6gT+3h0CO/lQGMil0DxoKugKoEkqqvFF5ZJdAhw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j/E7QXx0CCEB5vxBrgZk6QFOqanaJt9H+23kGZHxoXRwMI1jJSsP2+smBng24q38e
	 rqc4bzUSmx+qoM9Cb/13ubBrLXkk0rrE/AHHvxBl1jBKDQEdnXYQgLfXLzaLg6A1ib
	 NZS8OmpEZvlSFsenji4bLt1vkhOE/UCHS4TbWY68=
Date: Sun, 10 Aug 2025 04:46:28 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989695/000000-5c523c@github.com>
Subject: [bluez/bluez] 5c523c: bap: remove bap_update_cigs callback properly
 whan...
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

  Branch: refs/heads/989695
  Home:   https://github.com/bluez/bluez
  Commit: 5c523c08d6283172c324ab2e73c3dcda229356a4
      https://github.com/bluez/bluez/commit/5c523c08d6283172c324ab2e73c3dcda229356a4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-10 (Sun, 10 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: remove bap_update_cigs callback properly whan data is freed

setup_free() may re-enable the CIG update callback. If this occurs in
bap_data_free(), the callback crashes with UAF.

Fix by moving clearing the callback after all setups are freed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
