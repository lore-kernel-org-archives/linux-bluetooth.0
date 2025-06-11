Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B4186A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633154; cv=none; b=A+tPADeldkKeB3LA8qYZg+/hxbUv3llDH3vgG2JYe4XIPY92GgIwYFnoXoqD5KiiW8lrENqUyN1hgv3/jWsgFVnEBwdbtuHKAPjUAccRc/Ds3bmajI9GsuT331zd/CkLzXcZJTXM8B8UIVrs5qKT+aJZV+mnf3XwXgNUa3/OyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633154; c=relaxed/simple;
	bh=9myNqtUeKOxnmsjdKWxUJ3C54U47XRa3YPEvOoLPB1s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FGeDHvHy9tmoUUFg8oWdVuOwP1EoPoVu0+QFnlSHA0Lw72nHd1454jnhWPuj9vWAzecln74xXCPnAZsCioi9DDA+1hwpTk582sRfxtuzAk1xwf+KFv9eBaI1ujvo0/j0kT6lH8GaDcx3G4vj3syyyOf2CxQpRzYfJCyq4TEa7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l354mEWn; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l354mEWn"
Received: from github.com (hubbernetes-node-407bfdf.ash1-iad.github.net [10.56.225.23])
	by smtp.github.com (Postfix) with ESMTPA id C236E9211D6
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749633150;
	bh=iGguUqkJqQ6x4YyoOPATKY23Is+hjg1ifLkNzyqi7o4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l354mEWnw8HbqQkeqH9Xlfj/27oRJRVXFJtq6k8aQNqF1lwyV9ju0MDdeqiGbBvtB
	 8j+Z0Ia4yKJaBFXEtYI1e6IfX0mYZ2IR8SszIDIPyo933KiAhi77qwviQgCW89nROb
	 ftyo1/YgOIAyl40BBQo15JlFmRiMWQNDIo/+v/sE=
Date: Wed, 11 Jun 2025 02:12:30 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970719/000000-4f1054@github.com>
Subject: [bluez/bluez] 4f1054: BASS: support for encrypted broadcast source
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

  Branch: refs/heads/970719
  Home:   https://github.com/bluez/bluez
  Commit: 4f105421ced5afad0fdb188cbe08ba902be70010
      https://github.com/bluez/bluez/commit/4f105421ced5afad0fdb188cbe08ba902be70010
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M profiles/audio/bass.c
    M src/shared/bass.c

  Log Message:
  -----------
  BASS: support for encrypted broadcast source

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
