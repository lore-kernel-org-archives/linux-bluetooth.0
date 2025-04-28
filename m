Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AEA1D63C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854466; cv=none; b=QUesVNDkmnqsMNOgxRtg7Mt2fO9vRZfEktEfi6G9OQ2IvyeuGLEWuasyTd5G+UJVJZSpj2HWRk/HTW9I9+ITtkz3DEsMnoI+tt+1WCdewt4IJXtE/+VHGsDcEEO+9/qAq7DFksKY2lEUEf25qIaAx8JQU8jfRjmali4og1Swlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854466; c=relaxed/simple;
	bh=tTBitA5kz8L/5bAEkr3JIxHPn6/z8BUfu/CjVcaCup0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O6mzcsutBOs/jCdWYmRYauO0dryvfWdXXH8CGj0nTLepOvo+iAd3z5W8vigdfyVfYMFay/I/ed3Rf5V07UH0afgII/P2KrsPme+W37TWA30kbjMZi+5MGahL7a8Wsun8YlpZlT4hWcp6hAD1X+8QhwBweS3MCI7HM1fv4MbAZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eRtc7fI+; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eRtc7fI+"
Received: from github.com (hubbernetes-node-a0e7df4.ac4-iad.github.net [10.52.158.25])
	by smtp.github.com (Postfix) with ESMTPA id E03C4701046
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745854463;
	bh=XNzmXy8LCZjB6n9KWr0xjtP7r/wKKLpoJUXmqY2nK2s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eRtc7fI+FLbtdQ/DFYtSUAeZgn7nNdSZlm0cVUFi9MwJUuDlhoNsPbdQU+YhioYf8
	 jHIJeQ4pN7/8daPGyRKOdzGgOJ0rB1dLHHK2c2xQmJvQN6vIMf5BHcGwg2cZVLGBPn
	 W8YrG37BD527tR4LXtsmmnRIDFhNDcFCcrqLHctY=
Date: Mon, 28 Apr 2025 08:34:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/alert-autofix-21/000000-f1d167@github.com>
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

  Branch: refs/heads/alert-autofix-21
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
