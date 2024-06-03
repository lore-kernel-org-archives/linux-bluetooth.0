Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B185664
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424015; cv=none; b=gYR1zU+KfXW1ecZlU/xWtfHH/T0f73bXhma6d3LbtRDyozpm9LklyzKXSacuMqZ59HGIG1NaSxFQ9tQ8a6+e/WhSr1cFCm7Kr8GfR1cuCs3yCZBpyO7TRFTYWuYlmQrHz+CqKa6Y6denLRb0LwWYgqFQVXarMiVwIwYsuDwRlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424015; c=relaxed/simple;
	bh=wRrP0iQojsER8zHP7e6e0xh/HizkvBAsZoou/9Otn78=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qMrsNTwZEZc1tg9G0a1W0A2Pnj4kQqEo/n0+Qwpfklnc8ZMy64skft5IsQXJiM9692sxlRm8khqComzLe4twF71zUyPdWVm+DiUyiICQSc3CKIXWwsSIMBFHkFDt+zk8x5bcJPvXwzMT4OE5KaZvK6vrQIjqT0JhuV43iJ3sGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aAFKvtex; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aAFKvtex"
Received: from github.com (hubbernetes-node-5b47623.ash1-iad.github.net [10.56.161.38])
	by smtp.github.com (Postfix) with ESMTPA id 2224B1411CC
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717424013;
	bh=/vTpaGPyoUixtRPi7H6hYj1483cjTTE8MNTgNv00TKo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aAFKvtexbT8kyfTct0qwOwfOc0W5KdOV50fdkSgT7bDP4x6wk1vmGKPB8pq5EtKng
	 6DvARN4fdD9sKl+vHyHSpxw/2ZtTl+IjgtbJCj57sIeXCOvfCkkKTH7xuNawDC/jfe
	 J4TJvgBvm6iqWA/IF6ymFieQ23cantakDRGhK2YQ=
Date: Mon, 03 Jun 2024 07:13:33 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/758930-3f7477@github.com>
Subject: [bluez/bluez] f5e598: doc: Add initial L2CAP(7) documentation
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
  Commit: f5e59893e634b32e899db1bc8c3d16dfb82efcf4
      https://github.com/bluez/bluez/commit/f5e59893e634b32e899db1bc8c3d16dfb82efcf4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-23 (Thu, 23 May 2024)

  Changed paths:
    M Makefile.am
    A doc/l2cap.rst

  Log Message:
  -----------
  doc: Add initial L2CAP(7) documentation

This adds initial documentation for L2CAP sockets.


  Commit: 098ff00dea086764b309d8e43bab83b70eff8941
      https://github.com/bluez/bluez/commit/098ff00dea086764b309d8e43bab83b70eff8941
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-23 (Thu, 23 May 2024)

  Changed paths:
    M Makefile.am
    A doc/rfcomm.rst

  Log Message:
  -----------
  doc: Add initial RFCOMM(7) documentation

This adds initial documentation for RFCOMM sockets.


  Commit: 491e5b35370099bf61ef89ca9dcdcf6b6b4c4f89
      https://github.com/bluez/bluez/commit/491e5b35370099bf61ef89ca9dcdcf6b6b4c4f89
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Remove DISABLING case from bcast state cb

This removes the switch case for the DISABLING state from
bap_bcast_set_state, since this state is not used for broadcast.


  Commit: af2873b2691291e165b3ee3f24b651433885537f
      https://github.com/bluez/bluez/commit/af2873b2691291e165b3ee3f24b651433885537f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix potential stream access after free

In bap_bcast_set_state, state->func might trigger the stream to be
released, thus the stream would have been freed before reaching the
switch. After calling stream->func, the stream reference should not
be accessed anymore, apart from when the stream has not yet been
released and those cases will be handled inside the switch.

This commit also handles the case when stream ops might lead to a
state machine that ends with stream release, so the stream should
avoid being accessed after the ops are executed.


  Commit: 6cb268f47f477a07185a6b982e96787f82de98bf
      https://github.com/bluez/bluez/commit/6cb268f47f477a07185a6b982e96787f82de98bf
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Update bsrc_state to just handle CONFIG state

This updates bsrc_state to just handle the CONFIG stream state. Dedicated
state changed callbacks will be implemented for tests that require streams
to be established, disabled etc.


  Commit: bb30b19901547b012896b239dfa10a2a9e95c665
      https://github.com/bluez/bluez/commit/bb30b19901547b012896b239dfa10a2a9e95c665
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source Establish test

BAP/BSRC/SCC/BV-35-C [Establishes Broadcast] (page 175):

    Test Purpose:
    Verify that a Broadcast Source IUT can establish a broadcast
    Audio Stream.

    Pass verdict:
    The IUT sends AUX_SYNC_IND PDUs with an Extended Header
    containing BIGInfo in the ACAD field.

    The IUT sends BIS Data PDUs over the broadcast Audio
    Stream.

Test Summary
------------
BAP/BSRC/SCC/BV-35-C [Establishes Broadcast]         Passed


  Commit: 06a905d6b8c89ad518badd90b07fea122ecdee8d
      https://github.com/bluez/bluez/commit/06a905d6b8c89ad518badd90b07fea122ecdee8d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source Disable test

BAP/BSRC/SCC/BV-36-C [Disables Broadcast] (page 176):

    Test Purpose:
    Verify that a Broadcast Source IUT can disable a broadcast
    Audio Stream.

    Pass verdict:
    The IUT sends a BIG_TERMINATE_IND PDU.

Test Summary
------------
BAP/BSRC/SCC/BV-36-C [Disables Broadcast]            Passed


  Commit: 3f747788c1b19dd328299b87b616c220311ab65c
      https://github.com/bluez/bluez/commit/3f747788c1b19dd328299b87b616c220311ab65c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source Release test

BAP/BSRC/SCC/BV-37-C [Releases Broadcast] (page 176):

    Test Purpose:
    Verify that a Broadcast Source IUT can release a broadcast
    Audio Stream and transition from Configured state to Idle
    state.

    Pass verdict:
    The IUT stops transmitting periodic advertising.

Test Summary
------------
BAP/BSRC/SCC/BV-37-C [Releases Broadcast]            Passed


Compare: https://github.com/bluez/bluez/compare/75893035705d...3f747788c1b1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
