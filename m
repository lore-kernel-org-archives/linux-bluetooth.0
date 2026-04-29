Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072740B6C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482003; cv=none; b=YhahN3oHfQzN2XISDiZKonTdsAvrcZtqzzhfwAzJwI6UehdFNFns8JU7Vd8SydYXOnzLyn4QoW7M+CKPK93q2PkpKQ/VYpDeukn7TWMXdPm0xr16zGQ1gTD0VJKnvCYBgojJfYzO6svqCDSdkTS1SKzFVYY9VVUYLVs5kVbLiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482003; c=relaxed/simple;
	bh=UTJXlURM+m9NGklDjG2+Gd5C9lY6a7KY856nxXan2gg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EER06RZzAlMOQOX9izNBXb2GNl7Y5sWHD/b2avVhdWUWBjcSclp1QwX4SbG9KfIG2xqziVH+xjiMmVGnX8tNAZo8TJU+DENIf/JzkxEe8qR4yKpS9NEMEUPwA2OqsviAzdQerHDIQCA2//OJFvyQcg6akbBB9Oup7jWq485e7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N2l4DowF; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N2l4DowF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777482000;
	bh=CtRt0Px5m65v03bXjCGkPOai7CQbjBe5xV9ZmN8xwRI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N2l4DowFhmZ/NsWgFwfXiBkAwZuyNdkH0KH4VvImlmJ2lh+f1QJpvdAIVFJJyms3y
	 FOQ/IA+Esidei1q4RXUwYoQLDDANj64c9TDqo3NiJmkH5UngM2hZyCsHtKrtTPW+a9
	 p8Zf3+r6WlYT0V5MxS9PKPKOW0h7PqX5qdW2QM3M=
Received: from github.com (hubbernetes-node-e0b359a.ash1-iad.github.net [10.56.184.35])
	by smtp.github.com (Postfix) with ESMTPA id EE396360FE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 10:00:00 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:00:00 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087593/000000-ef82bc@github.com>
Subject: [bluez/bluez] 62ddd2: src/shared: Add RAS packet format and
 notification...
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

  Branch: refs/heads/1087593
  Home:   https://github.com/bluez/bluez
  Commit: 62ddd2ea0370831d471a189551380c197e076a6d
      https://github.com/bluez/bluez/commit/62ddd2ea0370831d471a189551380c197e076a6d
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: ef82bc92632ac28d2a435938ddf07614db4518e9
      https://github.com/bluez/bluez/commit/ef82bc92632ac28d2a435938ddf07614db4518e9
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members

Rearrage reading of cs_mode_one_data struct members as per spec.


Compare: https://github.com/bluez/bluez/compare/62ddd2ea0370%5E...ef82bc92632a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
