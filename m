Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D32C190
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727846; cv=none; b=sWh+2UHRzShQRSeOGOiyMJh/3PFfkbbrE811A+uH/FxVK14pXkBu8tnw9MSuwCBJFdfuy+zyQznmQIVxEKnqQU1WKb4t4WXW8aJ2NNN5Lul55nUBVQEj14j63AjYwWwYeIDMIYCjwMRjOq/peKYc6k4W3J0oSzyeyjlI8uILsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727846; c=relaxed/simple;
	bh=wFbESdm4n3Nep+8CitsqI8GkJZpBD0gff+vNzvsA//Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PHhjycbsTs9UMU9FrbnZfgMlYy5TKWpYkoTytnwgGMYxfI9tzQvdU9zF37ziAOQNpSy7GtKVf0rTif8M/G7JdPHl+7ElbXNn1E3pRUwZrt9CBuLKya75cGNmwpAlo2//hWdCv/wAwXkMlAOh5aC6wkwOLF4owHHArDGe0Hl28/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E1p3VQOy; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E1p3VQOy"
Received: from github.com (hubbernetes-node-43e8970.ash1-iad.github.net [10.56.224.77])
	by smtp.github.com (Postfix) with ESMTPA id 158656004F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 18:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750727844;
	bh=xy8tD2TLNNlPrv+mPdRqzlg0PxDgdJmcR5msJC0S2SE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E1p3VQOycMITRSOVYNCWR1yjJQDCuB6r1xJuBLxQg6afhCGJ7/PYf4TmKnzzNQMqF
	 CnRBu8B++mE9qBfCiJ6eZ6kbdterz8esq2fX3VbsrXZceP9xLYyEhQDkWBYecTgqci
	 qnStd01YNKHJE5y1ItC5XmS1UNmXW6f0NLwOHwY8=
Date: Mon, 23 Jun 2025 18:17:24 -0700
From: Ronan Pigott <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975068/000000-a00c4c@github.com>
Subject: [bluez/bluez] a00c4c: zsh: amend completions
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

  Branch: refs/heads/975068
  Home:   https://github.com/bluez/bluez
  Commit: a00c4c12500a5356f9a24b6a07c2b511ae42fd92
      https://github.com/bluez/bluez/commit/a00c4c12500a5356f9a24b6a07c2b511ae42fd92
  Author: Ronan Pigott <ronan@rjp.ie>
  Date:   2025-06-24 (Tue, 24 Jun 2025)

  Changed paths:
    M completion/zsh/_bluetoothctl
    M src/shared/shell.c

  Log Message:
  -----------
  zsh: amend completions

First, use the correct completion return value.

The return value of a completion function is significant, if we fail to
return success additional completers may be invoked when they otherwise
should not be.

Also cleanup up the zsh completion, removing the redundant definition of
_bluetoothctl and using the _call_program helper where appropriate.

Finally, update the bluetoothctl command invocations to account for the
media lines printed after some of the non-interactive commands.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
