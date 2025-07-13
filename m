Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3672581
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752429278; cv=none; b=nqoI8sAIlcqmqBjG/0zWpTy7/NkW3g2Bo2ZTCSe5ytbIy/+51K363a4f3VeVtWea+zRuFL14NS+0xxDigOEjz3f4iMhjatsyJCUxrNFDqAOdJ3k3fTE8Fvj08vBCgPllDF/OfeHaZPWmUk4QATWJNUGenaZgJLColJu+fTvkkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752429278; c=relaxed/simple;
	bh=hQTpEThHdAmn6FeqxHv9TBWYTOg1pTWy/DQN23qvuQw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Pajp2dUEhhkzxwhzysiXL7n7dNnMqB6r3hBcN1CwGJfrCX08MJnxkYZfBYt0zQ8bnvm4X3Hyp+x2tMs0E9/J2xrfqy5YS/MMp1GcqTD4KnNQ0VhY6oIXkmYVG6+7Z5KO2I3DGNjvbsfGI1h/hC6Swnv1wha7I4u8foOjeUKG0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XynsrtXx; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XynsrtXx"
Received: from github.com (hubbernetes-node-50bb8f4.ac4-iad.github.net [10.52.138.36])
	by smtp.github.com (Postfix) with ESMTPA id 8A61A6402F2
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752429276;
	bh=2hRDjRC6pWhSeOggr5cNMtEEH0SA/+SN+Uxjxfo2jvQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XynsrtXx/wSb2fTtheelha5e6jh1R7Ks9TL2mTm/H8HaZ1ZCzS5mKEnb5tpzSLzs6
	 cSQSBYPn6SatIVSCnrRWFtzoOPiEpNNa99zPQg73Oq5R/q3qjietw8lRr1hvKxdsSH
	 mQwvWTlIsBtYYM015GhUIm+PmjDluvmsyut+9WDg=
Date: Sun, 13 Jul 2025 10:54:36 -0700
From: anteater <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981848/000000-e0bf89@github.com>
Subject: [bluez/bluez] e0bf89: obexd: clear pointers in `phonebook_exit`
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

  Branch: refs/heads/981848
  Home:   https://github.com/bluez/bluez
  Commit: e0bf8908184ec1139cffe56493b177872d2aaf4f
      https://github.com/bluez/bluez/commit/e0bf8908184ec1139cffe56493b177872d2aaf4f
  Author: Antonio Rische <nt8r@protonmail.com>
  Date:   2025-07-13 (Sun, 13 Jul 2025)

  Changed paths:
    M obexd/plugins/phonebook-ebook.c

  Log Message:
  -----------
  obexd: clear pointers in `phonebook_exit`

This fixes a double-free which segfaults when dbus connection is lost:

    #0  g_type_check_instance_is_fundamentally_a (type_instance=type_instance@entry=0xffffb55201d0, fundamental_type=fundamental_type@entry=0x50 [GObject]) at ../gobject/gtype.c:3918
    #1  0x0000ffffb52712c0 in g_object_unref (_object=0xffffb55201d0) at ../gobject/gobject.c:4350
    #2  0x0000aaaac63f4798 in phonebook_exit ()
    #3  0x0000aaaac63f83a4 in plugin_cleanup ()
    #4  0x0000aaaac63e0ae8 in main ()



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
