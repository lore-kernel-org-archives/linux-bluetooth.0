Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E22E266B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986831; cv=none; b=G/n2fFEuPVK4zQoTLaKyd5ahIi0N/FQOo3rORJwGG/i06ujviMhT9qCNSKGkfRIY0Rj2CDTmF/+3GA72mgkfzSSF0SSKbd8tNGMt3L4KYDOrZTjpBQ52MNAdYvygEKccvJxWwJmQJRya3XhHw/P7Xc5a6t4uPKJ+Q8kmChWbeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986831; c=relaxed/simple;
	bh=7Xn4rwM2IAApKqTp8grkUYQL9uNKSWcQTi1SSMizwwg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oUSgDWoUsnVFDHoNRw1Zp9oW99MzzDjeSlc0HzOMhOZj1bK4frDwZiLNadv5gf4ThJfE2GxkfZ7Eygma68ol7miYaNikOkTod9/7UFJlWdR5Ow397ac0t8wfWkr6xRJCawWoQPqVT25qmB+/0Ln/r028D2wEw0pt8fzSHP4ftds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zr0aQs8v; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zr0aQs8v"
Received: from github.com (hubbernetes-node-eb75fd8.ash1-iad.github.net [10.56.200.80])
	by smtp.github.com (Postfix) with ESMTPA id 7221292166C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751986829;
	bh=zA1TtUPZUhntUatsIZ11dBjwXhhsO5oltm0pAWgFOF0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zr0aQs8vbJLGMQo5e4LvYBPr0tTDdi0j8xgBhp7cLSxg8HfNU+c4U4nzR5xOMkXyo
	 O0WAKnePFsaD/0BqsWykvKaSmfM+L/inkOTAQAgiK3C447oqGMsZZYpZH822JW1FNe
	 PrKYZh7SRdU07XJfjo5waZuiG5J3DVuHME1JZXGg=
Date: Tue, 08 Jul 2025 08:00:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a5d517-a7e074@github.com>
Subject: [bluez/bluez] c1d4c4: bap: fix memleak of bt_bap
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
  Commit: c1d4c478c40d659f1b76bb7c38034dc161528e3d
      https://github.com/bluez/bluez/commit/c1d4c478c40d659f1b76bb7c38034dc161528e3d
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: fix memleak of bt_bap

Make failure branches deallocate memory before leaving.


  Commit: f6dcd1d2bd71ee8c128673241ff5771d364ba732
      https://github.com/bluez/bluez/commit/f6dcd1d2bd71ee8c128673241ff5771d364ba732
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix memleak


  Commit: 47ffe6086f371f023aec4200178f6f1eaa6363f2
      https://github.com/bluez/bluez/commit/47ffe6086f371f023aec4200178f6f1eaa6363f2
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/gatt-db.c

  Log Message:
  -----------
  src/shared: move null checks before dereferencing


  Commit: a2d7be18ace6a4721d89511a68f4aaed9962dd6f
      https://github.com/bluez/bluez/commit/a2d7be18ace6a4721d89511a68f4aaed9962dd6f
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: remove repeating conditions


  Commit: a7e0747e21de73b604e87f6b26355b0781469eb1
      https://github.com/bluez/bluez/commit/a7e0747e21de73b604e87f6b26355b0781469eb1
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  plugin: fix args order

According to other functions and arguments usage, the
case with external_plugin_init seems to be erroneous.


Compare: https://github.com/bluez/bluez/compare/a5d517dd4134...a7e0747e21de

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
