Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEA18801E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903356; cv=none; b=aij0QaWSac9Ldtg49ml7OMGmSAVmjUBMB8Zo6qFZ/TeqgxwGqoaYJ1scXsnbDXa2lRK59ZJPkJYL1FxMqpsodnf9XKRXJKZPOFqK+/R6akH1S7NIc3d88i0fkarDEl8dWfwdo0XT3iY2xojKkkk+lZgtAHZ6+Ft0HiBtYHFewuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903356; c=relaxed/simple;
	bh=B03lsdJhaTNZTY6NeOhaIDXriAfJP8Mx544C19+M4+8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N2s63ubYU0U04EdUG3WInszjA/1Z5sfHICnAbxtXY+q6ZkesFGMkw6cv7Nt18bXqPWTnX5c5lYrKVIF9kidncCc8W83Gn81E+cTuajIs6v4EUXLnt0Q25nNbnNNg646KR4MbFRCV5t2wZMWOSAADto+iiOrWDc/1pdmDzIUpz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R4vwhbcR; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R4vwhbcR"
Received: from github.com (hubbernetes-node-25778e7.ac4-iad.github.net [10.52.131.39])
	by smtp.github.com (Postfix) with ESMTPA id 405B1700A91
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725903353;
	bh=WhCjnhPb6WjuBM3MtldP/WmQ+fHzCD59qJuWW1ZlFQM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R4vwhbcRh1tyP+S6v5pEfrhON/Kc1jGDHHuFkX2NU1f5zL7lggHM7fVrLiP+YZlCV
	 Wkrz9iJ+JqR3iqkwdUzcGPNrKUgjIt6NBiyUxFEqYKRME4MZk89j6L7DoOzGhn/N9A
	 XB576CdPiuaQWVVed8LBD+Fk8tzxyrDytlywwNK4=
Date: Mon, 09 Sep 2024 10:35:53 -0700
From: vlad-pruteanu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dfcbc2-54866c@github.com>
Subject: [bluez/bluez] 2ec779: client/assistant: Enter Broadcast Code as
 string
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2ec7799354968f66dd00832bb33895134029c3bb
      https://github.com/bluez/bluez/commit/2ec7799354968f66dd00832bb3389=
5134029c3bb
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Enter Broadcast Code as string

Currently, the user sets the Broadcast Code as an array of bytes
when prompted from the assistant submenu. However, the Bluetooth
Core Specification requires that, on the UI level, the Broadcast
Code shall be represented as a string (Vol 3, Part C, 3.2.6).

This commit makes the Broadcast Code be parsed as a string from
the assistant prompt. The bluetoothctl log below shows a Broadcast
Assistant pushing an encrypted stream to a peer:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 19:9A:7A:71:E5:8B 19-9A-7A-71-E5-8B
[00-60-37-31-7E-3F]# [NEW] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): a
[Assistant] Enter Broadcast Code (auto/value): Borne House
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: pending
[00-60-37-31-7E-3F]# Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: active

The btmon log below shows the way the Broadcast Code string is converted
into a byte array and sent to the peer via GATT:

bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 28
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 02018be5717a9a1900db5e3a02ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 19:9A:7A:71:E5:8B
            Source_Adv_SID: 0
            Broadcast_ID: 0x3a5edb
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0201010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 040142c3b8726e6520486f75736500000000
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 426f726e6520486f7573650000000000
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0202010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001


  Commit: f30cbaa43d28b430104393b76c648323d8100b33
      https://github.com/bluez/bluez/commit/f30cbaa43d28b430104393b76c648=
323d8100b33
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M client/bluetoothctl-assistant.rst

  Log Message:
  -----------
  bluetoothctl-assistant.1: Update push command example

This updates the push command example to enter the Broadcast Code,
since it should be entered as a string instead of a byte array.


  Commit: daa86e06c376d6e92bb0d1e2f1edb649974bfcbd
      https://github.com/bluez/bluez/commit/daa86e06c376d6e92bb0d1e2f1edb=
649974bfcbd
  Author: Guido G=C3=BCnther <agx@sigxcpu.org>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M Makefile.am
    M Makefile.obexd
    M Makefile.tools
    M configure.ac
    A tools/mpris-proxy.service.in

  Log Message:
  -----------
  tools/mpris-proxy: Add systemd user unit

That way it will be started automatically which is convenient on phones.
Distributions can then decide part of which install the unit should be.

Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>


  Commit: 54866cee3fad31880047ba81dbb12746186522cb
      https://github.com/bluez/bluez/commit/54866cee3fad31880047ba81dbb12=
746186522cb
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix broadcast sink check

In transport_update_playing a check is performed to guard the path
which contains the TRANSPORT_STATE_BROADCASTING state. This branch
should be taken only when the device on which the code runs is a
broadcast sink. Thus, the UUID check is wrong, and this patch
updates it appropriately.


Compare: https://github.com/bluez/bluez/compare/dfcbc2d3c011...54866cee3f=
ad

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
