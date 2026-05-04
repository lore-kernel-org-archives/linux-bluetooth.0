Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1F3E4C8C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917518; cv=none; b=mWWEpcl2aBPUUu4kFQ4qIQHBXDUHwvIQ6Mhov9gTwMkMkHtgDUq/anFQ2CdjKidwMW4ooJhgwReAcMiq2yaGsk5rX6+9qPVzJdHHISR2bXopkjpU+jYJeYZAy/37sDVuTwtX2JrTjpPiJ32GKx15+ei0d4sbABG71xem5KuBKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917518; c=relaxed/simple;
	bh=9fRbhQMRpDfZte7CkabUMW50rjmNhLJOBZeBvU+kuaM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nDlNveiphcTcf+OL7GvKCipDjN2HnPOEhWe4htjpVEQbBPxL66MhQLkAtoKBR4M3f1ldc9JLqR6OnLAF2vO1bLH4H6HBEvvZe1a97V6QU7QlcWW506MWgpKz/6Nc9YwcOpxr5dihIMan+OYDfppY+vN2x11HKJM/Avo1pocQ2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hH6JNU0y; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hH6JNU0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777917516;
	bh=61oFI7MoT5CyXv8YIBrfSl93hbC1gZ4/0sQqCbHN4jQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hH6JNU0y1ajpVT7Q/zrniupaFY+hsO7VQNGjgiUq9ZO/BH5CeM6AI5r/OlLTDM7AC
	 eqCo+XO3gxG5ykFfpe7t3OIyuWUFQWdiXbEVQrqrqgaGtGAx23/sWJ1r4at/oJq2Ol
	 ENfAalITSGwX4SJuaJs5vTBOHYDOlSKpoQKDg7pk=
Received: from github.com (hubbernetes-node-12627c4.va3-iad.github.net [10.48.222.13])
	by smtp.github.com (Postfix) with ESMTPA id 38D87180C7E
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 10:58:36 -0700 (PDT)
Date: Mon, 04 May 2026 10:58:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089386/db9aa4-000000@github.com>
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

  Branch: refs/heads/1089386
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
