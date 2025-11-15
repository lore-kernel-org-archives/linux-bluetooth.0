Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E809246770
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244011; cv=none; b=S+3s8wFEremQhF/u09TWvGiaopJAJ0OVEBqcOOpEEvYZdK3w0fx7fFurjFTk2SKFzb+v6otgQocmS3olofZwhoRfvKrzO/zD0AwyioAGLy3HhSJF3WDNwiMqEW7pb1JmLaPEfb67rICQmtoAZDSPces7qMzzY5VCPPLUk4pHMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244011; c=relaxed/simple;
	bh=8tt93jD6tK8kh1jS/onkzPtGM2LtJhjAWANfCJudTVg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Jv6vUZLlIAW/OBIKUridzEV1Nz0K9Aw3+NPKTaGKtUJiXv1nAMZCsJNl+AjSqUZHwao5BOQkfNgLtc6PjGlLAO1pK6DIj63/Jh5N1zI9GkrVnmOtyjVj6JUbqX8uk2kHu5r9+ZAddl2Z0LTUwWLfbkoT3siqrPuq3qhw35GjLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AwtO+pTe; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AwtO+pTe"
Received: from github.com (hubbernetes-node-b52ccb4.va3-iad.github.net [10.48.204.54])
	by smtp.github.com (Postfix) with ESMTPA id 187B3E0726
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763244009;
	bh=/6E3XwsfTdBkQoIENMIaw2Sjx6blS8d/ruy5DlYvlNw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AwtO+pTe2uLel0ybuKV8Fa5R79pgB9H6mxlRFG4Bbm60yYOKu20WIYwY0O5mJxu8h
	 7f0giNRuSWLNPaAz0UJ1qCmb6OILoSTMarmhIUGWBF+48ma89OGH95SqGTQgv14Kma
	 GFW1MSCTQpDgpUTuna+Zbt7x5hDImRv+hzmGoQG4=
Date: Sat, 15 Nov 2025 14:00:09 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012546/d7308c-000000@github.com>
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

  Branch: refs/heads/1012546
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
