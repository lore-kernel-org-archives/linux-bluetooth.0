Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B22EC0B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806148; cv=none; b=NIut5pDVn5WlZRYa3Gix5g4rxEc9eGle8cH8ZQRCzAfnNMNtzQi+wTx5tWoXlZsiDto08n+WEtOEVKlmYSCTfQyVsxWhjoYfPcaPQxKDaYbDwuFH+54esP7ucTMUe/wrDIxTBRRNUlL1y+hjs/Hpil8HSOHb1IlZEpiAfAFzfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806148; c=relaxed/simple;
	bh=HG9KxvKvDDVgNJZmZ5H2zQcHu6xgH3i3etmzVkaA6Y8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HYyLlW9zx33Mmx28UcpIR2LcOU0edzWT5Q+DnyYk853tZKtvNbVvLdJT6kQMf2pFkRSAFn6Bc5iVHqODG/bQkVVy3brQL9qw/3fWorde9WYpgoq30YmZA571IO7bZfcqjmyjJRzX9CMyGwc0TBwqcZqxijj392qY+FbWc0vMOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AU7ywGut; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AU7ywGut"
Received: from github.com (hubbernetes-node-4ae5255.va3-iad.github.net [10.48.222.11])
	by smtp.github.com (Postfix) with ESMTPA id 843834E0A14
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806146;
	bh=hXPPN3YhrZG8rPNUi540cRMEZtwl4F6GGTiDOG2DugY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AU7ywGutz97+nrmpg/n4gyqELg7FfkeHkMga8gKGkmgWhC3A/Uwcb6J+Q1QNtBz5t
	 zwGKw0lPNNMmF2gV42R+JxxYoZSrmTq5gYVe4xiMJF2X5jP33ZBuU1reqpThbWUlKn
	 k2Et8xWVifiEe5rIBxtcztReUG8aC8KPjdOgTSGw=
Date: Mon, 10 Nov 2025 12:22:26 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020579/873523-000000@github.com>
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

  Branch: refs/heads/1020579
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
