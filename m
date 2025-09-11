Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC553101AD
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587374; cv=none; b=tvUujIgqQyh4o8jHaJ51AcuxZdE4Qf4VyGv+F4HfQnY99uLCZjKitx5A6g+hOvEuBbaPOYiIl8wJydLWJzSW17IOwHw/EOynpeN4LhqHzutIokRHANMAc7So8dISWcVz9hhfzPkuHUMttZVsQ1yxdZnn87hQG5jHLE24PZ8ObAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587374; c=relaxed/simple;
	bh=G8i5itB5n+rNsyurbAu8GhdhbevR0oAWEYRNzA/D9B0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NC5jnNmfwEPxhw3+5fgIF8h+T5yKDgqbqeLd6cdAOPLvd+t2kxqjxZPKwatIWcwFOvjq8Rupwr/qizt/anG7WkuiDumtGS+nb6/Vo80w4jsqBtsn2Kdacza0inKcgHf+d/L9/Egll0f5JhPIbtEgf9a5X7ytorWa7x23EWEe1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=erJNcdJA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="erJNcdJA"
Received: from github.com (hubbernetes-node-31b3d7a.va3-iad.github.net [10.48.178.39])
	by smtp.github.com (Postfix) with ESMTPA id 0384A8C06E5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757587372;
	bh=7BbyYTpJQzVSemj11D3Emh1NEaAFbW4ogfsnQmwytbM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=erJNcdJAq9uWYzXarzZApz06lazevBf/VO/x86b8cFKCW1xBGndMqsxxWS3GdDRs9
	 VwNc4TNRSCuerIgXEJaQXwGeUJQesvFkoVOpEhPUmxC4LPWqS1CNaEce3ji/xzyjae
	 w8CiCYZxDoNKY/JxS23/nQnTDdhZ0yrEa31//9Q0=
Date: Thu, 11 Sep 2025 03:42:52 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001291/000000-6b4247@github.com>
Subject: [bluez/bluez] b79d2c: shared/hfp: Add Operator name support
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

  Branch: refs/heads/1001291
  Home:   https://github.com/bluez/bluez
  Commit: b79d2cb9de144e30c87ce89af547e5f787b2cc03
      https://github.com/bluez/bluez/commit/b79d2cb9de144e30c87ce89af547e=
5f787b2cc03
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Operator name support

Send AT+COPS=3D3,0 at the end of the SLC creation to set the format of
the operator selection to long alphanumeric, then query the currently
selected operator name from the AG.

Register +COPS handler to call the update_operator callback on event.


  Commit: 89e0dd83a8b141ef7229a0e825a0b0a8bc93168f
      https://github.com/bluez/bluez/commit/89e0dd83a8b141ef7229a0e825a0b=
0a8bc93168f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Operator name test for HF

This add the following test:
- HFP/HF/PSI/BV-04-C
  Verify that the HF can query the currently selected operator name.

Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
callsetup and callheld indicators at connection time.


  Commit: 8c0d2fc8cb841a8943ee6127b77dbd48f4c282fb
      https://github.com/bluez/bluez/commit/8c0d2fc8cb841a8943ee6127b77db=
d48f4c282fb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Call Line Identification support

Send AT+CLIP=3D1 at the end of the SLC creation to enable CLIP event.
Register +CLIP handler to call the update_call_line_id callback on event.=


During incoming call notifications, i.e. after +CIEV:<callsetup>,1
event which creates a new call object, the reception of +CLIP event
will update the line_id and type of the call object.


  Commit: 6b424722aa82bf6b389dd6c675e94e19c8d86519
      https://github.com/bluez/bluez/commit/6b424722aa82bf6b389dd6c675e94=
e19c8d86519
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Call Line Identification test for HF

This add the following test:
- HFP/HF/CLI/BV-01-C
  Verify that the HF receives the caller ID.


Compare: https://github.com/bluez/bluez/compare/b79d2cb9de14%5E...6b42472=
2aa82

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
