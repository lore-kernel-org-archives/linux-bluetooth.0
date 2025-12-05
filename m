Received: from o7.sgmail.github.com (o7.sgmail.github.com [167.89.101.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DA261393
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966277; cv=none; b=pbbuX9XE7r/DJKcztNyVxcKV2Xj2V0vICXdJtty4veU96UP37ZnfO9o0wPJjjrHVi1AnAuLmv79Y2b+gOjG4AzpvxvSZ7PS+8mfETmiRLkpqfVgXL+FUYoecRyyVIVlPIhr0nBKg06JIbBJ5Sj0rMdd41MCTkN/Vve1axSe9NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966277; c=relaxed/simple;
	bh=K6FexvAnvjD4QBxPYRVevvG0vWr3AMZ5cXUQ9mkNuvY=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=W54Xlzi9p5lQHhl59pGLwFH7LM0L6WHIaHU6/SDaBz4pDw3NZsQ1TLBOYjwM1jPc9mJe5GTDq81EMDiinjLB0qqiKbuqPTxJHwRLasnf6B10DOJNdZb2hBw8vk9tteKAoQ4zo/cjxpYKkFEI5KYCnvNpKGNbA0EWxZv55JjkczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GQFYS/cO; arc=none smtp.client-ip=167.89.101.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GQFYS/cO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=1C191r3tOCp6YrQMmBNYicHYpmFsHVQYdgXDNuRKrNQ=;
	b=GQFYS/cOOHJhXtq4G/WJDkk/MHtIF1Tk7rwEygxVe7hQxu52JVGJMJo/xVEkm2K6nKqb
	iDBsL9KR6vC76H6LwOd0NEaz6y0jgb8P2bNzvGXUd12B0p0HFKh2InIUV3EdGJsoA5b2Z7
	dXApnCtdJyUEGRRwNXpwrfKnMkHVpyd3Q=
Received: by recvd-566f48c6f7-p2hg8 with SMTP id recvd-566f48c6f7-p2hg8-1-69333F81-7B
	2025-12-05 20:24:33.987589059 +0000 UTC m=+8111000.857077861
Received: from out-25.smtp.github.com (unknown)
	by geopod-ismtpd-48 (SG)
	with ESMTP id 3sBhIbAQQtSDMokd4_SJyQ
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 20:24:33.961 +0000 (UTC)
Received: from github.com (hubbernetes-node-81063de.ash1-iad.github.net [10.56.154.41])
	by smtp.github.com (Postfix) with ESMTPA id 6D4F414092A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 12:24:27 -0800 (PST)
Date: Fri, 05 Dec 2025 20:24:34 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/c42a49-d83198@github.com>
Subject: [bluez/bluez] 90a244: bass: Fix attaching to unicast session
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAjnvo7pZOl0R?=
 =?us-ascii?Q?UD1cHr3VkXsCkD3ILWN=2Fp2Jqvh5Khv3=2FJZTjp2n?=
 =?us-ascii?Q?8yosT=2F2bMBqFl6bdKIPkHp4Qy0MtE2UnLf=2Fb9mJ?=
 =?us-ascii?Q?6BQspNr1dfKbXm3QOTfqdD+ULgmEDaskqdstfNJ?=
 =?us-ascii?Q?wcZDEfb8ChV2gdGra49Er=2F6bA1qkK6+T8Rc3uDg?=
 =?us-ascii?Q?O8Q6RbXka79ol96hSStCO=2F2LZA=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 90a2447a39fcf13d6c2e28828e92bbf8932023c6
      https://github.com/bluez/bluez/commit/90a2447a39fcf13d6c2e28828e92bbf8932023c6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix attaching to unicast session

This attempst to check if bt_bap session is attached to an ATT channel
then it shall be considered an unicast session not a broadcast session.


  Commit: 753262031701b479b89884fc1a4d7007c7e80996
      https://github.com/bluez/bluez/commit/753262031701b479b89884fc1a4d7007c7e80996
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix parsing of BT_ASCS_METADATA for multiple ASE IDs

bt_ascs_metadata is variable length so when there are multiple ASE IDs
each item needs to be parsed according to its length otherwise it would
cause issues such as bellow where the ASE IDs is incorrectly parse:

> ACL Data RX: Handle 2048 flags 0x02 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x009b Type: ASE Control Point (0x2bc6)
          Data[18]: 070201060302040001050206030204000105
            Opcode: Update Metadata (0x07)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x01
            Metadata: #0: len 0x03 type 0x02
              Context: 0x0004
                Media (0x0004)
            Metadata: #1: len 0x01 type 0x05
            ASE: #1
            ASE ID: 0x02
            Metadata: #0: len 0x03 type 0x02
              Context: 0x0004
                Media (0x0004)
            Metadata: #1: len 0x01 type 0x05

= first LTV in the metadata is incorrectly used as ASE ID (0x03)
src/shared/bap.c:ep_metadata() ep 0x55b1f428d490 id 0x03 dir 0x02
src/shared/bap.c:ep_metadata() Invalid state config

< ACL Data TX: Handle 2048 [1/6] flags 0x00 dlen 15
      ATT: Handle Value Notification (0x1b) len 10
        Handle: 0x009b Type: ASE Control Point (0x2bc6)
          Data[8]: 0702010000030400
            Opcode: Update Metadata (0x07)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x01
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
            ASE: #1
            ASE ID: 0x03
            ASE Response Code: Invalid ASE State (0x04)
            ASE Response Reason: None (0x00)


  Commit: d83198c78ee11a3003b83a58f9f25f16657fc3a3
      https://github.com/bluez/bluez/commit/d83198c78ee11a3003b83a58f9f25f16657fc3a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix attempting to create multiple assistant for the same stream

bt_bap_stream may change from streaming -> streaming when updating its
metadata in which case bis_src_handler would be called multiple times
for the same stream causing it to fail at g_dbus_register_interface, to
fix this adds a check if the state is already streaming then it must
have been handle already so it safe to skip calling bt_bap_parse_base.


Compare: https://github.com/bluez/bluez/compare/c42a49a243e4...d83198c78ee1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
