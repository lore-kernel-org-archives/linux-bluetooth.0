Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6935230BD5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534776; cv=none; b=DKuHy8kn3+rQlFxqPgAXqSh1Aw7S/XVA69hsFownjZ3iD4HQV7DtFMVIJZ4380amVWucKusFjxz57hJhFvBsMpD6ClRi3U9pj6nxK9reIu9u3/GRx8rjYPaRaDoHpsU2KxmI2KvG5H8Pz7imqB9YgSsiLE/Qoa1WAZ7pvEQFkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534776; c=relaxed/simple;
	bh=KxL/JcGfgYL5p1BtxGmjI2vLgVOJxo4v/F3Asufexsc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l4++e1qLkf/AYbE/kMTVv9QkVMEP18ItO/7xcQDnc20tXftsFfBvD1uWDfqTrpo3auZ2qc5UZAeVIg3NR1q+iDyqRJoexWrJhea8GupHjN6bNfWZMjamCwRm3qL817MmyWE3Nmd0YV87QDzcgXSlMYKMSXM5OguUNRGXOSiB820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FJOUtWqg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FJOUtWqg"
Received: from github.com (hubbernetes-node-9093575.ash1-iad.github.net [10.56.201.93])
	by smtp.github.com (Postfix) with ESMTPA id 1A7FF1402CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534774;
	bh=Lnbaw0TQQLLnRcKzv8uDadUZoXwIbY45bW6bNqHdxHc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FJOUtWqgneaVXHFGXi6vNCLTuoEGRxR6FJL5iwzX6FYj1ljfxV7UiOM1WmTkN/u1e
	 YtS4VxEtXABpptxAlnzN9AOnTKqfQfkEOdfXKfrHT87I4sZXSfcWnxUAiOJFYKJlqB
	 70KGVQP5uyqXE6R8myjGuJ+7hnYrjzFUG19fB3fQ=
Date: Tue, 27 Jan 2026 09:26:14 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047686/000000-11c867@github.com>
Subject: [bluez/bluez] 11c867: doc/qualification: Add PICS and howto for the
 AVCT...
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

  Branch: refs/heads/1047686
  Home:   https://github.com/bluez/bluez
  Commit: 11c86777662491c73369845b595c618f5b4f698e
      https://github.com/bluez/bluez/commit/11c86777662491c73369845b595c6=
18f5b4f698e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avctp-pics.rst
    A doc/qualification/avctp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVCTP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
