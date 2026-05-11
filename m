Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E036B046
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506539; cv=none; b=exx3IEdgOwXDcXwUc2hlNN0PAHxufuKt9O6GONWP6cNc0X6d0frqOqE2ivbgvziRw25W1oJ3UIULHoA4w/y5yr8BDUTETVxYYusUCycEE3Tx9WXyIyZw6eRBHG4F/+PMTNW0FquqwkD/N9xJKFNr78q4AQhXskUmKHNrxWwcZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506539; c=relaxed/simple;
	bh=WitztCpN6DTVt3oNGip8rtb4OTReIW48S41uixcKnXs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=X4LIyUO+qWgHtm42zuzIR+pDoAjx+HcGTicvHYpvXivuu3sJjOF5u1vT5vpE01NyupnOKgN0CtnWG7rui+CWmzkXwBDRsV1/o9I7BLUiPgi3BzQptTUDaElUZk/pxJYRJZ8ulS1gi+W4awWtmP1lnKhjeG90m0vSDEKP00gYVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kk02H2sY; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kk02H2sY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778506537;
	bh=8Buj1B0ZJyKx89aM9FFTpdNmvs8eyQ4VC4Asu9noP/4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kk02H2sYGdYcm/4XiY5uJY64O/X6+QXmFIWFFUT8id6KX3eytFH+gSABt3LIGQDGT
	 aYsAQjA2pN0LwVq7vwVZXOtCqcdWnZFO0op2C8G387iSDaGzqkUn9L+V6BblGfIrHb
	 soDkWOINcKEzoaQbKzQpUKgEbdWSyLc9B7QUCaDc=
Received: from github.com (hubbernetes-node-8c40f84.ac4-iad.github.net [10.52.150.25])
	by smtp.github.com (Postfix) with ESMTPA id 4A10A74097B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 06:35:37 -0700 (PDT)
Date: Mon, 11 May 2026 06:35:37 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092705/000000-4246ca@github.com>
Subject: [bluez/bluez] 4246ca: bap: set QOS state when CIS is lost while the
 stat...
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

  Branch: refs/heads/1092705
  Home:   https://github.com/bluez/bluez
  Commit: 4246cabd1ecf06193ce603f6950c85fe57d043ba
      https://github.com/bluez/bluez/commit/4246cabd1ecf06193ce603f6950c85fe57d043ba
  Author: raghu447 <raghavendra.rao@collabora.com>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: set QOS state when CIS is lost while the state is streaming/enabling

This is used to Pass PTS tests BAP/USR/SCC/BV-167-C abd BV-168-C.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
