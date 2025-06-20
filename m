Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12928C2D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427796; cv=none; b=TM2T+qPiFCG/Vlc3gA+RRabf/MYVsSdWyLuZleF9i8K/fHjUEcGK6PVxJBGW0ZEsO1SABxgPVmIiaOHEznaFL2OH6v8xbeu4FvL0F46Y/PDDw3keB4M4RaCVH1GFkqMaZaRq7BY/yCGMAol9HxAoGnwA3i9jpKDTFoqvYs9SSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427796; c=relaxed/simple;
	bh=+AaSufu5z7tLcMgvyIYW7LNZxIQA1TlwHRjJm7WWrmo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dg90lLVjdNiXFnPV6HiWenzrdarq4zCfOdzeaoC/A+YtOewFWBW50jFB6iKOeVYo+j9ZgvgSVkNGwN0c6olhfgRvqVPFFHDVfu+34xKm7uDufktsLmz3+Mqt7dfUyFbiwctypZbs/wn2hJ5CAtAnTcikGmqMtbQPDcnHXqXfDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HQZuDAdm; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HQZuDAdm"
Received: from github.com (hubbernetes-node-ef43804.ac4-iad.github.net [10.52.179.52])
	by smtp.github.com (Postfix) with ESMTPA id 823F4202F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750427791;
	bh=emQTRrmA62JekWnopLbSVFMGLgemva0CXkqjqMC6BmU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HQZuDAdm/B0lGhnKVN1BjsXjfDTGPvjZAscPjBV8NMRHfKoIOk6Zs3Wuse5UgRWPw
	 ubooaxbLh/PsazJu7jARJqo0/2eWAkrlu9EwYgnYmAqdoD8QOdi6a9kKvCIy39XmRf
	 yypKsKoU0AfPo4NgKyWN4QJM0MtwJy8ovGh5qG+0=
Date: Fri, 20 Jun 2025 06:56:31 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974291/000000-b53127@github.com>
Subject: [bluez/bluez] 3be28f: shared/bap: ignore NULL attach/detach callbacks
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

  Branch: refs/heads/974291
  Home:   https://github.com/bluez/bluez
  Commit: 3be28f8d3982fff7e58d553883acb144e6568e49
      https://github.com/bluez/bluez/commit/3be28f8d3982fff7e58d553883acb144e6568e49
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: ignore NULL attach/detach callbacks

Allow registering NULL attach/detach callbacks with bt_bap_register
for cases when one of callbacks is not needed, e.g. in tests.


  Commit: 672f18412da47732a438b6eb32a31b4496934e58
      https://github.com/bluez/bluez/commit/672f18412da47732a438b6eb32a31b4496934e58
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M unit/test-vcp.c

  Log Message:
  -----------
  test-vcp: remove unnecessary bt_vcp allocation

Do not create bt_vcp in test_server since it is not necessary for this
test. Also register bt_vcp detached callback to unref and free
objects created by vcp_get_session.


  Commit: b1b39500f36dd34296e8ff6312248fcd9622e0c4
      https://github.com/bluez/bluez/commit/b1b39500f36dd34296e8ff6312248fcd9622e0c4
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M unit/test-micp.c

  Log Message:
  -----------
  test-micp: remove unnecessary bt_micp allocation

Do not create bt_micp in test_server since it is not necessary for this
test. Also register bt_micp detached callback to unref and free
objects created by micp_get_session.


  Commit: b53127f08e2c1015ee01b417b68475a55e280864
      https://github.com/bluez/bluez/commit/b53127f08e2c1015ee01b417b68475a55e280864
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: shutdown tester IO before test teardown

Some tests may require shutdown of tester IO for proper teardown.
Add function tester_shutdown_io to accomplish that and call it
automatically when test finishes.


Compare: https://github.com/bluez/bluez/compare/3be28f8d3982%5E...b53127f08e2c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
