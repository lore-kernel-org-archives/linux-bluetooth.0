Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CD2512E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874962; cv=none; b=STgLNQapLb935LAI92ZOxy5kn8Cy3MwjhHdXrSiL1lC+DmDcwTt2fiwHC3iugBRhtcBVmBhz8izVFjTnW5mAJJmSx49kC5Ms6nhsLWOX7JCHTzw9BfpAFnN9MYi3+9kxDNY7G5ATNrJlZ5XtEtKsOWgw5TzTAqIODjrguxsl+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874962; c=relaxed/simple;
	bh=PEhLhTYa+1wrecV7ZwMERw+MkqBG52ZHKxGONjvoSlI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pYowM2+/BaETulJ76SCy7m9BOhmH3n+Psebqp9FcGBLDJvLfRHZpIT+2OLd/U5QdXgFvCkgXu04xTbYi292yyewnTQgUk7G6KUGrJvXdM4Aq2BWZg+p4nVsvv5+T1whvRRM3RiKr9U73ulJoAuGzDULcZ6qpXW704Y3ZcTCyQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TpBgUGaa; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TpBgUGaa"
Received: from github.com (hubbernetes-node-2f7f4e4.va3-iad.github.net [10.48.170.49])
	by smtp.github.com (Postfix) with ESMTPA id EA44D4E03E3
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764874960;
	bh=McxOPR1wfxwxpiCmnezs9J7w46peFmtRokUEyEjgLXo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TpBgUGaawLhuYMlaudX0AnO9mHintZHjLrVLabl13Bep/MDL6tI6lWyQBHQnVdCqI
	 qspM7ztf0bH7okcZqkRObbg4R1Wn3L7pBbuHT8fWpc7aEZ4YdVGTKks2PaMXhbVlYI
	 N2xsVs+7bLV7BQN9ixBxoDGamAW9UvxAat15pmzU=
Date: Thu, 04 Dec 2025 11:02:39 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1030563/000000-81e8d4@github.com>
Subject: [bluez/bluez] 72a5e3: bass: Fix attaching to unicast session
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

  Branch: refs/heads/1030563
  Home:   https://github.com/bluez/bluez
  Commit: 72a5e3b9c50e3cf7ad6441c204de6f32b8cb50af
      https://github.com/bluez/bluez/commit/72a5e3b9c50e3cf7ad6441c204de6f32b8cb50af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-04 (Thu, 04 Dec 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix attaching to unicast session

This attempst to check if bt_bap session is attached to an ATT channel
then it shall be considered an unicast session not a broadcast session.


  Commit: 81e8d494a6b470c7b61208a9192c015aada51719
      https://github.com/bluez/bluez/commit/81e8d494a6b470c7b61208a9192c015aada51719
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-04 (Thu, 04 Dec 2025)

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


Compare: https://github.com/bluez/bluez/compare/72a5e3b9c50e%5E...81e8d494a6b4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
