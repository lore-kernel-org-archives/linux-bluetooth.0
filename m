Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CD346A02
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437766; cv=none; b=FYRkmemmLDmpUpX9eY8XJK8rFUmWjHTmtCF52FhgE7ez7aDbmN6itvWZOkjIgDS1RWj8R/Kd2FyIo066onFes5D7XzURpyQLQEqRYxxwpFUSzBVkdvtTx0Ex63klMPa7cAu+6nkMV3EPWrrIfE2nLIETrVSlkM9N3EcnrwRdUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437766; c=relaxed/simple;
	bh=ljelCtzHmPqX/iGq4Vkp57TXRb+qThThns2azcjqKmI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NhiqEWbCHWAn0i6nPBsaem0l27PdF1Ta9xHp8QqPxbDW11ylTnUvQi2yKRna6NraZku8is+pTCydMDzrauro9ZJHLdrqokdts56RKtRcmIV5AtmjfQzJTaWiFA0k3/7NaOPDB01N46hehIftBf7Pa6DwJKPFx2aYhRgT3ypL/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Hc4zV22Q; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Hc4zV22Q"
Received: from github.com (hubbernetes-node-f70c086.ash1-iad.github.net [10.56.226.69])
	by smtp.github.com (Postfix) with ESMTPA id 82D2E9211D2
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771437764;
	bh=HHZTCOtxv5x0KDtqdtmi3Vb8Klrq+IkRiq3LaQ8kBpQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Hc4zV22QbkJaHaCq1p/cn5vRbSl2OSNzRcjsrjr5uSlfpimZcByBNA1KYRRIBJ3Je
	 gflyGxQWNaYNWOfAH8CqevUtrHucGSKyfUgBFiMP8QwJslbyF0LC0p1TrtB47hN/72
	 CGdoia/BjR33qCw2b4l6zS1HA0OWTW5AAPt1lnks=
Date: Wed, 18 Feb 2026 10:02:44 -0800
From: Ronan Pigott <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055282/000000-f484da@github.com>
Subject: [bluez/bluez] f484da: zsh: amend completions
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

  Branch: refs/heads/1055282
  Home:   https://github.com/bluez/bluez
  Commit: f484dab82fa968b4c28811ec529c7d44574562ae
      https://github.com/bluez/bluez/commit/f484dab82fa968b4c28811ec529c7d44574562ae
  Author: Ronan Pigott <ronan@rjp.ie>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M completion/zsh/_bluetoothctl

  Log Message:
  -----------
  zsh: amend completions

First, use the correct completion return value.

The return value of a completion function is significant, if we fail to
return success additional completers may be invoked when they otherwise
should not be.

Also cleanup up the zsh completion, removing the redundant definition of
_bluetoothctl and using the _call_program helper where appropriate.

Finally, update the bluetoothctl invocations to be a little more robust
when parsing the output of device and list commands in case new output
lines are added.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
