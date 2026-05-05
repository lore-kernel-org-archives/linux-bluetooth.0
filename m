Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE4365A14
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998005; cv=none; b=MbVRGysI4fCjv9MnAU6pfhoRNy39o9xWdKH/6CABtGbvWm6rp/0/otZhkMByAAIHbX2tIiJfaB0GP8yEzBR7HYIn0b0UuqubRKpZFI82zADSz9R8d50Ic8juGLXw9jJiXO5VsCBEKlCNu8v2Dnek8CzAvtajdU8aAG/xDZBJP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998005; c=relaxed/simple;
	bh=oH/6fYB07+gyrs+I0N8b/S6lPPfgUMydzim95ssKNhU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dVr1EzSOHzGzh5Za+2uOdt2MoQxvDQ2wEDFAD8dUR9fQileU5NeueyODNRlvIySOn4sWEHoNwGUFZtt6gSrm3SAxDjMY1KadbGWwJ0GFdirPuQSXNqRD0qqg0tCx1gdqjyosNIW2cm2li6H3WTg372TI70m/PUmuX9AXBkJTUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SPw5pMNg; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SPw5pMNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777998003;
	bh=4GR6iZpoLw3JKXBDCw/VDvxYgI3gm5ZKYh0QFu9K4k8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SPw5pMNgyY07YAs11KgTfaAsq4CTi8L2kiYh6UvesDcHQ3r9QwMWQM99xJPSXTawW
	 uM0tNI/C6jSdFGSVtpw+MEs4+UwEaChwjUMVkZC7ZsVxhfV3vN1ixcryfnCrmxjfFg
	 jL7vu7e2iTUS94DLhJiSnAWueFJsWf6LzvvjR0tQ=
Received: from github.com (hubbernetes-node-ad23437.va3-iad.github.net [10.48.219.29])
	by smtp.github.com (Postfix) with ESMTPA id A1A4C180C7D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 09:20:03 -0700 (PDT)
Date: Tue, 05 May 2026 09:20:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077422/9a7446-000000@github.com>
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

  Branch: refs/heads/1077422
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
