Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C623182D
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527852; cv=none; b=RL+JhXoLpxd1HTHxKoxnqmJVlkow/QeExpTpR1Dw4IPEu4y+5jPOcLXOvRuvmIH4lekhnPRHPd8zvE/pJTdsR5aZ+b9qPx9V/9VUQs4+iufgOiWwf1aYfa5FPJ9s6fYfRXnQhk7ZobJb9UVlzI9NQ4bOSK8HdKWXBEQCnmt+DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527852; c=relaxed/simple;
	bh=/oXLQqP1U1xXytA6Mw5MI11JHynOS7rqbJKyFqwWss0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LwAIL/z+LVBiK54mYgyq8o+HdkCLUZzlHP9xJimQbw8Gwb0dn5i4ildrckOIS8WwkXikgvFFUEmEgx/m8OtUuuWflfA+1t7Ct2NqcSMSNmQivTljlevLeLdlDl/78gBfoeFaTm/TSGSp43wIJ/mlUy36CbxLfcEZ/RGo8iQICOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ETzY0G4O; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ETzY0G4O"
Received: from github.com (hubbernetes-node-ce2c421.va3-iad.github.net [10.48.157.17])
	by smtp.github.com (Postfix) with ESMTPA id DA95B8C09F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752527849;
	bh=isO5/vtDc9gIz5LlaJOPZkAeD4qH0Ah5jsIvu77PwpA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ETzY0G4OgdMqF+sMZP++tREVsEPXuoeRbhHMWLKAFfOKCeRmmDvywYjkHfH+O5P3Q
	 dwJnTbCTRV8krddAzum/YpM5iMOAEuQMJGwqNEKqjYtYU1f4rw6rvfLta9qVCi3Ssz
	 B7ZnWqKX16H6rUKQd9zSGedqaOHo/25dqzhWRBeg=
Date: Mon, 14 Jul 2025 14:17:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982181/33ec72-000000@github.com>
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

  Branch: refs/heads/982181
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
