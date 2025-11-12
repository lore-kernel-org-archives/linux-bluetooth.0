Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF334A77D
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974055; cv=none; b=MOj5xQuu3YlwKSMRF3WdevKg84VqTwWQ3L4FE4M9qNI7lipKxcl+jC+QBNvdycLH7WQrxYJrMQ0TArxCItxR1wUzuUN+1no3dhe6Ybpt9edq6I5aISqFXG7pAGRGNvbX3mGFBlQG+Tf86LAZZ0Uhkff8tE88YdM6BYwCkXh4eZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974055; c=relaxed/simple;
	bh=YBcP0cYBx0Vg8YUBaQqyPI2WtYD7Egwwz6ubsLTybqM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RxM4jEfVuTkskyQHlkf7qy2D4+O0xLwYojaAxy8QpxrFlNVqTKzrSAUAsOmNHY9+WYAkPhrDPyslHpxp9veY6tKauYK+RwfoVKXvpzJeX8m5fNhi5YITd8D9VjGvcD2alwu3zamsE1q9DbuzNGQqFxbHScmY8wO7cg/wDoDQdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RUdQ29yw; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RUdQ29yw"
Received: from github.com (hubbernetes-node-5499e75.ac4-iad.github.net [10.52.143.34])
	by smtp.github.com (Postfix) with ESMTPA id 488A82142A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762974053;
	bh=SQ2t5KjhY1v3qmXM3KDa6Bq+sRN+iweOc/GnKZnctkQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RUdQ29ywGLufzAlTq13KFb12LewS53EqCtGUmTPQ59va1z2ZXDOMSpKACl5CP7kra
	 WXd3ylg1L0XyaOCV/g1G3R38qgxANVy/bZdhoAjMqdLyayaJrUDdC0rpmjXwJFER2L
	 o460Qg4OGmK0zaxN8iHp6m+x1/ejSCndMyah0k9I=
Date: Wed, 12 Nov 2025 11:00:53 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022641/000000-a4d2b1@github.com>
Subject: [bluez/bluez] df0eb5: shared/bap: fix channel allocation logic in
 bt_bap...
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

  Branch: refs/heads/1022641
  Home:   https://github.com/bluez/bluez
  Commit: df0eb54800fd6a95e67841c20a747c495574b559
      https://github.com/bluez/bluez/commit/df0eb54800fd6a95e67841c20a747c495574b559
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: fix channel allocation logic in bt_bap_select()

bt_bap_select() does not correctly determine the need for multi-stream
configurations 6,7,8,9,11(i), as its result depends on whether Audio
Locations is read before or after the PACs, doesn't work with general
location bits, etc.

Fix the procedure to be simpler: create streams for all locations, up to
a specific number of channels.  By default, limit to max 2 channels per
direction for compatibility (BAP doesn't have explicit AC with larger
channel counts.) Also simplify the code.

Ignore lpac Locations when selecting: the value mostly makes sense for
Unicast Server role, but Client and Server cannot use the same value as
only a few bits can be set. As Client, we should be able to configure
any Location bits.  The sound server can simply ignore our suggested
channel allocation if really needed, or use SetConfiguration() API to
build custom configurations.


  Commit: ddc182953cbe131268e7caea6dcdace3376f333c
      https://github.com/bluez/bluez/commit/ddc182953cbe131268e7caea6dcdace3376f333c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: adjust macros for customizing remote audio locations

Add arguments to customize audio locations, in the macros defining data
for remote PACS.


  Commit: d59c90ad2bff1a9b2311abe3ff7a637870ab1413
      https://github.com/bluez/bluez/commit/d59c90ad2bff1a9b2311abe3ff7a637870ab1413
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: add tests for bt_bap_select()

Add basic tests for bt_bap_select(), for configurations in BAP.TS. 4.10.

UCL Select LC3 AC 1 (0a)
UCL Select LC3 AC 1 (0b)
UCL Select LC3 AC 1 (0c)
UCL Select LC3 AC 1 (0d)
UCL Select LC3 AC 1 (1)
UCL Select LC3 AC 1 (1a)
UCL Select LC3 AC 1 (1b)
UCL Select LC3 AC 1 (1c)
UCL Select LC3 AC 4 (2)
UCL Select LC3 AC 4 (2a)
UCL Select LC3 AC 4 (2b)
UCL Select LC3 AC 4 (2c)
UCL Select LC3 AC 2 (0a)
UCL Select LC3 AC 2 (0b)
UCL Select LC3 AC 2 (0c)
UCL Select LC3 AC 2 (0d)
UCL Select LC3 AC 2 (1)
UCL Select LC3 AC 2 (1a)
UCL Select LC3 AC 2 (1b)
UCL Select LC3 AC 2 (1c)
UCL Select LC3 AC 10 (2)
UCL Select LC3 AC 10 (2a)
UCL Select LC3 AC 10 (2b)
UCL Select LC3 AC 10 (2c)
UCL Select LC3 AC 3
UCL Select LC3 AC 5
UCL Select LC3 AC 7i
UCL Select VS AC 7i
UCL Select LC3 AC 6i
UCL Select LC3 AC 6ii L
UCL Select LC3 AC 6ii R
UCL Select LC3 AC 9i
UCL Select LC3 AC 9ii L
UCL Select LC3 AC 9ii R
UCL Select LC3 AC 8i
UCL Select LC3 AC 8ii L
UCL Select LC3 AC 8ii R
UCL Select LC3 AC 11i
UCL Select LC3 AC 11ii L
UCL Select LC3 AC 11ii R
UCL Select LC3 Many 2
UCL Select LC3 Many 8


  Commit: a4d2b16130095cde0022ad04b15ced5b324a19fc
      https://github.com/bluez/bluez/commit/a4d2b16130095cde0022ad04b15ced5b324a19fc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: don't configure endpoints of all codecs at once

When device is connected we currently try create all streams for all
endpoints. If there are multiple (= vendor codecs), this likely causes
creating multiple streams for same location, which is not allowed.

Change it to create streams only for the first endpoint, for each
direction.

Sound server can later request switching to another endpoint if
necessary.


Compare: https://github.com/bluez/bluez/compare/df0eb54800fd%5E...a4d2b1613009

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
