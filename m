Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BB3128B6
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864031; cv=none; b=NGdZWupHh409gzWg5LYRaTbwICkfTJyEX/Xtfd26OQk84hkkLVFAKhq0HOUe6yeJF66Ekr8fh1msyUrIGi3KASR+aliammCI7x8fdD3jMhR6cU94N5A2JitcReSyfYB6gjePERcLUUPMPmecEZ3cA9Hx00ndbeV81hu4CYKY1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864031; c=relaxed/simple;
	bh=VvkFzLgUhRIV2Kwb9Hnf91kHvkUjyn2OZrqw5O+1tZE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A7ncdKVxe/BNnquQmSvxTFRREy9kkPG6aN67a+whXLW5adhidKpDUx/TIIk9+cJ6CnOMLKnAgysktimWVsI9eFUQfAT3Qf/F4hzHnK1DSDExjvhJZV0coruaIzFu39NhGSXiP3j9AXEWy7gzdJE0BtdKGx7X0ncORfUt4X2f/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TK5lbttl; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TK5lbttl"
Received: from github.com (hubbernetes-node-03ffb3e.va3-iad.github.net [10.48.133.37])
	by smtp.github.com (Postfix) with ESMTPA id ABF9B2C10F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773864029;
	bh=1J462Dzxthz4GOR5cqPryv1PdxH1a5fd1pW6vSVTIWw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TK5lbttlZIbddkaqa9EZbwc4Ax2rxngrmm03MGwpA8EvojoTgVU5gTD91/BXBNfj5
	 U2/GzYfTgcq7KxQIEE8QmrJEo0Tx22RzzyHgxuhGBB1ZKZSqFEeV86XkV//lHuXDjW
	 uBv6pt3JIchaW0hzWyjwC0KWswGvoGgIpqRHDCVI=
Date: Wed, 18 Mar 2026 13:00:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054670/18432f-000000@github.com>
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

  Branch: refs/heads/1054670
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
