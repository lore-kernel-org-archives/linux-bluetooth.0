Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A8364EBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851305; cv=none; b=JSPCVzFiHkktirGNygytZcXneEkZd/t6ptfTEaD0pxO4xV3ZbhWE05Z1QM3gLT0X6J/JNXJZFznxxuQTg4zhJNMj9rha/N59AktmY0ZS9AX/YoJDvqMglvVumyD5o8H4DIr0ySVJQYg1EN6MtFuIqskFntxDPWqpaCEpz7ebNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851305; c=relaxed/simple;
	bh=WGG7/mg0spZ5w/d64/ymyUNt/SB5wQ7ZP64jpMQMDx4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hTXlhTaDyRMVe9YrLujuJy2kSSdMtT5Zm7uJz52MB3y5CnRTYj8BUnoUZWbAhXktXuao0UAl+yUCdqo9sDaEgoXdIgqRRe5sx0Y74aLRGb3WU+oLcoTgauL2CMnGaa98yAQ4XqJ0FMQHiKvlryzSWN/Tt6nBDgexUJNdQpfzYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gU7eV4Nw; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gU7eV4Nw"
Received: from github.com (hubbernetes-node-873c785.va3-iad.github.net [10.48.142.39])
	by smtp.github.com (Postfix) with ESMTPA id 439A73C1308
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 04:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771851303;
	bh=EQum2ljfWEQgGm1hf+/tudrXQrb+ZwCWFz7qiXg/pjo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gU7eV4NwBVmntxtNAhy58CUdqbueZFZj1lk2rc+asYQwd1sNmywDb97ZqbAbfavHB
	 4JoqSqkNp7gEYfsOuRiMVjz5k22DD9mRi8K9byU7ieLQtzSNqr3W2Fl8UtY7mFrhnf
	 av2T+zmC/NVVyvl6ppqbYVDNatlrk/EQYi7Jxa2M=
Date: Mon, 23 Feb 2026 04:55:03 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1056469/000000-928fa9@github.com>
Subject: [bluez/bluez] 928fa9: shared/bap: Fix endpoint configuration
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

  Branch: refs/heads/1056469
  Home:   https://github.com/bluez/bluez
  Commit: 928fa9eb095d4fef96668541b17312e5800d6de2
      https://github.com/bluez/bluez/commit/928fa9eb095d4fef96668541b1731=
2e5800d6de2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-23 (Mon, 23 Feb 2026)

  Changed paths:
    M profiles/audio/media.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Fix endpoint configuration

When a first local endpoint is created after connection to a remote
device this doesn't trigger the SelectProperties request because
bt_bap_bac ops are not yet set when bt_bap_select() is called.
Creating a second local endpoint allows to trigger SelectProperties
request for the first endpoint.

This commit fixes this behavior by setting the ops during bt_bap_pac
creation.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
