Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542B17165C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483933; cv=none; b=UPfQdg7SclGZ32ccDwmGaWjgI+3W+SRH3v+8WhhAya5xWHciLK1d+2Rr/AYXMmSHo2MBl+xNMTCUtd4jiFMiFYn9hPJ1vcxu8f0LbJBRnabIdQXMBj1eG3CHYrLDufrspN5ovkhCt2qQILHX7o9Z6Qo/PNpltKDD2BzGsdP7g1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483933; c=relaxed/simple;
	bh=ZpmdSqItlOayiVYwqW9DzaR5cIFQETygkwk/PlMkCx4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bgY2cTNPHrGdP2mikhIIAKhI2oxFxGwQzXEK2spPs52lzK1vCaUznOUuUbzJruZC2LySbdmJMJchMiXpStxb94SDnBlS83vrB0lGtv+b5D1sI3K6TMpwLR1nTm1fGM+yo+wXbDR6dDeuh1EgOYGv7ZhuVio0AKWZNa0wDB9ALFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Cjpso0Tl; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Cjpso0Tl"
Received: from github.com (hubbernetes-node-5cab7ce.va3-iad.github.net [10.48.160.12])
	by smtp.github.com (Postfix) with ESMTPA id 148984E1207
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1714483931;
	bh=T1NR5sH+0WW+lIp1zbs7TJLuT+J1z/wRfK+ncJZ+PNo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cjpso0Tlryd46Jyv/lls5GcWax3o6aRTQ1fBQ/3PAOPyq2kMpMYcaAlpj4Ac+tu58
	 TpHG0SynV07AKPYeFA80y+FzdCiWnMqHae8pMFr91Rlr4e63CyzIaC6tdUpjq2Sx0E
	 KvNUJD7RQa5cTOv2bpq4PSVf1D9DMlCiRWTps0T4=
Date: Tue, 30 Apr 2024 06:32:11 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d2a2aa-6fc599@github.com>
Subject: [bluez/bluez] 7e6079: gatt-database: Fix matching
 ImproperlyConfigured e...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7e6079219b2218f4c3f52521f4a2c521049d961a
      https://github.com/bluez/bluez/commit/7e6079219b2218f4c3f52521f4a2c521049d961a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-30 (Tue, 30 Apr 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Fix matching ImproperlyConfigured error

Condition for ImproperlyConfigured error was not checking it correctly.


  Commit: 6fc599e334cead9cbd014f7830753bc28ee5868b
      https://github.com/bluez/bluez/commit/6fc599e334cead9cbd014f7830753bc28ee5868b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-30 (Tue, 30 Apr 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Fix not calling pending_op_free

acquire_write_reply needs to call pending_op_free once done with the op
since it not called automatically as it is not passed as destroy
function to g_dbus_proxy_method_call.


Compare: https://github.com/bluez/bluez/compare/d2a2aabee646...6fc599e334ce

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
