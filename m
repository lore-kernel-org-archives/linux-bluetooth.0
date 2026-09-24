Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5B2F0C48
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274764; cv=none; b=ZYYGCyFuydNR9bi+jHCYJsDb0dsSvssnLFClSCuUHkiMcLxFYAc16G2Ke7KFAE8Fh/1E4gpEIRY0QkmruOjwFLkaJf55oD09wu0KhypIfxL/djW4Ijz2gbodYwQm4is9vevIEiVqZ5pQgFbpnm/gAUTXA7ebMzCAlBur2lG8dDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274764; c=relaxed/simple;
	bh=7TpJxiCPyXcQDz0WqA3APAiyldZWgJzMqMATZURdqks=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nYXOf86oQziyd7kkIosaSokpba4hhndn5/QlkNwUN3QyclMs8awr2D440SBbaSr82Flmgbv/clXWyjKHTesHSW3udk12FiEoMo9nH18y3dHpG/nOcG/StwfoBPuifAljuS85B8fWhqJsgN5nmARTVbXv5KM2bF0t75B1Ityv25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j6I/xHD2; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j6I/xHD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790274762;
	bh=Dzke0VL32JyJY1jU3mmOF8uMcGI902NJxDbwBixQOlY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j6I/xHD2d97fwIoGp90PzJwPYfb0Dask7KGmLndXjWCSGxPNT/j9noorAq3S+4zSs
	 S0Y1Ttjcss2SQ6i5kOzJhLB5ACO0WSIrU+UpWbjAWr0wXTN9I9gt/JeOKtC5+uRX1o
	 hnF9lba8WiqxtxcSG9qk2DSPJV1gwv5QRl/wD60c=
Received: from github.com (hubbernetes-node-d9a4a9a.ac4-iad.github.net [10.52.171.46])
	by smtp.github.com (Postfix) with ESMTPA id 51E50740A75
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 11:32:42 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:32:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173166/f191e7-000000@github.com>
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

  Branch: refs/heads/1173166
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
