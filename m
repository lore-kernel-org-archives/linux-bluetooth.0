Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E273BD64D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834361; cv=none; b=S5OhWlUZRRhW7wAWh0dBgvshzHw+eCf8sRzJM/N0cQ1GsmFEQ6SQYn1oyn1ZVBEy6psE4JR6/bksVF404tYzzFYZyzWTdW1aI+KXyBFn1Tg3Ei9QqISgChsJNu+JP9GBs01vssWmCwCwI95bBxcRIkFF+vw+PgKMjn2eWf+1NIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834361; c=relaxed/simple;
	bh=Sb7O8YjzhBnul3BPGX4e4XW4yZ+lPV6FwskpRtOHpUI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PHGClPWvMHbn9oQbDeQBCfitoT602B2HzRWQCuuom2JwuewU9/wJ8I7ruDI18p+QIHAUUrZzerLS0TAzdG+g2RszUBRdlZlrAyJfLmSCXZeTeMGH44r0KO2lE/qN6EiezQktPJZ1tzfa11fF8J2rVSCd5ru5Dwx0+foDnB6OVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aEKOt5tc; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aEKOt5tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782834359;
	bh=uXRErz+sSoMjTY3WVCQjWsYL///4U+tYzrAVLkSekms=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aEKOt5tcVzEzmCBglgL827tkaPNJmqh7nH+MFYtz4CU1xOb2IzpAIx1NogYI0eoHj
	 SdhxK6TwG3LUfnoP/luR3pufCky/XUA6n7rO36fW5Tc0WU1Az3G6+oET25pyXKElwn
	 /hLNduTTNJhLDZ1j/HfhvC4BFDUuiWl3PFtMAQT8=
Received: from github.com (hubbernetes-node-8c9d125.va3-iad.github.net [10.48.201.111])
	by smtp.github.com (Postfix) with ESMTPA id 4772228D342
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 08:45:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:45:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1118869/9d4da6-000000@github.com>
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

  Branch: refs/heads/1118869
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
