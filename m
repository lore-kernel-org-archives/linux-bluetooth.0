Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C453ACF1C
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765471; cv=none; b=NgZnV7GjeAy/ejIA9TKmsY76GwUfCpLKFZO6bgtZ4xzMqS9XZOIjXmEsEjOy0JfLM1wH1C3k2LclZfP42VsNV8Z3zyKl29NAoutpMq3LD3KgPpPzOX+7m1/8x6VkVzGZK+qGbejxBSEcPNjrTw7r2SStqOPDn3z0V5pU8uRJq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765471; c=relaxed/simple;
	bh=0XNnw8qDXGfPbwtRQGJy4vukW3/KwMTswYdDG8vlNMM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pblOwhxINRxDYFr/x3H3Ps0hVKnXCcimxCtimhhLh31V6Ozyb3UVA0EPwPlkRYH1P41JIBFJGO8JLyiDdkI1/amty13m6JcMpHGf4Sm20LPyXLSK3Z5Xyg2KzVhxC9vuEh04MyGHjXIaGDPQxcq0PWHjOSsBI/2xOuleTefOJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZrYAsg9C; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZrYAsg9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783765467;
	bh=JyAYwNvrR/eAKvf8R924ooUSM9sdIljXPAk1eZBF+NM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZrYAsg9CpNwkrt5k+FvClXE1qsowzX4aM0L77RUx1zZRGEeV+HyINovbD1ftCq1f/
	 7kMnUhWCKCqDksQFb3sGNrVSQqQfi/Sno4BEcUiewPXP6xvpsHK6yWOIAL+rr301e5
	 Ym7WWay6RT74/NNjHJTfua0h9x2TADMHha4zg22M=
Received: from github.com (hubbernetes-node-0f90e9e.va3-iad.github.net [10.48.161.40])
	by smtp.github.com (Postfix) with ESMTPA id D0744780FE5
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 03:24:27 -0700 (PDT)
Date: Sat, 11 Jul 2026 03:24:27 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125775/000000-01a66f@github.com>
Subject: [bluez/bluez] c63a69: lib: add iso_data_* macros to hci.h
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

  Branch: refs/heads/1125775
  Home:   https://github.com/bluez/bluez
  Commit: c63a69d75ae260ecf119b6838442293751d5f1fd
      https://github.com/bluez/bluez/commit/c63a69d75ae260ecf119b6838442293751d5f1fd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-11 (Sat, 11 Jul 2026)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: add iso_data_* macros to hci.h

Add macros for parsing ISO Data Packet header items.


  Commit: 01a66ff0ec8fdc5c09786741a5361c9ad2c95140
      https://github.com/bluez/bluez/commit/01a66ff0ec8fdc5c09786741a5361c9ad2c95140
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-11 (Sat, 11 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix parsing of ISO packet data header and slen check

Check PB flag to see whether timestamp and data headers are present.

Check bounds before accessing data. Bump handle_str length to fit
maximum.

Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
SDU length check, as we are not tracking fragmentation.

Fixes: https://github.com/bluez/bluez/issues/2292
Assisted-by: GLM-5.2


Compare: https://github.com/bluez/bluez/compare/c63a69d75ae2%5E...01a66ff0ec8f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
