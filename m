Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F833CE8A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637585; cv=none; b=S/U44Blz0cvSAZfBNHUqzdiA8d2z5v4SXfvX10wvhgaXZnu+/HNy8n4HWOo28QJIV4jZWlLD/SL0vlHa33jwTER0ToxZwJ6/4D+T436Flax787SkRpSoBioQVOjh5oBYTbpHc5MWOP++yrJiJEmkhjN/ZQ56WreQxmv+eccwNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637585; c=relaxed/simple;
	bh=tKFLDZSgLTWle/mKXlzcxoKokh2LbW5AQeN8QVBYHKc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eq8AN3nwuAfbYs/HQTtkkqHvSY2J1AzrEKifIIRzHq6nrpbZfPJZpwl0Yg2uNFK1cWS8X/T5h7Hx2dGv6gCp4PhN5lAoBgdnOKdDYTX1rAqaSNsJkCHC274vmlPVdYzg6tUPf914VVJxGSAOY5S+yeuoVjeZcC9bZuKr2RzVwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D9kiJQn+; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D9kiJQn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783637583;
	bh=K7T3Y1eENkfyTJ+Kg9ACpuqZ5UaNO9PDXBXqSDZ6IdY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D9kiJQn+TA5dmeyZshnciDlgdnhVCNXavvHyrQAJuFwHdSBhObZMWJ1oqjLk+khkC
	 K9T34YTRkqEsTU+gPq3twJ1ObI6Xoxs4VdpRJ8moOdsZiGr67p7jJLeYZCAlBbHxfl
	 eZCzp/5twHKnABK+k935baA9Xaaja7D/sm7Xo5UM=
Received: from github.com (hubbernetes-node-a8a5355.va3-iad.github.net [10.51.90.36])
	by smtp.github.com (Postfix) with ESMTPA id 7827128097F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 15:53:03 -0700 (PDT)
Date: Thu, 09 Jul 2026 15:53:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108824/b854c4-000000@github.com>
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

  Branch: refs/heads/1108824
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
