Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709F1940B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876906; cv=none; b=OD3y4fSF8Zk5/AIvQXYRSZhXlXWXDNxK152j13EPqDoGmZWa4E9HxgnOjmLFSIBI0vja7NHJB8IjAutIelY+KrAcHEX0wV0xYytyk+Slipl7Zo4WtBjV0Zv7DzKvtWyN2GWWs1G8wyjQ0RlVawH4DiVNbRvnbNvr/Gwb+WxJ5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876906; c=relaxed/simple;
	bh=VDAKrYJK4QJ4vYgXIualP559uuhtHyRAh+EF7FUkTEk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ikn88iI/hqqJ3UBNfT0zbwhci/3DeQz7s1GVD1cQ28ZTNXGCxcOXCuvWE+3NbPgw2bbrfCLpxdOhys3ZTXDjEUT1PKdKrWuJWIVw75CQCMhh+ZIlSWhDhsK8bx85gRWB4vuR2dAPbS4x6csoiSyg4eqUdzj8QzLX+ywp7CaQyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZnseoCNU; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZnseoCNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787876904;
	bh=KpzMslVIOlkp3QHHnb6Z5ZKX7oSEqzsBXAzlHdNU3XM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZnseoCNUMxgyzdjKd33YNYi5gUSWVmVSvDLmqTC20GnklptD06qKCRPsyWvYsBOze
	 /jR65jLrO6NaYx3qwl8sPfmzjTr/BwvT1+EIw5stUFGSMlmvyIvRMkQUY7FK8L9J0Q
	 VG17l233zrU/z9LM+vrZP/i/tbwRZF6x71C4uM0M=
Received: from github.com (hubbernetes-node-934bf96.ac4-iad.github.net [10.52.132.29])
	by smtp.github.com (Postfix) with ESMTPA id 80FE93203BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:28:24 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:28:24 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9f5adb-49592c@github.com>
Subject: [bluez/bluez] 73ccf6: all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
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
  Commit: 73ccf6d83e6a1c65bd4971c6e35da16520f7d74e
      https://github.com/bluez/bluez/commit/73ccf6d83e6a1c65bd4971c6e35da16520f7d74e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M monitor/avctp.c
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M tools/parser/avrcp.c
    M unit/avrcp-lib.c
    M unit/avrcp-lib.h

  Log Message:
  -----------
  all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL

It's "illegal" not "ilegal".


  Commit: 627f9fae78959cb38d5e48a7cc3f008ad746f39c
      https://github.com/bluez/bluez/commit/627f9fae78959cb38d5e48a7cc3f008ad746f39c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser

A stack buffer overflow (CWE-121) in bap_sink_match_allocation() in
src/shared/bap.c allows an attacker within BLE range to write ~195
attacker-controlled bytes past a 4-byte stack buffer in bluetoothd
with no pairing, no connection, and no user interaction. The BAP
profile auto-syncs to any device advertising the BCAAS UUID.

bap_sink_match_allocation() copies the value of an
Audio_Channel_Allocation LTV (type 0x03) into a 4-byte uint32_t stack
local using the LTV's attacker-controlled length byte as the memcpy
size, with no upper bound check:
	// src/shared/bap.c:7767
	memcpy(&location32, v, l);  // l attacker-controlled, no upper bound

A second identical instance exists in bap_sink_get_allocation() at line 2558.

Per Bluetooth Assigned Numbers, Audio_Channel_Allocation is a fixed 4-octet
bitfield; any other length is malformed.

https://github.com/bluez/bluez/security/advisories/GHSA-9683-2chf-hfw9

Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration with


  Commit: 3c18444ced8e40067a855560d6fc18cda21efaba
      https://github.com/bluez/bluez/commit/3c18444ced8e40067a855560d6fc18cda21efaba
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  bass: Fix heap buffer overflow allocating subgroup_data array

bass_build_bcast_src() in src/shared/bass.c parses the Broadcast Receive State
characteristic value received from a remote BASS server.

It reads an attacker-controlled num_subgroups byte (range 0-255) but always
allocates a single bt_bass_subgroup_data entry (24 bytes):
subgroup_data = new0(struct bt_bass_subgroup_data, 1);   // line 337: always 1
for (int i = 0; i < num_subgroups; i++) {                // line 343: up to 255
    subgroup_data[i].bis_sync = bis_sync_state;          // line 355: OOB write

Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration
 with Claude and Anthropic Research
Suggested-by: @trace37labs for the Fixes

Fixes: 8980f4f1f7 ("shared/bass: Functions cleanup")

See: https://github.com/bluez/bluez/security/advisories/GHSA-7wjj-8mrm-jhw4
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration


  Commit: d094be10ff0cc9d48714d35557e0fd297f36f907
      https://github.com/bluez/bluez/commit/d094be10ff0cc9d48714d35557e0fd297f36f907
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M gobex/gobex-transfer.c

  Log Message:
  -----------
  gobex: Fix ABORT response being discarded

g_obex_drop_tx_queue() in transfer_complete() clears any pending tx,
so the ABORT success response should be enqueued after transfer_complete().

Fixes the following PTS test cases:
- OPP/SR/OPH/BV-27-I
- FTP/SR/OTR/BV-02-C
- PBAP/PSE/PDF/BV-06-I
- PBAP/PSE/PBF/BV-03-I

Fixes: 7a35c12a6ceb ("gobex: Fix segfault caused by interrupted transfer")
Assisted-by: Claude:claude-sonnet-5


  Commit: 06b1ba3343c56ed71e9a45aa0439ebbaec9c0072
      https://github.com/bluez/bluez/commit/06b1ba3343c56ed71e9a45aa0439ebbaec9c0072
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  src: Modify MaxTxPower option documentation for ChannelSounding

Modify MaxTxPower configuration option to take decimal values
within the range of -127dBm to 20dBm
Defaults to 20 (max power).


  Commit: 49592cbc141675d15d13c83ea190ae438684bb09
      https://github.com/bluez/bluez/commit/49592cbc141675d15d13c83ea190ae438684bb09
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M client/cs.c

  Log Message:
  -----------
  client: Enforce Valid Main Mode and Sub Mode Combinations

Introduce validation for main_mode_type and sub_mode_type combinations as
specified in the protocol requirements.
Reject invalid combinations and guide the user by displaying
the acceptable mode pairings.


Compare: https://github.com/bluez/bluez/compare/9f5adb00c7c1...49592cbc1416

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
