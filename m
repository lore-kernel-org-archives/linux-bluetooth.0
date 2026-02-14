Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158017A31E
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771041766; cv=none; b=jrsvfpwH/JzviyzgzLiVBrtBrxb13tVNS3oicvnHk8fP0wueEh+ZCwiI0sPMQtlZdiaE1jQ0ag8Y/pqu2nu6bQroenvmQdYrV3aF6CfzWUras7eWDU0TpIDzri8+BUO6VpgWcz1YS+TedOjjQUpVEojbY/jECft2DO/43KLnC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771041766; c=relaxed/simple;
	bh=l4enVJ9mMCmWhStKXzeFMgq2fKxLMwvp97s3fL81seg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TPviSRzTlIBXe7z82YMVCzYkjgHukfCOLeb9T7bB/zW5e9rDsEOSKK/0cQHF0bFwfZo4eEjQeIuW5e8Yze5czE03usasH++c2uQTnaLNWiaMFThv48NV1nncYAN5MtXi0BREg0k768QgmZ+fr0Mm9YXfqzXU1r07J1qBIK7Wjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XBg8rcTI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XBg8rcTI"
Received: from github.com (hubbernetes-node-6a50456.va3-iad.github.net [10.48.125.76])
	by smtp.github.com (Postfix) with ESMTPA id 7969B3C1148
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771041764;
	bh=i9PdFisFzdlcPfgOXL8+kUNs4YC3P381SGjEVNlLsNE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XBg8rcTIuaXqRZR1wJPtNs5hxApiANUrV3Ftu4E/3/6dErpheF64A3N9j7LopVj8X
	 vmY1q+GaI6XBhKjiG+vXrNqJ5eAUZ+ePUWn2og3gC7w5NgrV2d6PkzfggFb2KYNaH6
	 460Riivy5MT/gyFQsI7B2W8UaTTdH7EEZg/QAJas=
Date: Fri, 13 Feb 2026 20:02:44 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042572/5567c2-000000@github.com>
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

  Branch: refs/heads/1042572
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
