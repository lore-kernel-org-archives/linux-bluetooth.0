Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C9391822
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424603; cv=none; b=i9s/aFFDAzyHid4geMYT1ymAtpoH1M7zsK0YViGwASXmBUbu/fw6Mr7MiwfUE5yekCFtkyXEB/JV4QvrYof6zXvneW5ybVoJujnJqASkvpRClkva0qyXE6nbtV9QL5zNQ0pCpxljUAS8Njap34g9YvtBl9CdV89KIxlfP++NEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424603; c=relaxed/simple;
	bh=DD0NvAA3bCxXxiDgGBYCUojDwl5rJLVl8rbRAGiLhmY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cymbpMZ+Mf8XDHBrVIhgtUW2jkrE6kd8Q7MBxC6lga9UaLR8eI6Dgd7TwNnOouM0qCT4T0yKehZEgNf6YTE/odbgViJqWmxTMrNQ0nbua0t7cS7QyIEvMYwIoRBDbRNzpZGK+PeHaRrwIT4mZncPDaAgsyXFVyf7RIU/NVSQKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eZpUDwGx; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eZpUDwGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780424601;
	bh=HibTzPlD9mT2/NOVfS0Tj72tdYGKvnP7RQBTwZyNvPg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eZpUDwGxUsvy62Ze4kA+DEnPAs6nSSvOxWp5i9vkUtY3IKznTZ5YXZ6qZV3bWKvoo
	 CCnN0VB4ubIKcxj+Ek16NnH9G4zP8A9lcn9JcsBrl3gbbGvE+9FOR02KBM/VIhUKGa
	 QJ9S8IvBUzw91pMYBRSvvmB5miVTI56qd7DmK5jU=
Received: from github.com (hubbernetes-node-8dec1ad.ac4-iad.github.net [10.52.170.38])
	by smtp.github.com (Postfix) with ESMTPA id 3735A32045A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 11:23:21 -0700 (PDT)
Date: Tue, 02 Jun 2026 11:23:21 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e2874d-07b6fc@github.com>
Subject: [bluez/bluez] 96a51d: client/btpclient: Fix GAP unpair command
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 96a51d53ccf3f3e443c524478c8c697d1a2dd799
      https://github.com/bluez/bluez/commit/96a51d53ccf3f3e443c524478c8c6=
97d1a2dd799
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Fix GAP unpair command

Fix unpair_reply() because the device is no more available on
RemoveDevice reply.


  Commit: 07b6fc156348bb515ac0a876d49644312c9476d6
      https://github.com/bluez/bluez/commit/07b6fc156348bb515ac0a876d4964=
4312c9476d6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Don't remove all devices on GAP Reset command

Currently running auto-pts remove all paired devices, instead of just
removing the PTS devices.
This removes this behavior, expecting auto-pts to explicitly remove the
PTS devices using Unpair command.


Compare: https://github.com/bluez/bluez/compare/e2874db00a40...07b6fc1563=
48

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
