Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D127280F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838471; cv=none; b=SWsvr8Pmc3kuGdOcqT3NypF9u7pvaHR77E/3MUSjpaTg/J6gQ3gRs3DSLxIQA/QHQJW9PAKnrDvN0OphHNy7GyaG4Mwez0ZIsWDXjPtUJhdC8PdbvHTfg1grh9LmQdhhx1K4eOzGzzmIdCxPZA0ahK9DQDFZ6i837mXaBVwkMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838471; c=relaxed/simple;
	bh=4ab5VRi1fph8tBB/c26phD4fVBRJlwKCTKpDic2YYdM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eRJrZUyFy2ln/RhRSD8vhnoPVAuOFhrOvC2vIu3yWZuRhlcfW3qonNILffK3HR/LSXgZ6Y3xGtAh34cWd2f6hbmYUEPXAgOWKQr8saeF1Z/QyQX5sW9Oe+Wg00m5fUoVnBiE1QyCvf153QOjQ09gfhqlKEuYFyHTh8YZB0FN2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ds59KJ8q; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ds59KJ8q"
Received: from github.com (hubbernetes-node-5f3a108.ash1-iad.github.net [10.56.178.11])
	by smtp.github.com (Postfix) with ESMTPA id B6776920C29
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768838469;
	bh=F7NOstOhncOfECmT694tWk6Auw1GaQZ96W9u7DtOym4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ds59KJ8qb5xcsGrItL7ImhFycfqmBSVUhizYZ/OIOliZQVaAkuqJWYyjDhNNEkf0P
	 nHiWn+8Zcl3Il6a5SGxxdy29JLeeqETAEuOEz4guIxF/b2nb/2evz/rMX3uu+DjFJd
	 P9XElBzKZNcsF5BWrTsuvAbqYn6G6L0A0kRKFxHs=
Date: Mon, 19 Jan 2026 08:01:09 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044232/000000-89c24e@github.com>
Subject: [bluez/bluez] 89c24e: doc/qualification: Add PICS and howto for the
 L2CA...
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

  Branch: refs/heads/1044232
  Home:   https://github.com/bluez/bluez
  Commit: 89c24e9b67a04a0f0fe7a18099f4cc130b7eb859
      https://github.com/bluez/bluez/commit/89c24e9b67a04a0f0fe7a18099f4c=
c130b7eb859
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-19 (Mon, 19 Jan 2026)

  Changed paths:
    A doc/qualification/l2cap-pics.rst
    A doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the L2CAP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
