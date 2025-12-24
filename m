Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D334D3AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587689; cv=none; b=d6IkpabqUEbZgeDUbWO/qn1pmA/Zk1E3wYkJ5im5fzYzjcLLiBvOxvPBsAAupwZekvDTNLU40O6A2i5AT/jFkJkQWaqEb1YPQTWnOycmv4j6cHErn/2sg66bQWsADY9T2XxWMHj/Lhu9BViAd7SA3G1xduqhARnaaOLOjkNVFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587689; c=relaxed/simple;
	bh=lwZ6FjF+9ALdeB7hWGC1nNGOeLbBiuMjOISfrOu+iQw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DCtCjVc5Bm+KALgbSsLfhPr+4J3Ohrayug+3xVHOEwLdb13eotdoX44+kdO2nEhtlcIPKKIAQ9GHlkxyJxBoT9HVCU4iyAKnvXL8HxUHD89A8BPMmePMlZ7MjM65Y3JZxoVfKZjOuBipJNUTNxZUsmICuHfFL+jF9KCyO18LmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A/lRyNzm; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A/lRyNzm"
Received: from github.com (hubbernetes-node-fd43568.va3-iad.github.net [10.48.204.73])
	by smtp.github.com (Postfix) with ESMTPA id 668D9E0513
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766587687;
	bh=70+//1Df3NVL7Al8SDpH7bLdTnZ67ApJIX4Lw6oGqRA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A/lRyNzmbwjW3zqQ4dNb02nZMfnEaWi+Ki3pbzcceR8835u6X19pQO7b95bf356s3
	 5P1Ad73JZKipjBLuVWNBawNXhoXL7np/ar69BDxWRDOvdclS0RopW2U4GhKGN8Z0rW
	 +6FMVYAYoh4K9jVHA3igfbWhKsnV1OWhXPgY9x4k=
Date: Wed, 24 Dec 2025 06:48:07 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1036434/000000-21a817@github.com>
Subject: [bluez/bluez] b6fc31: shared/hfp: Add function to get multiparty call
 st...
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

  Branch: refs/heads/1036434
  Home:   https://github.com/bluez/bluez
  Commit: b6fc31421f576ecf78b762b539f78d103266f459
      https://github.com/bluez/bluez/commit/b6fc31421f576ecf78b762b539f78=
d103266f459
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-24 (Wed, 24 Dec 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add function to get multiparty call status


  Commit: 21a81713265b389a141207aa5e8cf40b234e811e
      https://github.com/bluez/bluez/commit/21a81713265b389a141207aa5e8cf=
40b234e811e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-24 (Wed, 24 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Update multiparty status on call creation


Compare: https://github.com/bluez/bluez/compare/b6fc31421f57%5E...21a8171=
3265b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
