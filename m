Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8C4657E7
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178369; cv=none; b=AZeP8tmamy8Sn80L/Kr4aeZ3kfgWFdQAaIHAemadLP2/chrTSRqvppZXXXn4N7TluHH+8bTaK780p5Z1WvlPPXgmtUDtoTehiJUNX54V/ctyOVWGmlo10JQMXXLphKLo5ayO1negWU51dz7Nv6ByGlcCPh84nHkS0uNLd93VigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178369; c=relaxed/simple;
	bh=l607Le1DZb+vC7Z4b2c3rQnqGdiSNrFR87wvnFhk4AQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OACkpFX9xo1lxSU4mJ+pBn68nMXk6mVITMv/bWVM8eCZp8QkF309HfFe4VAuIrR187d8ewunGoJEQynXCjmJZVmvahy7oSPCkrNmSkoLEvx0vE6v0b8uynSgGUdieQKWUrOI4B7izyuHwyXNk68dtpjnh4bKJYXUlCNyBYaOCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ult4fJVk; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ult4fJVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778178367;
	bh=pFrgxO1mSzs66ZaQhCbePQWjb6VqqxlBWAH3fbfBGoU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ult4fJVkr3Vm3+f1k4lhu76e3EqKQTlBm5R3oh0N2u04vuHWtKwP35mcJz65hoaRl
	 sol5Xx56/I2PW38qPzOdfvL6Q/6lYO0/3uFXiTUqJ+Q6uirGL3dIvENdglgSkHFRVq
	 Q6gBdk6intKQAbajHfgdOUmdecUDsUaTXZHoHs24=
Received: from github.com (hubbernetes-node-1057fe6.va3-iad.github.net [10.48.13.73])
	by smtp.github.com (Postfix) with ESMTPA id 8F0CC78103D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 11:26:07 -0700 (PDT)
Date: Thu, 07 May 2026 11:26:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090721/67706c-000000@github.com>
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

  Branch: refs/heads/1090721
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
