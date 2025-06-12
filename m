Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC3268FCD
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740150; cv=none; b=BvVroQhxAODYLNwwMT1lz8cwsmJ18iyw2T0QVmvQORhaUhiUAGUWoFqevp8QL4tesjd3pwSnNoZWnOdz8Izj65EOYkBlxphPQeKzf0Z3hqnLLPzN1VeVWB9EI7XSjwe11gkvBvY6xiadZNjok1TQAYusWpJ73PslN/xiIF+DNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740150; c=relaxed/simple;
	bh=chUqZNKV10ZLlOiAuPAieSlZw+Lw+s34pt3vipFZAmk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Nzl8N5Wa2anu0DSjQpedNSz62Vm7DpxZ924zlDDv3VLxEbwei5ztKYZYrQqh+kUk2fdy12XZ+i18ZU2v0TKnOJEv5uLKL4MwnEYIRoaYDDJ7umUv34Rp3Qn18MD1P+WXiLJqzniwWAq1M99S7SQZ5aNvT26YjkvUFErz/kqTrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UnGl9eh2; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UnGl9eh2"
Received: from github.com (hubbernetes-node-ab292ff.va3-iad.github.net [10.48.133.44])
	by smtp.github.com (Postfix) with ESMTPA id CB6114E1004
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749740147;
	bh=mo5JvsScAkn+5yreK57l9obTpP29ukcc3TN4oI/xkHc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UnGl9eh2ZKkZQj30RPb9Vt5o09pc/xepgp1TylZeuiNxXo8UWE3qwdKmoBbkrX2ZV
	 rLfMaJMaIDOTRTTKefSSI+Sw7sCB7fcMDLmjSJ7dTfJWExevGL2rbk6VM8k26r/qEw
	 +tPxlc9gMdro3ABEjOPRYZekppIQA3PROSYkRWm0=
Date: Thu, 12 Jun 2025 07:55:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/aea0f4-6bc584@github.com>
Subject: [bluez/bluez] 39d965: shared/bass: Move cb->handle earlier in the
 flow
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
  Commit: 39d9651857658811e1d8c0fb6197b281273eef0e
      https://github.com/bluez/bluez/commit/39d9651857658811e1d8c0fb6197b281273eef0e
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-12 (Thu, 12 Jun 2025)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Move cb->handle earlier in the flow

This change ensures cb->handle is executed even
if the function returns early in the attribute_notify
section. It also allows the stream status to be updated
before notifying the client, improving efficiency.


  Commit: 6bc584b11b8b10dbd717ca4012a6c09afb18d1c7
      https://github.com/bluez/bluez/commit/6bc584b11b8b10dbd717ca4012a6c09afb18d1c7
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-12 (Thu, 12 Jun 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: support for encrypted broadcast source

If the BIS is encrypted as indicated in the BIG Info Report, the
broadcast code needs to be requested from the Assistant.

step 1: Broadcast_Code required
  > HCI Event: LE Meta Event (0x3e) plen 20                 #631 [hci0] 27.176606
        LE Broadcast Isochronous Group Info Advertising Report (0x22)
          Sync Handle: 0x0000
          Number BIS: 2
          NSE: 8
          ISO Interval: 20.00 msec (0x0010)
          BN: 2
          PTO: 2
          IRC: 2
          Maximum PDU: 60
          SDU Interval: 10000 us (0x002710)
          Maximum SDU: 60
          PHY: LE 2M (0x02)
          Framing: Unframed (0x00)
          Encryption: 0x01
  < ACL Data TX: Handle 16 flags 0x00 dlen 44               #633 [hci0] 27.184478
        ATT: Handle Value Notification (0x1b) len 39
          Handle: 0x005f Type: Broadcast Receive State (0x2bc8)
            Data[37]: 01016698a411bb13019f103b02010100000000110d03506978656c20395f32303938020502
            Source_ID: 1
            Source_Address_Type: 1
            Source_Address: 13:BB:11:A4:98:66
            Source_Adv_SID: 1
            Broadcast_ID: 0x3b109f
            PA_Sync_State: Synchronized to PA
            BIG_Encryption: Broadcast_Code required
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata: #0: len 0x0d type 0x03
              Metadata:   50 69 78 65 6c 20 39 5f 32 30 39 38              Pixel 9_2098
              Metadata: #1: len 0x02 type 0x05
              Metadata:   02
  > ACL Data RX: Handle 16 flags 0x02 dlen 25               #636 [hci0] 27.455744
        ATT: Write Command (0x52) len 20
          Handle: 0x0065 Type: Broadcast Audio Scan Control Point (0x2bc7)
            Data[18]: 04013a4931614b3a2b7c4b7431722b666724
              Opcode: Set Broadcast_Code (0x04)
              Source_ID: 1
              Broadcast_Code[16]: 3a4931614b3a2b7c4b7431722b666724

step 2: Set Broadcast Code when BIG Create Sync
  < HCI Command: LE Broadcast Isoc.. (0x08|0x006b) plen 26  #641 [hci0] 27.669211
          BIG Handle: 0x00
          BIG Sync Handle: 0x0000
          Encryption: Encrypted (0x01)
          Broadcast Code[16]: 3a4931614b3a2b7c4b7431722b666724
          Maximum Number Subevents: 0x00
          Timeout: 20000 ms (0x07d0)
          Number of BIS: 2
          BIS ID: 0x01
          BIS ID: 0x02

Fixes: https://github.com/bluez/bluez/issues/1306


Compare: https://github.com/bluez/bluez/compare/aea0f46f173f...6bc584b11b8b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
