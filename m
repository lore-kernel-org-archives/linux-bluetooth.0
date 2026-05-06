Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B547ECCB
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076012; cv=none; b=Tmyg0MWN4NE5h6vbc0pKSNrgZdAKmCTpmAnD3ed5tmqC5wnV9jG4SnhgrH6L30qR8Za0VsiE5yflt1HLQpA3VSBQt4rAlBCSo0BLokEm1ba0INHqs6SOBbWjszS+yIWLRHnUVm4VUTlguv5PSSsFzA3EZ1Glo/qGowwVoSy9IxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076012; c=relaxed/simple;
	bh=Jvtto3P/AeE4phXDHt249eUh6Urnit91/2r8hE1YkNQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HPM54P/R0aSDRz8WQlFfgKR224wq2soOByCG8zavPMcd+oyyzTwyXu3o/8FppSttBZzuCTXmMqVZlulh+d4m7OhoLAcfEvRE0eHyen3CHfHes27CkyNGBl+/ps6aEja8xmo6jNl7+3X6c5jB9vpFsjYkklXhUzuv3F9KbWxkVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ICqKKmEt; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ICqKKmEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778076010;
	bh=TZCrhTxX0+PGohqffYszPlXVXALPRhIcKu4a9m5N874=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ICqKKmEtkatmFmkVdLAFoLfqIzxG806MO6pvbQ6FoIran1ueU8FDMWKrfQPy/Q9kV
	 pxeLJFWzkRMsd3mDtdlPFLbaJmojIWxv6KQOLTabe2ZPWAanZXJcow0tGB5GcxcmX+
	 9eCHDJqqnXIkm/NuWtfWsjsiZDTTmXkkMWG3idFA=
Received: from github.com (hubbernetes-node-dbb8178.ac4-iad.github.net [10.52.169.40])
	by smtp.github.com (Postfix) with ESMTPA id 74D6D740C7D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 07:00:10 -0700 (PDT)
Date: Wed, 06 May 2026 07:00:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089499/369b30-000000@github.com>
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

  Branch: refs/heads/1089499
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
