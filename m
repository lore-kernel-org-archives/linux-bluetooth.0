Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD082864
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746304; cv=none; b=Rvq/wyW1yTrXNjV/1eIGl/gGuGmAfl0zKTUNv4YclSycWzzIOjONKgWe2GOknRWvDF1aBDiegE0knDclKq0e3UgqwAP/MuW/6RgfG6XjI3oywy0Wvm/sZfbPW3ecj6Af1HJ8Cu061JYgcrjMn331MLgk+ZCwhNuCdJ6wrlnqbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746304; c=relaxed/simple;
	bh=k4BcVM1975ze4luyAlAn6eKpU+RMonNWUl2kaGAdN1k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GeOq5RQ4+fE63fj9FNIEi4JrxfQ2YvPb3JNGarPSY3oCf3rMIXuqowU4HTWfAbF+zqpJqknsbhyOihPAPC08niCYmkuNeVayjRMxl7NPmtbVwg7KzY958pENQymC3XRbqP8lVRsnHc5furjdu2ZIRaCtpbIE+5jxSM1Qbxe3fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z2Gzlane; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z2Gzlane"
Received: from github.com (hubbernetes-node-e55b8c4.va3-iad.github.net [10.48.179.47])
	by smtp.github.com (Postfix) with ESMTPA id 0A5D24E02C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750746302;
	bh=JF88+odAcCBbWrSOeBg2GGfs35xqX0HU8bzPjVFjeFM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z2GzlaneEzJfKfr500jwx2jHaB8z/XbHG/bNa4letFDjpeye33G55WIb2zj+jCR9E
	 rfF4osuaZW9hl0QcsZTOPfIRwNfDA8dtAVy7lcG2jmD3yFtqKpse9JI/pB082/PeXP
	 J7eDBdBYN7jPakGl42Wgg09zHqJ0TrLZ136jWMG8=
Date: Mon, 23 Jun 2025 23:25:02 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975123/000000-82ecfe@github.com>
Subject: [bluez/bluez] 82ecfe: shared/bap: Set stream to idle when I/O is
 disconn...
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

  Branch: refs/heads/975123
  Home:   https://github.com/bluez/bluez
  Commit: 82ecfeb57b124b4a14ffb031ea74231c3c51c3e0
      https://github.com/bluez/bluez/commit/82ecfeb57b124b4a14ffb031ea74231c3c51c3e0
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-24 (Tue, 24 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Set stream to idle when I/O is disconnected

When the CIS link is disconnected, the ASE status transitions from Releasing to
Idle.

  > HCI Event: Disconnect Complete (0x05) plen 4           #1484 [hci0] 67.947425
  		Status: Success (0x00)
  		Handle: 512 Address: 5C:B1:E1:2F:01:B9 (Resolvable)
  		Identity type: Random (0x01)
  		Identity: E8:D5:2B:59:57:A6 (Static)
  		Reason: Remote User Terminated Connection (0x13)
  = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0x..   67.948018
  = bluetoothd: src/shared/bap.c:bap_ucast_set_state() stream 0xdff..   67.948145
  = bluetoothd: src/shared/bap.c:stream_notify() stream 0xdffda8 st..   67.948275
  = bluetoothd: src/gatt-database.c:send_notification_to_device() G..   67.948525
  = bluetoothd: profiles/audio/bap.c:bap_state() stream 0xdffda8: r..   67.948679
  = bluetoothd: profiles/audio/transport.c:bap_state_changed() stre..   67.948967
  = bluetoothd: profiles/audio/transport.c:transport_update_playing..   67.949061
  = bluetoothd: profiles/audio/transport.c:media_transport_remove_o..   67.949106
  = bluetoothd: profiles/audio/transport.c:media_owner_free() Owner..   67.949149
  = bluetoothd: profiles/audio/transport.c:media_transport_suspend(..   67.949375
  = bluetoothd: profiles/audio/transport.c:transport_set_state() St..   67.949423
  = bluetoothd: src/shared/bap.c:bap_ucast_detach() stream 0xdffda8..   67.949574
  = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd2d2..   67.949710

When BIG sync is lost, the stream status transitions from Streaming to Idle.

  > HCI Event: LE Meta Event (0x3e) plen 3                #3189 [hci0] 118.870863
  	LE Broadcast Isochronous Group Sync Lost (0x1e)
  		BIG Handle: 0x00
  		Reason: Remote User Terminated Connection (0x13)
  = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0..   118.871183
  = bluetoothd: src/shared/bap.c:bap_bcast_set_state() stream 0xdf..   118.871227
  = bluetoothd: profiles/audio/bap.c:bap_state_bcast_sink() stream..   118.871258
  = bluetoothd: profiles/audio/bass.c:bap_state_changed() stream 0..   118.871307
  = bluetoothd: src/gatt-database.c:send_notification_to_device()...   118.871384
  = bluetoothd: profiles/audio/transport.c:bap_state_changed() str..   118.871452
  = bluetoothd: profiles/audio/transport.c:transport_bap_update_li..   118.871509
  = bluetoothd: profiles/audio/transport.c:transport_update_playin..   118.871555
  = bluetoothd: profiles/audio/transport.c:transport_set_state() S..   118.871610
  = bluetoothd: src/shared/bap.c:bap_bcast_sink_detach() stream 0x..   118.871660
  = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd25..   118.871689

Fixes: https://github.com/bluez/bluez/issues/1343

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
