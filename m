Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAB1E8338
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684512; cv=none; b=HT9uv/cMr4OFxaC/zvcmoHjo7pArEWANLu95/3xvoC4DB4TLOxrWaacpra0Q5SHnwU8t28cWJ7XlKt4QeAYriZ+v3WCic8P8VLEDvUsLwtNgcVHdLaHam/WbdGsYUpCLyxjpIZXhAFrjCK8qG0x7cv+b+fPrmERJlnNRfqL/M7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684512; c=relaxed/simple;
	bh=dDcnkAhwdDMiNHNNcGa53zxDLokU7+TU5DN+v8RaJbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I25onobB49GE+ZlQpVcYARedYRyYQ20656/tUZ21xw2Src8Ce+fuGRWiVcUIXCE/2D7imJKrDtyrSxMd8GqYrFBb5/NUfBbHLrDTk57hvGyeD05GPXlcfx/oGQYs5e4Tq8xeVagGvqX58taXEptfZj4hiESAleu784/hBjjQbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PVTB/DGi; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PVTB/DGi"
Received: from github.com (hubbernetes-node-f629ffa.ac4-iad.github.net [10.52.134.19])
	by smtp.github.com (Postfix) with ESMTPA id 462997005B6
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747684509;
	bh=DGPhen6yLq6J/oSPIWBS576yT+JjOgz9jBqNRt0c9h0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PVTB/DGiZXQz7L7MHAVR7aHm12R/KilxzadfmghCv0T2+TTyvDfgqRj0xNJHvSKHa
	 09HMRLG0zJTg1+TwbHV8OSqN/WvFeCTPcO4j5vXrTQFOfJVNkZlE3KkI0uLYVj2pvn
	 0nf9Vtv5kc7w0TyFGDKUsbkaDUXFx4CplZ63VnyI=
Date: Mon, 19 May 2025 12:55:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961436/b0142a-000000@github.com>
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

  Branch: refs/heads/961436
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
