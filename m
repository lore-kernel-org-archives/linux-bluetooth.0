Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E41E9B39
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542020; cv=none; b=cHRRZC6iiEn0d4JK1gmi/Fgm0rM7RG3ZZGlTfhI+hLJMm1+DTN4DyhhpROKRLxvNGLYry3zMGRdvn9rwyUuC5LpQR3VKOAV3btNevZW2GSr/EUxXxrwZ/2KWQ3EZ0krg2/wdAc4atrc8R5x/8Kd/1Dj5n/Lhr9+h8IvNYBaLD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542020; c=relaxed/simple;
	bh=Uv9t4RXL/D26E8IioWeLYyntny+mr15gDbJqkBr/Eog=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AWQR2E1y3fr4XN6IZ0lBH96xdjO4CmgWEm84kcFtLRjiWYoHVLxDwJq8I+9vLx+lHMFtwZ29FVceCrC2GbbIAyD9dKdM5PJwownp4AvfSbNguMsrst65ie0HgPn2ll9hQspPlkojr89YzhaaE2fHaAS4pznslktR7MFlrPGUSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TE651qpI; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TE651qpI"
Received: from github.com (hubbernetes-node-aee6549.va3-iad.github.net [10.48.141.40])
	by smtp.github.com (Postfix) with ESMTPA id 51804E0AE5
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743542018;
	bh=A0n1eXy55EaREylmbn7TuLzvhBdNamDxh4aCLkb5Wiw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TE651qpI5yUVlBtG66cSLC+mcHsRPJgNomZ2FhtsQCxIoS+E2ixGboBgoQwA4xifu
	 fgtUPQmaZfDaSP0pZkkG1C4CsBUTzMSwENzLTSI+Tf06ieAPIC/2ys49hhg/SBqBKa
	 hJ7O0H3uiaCPFkuP/c2b8cjdF9RHzuPUBauuOc/c=
Date: Tue, 01 Apr 2025 14:13:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/47e5d3-6d20a3@github.com>
Subject: [bluez/bluez] da5846: dbus: Fix condition for invalidating path
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
  Commit: da5846c096cd1006d512bbdbc466fc46a61417b8
      https://github.com/bluez/bluez/commit/da5846c096cd1006d512bbdbc466fc46a61417b8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-01 (Tue, 01 Apr 2025)

  Changed paths:
    M gdbus/object.c

  Log Message:
  -----------
  dbus: Fix condition for invalidating path

This fixes the condition introduced in cdd02afbb7ef
("dbus: Fix add invalid memory during interface removal") which was
reversed while applying the original fix.

Fixes: https://github.com/bluez/bluez/issues/1155


  Commit: 6d20a300642f312290af0bc9869a0e1b416c58dc
      https://github.com/bluez/bluez/commit/6d20a300642f312290af0bc9869a0e1b416c58dc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-01 (Tue, 01 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix swallowing states transitions

In certain cases (e.g ASCS_Enable) a Control Point operation may change
states multiple times causing states not to be notified.

To fix this attempts to queue states if timeout is pending (state_id)
and then proceed to notify them ahead of the last state set in the ASE
so the remote side is informed of all the state transitions.


Compare: https://github.com/bluez/bluez/compare/47e5d3491d37...6d20a300642f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
