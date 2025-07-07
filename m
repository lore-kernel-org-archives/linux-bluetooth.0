Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C1190472
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900180; cv=none; b=IBTirZ/EBg7KZ54b4xkgTE4cKkha2AFeDRmFJBlo1HeK3+WfNZL1hwW+0KAFjVkzRBqGzQbrFoPCHt6dHVj7CwokkC3SC16nSEv0XzY9yWVpDJwf33F8y4bbnbfALryFLFZKn3oYD61zeLxyFfg7HlOf1DW8PQ6s2ei5k91F/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900180; c=relaxed/simple;
	bh=k828IXlLzvL9OfKX+rBg6WX/Z344sakHp8YElLLJy/U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=odaawH/Q/4R+MA9rdUHDBuk7Ye/4FCMb17yhOG//y80Y324tu7tx/47brzIgTQmN0/UDxUaltxepFyq08nWpxzF1l79cGbdJh390Vv/IYQb78uxxGwlvk0rE/LFLxphh+nC8FjFdFBrOf9bwDl000SVcITgkj85qly5ubLleJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hUpuwVIq; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hUpuwVIq"
Received: from github.com (hubbernetes-node-8d3a059.ash1-iad.github.net [10.56.162.36])
	by smtp.github.com (Postfix) with ESMTPA id 83227141092
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751900176;
	bh=5SZo93x5doehkirpy7x7EbD3c41z1jp2P61ciUZPAl0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hUpuwVIqj8Gm5cQ+Kj+FZ224aOC177Nsi3OP2XUmhJSgH2b+Res6+K0cUCD2KrBAm
	 lZXmpnUcDjn9RdFZLdNwULHjToIn+tDuisC2Y3zgBYmDn24tHAkdJ2PKXGRhUOkUHZ
	 5CcUNYmh4FTK8PSxZfAJZLdTGIFVFozdizkCDZPY=
Date: Mon, 07 Jul 2025 07:56:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979695/4a799c-000000@github.com>
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

  Branch: refs/heads/979695
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
