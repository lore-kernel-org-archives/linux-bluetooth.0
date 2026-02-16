Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B417A2F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261735; cv=none; b=SQQ6VDbYiZ6uc8eX5pN4P52jP2w58itVDzHtvOXwo88ho0RoDVt2qwOMeP020HWJ015qF1gn+6WyCl3B3R+kCLklHfybaa/JeqadkWVfahT3aFlzPxnnp4woWMdUeEfA//7B4tkXI18xzO/uhoK8FPgRHSHYc8ORl4wCIW86lRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261735; c=relaxed/simple;
	bh=oqgQhLV2gRAQaiaGH9LlB8imGiHZoWypo2wOhOVJqFk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ABB714YWCbnrb+a0svCfebirsNVNKHKzmxeJYBS2QVk/VIw0d4hEfnvGfsyvaU6kA1tkYv7+vimtMplIwAjUuvYyKRU08IksiIaaLC26jrpElVEg9H5Y+OD/Bp27Ihe5YxUCQ/f10ElEcjhYgqR58iAAq40k/u52KOrLaF/4jGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QzOOkQOw; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QzOOkQOw"
Received: from github.com (hubbernetes-node-8626523.ash1-iad.github.net [10.56.225.26])
	by smtp.github.com (Postfix) with ESMTPA id 0534E14082B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771261734;
	bh=0qUnWfnJYpnxSy40eem7uHv9zC972FHZYHxppVeLZsQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QzOOkQOwMwUTJV3Eo/1KlgOzHbA5+IdxiU2Ka/tkwsr/tZu17dvjKErVKkyu2PrO0
	 qTqj3PMdDM/4+t92pvKCivAs89IGm7gR2zXpz4P3z/sjwXqPLAxHYAAv5vCkOOT6QO
	 TmxdMELC/Y2Y37GtxRCFcKGupeQgmrvQIxq5qqZw=
Date: Mon, 16 Feb 2026 09:08:53 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054634/000000-50e9d2@github.com>
Subject: [bluez/bluez] d72e51: tools/btpclient: Move btpclient to
 client/btpclien...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1054634
  Home:   https://github.com/bluez/bluez
  Commit: d72e51c696f5558a6e8610d971cd9268e6941f41
      https://github.com/bluez/bluez/commit/d72e51c696f5558a6e8610d971cd9=
268e6941f41
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M .gitignore
    M Makefile.tools
    A client/btpclient/btpclient.c
    A client/btpclient/btpclientctl.c
    R tools/btpclient.c
    R tools/btpclientctl.c

  Log Message:
  -----------
  tools/btpclient: Move btpclient to client/btpclient directory

This prepares the split of btp services in per profile files for
easier maintenance.


  Commit: 1bbc0b8ad95259f8a780a17ff80a2e898014f84b
      https://github.com/bluez/bluez/commit/1bbc0b8ad95259f8a780a17ff80a2=
e898014f84b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    A client/btpclient/btpclient.h
    A client/btpclient/core.c
    A client/btpclient/core.h

  Log Message:
  -----------
  client/btpclient: Move btp core service in its own file

Moving the btp services in their own files will simplify maintenance.


  Commit: 50e9d26760c85913a057fde324c47a6871da6d4d
      https://github.com/bluez/bluez/commit/50e9d26760c85913a057fde324c47=
a6871da6d4d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/core.h
    A client/btpclient/gap.c
    A client/btpclient/gap.h

  Log Message:
  -----------
  client/btpclient: Move btp GAP service in its own file

Moving the btp services in their own files will simplify maintenance.


Compare: https://github.com/bluez/bluez/compare/d72e51c696f5%5E...50e9d26=
760c8

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
