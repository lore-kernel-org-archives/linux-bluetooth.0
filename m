Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4720E003
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876588; cv=none; b=fYSM70NLCJfY0TGqVPxOzFMPGKZnjIthPuoheU10/B6um6bCI0S5mUcpnIntFssu69+YgHaBieRNUQjowlZt93JLW0AyujKehnoTSnkuoBHxZDZWMoxOfZKnrEPKw+IvV4LdK1wi/2gKFaVTxo6LITcLfSTfLhyxOPzVdp6lTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876588; c=relaxed/simple;
	bh=VXUo3DwLriKIbR6GeI5WwxCBEDtCoLOfVykpMn5hOVM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WIi4HDeGAKs/pHtzuSwOJTcmml2LIixO1gIGvdR2CHZ8qLgkF3T7IyB1vsSoShsVa++D9+3q04CU2m2qL8oy41UWwaFVpxBXNPN0SPIAhee6Oiqh6pAlHMKjKf5a/irwd3RVDBpsmuFa5UJK+uzubrMz7KAygrguqvwzxnBVKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XrwmpOBi; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XrwmpOBi"
Received: from github.com (hubbernetes-node-3798eae.ac4-iad.github.net [10.52.157.12])
	by smtp.github.com (Postfix) with ESMTPA id 4104C700A92
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745876586;
	bh=nGOMUkelkV2gX0lS2fYHSU/hwNj5AiKSPKOEhs23blI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XrwmpOBiQaOmIzZ8FDalF5+AyrWb5yDFlhkD6cLJxC5V0gvtKEtr5+gJ0jycpy0Lt
	 dV3e0Z2QNr1HAGKX1gdI8rSLlQt56zGNK/T+86OVG6H1cGH5WPgE2cp2NV3C7l7E/W
	 cnbEqjWg5KS8SbZKIOtnILjOmTvuuM436nSvI6mM=
Date: Mon, 28 Apr 2025 14:43:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957766/4c66c9-000000@github.com>
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

  Branch: refs/heads/957766
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
