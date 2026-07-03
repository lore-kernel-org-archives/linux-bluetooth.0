Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE828505E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783109163; cv=none; b=tuHdewPf43qhXWYqkgsjfdF0FqvU7XbdR6amFwM6QpDwO/DH+3pzhCdLzXTQqkJE+SamAnIc6kND1r+wpzMHXm9UeoE16Pn3WuDFgc1C7RbEgApW0dv4y5hFwv13C4nOWog27GI3jCYYtEI12FnmJ9mVSLTHnkVCQjpvKzyCo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783109163; c=relaxed/simple;
	bh=kbx6Oc5ZWqqOsPdXXzbqijILsaRmOgWl3C5292XDOW0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A1/Cd6ckspFburC2/zv0mIIFRo7iHZTnIsQNXHBukJd65HGHO3x7Z9nUcmYh4Pdji4DQUvRO6ndwB6KQodX3br0/qexfNOEFLb2TW2/NVILbktTlORhDA0hTffImlSSsV8VGwud+3H360L9Zpg3FKRwcT516dSHcLU8svQ5zx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HZpWByn7; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HZpWByn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783109161;
	bh=hFBtrx6HotUL2vF0x5GBMUVT2Xia8D79EhvCBjICaNY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HZpWByn7tY28821mCe2KvzwuSUXOnoKLndsqeV6FvBpWE9llJptZ6bT+cS6mXbezN
	 ByCzSt0l7hA00iOAnzlfXyYRVO4LZdBnclNdPCAhXTIq6xHfgAi83W4jfTEPf4lukZ
	 mwSP+YHk87SWIFJJZPCx8rhetPjg9/NGWkfn4bWs=
Received: from github.com (hubbernetes-node-67f59f0.ash1-iad.github.net [10.56.185.41])
	by smtp.github.com (Postfix) with ESMTPA id AA4326091C4
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:06:01 -0700 (PDT)
Date: Fri, 03 Jul 2026 13:06:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105509/14aeb5-000000@github.com>
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

  Branch: refs/heads/1105509
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
