Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF4381AF
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589149; cv=none; b=Fx0nEVprJrKn/2COzuYiyKcmgi0ZYSCgj8kvU4Lad4gPOfSl3hYzAhn1uNgxuB5fomj/rq/t45dERZqML5v8Cdp1XZjYMmpsdkGRNSKAE4fLmo+ceBbba7z9dzb973u8CPuw5Vxu8vRFXRJpEWETN/BuTpulC2tWKGmiFjKTl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589149; c=relaxed/simple;
	bh=/Mns5mMCkotYdpxWmqVvC/tbh66tSLqCcnaYCY7hGNY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uAy6OuobLyFK/b0SyPztHksde9ajj9ueGT1xtLke4o/tx1juEGhZMSZAr/Aq5upHnANQ9pWx8wT+UYamCga9D8C9fKIJRCAnHqD0Nx+4TYTNYrzSGerhvUyz9akpZEhokm1SuCspSUitfQpoQ7Tfl6cm6bFfgbj8rlqt++FvoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=H1ltTPKV; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="H1ltTPKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791589147;
	bh=VFcTBnnUne6eTftkQ5zrA2NrhndDEruXujwHFjgDcRY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H1ltTPKVwmtNIpWGAv4BmVcW+VdFb/SRUDMbBKhyoOY19l5+G5MOzxj1Vyq1YLybT
	 uLlhCjUdkrrmoxHfrQ6kQDRIrsbg8j0/z8S3A55RmmMyxwxmeByIoysZKpvmpzIdYa
	 Kh9hT8UIRbp05H0+Y5Fk1OkqkkMHTCrRm1QA+Y0wYUNdkuNVHBhBym+oFuUk5fiDwX
	 ceIKRRf325PVm4ZxAEi40kFvcncL5Ahtiw7wSM3MN+eyTXhhNLBUkE0E6KWHlF/bkp
	 0b5fpnklJE4ZiwE9/vfwKuuWk7xLDV+MAQVKcDOv/Gb+CqEczbq7dtSQVQe0Tf6pZv
	 k5sgHrOfejBPA==
Received: from github.com (hubbernetes-node-ff97729.va3-iad.github.net [10.48.68.59])
	by smtp.github.com (Postfix) with ESMTPA id 8671080025C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 16:39:07 -0700 (PDT)
Date: Fri, 09 Oct 2026 16:39:07 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182593/000000-bd47bb@github.com>
Subject: [bluez/bluez] bd47bb: shared/rap: Track RAS CCC state per connection
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

  Branch: refs/heads/1182593
  Home:   https://github.com/bluez/bluez
  Commit: bd47bb95c5deaa85b2a7ab6a33bb867b5666eed8
      https://github.com/bluez/bluez/commit/bd47bb95c5deaa85b2a7ab6a33bb867b5666eed8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Track RAS CCC state per connection

The Real-time, On-demand, Ranging Data Ready and Ranging Data Overwritten
CCC values were stored on the RAS service shared by all connections, while
ranging data is sent on the ATT channel of the connection that produced
it. One central's subscription could therefore decide whether, and with
which transport, another central was sent ranging data, and the Real-time
vs On-demand exclusivity check rejected a central because of another
central's configuration.

Store the values on the bt_rap session of the writing connection instead
and use them for the mode, transport and subscription checks.

Fixes: a9b39d71597d ("src/shared: Add RAS packet format and notification support")
Fixes: 2ac9fc0901c4 ("shared/rap: Honor CCCD transport for RAS on-demand ranging data")
Assisted-by: OpenCode:claude-opus-5.5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
